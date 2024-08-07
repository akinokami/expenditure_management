import 'package:expenditure_management/constants/color_const.dart';
import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/login_controller.dart';
import '../../custom_widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isAccepted = false;
  bool isChecked = false;
  int firstTime = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        firstTime = prefs.getInt('firstTime') ?? 0;
        print("First Time: $firstTime");
        if (firstTime == 0) {
          if(context.mounted) {
            showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => Builder(builder: (context) {
              return StatefulBuilder(
                builder: (context, StateSetter setState) {
                  return AlertDialog(
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SingleChildScrollView(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.65,
                              width: double.infinity,
                              //width: MediaQuery.of(context).size.width * 0.90,
                              child: InAppWebView(
                                // Initial URL request for the web view.
                                initialData: InAppWebViewInitialData(data: """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Flutter InAppWebView</title>
</head>
<body>

<h3>Privacy Policy</h3>
<div class="tyJCtd mGzaTb Depvyb baZpAe">
    <p dir="ltr" class="zfr3Q CDt4Ke " style="">
        <span class="C9DxTc " style="">This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service. If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.</span>
    </p>

    <p dir="ltr" class="zfr3Q CDt4Ke " style="">
<span class="C9DxTc " style="">The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at MKSports Live unless otherwise defined in this Privacy Policy.
Information Collection and Use For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request will be retained on your device and is not collected by me in any way.
The app does use third-party services that may collect information used to identify you.</span>
    </p>
    <p dir="ltr" class="zfr3Q CDt4Ke " style="">
        <span class="C9DxTc " style="">Link to the privacy policy of third-party service providers used by the app</span>
    </p>
    <p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">•</span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style="">Google Play Services</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">•</span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style="">Facebook</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">•</span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style="">Adjust</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">Log Data</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">Cookies</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">Service Providers</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">I may employ third-party companies and individuals due to the following reasons:</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">•</span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style="">To facilitate our Service;</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">•</span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style="">To provide the Service on our behalf;</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">•</span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style="">To perform Service-related services; or</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">•</span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style=""><span class="Apple-tab-span " style="white-space: pre;"> </span></span><span class="C9DxTc " style="">To assist us in analyzing how our Service is used.</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">Security</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">Links to Other Sites</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assumeno responsibility for the content, privacy policies, or practices of any third-party sites or services.</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">Children’s Privacy</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">These Services do not address anyone under the age of 18. I do not knowingly collect personally identifiable information from children under 18 years of age. In the case I discover that a child under 18 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions.</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">Changes to This Privacy Policy</span></p><p dir="ltr" class="zfr3Q CDt4Ke " style=""><span class="C9DxTc " style="">I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.</span></p></div>


</body>
</html>
"""),

                                // Initial options for the web view, configuring platform-specific and cross-platform settings.
                                initialOptions: InAppWebViewGroupOptions(
                                  android: AndroidInAppWebViewOptions(
                                    cacheMode: AndroidCacheMode.LOAD_DEFAULT,
                                    useHybridComposition: true,
                                    useShouldInterceptRequest: true,
                                  ),
                                  crossPlatform: InAppWebViewOptions(
                                    cacheEnabled: true,
                                    useShouldOverrideUrlLoading: true,
                                    javaScriptEnabled: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Text(Global.policy, style: TextStyle(fontSize: 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                activeColor: Colors.green,
                                side: BorderSide(
                                  width: 1.5,
                                  color:
                                  isChecked ? Colors.green : Colors.black,
                                ),
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                    if (isChecked) {
                                      isAccepted = true;
                                    } else {
                                      isAccepted = false;
                                    }
                                  });
                                },
                              ),
                              Text('I agreed to the Privacy Policy.',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ))
                            ],
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith((states) => isAccepted? secondaryColor:greyColor)
                            ),
                            child: Text(
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              'Accept',
                            ),
                            onPressed: isAccepted
                                ? () async {
                              SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              prefs.setInt('firstTime', 1);
                              Navigator.pop(context);
                            }
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          );
          }
        }
      } catch (e) {
        print("Error fetching SharedPreferences: $e");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/google.webp',
              width: 70.h,
              height: 70.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomText(
              text: 'expenditure_management'.tr,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
              image: 'assets/images/google.webp',
              text: 'sign_in_with_google'.tr,
              bgColor: Colors.white,
              txtColor: Colors.black,
              onTap: () {
                loginController.loginWithGoogle();
              },
            ),
          ],
        ),
      ),
    );
  }
}
