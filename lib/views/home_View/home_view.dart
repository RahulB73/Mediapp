import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/consts/lists.dart';
import 'package:mediapp/controller/home_contorller.dart';
import 'package:mediapp/views/category_details_view/category_details_view.dart';
import 'package:mediapp/views/doctor_profile_view/doctors_profile_view.dart';
import 'package:mediapp/views/search_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeContorller());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Row(
          children: [
            welcomes.text.white.bold.make(),
            "User".text.semiBold.color(Colors.amber[100]).make()
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              color: Colors.blue[800],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.searchQueryController,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: search,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  5.widthBox,
                  IconButton(
                    onPressed: () {
                      Get.to(() => SearchView(
                            searchQuery: controller.searchQueryController.text,
                          ));
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(CategoryDetailsView(
                                catName: categoriesNames[index]));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.blue[400],
                            ),
                            height: 44,
                            margin: const EdgeInsets.only(right: 8),
                            child: Column(
                              children: [
                                Image.asset(
                                  categoriesIcons[index],
                                  width: 40,
                                ),
                                5.heightBox,
                                categoriesNames[index]
                                    .text
                                    .size(12)
                                    .semiBold
                                    .white
                                    .make(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  20.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: "Popular Doctors".text.bold.size(16).make(),
                  ),
                  10.heightBox,
                  FutureBuilder<QuerySnapshot>(
                      future: controller.getDoctorsList(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var data = snapshot.data?.docs;
                          return SizedBox(
                            height: 150,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: data?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => DoctorsProfileView(
                                        doc: data[index],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 150,
                                    margin: const EdgeInsets.only(right: 8),
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      color: Color.fromARGB(255, 238, 227, 227),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            width: 150,
                                            alignment: Alignment.center,
                                            color: Colors.blue,
                                            child: Image.asset(icLogin,
                                                width: 100, fit: BoxFit.cover)),
                                        5.heightBox,
                                        Text(
                                            data![index]['docName'].toString()),
                                        5.heightBox,
                                        Text(data[index]['docCategory'],
                                            style: const TextStyle(
                                                color: Colors.black54)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      }),
                  5.heightBox,
                  GestureDetector(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: "View All".text.semiBold.color(Colors.blue).make(),
                    ),
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                      (index) => Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            Image.asset(
                              testList[index],
                              width: 25,
                            ),
                            5.heightBox,
                            testNameList[index].text.white.make(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  30.heightBox,
                  Image.asset(icFooter)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
