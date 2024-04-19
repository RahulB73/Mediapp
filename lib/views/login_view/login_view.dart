import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/controller/auth_controller.dart';
import 'package:mediapp/res/components/custom_button.dart';
import 'package:mediapp/res/components/custom_textField.dart';
import 'package:mediapp/views/appointement_details_view/appointment_details_view.dart';

import 'package:mediapp/views/home_View/home.dart';
import 'package:mediapp/views/signup_view/signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var isDoctor = false;
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            SizedBox(
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    icLogin,
                    width: 180,
                  ),
                  10.heightBox,
                  welcome.text.semiBold.size(18).make(),
                  weAreExcited.text.semiBold.size(12).make(),
                ],
              ),
            ),
            30.heightBox,
            Expanded(
              flex: 2,
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                        hint: emailHint,
                        textController: controller.emailController,
                      ),
                      10.heightBox,
                      CustomTextField(
                        hint: passHint,
                        textController: controller.passwordController,
                      ),
                      10.heightBox,
                      SwitchListTile(
                        value: isDoctor,
                        onChanged: (newValue) {
                          setState(() {
                            isDoctor = newValue;
                          });
                        },
                        title: "Sign In As Doctor 🧑‍⚕️".text.make(),
                      ),
                      20.heightBox,
                      Align(
                        alignment: Alignment.centerRight,
                        child: forgetPass.text
                            .size(16)
                            .semiBold
                            .color(Colors.blue)
                            .make(),
                      ),
                      20.heightBox,
                      CustomButton(
                          onTap: () async {
                            await controller.loginUser();
                            if (controller.userCredential != null) {
                              if (isDoctor) {
                                Get.to(() => const AppointmentDetailsView());
                              } else {
                                Get.to(() => const Home());
                              }
                            }
                          },
                          buttonText: login),
                      20.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          dontHaveAccount.text.size(16).make(),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const SignupView(),
                              );
                            },
                            child: signup.text
                                .size(16)
                                .semiBold
                                .color(Colors.blue)
                                .make(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
