import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/res/components/custom_button.dart';
import 'package:mediapp/views/appointement_view/appointement_view.dart';

class DoctorsProfileView extends StatelessWidget {
  final DocumentSnapshot doc;

  const DoctorsProfileView({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue[400],
        title: const Text(
          "Doctors Detail",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: Image.asset(icLogin),
                    ),
                    10.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doc['docName'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Vx.randomPrimaryColor,
                            ),
                          ),
                          Text(
                            doc['docCategory'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: fontGrey,
                            ),
                          ),
                          const Spacer(),
                          VxRating(
                            onRatingUpdate: (value) {},
                            count: 5,
                            maxRating: 5,
                            selectionColor: Colors.yellow,
                            value: double.parse(doc['docRating'].toString()),
                            stepInt: true,
                          ),
                        ],
                      ),
                    ),
                    "See all reviews".text.blue400.semiBold.size(14).make(),
                  ],
                ),
              ),
              10.heightBox,
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: "Phone Number".text.bold.size(16).make(),
                      subtitle: Text(
                        doc['docPhone'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600, // semiBold
                          fontSize: 14,
                          color: Color.fromARGB(255, 62, 62, 62),
                        ),
                      ),
                      trailing: Container(
                        width: 50,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.yellow[800],
                        ),
                        child: const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    10.heightBox,
                    "About".text.bold.size(18).align(TextAlign.start).make(),
                    5.heightBox,
                    Text(
                      doc['docAbout'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.grey[500],
                      ),
                    ),
                    10.heightBox,
                    "Timing".text.bold.size(18).align(TextAlign.start).make(),
                    5.heightBox,
                    Text(
                      doc['docTiming'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.grey[500],
                      ),
                    ),
                    10.heightBox,
                    "Address".text.bold.size(18).align(TextAlign.start).make(),
                    5.heightBox,
                    Text(
                      doc['docAddress'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.grey[500],
                      ),
                    ),
                    10.heightBox,
                    "Services".text.bold.size(18).align(TextAlign.start).make(),
                    5.heightBox,
                    Text(
                      doc['docServices'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: CustomButton(
            onTap: () {
              Get.to(
                () => AppointementView(
                  docId: doc['docId'],
                  docName: doc['docName'],
                ),
              );
            },
            buttonText: "Book An Appointment"),
      ),
    );
  }
}
