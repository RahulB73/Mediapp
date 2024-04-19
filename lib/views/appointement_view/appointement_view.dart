import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/controller/appointemnt_controller.dart';
import 'package:mediapp/res/components/custom_button.dart';
import 'package:mediapp/res/components/custom_textfield.dart';

class AppointementView extends StatelessWidget {
  final String docId;
  final String docName;
  const AppointementView(
      {super.key, required this.docId, required this.docName});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmentController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue[400],
        title: Text(
          docName,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Select Appointment Day".text.bold.size(18).make(),
              5.heightBox,
              CustomTextField(
                hint: "Select Text",
                textController: controller.appDayController,
              ),
              10.heightBox,
              "Select Appointment Time".text.bold.size(18).make(),
              5.heightBox,
              CustomTextField(
                  hint: "Select Time",
                  textController: controller.appTimeController),
              20.heightBox,
              "Your Name :".text.bold.size(18).make(),
              5.heightBox,
              CustomTextField(
                  hint: "Enter Your Name",
                  textController: controller.appNameController),
              10.heightBox,
              "Your Mobile Number :".text.bold.size(18).make(),
              5.heightBox,
              CustomTextField(
                  hint: "Enter Your Mobile Number",
                  textController: controller.appMobController),
              10.heightBox,
              "Your Message :".text.bold.size(18).make(),
              5.heightBox,
              CustomTextField(
                  hint: "Enter Your Message",
                  textController: controller.appMassageController),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(12),
          child: controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CustomButton(
                  onTap: () async {
                    await controller.bookAppointment(docId, docName, context);
                  },
                  buttonText: "Book An Appointment"),
        ),
      ),
    );
  }
}
