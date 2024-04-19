import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/views/appointement_details_view/appointment_details_view.dart';
import 'package:mediapp/views/home_View/home.dart';
import 'package:mediapp/views/login_view/login_view.dart';

class AuthController extends GetxController {
  // User Data
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // Doctor DAta
  var aboutController = TextEditingController();
  var servicesController = TextEditingController();
  var timingController = TextEditingController();
  var addressController = TextEditingController();
  var categoryController = TextEditingController();
  var phoneController = TextEditingController();

  UserCredential? userCredential;

  isUserAlreadyLoggedIn() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        var data = await FirebaseFirestore.instance
            .collection('doctor')
            .doc(user.uid)
            .get();
        var isDoc = data.data()?.containsKey('docName') ?? false;

        if (isDoc) {
          Get.offAll(() => const AppointmentDetailsView());
        } else {
          Get.offAll(() => const Home());
        }
      } else {
        Get.offAll(() => const LoginView());
      }
    });
  }

  loginUser() async {
    userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }

  signupUser(bool isDoctor) async {
    userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    await storeUserData(userCredential!.user!.uid, fullnameController.text,
        emailController.text, isDoctor);
  }

  storeUserData(
      String uid, String fullname, String email, bool isDoctor) async {
    var store = FirebaseFirestore.instance
        .collection(isDoctor ? 'doctor' : 'user')
        .doc(uid);
    if (isDoctor) {
      await store.set(
        {
          'docAbout': aboutController.text,
          'docServices': servicesController.text,
          'docTiming': timingController.text,
          'docPhone': phoneController.text,
          'docAddress': addressController.text,
          'docCategory': categoryController.text,
          'docId': FirebaseAuth.instance.currentUser?.uid,
          'docRating': 3,
          'docEmail': email,
          'docName': fullname,
        },
      );
    } else {
      await store.set({'fullname': fullname, 'email': email});
    }
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
