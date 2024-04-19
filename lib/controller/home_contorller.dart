import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';

class HomeContorller extends GetxController{
  var searchQueryController = TextEditingController();
  var isLoading = false.obs;

  Future<QuerySnapshot<Map<String, dynamic>>> getDoctorsList() async {
    var doctors = FirebaseFirestore.instance.collection('doctor').get();
    return doctors;
  }
}