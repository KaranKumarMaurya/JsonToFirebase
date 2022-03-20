// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:karan/HomPage.dart';
// import 'package:firebase_core/firebase_core.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Main(),
//     );
//   }
// }

// class Main extends StatefulWidget {
//   const Main({Key? key}) : super(key: key);

//   @override
//   State<Main> createState() => _MainState();
// }

// class _MainState extends State<Main> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           child: Center(
//               child: MaterialButton(
//         color: Colors.blue,
//         onPressed: () {
//           Map<String, dynamic> data = {items[index].producturl.toString()};
//           FirebaseFirestore.instance.collection("Json").add(data);
//           Navigator.pushReplacement(context,
//               MaterialPageRoute(builder: (BuildContext context) => HomePage()));
//         },
//         child: Text("Push Data"),
//       ))),
//     );
//   }
// }
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:ecommerce_app/productDataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:karan/productDataModel.dart';
import 'package:path/path.dart' as Path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
          future: readJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var items = data.data as List<productDataModel>;
              return RaisedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                  for (var i = 0; i < items.length; i++) {
                    Map<String, dynamic> data = {
                      "ProductName": items[i].productName.toString(),
                      "ProductUrl": items[i].productUrl.toString(),
                      "ProductRating": items[i].productRating.toString(),
                      "ProductDescription":
                          items[i].productDescription.toString()
                    } as Map<String, dynamic>;
                    FirebaseFirestore.instance.collection("Json").add(data);
                  }
                },
                child: Text("push"),
              );
              // return ListView.builder(
              //     itemCount: items == null ? 0 : items.length,
              //     itemBuilder: (context, index) {
              //       return RaisedButton(
              //         onPressed: () {
              //           // for (var i = 0; i < items.length; i++) {
              //           //   Map<String, dynamic> data = {
              //           //     "field": items[index].productName.toString()
              //           //   } as Map<String, dynamic>;
              //           //   FirebaseFirestore.instance
              //           //       .collection("Json")
              //           //       .add(data);
              //           },

              //         child: Text("push it"),
              //       );
              //       // return Card(
              //       //   elevation: 5,
              //       //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              //       //   child: Container(
              //       //     padding: EdgeInsets.all(8),
              //       //     child: Row(
              //       //       mainAxisAlignment: MainAxisAlignment.center,
              //       //       crossAxisAlignment: CrossAxisAlignment.center,
              //       //       children: [
              //       //         Container(
              //       //           width: 50,
              //       //           height: 50,
              //       //           child: Image(
              //       //             image: NetworkImage(
              //       //                 items[index].productUrl.toString()),
              //       //             fit: BoxFit.fill,
              //       //           ),
              //       //         ),
              //       //         Expanded(
              //       //             child: Container(
              //       //           padding: EdgeInsets.only(bottom: 8),
              //       //           child: Column(
              //       //             mainAxisAlignment: MainAxisAlignment.center,
              //       //             crossAxisAlignment: CrossAxisAlignment.start,
              //       //             children: [
              //       //               Padding(
              //       //                 padding: EdgeInsets.only(left: 8, right: 8),
              //       //                 child: Text(
              //       //                   items[index].productName.toString(),
              //       //                   style: TextStyle(
              //       //                       fontSize: 16,
              //       //                       fontWeight: FontWeight.bold),
              //       //                 ),
              //       //               ),
              //       //               Padding(
              //       //                 padding: EdgeInsets.only(left: 8, right: 8),
              //       //                 child: Text(items[index]
              //       //                     .productDescription
              //       //                     .toString()),
              //       //               ),
              //       //               Padding(
              //       //                 padding: EdgeInsets.only(left: 8, right: 8),
              //       //                 child: Text(
              //       //                     items[index].productRating.toString()),
              //       //               ),
              //       //             ],
              //       //           ),
              //       //         ))
              //       //       ],
              //       //     ),
              //       //   ),
              //       // );
              //     });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Future<List<productDataModel>> readJsonData() async {
    final jsonData =
        await rootBundle.rootBundle.loadString("assets/jsonData.json");
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => productDataModel.fromJson(e)).toList();
  }

  // Future uploadFile() async {
  //   int i = 1;
  //
  //   for (var img in _image) {
  //     setState(() {
  //       val = i / _image.length;
  //     });
  //     ref = firebase_storage.FirebaseStorage.instance
  //         .ref()
  //         .child('images/${Path.basename(img.path)}');
  //     await ref.putFile(img).whenComplete(() async {
  //       await ref.getDownloadURL().then((value) {
  //         imgRef.add({'url': value});
  //         i++;
  //       });
  //     });
  //   }
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   imgRef = FirebaseFirestore.instance.collection('imageURLs');
  // }

}
