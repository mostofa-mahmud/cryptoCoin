import 'package:flutter/material.dart';
import 'package:cryptocurrency_flutter/component/forgot_password_component.dart';
import 'package:cryptocurrency_flutter/main.dart';
import 'package:cryptocurrency_flutter/screens/portfolio_screen.dart';
import 'package:cryptocurrency_flutter/screens/sign_up_screen.dart';
import 'package:cryptocurrency_flutter/services/keys.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginScreen extends StatefulWidget {
  static String tag = '/LoginScreen';
  final bool? isSetting;

  LoginScreen({this.isSetting});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  ///Login with google
  Future<void> loginWithGoogle() async {
    appStore.setIsLoading(true);

    await authService.signInWithGoogle().then(
          (value) {
        appStore.setIsLoading(false);
        toast("lbl_successfully_login".translate);
        appStore.setIsLoading(false);
        if (!widget.isSetting.validate()) {
          finish(context);
          finish(context);
          push(PortFolioScreen(), pageRouteAnimation: PageRouteAnimation.Fade);
        } else {
          finish(context);
        }
      },
    ).catchError(
          (e) {
        appStore.setIsLoading(false);
        toast(e.toString());
        throw e;
      },
    );
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      hideKeyboard(context);

      Map<String, dynamic> data = {
        userKeys.email: emailCont.text,
        userKeys.password: passCont.text,
      };

      appStore.setIsLoading(true);
      authService.signInWithEmailPassword(email: data[userKeys.email], password: data[userKeys.password]).then((value) {
        toast("lbl_successfully_login".translate);
        appStore.setIsLoading(false);
        if (!widget.isSetting.validate()) {
          finish(context);
          finish(context);
          push(PortFolioScreen(), pageRouteAnimation: PageRouteAnimation.Fade);
        } else {
          finish(context);
        }
      }).catchError((e) {
        toast(e.toString());
      }).whenComplete(() => appStore.setIsLoading(false));
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("lbl_dont_have_an_account".translate, style: secondaryTextStyle(size: 14)),
          TextButton(
            onPressed: () {
              SignUpScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
            },
            child: Text('lbl_sign_up'.translate, style: boldTextStyle(size: 14)),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text('', style: boldTextStyle()),
      ),
      backgroundColor: context.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('images/app_images/app_logo.png', height: 60, width: 60, fit: BoxFit.cover),
                            16.height,
                            Text("lbl_sign_in".translate, style: boldTextStyle(size: 22)),
                            4.height,
                            Text('lbl_please_sign_in'.translate, style: secondaryTextStyle()),
                          ],
                        ),
                      ),
                      40.height,
                      // AppTextField(
                      //   controller: emailCont,
                      //   textFieldType: TextFieldType.EMAIL,
                      //   autoFocus: false,
                      //   focus: emailFocus,
                      //   nextFocus: passFocus,
                      //   decoration: AppCommon.inputDecoration('lbl_email'.translate),
                      // ),
                      // 16.height,
                      // AppTextField(
                      //   controller: passCont,
                      //   textFieldType: TextFieldType.PASSWORD,
                      //   focus: passFocus,
                      //   decoration: AppCommon.inputDecoration('lbl_password'.translate),
                      // ),
                      // 16.height,
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: TextButton(
                      //     child: Text('lbl_forgot_password'.translate, style: boldTextStyle(color: secondaryColor, size: 14)),
                      //     onPressed: () {
                      //       showInDialog(
                      //         context,
                      //         contentPadding: EdgeInsets.all(0),
                      //         backgroundColor: context.cardColor,
                      //         builder: (_) => ForgotPasswordComponent(),
                      //         dialogAnimation: DialogAnimation.SLIDE_BOTTOM_TOP,
                      //       );
                      //     },
                      //   ),
                      // ),
                      // 16.height,


                      AppButton(
                        child: Row(
                          children: [
                            Container(
                              decoration: boxDecorationWithRoundedCorners(borderRadius: radius(30), backgroundColor: white),
                              padding: EdgeInsets.all(8),
                              child: GoogleLogoWidget().onTap(() {
                                loginWithGoogle();
                              }),
                            ).paddingAll(16),
                            SizedBox(width: 20,),
                            Text("lbl_sign_in".translate),
                          ],
                        ),
                        width: context.width(),
                        height: 45,
                        color: secondaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        //text: 'lbl_sign_in'.translate,
                        shapeBorder: RoundedRectangleBorder(borderRadius: radius(defaultRadius)),
                        onTap: () {
                          //submit();
                          loginWithGoogle();
                        },
                      ),
                      8.height,
                      AppButton(
                        child: Row(
                          children: [
                            Container(
                              decoration: boxDecorationWithRoundedCorners(borderRadius: radius(30), backgroundColor: white),
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.facebook).onTap(() {
                                loginWithGoogle();
                              }),
                            ).paddingAll(16),
                            SizedBox(width: 20,),
                            Text("lbl_sign_in".translate),
                          ],
                        ),
                        width: context.width(),
                        height: 45,
                        color: secondaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        //text: 'lbl_sign_in'.translate,
                        shapeBorder: RoundedRectangleBorder(borderRadius: radius(defaultRadius)),
                        onTap: () {
                          //submit();
                          loginWithGoogle();
                        },
                      ),
                    ],
                  ).center(),
                  // 16.height,
                  // Text("or_sign_in_another_account".translate, style: secondaryTextStyle()),
                  // Container(
                  //   decoration: boxDecorationWithRoundedCorners(borderRadius: radius(30), backgroundColor: white),
                  //   padding: EdgeInsets.all(8),
                  //   child: GoogleLogoWidget().onTap(() {
                  //     loginWithGoogle();
                  //   }),
                  // ).paddingAll(16),
                ],
              ).paddingAll(16),
            ),
          ),
          Observer(builder: (context) => Loader().visible(appStore.isLoading).center()),
        ],
      ),
    );
  }
}
