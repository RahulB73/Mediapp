import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/views/doctor_profile_view/doctors_profile_view.dart';

class SearchView extends StatelessWidget {
  final String searchQuery;
  const SearchView({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: "Search Results".text.white.make(),
        backgroundColor: Colors.blue[400],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('doctor').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 170,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var doc = snapshot.data!.docs[index];

                  return !(doc['docName'].toString().toLowerCase())
                          .contains(searchQuery.toLowerCase())
                      ? const SizedBox.shrink()
                      : Container(
                          height: 100,
                          width: 150,
                          margin: const EdgeInsets.only(right: 8),
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            color: Color.fromARGB(255, 238, 227, 227),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  color: Colors.blue,
                                  child: Image.asset(icLogin,
                                      width: 120, fit: BoxFit.cover)),
                              5.heightBox,
                              Text(
                                doc['docName'],
                              ),
                              5.heightBox,
                              VxRating(
                                onRatingUpdate: (value) {},
                                count: 5,
                                maxRating: 5,
                                selectionColor: Colors.yellow,
                                value:
                                    double.parse(doc['docRating'].toString()),
                                stepInt: true,
                              ),
                            ],
                          ),
                        ).onTap(() {
                          Get.to(DoctorsProfileView(doc: doc));
                        });
                },
              ),
            );
          }
        },
      ),
    );
  }
}
