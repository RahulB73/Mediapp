import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediapp/consts/consts.dart';

class AppointmentCheckView extends StatelessWidget {
  final DocumentSnapshot doc;
  const AppointmentCheckView({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue[400],
        title: const Text(
          "Appointment Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Patient Appointment Day".text.bold.size(18).make(),
            5.heightBox,
            Text(
              doc['appDay'],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color.fromARGB(255, 145, 174, 243),
              ),
            ),
            10.heightBox,
            "Patient Appointment Time".text.bold.size(18).make(),
            5.heightBox,
            Text(
              doc['appTime'],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color.fromARGB(255, 145, 174, 243),
              ),
            ),
            20.heightBox,
            "Patient Name :".text.bold.size(18).make(),
            5.heightBox,
            Text(
              doc['appName'],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color.fromARGB(255, 145, 174, 243),
              ),
            ),
            10.heightBox,
            "Patient Mobile Number :".text.bold.size(18).make(),
            5.heightBox,
            Text(
              doc['appMob'],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color.fromARGB(255, 145, 174, 243),
              ),
            ),
            10.heightBox,
            "Patient Message :".text.bold.size(18).make(),
            5.heightBox,
            Text(
              doc['appMassage'],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color.fromARGB(255, 145, 174, 243),
              ),
            ),
            10.heightBox,
            "Doctor Name :".text.bold.size(18).make(),
            5.heightBox,
            Text(
              doc['appWithName'],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color.fromARGB(255, 145, 174, 243),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
