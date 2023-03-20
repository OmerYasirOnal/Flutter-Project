import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grade_calculator/constants/constants.dart';

class myHistoryGradesWidget extends StatelessWidget {
  const myHistoryGradesWidget({
    super.key,
    required this.uid,
  });

  final String? uid;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc('$uid')
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> asyncSnapshot) {
          if (asyncSnapshot.hasData &&
              asyncSnapshot.data != null &&
              asyncSnapshot.data!.exists) {
            Map<String, dynamic> data =
                asyncSnapshot.data!.data() as Map<String, dynamic>;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                const Divider(height: 20),
                Text(
                  'Not Listesi',
                  style: kMetinStily,
                ),
                const Divider(height: 20),
                for (int i = 1; i < data.length + 1; i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.9),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '$i: ${data['$i']}',
                              style: kGradesStily,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white70.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc('$uid')
                                  .update({
                                '$i': FieldValue.delete(),
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            );
          } else if (asyncSnapshot.hasError) {
            return Text('Error: ${asyncSnapshot.error}');
          } else {
            return const Text('Henüz Hiç Not Bilgisi Eklenmedi.',
                style: TextStyle(fontSize: 20));
          }
        },
      ),
    );
  }
}
