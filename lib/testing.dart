// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitforalegend/constants/my_strings.dart';
import 'package:fitforalegend/utils/my_app_bar.dart';
import 'package:fitforalegend/utils/my_app_button.dart';
import 'package:fitforalegend/utils/my_colors.dart';
import 'package:fitforalegend/utils/my_fonts.dart';
import 'package:fitforalegend/utils/my_navigations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import '../apiservices/api_services.dart';
import '../utils/my_utils.dart';
import 'dashboard_bnb_screen.dart';

// ignore: must_be_immutable
class RegisterOtpVerificationMobileScreen extends StatefulWidget {
  String email;
  String firstName;
  String lastName;
  String password;
  String confirmPassword;
  String phoneNumber;
  String countryCode;

  RegisterOtpVerificationMobileScreen({
    super.key,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.confirmPassword,
    required this.countryCode,
    required this.phoneNumber,
  });

  @override
  State<RegisterOtpVerificationMobileScreen> createState() =>
      _RegisterOtpVerificationMobileScreenState();
}

class _RegisterOtpVerificationMobileScreenState
    extends State<RegisterOtpVerificationMobileScreen> {
  final formKey = GlobalKey<FormState>();
  var emailOtpcontroller = TextEditingController();
  var mobileOtpcontroller = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  String currentText = "";
  late Timer emailTimer;
  late Timer mobileTimer;
  int emailOtpSecondsRemaining = 30;
  int mobileOtpSecondsRemaining = 30;
  bool emailEnableResend = false;
  bool mobileEnableResend = false;
  bool isLoading = false;
  String deviceid = "";
  String devicetype = "";
  bool successEmail = false;
  bool successMobile = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    getIds();
  }

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void emailStarttimer() {
    emailTimer = Timer.periodic(
      const Duration(seconds: 1),
          (_) {
        if (emailOtpSecondsRemaining != 0) {
          setState(() {
            emailOtpSecondsRemaining--;
          });
        } else {
          setState(() {
            emailEnableResend = true;
          });
          emailTimer.cancel(); // Cancel the timer when it's no longer needed
        }
      },
    );
  }

  bool enableButton = false;

  @override
  void dispose() {
    // Cancel the timers when the widget is disposed of
    emailTimer.cancel();
    mobileTimer.cancel();
    super.dispose();
  }

  void mobileStarttimer() {
    mobileTimer = Timer.periodic(
      const Duration(seconds: 1),
          (_) {
        if (mobileOtpSecondsRemaining != 0) {
          setState(() {
            mobileOtpSecondsRemaining--;
          });
        } else {
          setState(() {
            mobileEnableResend = true;
          });
          mobileTimer.cancel(); // Cancel the timer when it's no longer needed
        }
      },
    );
  }

  void _emailresendCode() {
    //other code here
    setState(() {
      emailOtpSecondsRemaining = 30;
      emailEnableResend = false;
      successEmail = false;
      emailOtpcontroller.clear();
      emailTimer.cancel();
      emailStarttimer();
    });
  }

  startTimer() {
    emailStarttimer();
    mobileStarttimer();
    setState(() {});
  }

  void _mobileResendCode() {
    //other code here
    setState(() {
      mobileOtpSecondsRemaining = 30;
      mobileEnableResend = false;
      successMobile = false;
      mobileOtpcontroller.clear();
      mobileTimer.cancel();
      mobileStarttimer();
    });
  }

  String deviceId = '';
  String deviceType = '';
  String timeZone = '';

  Future<void> getIds() async {
    try {
      timeZone = await FlutterNativeTimezone.getLocalTimezone();
      debugPrint('timeZone>>$timeZone');
    } catch (e) {}
    if (mounted) {
      setState(() {});
    }
    getDeviceIds();
    setState(() {});
  }

  Future<String?> getDeviceIds() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor!;
      deviceType = "ios";
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.androidId!;
      deviceType = "android";
      debugPrint('deviceId>>$deviceId');
      debugPrint('deviceType>>$deviceType');

      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.colorWhite,
        bottomNavigationBar: AppButton(
            btnHeight: 50,
            isLoading: isLoading,
            buttonColor: successMobile == true
                ? MyColors.color17C6AA
                : const Color(0xFFE4DFDF),
            // : MyColors.colorTextFieldBorder,
            padding:
            const EdgeInsets.only(bottom: 40, left: 30, top: 10, right: 30),
            onPressed: () {
              if (successMobile == true) {
                enableButton = false;
                registerUserApi(context: context);
              } else {
                enableButton = true;
                Utility()
                    .errorToast(msg: "Please verify otp", context: context);
              }
              setState(() {});
            },
            name: 'Continue'),
        appBar: const MyAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MyStrings.verificationCode.tr(),
                    style: const TextStyle(
                        fontFamily: MyFonts.poppinsSemiBold,
                        fontSize: 30,
                        color: MyColors.colorBlack),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text.rich(
                        textAlign: TextAlign.left,
                        TextSpan(
                            text:
                            MyStrings.weHaveSendTheCodeVerificationTo.tr(),
                            style: const TextStyle(
                              fontSize: 17,
                              fontFamily: MyFonts.poppinsRegular,
                              color: Color(0xFF4D4D4D),
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: ' ${MyStrings.yourNumber.tr()}',
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Color(0xFF4D4D4D),
                                ),
                              ),
                              TextSpan(
                                text:
                                ' +${widget.countryCode} ${widget.phoneNumber}',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: MyFonts.poppinsSemiBold,
                                  color: MyColors.color17C6AA,
                                ),
                              ),
                            ])),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: const TextStyle(
                        color: Color(0xff254d71),
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      obscureText: false,
                      obscuringCharacter: '*',
                      autoFocus: false,
                      enablePinAutofill: false,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Please enter mobile otp"; // Validation message for empty field
                        } else if (v.length < 4) {
                          return "Mobile otp must be 4 digits"; // Validation message for less than 4 digits
                        } else {
                          return null; // No validation error
                        }
                      },
                      pinTheme: PinTheme(
                          activeColor: const Color(0xFFC6C6C6),
                          shape: PinCodeFieldShape.box,
                          errorBorderColor: const Color(0xFFC6C6C6),
                          selectedColor: Colors.black,
                          selectedFillColor: const Color(0xFFD3FFF8),
                          borderRadius: BorderRadius.circular(12),
                          fieldHeight: 66,
                          fieldWidth: 66,
                          borderWidth: 1,
                          activeFillColor: const Color(0xFFD3FFF8),
                          inactiveColor: const Color(0xFFC6C6C6),
                          inactiveFillColor: Colors.white),
                      cursorColor: MyColors.color17C6AA,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      keyboardType: TextInputType.number,
                      controller: mobileOtpcontroller,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.white,
                          blurRadius: 1,
                        )
                      ],
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        return true;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        successMobile == true
                            ? SizedBox.shrink()
                            : Row(
                          children: [
                            mobileEnableResend
                                ? Container(
                              alignment: Alignment.center,
                              padding:
                              const EdgeInsets.only(top: 10),
                              child: InkWell(
                                borderRadius:
                                BorderRadius.circular(10),
                                onTap: () {
                                  resendOtpApi(
                                      countryCode:
                                      widget.countryCode,
                                      mobile: widget.phoneNumber,
                                      email: '');
                                },
                                child: const Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "PoppinsRegular",
                                    fontSize: 15,
                                    color: MyColors.color17C6AA,
                                  ),
                                ),
                              ),
                            )
                                : Padding(
                              padding:
                              const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/ic_clock.svg',
                                    height: 25,
                                    width: 25,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${mobileOtpSecondsRemaining}s",
                                    style: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "PoppinsRegular",
                                      fontSize: 15,
                                      color: MyColors.colorBlack,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        successMobile == true
                            ? Row(
                          children: [
                            const Icon(
                              Icons.done,
                              size: 25,
                              color: MyColors.color17C6AA,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              "Verified",
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                fontFamily: "PoppinsRegular",
                                fontSize: 13,
                                color: MyColors.color17C6AA,
                              ),
                            ),
                          ],
                        )
                            : InkWell(
                          onTap: () {
                            verifyOtpForMobile(
                                mobile: widget.phoneNumber,
                                mobileOtp: mobileOtpcontroller.text,
                                countryCode: widget.countryCode);
                          },
                          child: const Text(
                            "Verify",
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontFamily: "PoppinsRegular",
                              fontSize: 13,
                              color: MyColors.color17C6AA,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> resendOtpApi(
      {required String countryCode,
        required String mobile,
        required String email}) async {
    try {
      var request = {};

      if (mobile != '') {
        request['phonecode'] = countryCode;
        request['mobile'] = mobile;
      }
      if (email != '') {
        request['email'] = email;
      }
      Utility.progressLoadingDialog(context, true);
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);
      var response = await http.post(Uri.parse(APIservices.registerOtp),
          body: convert.jsonEncode(request),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
            "api-access-token": APIservices.apiAccessToken,
          });
      Utility.progressLoadingDialog(context, false);
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse["status"] == true) {
        if (email != '') {
          _emailresendCode();
        }
        if (mobile != '') {
          _mobileResendCode();
        }

        if (mounted) {
          Utility()
              .successToast(msg: jsonResponse["message"], context: context);
        }
        setState(() {});
      } else {
        if (mounted) {
          Utility().errorToast(msg: jsonResponse["message"], context: context);
        }
        setState(() {});
      }
    } catch (e) {
      Utility.progressLoadingDialog(context, false);
      Utility().serverErrorToast(context: context);
    }
  }

  Future<void> registerUserApi({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setLoading(true);
      var request = {};
      request['first_name'] = widget.firstName;
      request['last_name'] = widget.lastName;
      request['email'] = widget.email;
      request['country_code'] = widget.countryCode;
      request['mobile'] = widget.phoneNumber;
      request['password'] = widget.password;
      request['fcm_token'] = prefs.getString('fcm_token') ?? '';
      request['device_id'] = deviceId;
      request['device_type'] = deviceType;
      request['time_zone'] = timeZone;
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);
      var response = await http.post(Uri.parse(APIservices.registration),
          body: convert.jsonEncode(request),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
            "api-access-token": APIservices.apiAccessToken,
          });
      setLoading(false);
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse["status"] == true) {
        prefs.setString("token", jsonResponse["data"]["token"].toString());
        prefs.setString("user_name",
            '${jsonResponse["data"]["first_name"]} ${jsonResponse["data"]["last_name"]}');
        prefs.setString("user_id", jsonResponse["data"]["id"]);
        if (jsonResponse['data']['image'] != null) {
          prefs.setString('user_image', jsonResponse['data']['image']);
        }
        prefs.setString("user_email", jsonResponse["data"]["email"]);
        prefs.setString(
            "deviceId", jsonResponse["data"]["deviceinfo"]['device_id']);
        prefs.setString("user_phone",
            "${jsonResponse["data"]["country_code"]} ${jsonResponse["data"]["mobile"]}");
        prefs.setBool("is_user_login", true);
        if (mounted) {
          CustomNavigator.pushAndRemoveUntill(
              context,
              DashboardScreen(
                pageIndex: 0,
              ));
        }
        setState(() {});
      } else {
        if (mounted) {
          Utility().errorToast(msg: jsonResponse["message"], context: context);
        }
        setState(() {});
      }
    } catch (e) {
      setLoading(false);
      Utility().serverErrorToast(context: context);
    }
  }

  Future<void> verifyOtpForEmail(
      {required String email, required String emailOtp}) async {
    try {
      Utility.progressLoadingDialog(context, true);
      var request = {};
      request['email'] = email;
      request['otp'] = emailOtp;
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);
      var response = await http.post(Uri.parse(APIservices.verifyOtpEmail),
          body: convert.jsonEncode(request),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
            "api-access-token": APIservices.apiAccessToken,
          });
      if (mounted) Utility.progressLoadingDialog(context, false);
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse["status"] == true) {
        successEmail = true;
        if (mounted) {
          Utility()
              .successToast(msg: jsonResponse["message"], context: context);
        }

        setState(() {});
      } else {
        successEmail = false;
        if (mounted) {
          Utility().errorToast(msg: jsonResponse["message"], context: context);
        }
        setState(() {});
      }
    } catch (e) {
      successEmail = false;
      Utility.progressLoadingDialog(context, false);
      Utility().serverErrorToast(context: context);
    }
  }

  Future<void> verifyOtpForMobile(
      {required String mobile,
        required String mobileOtp,
        required String countryCode}) async {
    try {
      Utility.progressLoadingDialog(context, true);
      var request = {};
      request['phonecode'] = countryCode;
      request['mobile'] = mobile;
      request['otp'] = mobileOtp;
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);
      var response = await http.post(Uri.parse(APIservices.verifyOtpMobile),
          body: convert.jsonEncode(request),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
            "api-access-token": APIservices.apiAccessToken,
          });
      if (mounted) Utility.progressLoadingDialog(context, false);
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse["status"] == true) {
        successMobile = true;
        if (mounted) {
          Utility()
              .successToast(msg: jsonResponse["message"], context: context);
        }
        setState(() {});
      } else {
        successMobile = false;
        if (mounted) {
          Utility().errorToast(msg: jsonResponse["message"], context: context);
        }
        setState(() {});
      }
    } catch (e) {
      successMobile = false;
      Utility.progressLoadingDialog(context, false);
      Utility().serverErrorToast(context: context);
    }
  }
}