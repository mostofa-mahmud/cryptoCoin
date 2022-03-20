import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptocurrency_flutter/model/user_model.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';

import '../main.dart';
import 'keys.dart';

final googleSignIn = GoogleSignIn();

FirebaseAuth _auth = FirebaseAuth.instance;

class AuthService {
  GoogleSignIn? buildGoogleSignInScope() {
    return GoogleSignIn(
      scopes: [
        'https://www.googleapis.com/auth/plus.me',
        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      AuthCredential credential = await getGoogleAuthCredential();
      UserCredential authResult = await _auth.signInWithCredential(credential);

      final User user = authResult.user!;

      await _auth.signOut();

      await buildGoogleSignInScope()?.signOut();

      return await loginFromFirebaseUser(user);
    } catch (e) {
      throw errorSomethingWentWrong;
    }
  }

  Future<AuthCredential> getGoogleAuthCredential() async {
    GoogleSignInAccount? googleAccount =
        await (buildGoogleSignInScope()?.signIn());
    GoogleSignInAuthentication? googleAuthentication =
        await googleAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuthentication.idToken,
      accessToken: googleAuthentication.accessToken,
    );
    return credential;
  }

  /*Future signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn().catchError((e) {
      log(e.toString());
    });

    if (googleSignInAccount != null) {
      setValue(SharedPreferenceKeys.isLoggedIn, true);

      //Authentication
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User user = authResult.user!;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser!;
      assert(user.uid == currentUser.uid);

      await googleSignIn.signOut();
      await loginFromFirebaseUser(user);

    } else {
      throw errorSomethingWentWrong;
    }
  }*/

  Future<void> loginFromFirebaseUser(User currentUser,
      {String? fullName}) async {
    UserModel userModel = UserModel();

    if (await userService.isUserExist(currentUser.email)) {
      ///Return user data
      await userService.userByEmail(currentUser.email).then((user) async {
        userModel = user;

        await updateUserData(user);
      }).catchError((e) {
        log(e);
        throw e;
      });
    } else {
      /// Create user
      userModel.email = currentUser.email;
      userModel.uid = currentUser.uid;
      userModel.photoUrl = currentUser.photoURL.validate();
      userModel.isEmailLogin = false;
      userModel.isTester = false;
      userModel.firstName = currentUser.displayName;
      userModel.loginType = LoginTypeGoogle;

      userModel.createdAt = Timestamp.now();
      userModel.updatedAt = Timestamp.now();

      if (isIos) {
        userModel.firstName = fullName;
      } else {
        userModel.firstName = currentUser.displayName.validate();
      }

      log(userModel.toJson());
      await userService
          .addDocumentWithCustomId(currentUser.uid, userModel)
          .then((value) {
        log("New User Added");
      }).catchError((e) {
        throw e;
      });
    }

    await setUserDetailPreference(userModel);
  }

  Future<void> updateUserData(UserModel user) async {
    userService.updateDocument({
      'updatedAt': Timestamp.now(),
    }, user.uid.validate());
  }

  Future<void> setUserDetailPreference(UserModel user) async {
    appStore.setLoggedIn(true, isInitializing: true);
    appStore.setFirstName(user.firstName.validate(), isInitializing: true);
    appStore.setEmail(user.email.validate(), isInitializing: true);
    appStore.setPhotoUrl(user.photoUrl.validate(), isInitializing: true);
    appStore.setUid(user.uid.validate(), isInitializing: true);
    appStore.setEmailLogin(user.isEmailLogin.validate(), isInitializing: true);
    appStore.setTester(user.isTester.validate(), isInitializing: true);
  }

  Future<void> signUpWithEmailPassword(
      {required Map<String, dynamic> userData}) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: userData[userKeys.email], password: userData[userKeys.password]);

    if (userCredential.user != null) {
      User currentUser = userCredential.user!;
      UserModel userModel = UserModel();

      userModel.email = currentUser.email;
      userModel.firstName = userData[userKeys.firstName];
      userModel.uid = currentUser.uid;
      userModel.isEmailLogin = userData[userKeys.isEmailLogin];
      userModel.photoUrl = userData[userKeys.photoUrl];
      userModel.userRole = userData[userKeys.userRole];
      userModel.isTester = false;
      userModel.loginType = LoginTypeApp;
      userModel.createdAt = Timestamp.now();
      userModel.updatedAt = Timestamp.now();
      await userService
          .addDocumentWithCustomId(currentUser.uid, userModel)
          .then((value) async {
        //
        // await signInWithEmailPassword(email: userData[userKeys.email], password: userData[userKeys.password]).then((value) {
        //   //
        // });
      }).catchError((e) {
        log("error$e");
        throw e;
      });
    } else {
      throw errorSomethingWentWrong;
    }
  }

  Future<void> signInWithEmailPassword(
      {required String email, required String password}) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      final User user = value.user!;
      UserModel userModel = await userService.getUser(email: user.email);
      setValue(SharedPreferenceKeys.password, password);
      await updateUserData(userModel);
      await setUserDetailPreference(userModel);
    }).catchError((error) async {
      if (!await isNetworkAvailable()) {
        throw 'lbl_please_check_network_connection'.translate;
      }
      if (error.toString() == accessDenied) {
        throw "lbl_you_are_not_allowed_to_login".translate;
      }

      throw 'lbl_enter_valid_email_and_password'.translate;
    });
  }

  Future<void> changePassword(String newPassword) async {
    await FirebaseAuth.instance.currentUser!
        .updatePassword(newPassword)
        .then((value) async {
      //
      await setValue(SharedPreferenceKeys.password, newPassword);
    });
  }

  Future<void> logout(BuildContext context) async {
    removeKey(SharedPreferenceKeys.isLoggedIn);
    removeKey(SharedPreferenceKeys.isEmailLogin);
    removeKey(SharedPreferenceKeys.firstName);
    removeKey(SharedPreferenceKeys.email);
    removeKey(SharedPreferenceKeys.photoUrl);
    removeKey(SharedPreferenceKeys.uid);
    removeKey(SharedPreferenceKeys.password);
    appStore.setLoggedIn(false);
  }

  Future<void> forgotPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      //
    }).catchError((error) {
      throw error.toString();
    });
  }
}
