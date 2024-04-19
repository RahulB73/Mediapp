import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/controller/appointemnt_controller.dart';
import 'package:mediapp/controller/auth_controller.dart';
import 'package:mediapp/views/appointment_check_view/appointment_check_view.dart';

class AppointmentDetailsView extends StatelessWidget {
  final bool isDoctor;
  const AppointmentDetailsView({super.key, this.isDoctor = false});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmentController());

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.blue[400],
          title: const Text(
            "Appointment Detail",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                AuthController().signout();
              },
              icon: const Icon(
                Icons.power_settings_new_rounded,
                color: whiteColor,
              ),
            )
          ],
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: controller.getAppointment(isDoctor),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data = snapshot.data?.docs;
              return Padding(
                padding: const EdgeInsets.all(12),
                child: ListView.builder(
                  itemCount: data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        Get.to(
                          () => AppointmentCheckView(
                            doc: data[index],
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        child: Image.asset(icLogin),
                      ),
                      title: Text(
                        data![index][!isDoctor ? 'appWithName' : 'appName'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        "${data[index]['appTime']} - ${data[index]['appDay']}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.grey[500],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ));
  }
}
