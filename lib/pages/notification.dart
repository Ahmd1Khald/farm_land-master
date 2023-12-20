import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../servises/firebase_servise.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataSnapshot>(
      stream: FirebaseDataService().dataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DataSnapshot? data = snapshot.data;
          //print(data!.value);
          print("----------------------------------------");
          if (data?.value != null) {
            Object? image = snapshot.data!
                .child('-Nm2e1dBRFgtsJJdOtVq')
                .child('photo_url')
                .value;
            print(image);

            return Scaffold(
              backgroundColor: Colors.green.shade300,
              appBar: AppBar(
                backgroundColor: Colors.green.shade900,
                title: const Text(
                  "Notification",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                actions: [
                  SizedBox(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///Todo for loop to show all images
                  Center(
                    child: SizedBox(
                      height: 300,
                      width: 300,
                      child:
                          Image.network(image.toString(), fit: BoxFit.contain),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.green.shade300,
              appBar: AppBar(
                backgroundColor: Colors.green.shade900,
                title: const Text(
                  "Notification",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                actions: [
                  SizedBox(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                ],
              ),
              body: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            );
          }
        } else {
          return Scaffold(
            backgroundColor: Colors.green.shade300,
            appBar: AppBar(
              backgroundColor: Colors.green.shade900,
              title: const Text(
                "Notification",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              actions: [
                SizedBox(
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  const BorderSide(color: Colors.black))),
                    ),
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              ],
            ),
            body: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
