import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/consts/lists.dart';
import 'package:mediapp/controller/auth_controller.dart';
import 'package:mediapp/controller/settings_controller.dart';
import 'package:mediapp/views/login_view/login_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SettingsController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: settings.text.white.make(),
        backgroundColor: Colors.blue[400],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Image.asset(icLogin),
                    ),
                    title: controller.username.value.text.make(),
                    subtitle: controller.email.value.text.make(),
                  ),
                  const Divider(),
                  20.heightBox,
                  ListView(
                    shrinkWrap: true,
                    children: List.generate(
                      settingsList.length,
                      (index) => ListTile(
                        onTap: () async {
                          if (index == 3) {
                            AuthController().signout();
                            Get.offAll(() => const LoginView());
                          }
                        },
                        leading: Icon(settingsListIcons[index],
                            color: Vx.randomPrimaryColor),
                        title: settingsList[index].text.bold.size(16).make(),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
