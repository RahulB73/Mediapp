import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/controller/auth_controller.dart';
import 'package:mediapp/res/components/custom_button.dart';
import 'package:mediapp/res/components/custom_textfield.dart';
import 'package:mediapp/views/home_View/home.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
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
                    icSignup,
                    width: 180,
                  ),
                  10.heightBox,
                  exploring.text.semiBold
                      .size(18)
                      .align(TextAlign.center)
                      .make(),
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
                        hint: nameHint,
                        textController: controller.fullnameController,
                      ),
                      10.heightBox,
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
                        title: "Signup as a Doctor 👩‍⚕️".text.bold.make(),
                        value: isDoctor,
                        onChanged: (newValue) {
                          setState(
                            () {
                              isDoctor = newValue;
                            },
                          );
                        },
                      ),
                      Visibility(
                        visible: isDoctor,
                        child: Column(
                          children: [
                            CustomTextField(
                              hint: "About",
                              textController: controller.aboutController,
                            ),
                            10.heightBox,
                            CustomTextField(
                              hint: "Category",
                              textController: controller.categoryController,
                            ),
                            10.heightBox,
                            CustomTextField(
                              hint: "Services",
                              textController: controller.servicesController,
                            ),
                            10.heightBox,
                            CustomTextField(
                              hint: "Address",
                              textController: controller.addressController,
                            ),
                            10.heightBox,
                            CustomTextField(
                              hint: "Timing",
                              textController: controller.timingController,
                            ),
                            10.heightBox,
                            CustomTextField(
                              hint: "Phone Number",
                              textController: controller.phoneController,
                            ),
                          ],
                        ),
                      ),
                      20.heightBox,
                      CustomButton(
                          onTap: () async {
                            await controller.signupUser(isDoctor);
                            if (controller.userCredential != null) {
                              Get.offAll(() => const Home());
                            }
                          },
                          buttonText: signup),
                      20.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          alreadyHaveAnAcc.text.size(16).make(),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: login.text
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
