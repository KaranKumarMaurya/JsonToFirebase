// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           child: Center(
//             child: Column(
//               children: [
//                 Text("Json Data Sent to Firebase"),
//                 MaterialButton(
//                   color: Colors.blue,
//                   onPressed: () async {
//                     DocumentSnapshot content = await FirebaseFirestore.instance
//                         .collection("Json")
//                         .doc()
//                         .get();
//                     print(content);
//                     Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                             builder: (BuildContext context) => HomePage()));
//                   },
//                   child: Text("Fetch Data"),
//                 )
//               ],
//             ),class productDataModel{
import 'package:flutter/services.dart';

class productDataModel {
  String? productName;
  String? productUrl;
  String? productRating;
  String? productDescription;

  productDataModel(
      {this.productName,
      this.productUrl,
      this.productRating,
      this.productDescription});

  productDataModel.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    productUrl = json['productUrl'];
    productRating = json['productRating'];
    productDescription = json['productDescription'];
  }
}
//           ),
//         ),
//       ),
//     );
//   }
// }
