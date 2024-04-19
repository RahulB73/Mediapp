import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';

class AppointmentController extends GetxController {
  var isLoading = false.obs;
  var appTimeController = TextEditingController();
  var appDayController = TextEditingController();
  var appNameController = TextEditingController();
  var appMobController = TextEditingController();
  var appMassageController = TextEditingController();

  bookAppointment(String docId, String docName, context) async {
    isLoading(true);
    var store = FirebaseFirestore.instance.collection('appointments').doc();
    await store.set({
      'appBy': FirebaseAuth.instance.currentUser?.uid,
      'appTime': appTimeController.text,
      'appDay': appDayController.text,
      'appName': appNameController.text,
      'appMob': appMobController.text,
      'appMassage': appMassageController.text,
      'appWith': docId,
      'appWithName': docName
    });

    isLoading(false);
    VxToast.show(context, msg: 'Your Appointment is Booked Succsessfully 😀😀');
    Get.back();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAppointment(bool isDoctor) {
    if(isDoctor){
      return FirebaseFirestore.instance.collection('appointments').where('appWith', isEqualTo: FirebaseAuth.instance.currentUser?.uid).get();
    }else{
return FirebaseFirestore.instance.collection('appointments').where('appBy', isEqualTo: FirebaseAuth.instance.currentUser?.uid).get();
    }
     
  }
}
