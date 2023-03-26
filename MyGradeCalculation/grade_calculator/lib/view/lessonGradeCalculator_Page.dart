import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../calculation/calculateTotalGrade.dart';
import '../constants/constants.dart';
import '../myWidgets/lessonGradeCalculatorPageWidgets/myRecordButtonWidget.dart';
import '../myWidgets/lessonGradeCalculatorPageWidgets/myStatWidget.dart';
import 'calculation_page.dart';

class LessonGrade {
  String? name;
  double? grade;

  LessonGrade(this.name, this.grade);
}

class LessonGradeCalculator extends StatefulWidget {
  final String? selectedTerm;
  final String? uid;

  const LessonGradeCalculator({Key? key, required this.selectedTerm, this.uid})
      : super(key: key);

  @override
  _LessonGradeCalculatorState createState() => _LessonGradeCalculatorState();
}

Future<void> addDataToDocument(
    String collection, String documentId, Map<String, dynamic> data) async {
  await FirebaseFirestore.instance
      .collection(collection)
      .doc(documentId)
      .set(data);
}

Future<void> updateUserData(String uid, String term, double average) async {
  final DocumentReference documentRef =
      FirebaseFirestore.instance.collection('Users').doc(uid);
  Map<String, dynamic> userData = {
    term: average,
  };
  await documentRef.update(userData);
}

class _LessonGradeCalculatorState extends State<LessonGradeCalculator> {
  late String _selectedTerm;
  late String? uid;

  @override
  void initState() {
    super.initState();
    uid = widget.uid;
    _selectedTerm = widget.selectedTerm!;
  }

  final CalculateTotal _calculateTotal = CalculateTotal();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  double _average = 0.0;

  int numberOfLessons = 1;
  List<LessonGrade> lessonGrades = [LessonGrade('', 0.0)];

  void calculateCourseGrade(int index) async {
    LessonGrade lessonGrade = lessonGrades[index];
    double newGrade = await Get.to(() => const CourseGradeCalculator());
    setState(() {
      lessonGrades[index] = LessonGrade(lessonGrade.name, newGrade);
    });
  }

  @override
  Widget build(BuildContext context) {
    _average =
        _calculateTotal.calculateAverageOfGrade(numberOfLessons, lessonGrades);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ders Notunu Hesaplama'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Kaç Dersin Var:',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            DropdownButton<int>(
              value: numberOfLessons,
              items: List.generate(
                  10,
                  (index) => DropdownMenuItem(
                        value: index + 1,
                        child: Text('${index + 1}'),
                      )),
              onChanged: (value) {
                setState(() {
                  numberOfLessons = value!;
                  lessonGrades = List.generate(
                      numberOfLessons, (index) => LessonGrade('', 0.0));
                });
              },
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Ders adını gir ve notları hesapla: ',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                  itemCount: numberOfLessons,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Ders Adı',
                            ),
                            onChanged: (value) {
                              lessonGrades[index].name = value;
                            },
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            '${lessonGrades[index].grade?.toStringAsFixed(2)} ',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        ElevatedButton(
                          child: const Text('Hesapla'),
                          onPressed: () {
                            calculateCourseGrade(index);
                          },
                        ),
                      ],
                    );
                  }),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Ders Notları:',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: numberOfLessons,
                itemBuilder: (context, index) {
                  final grade = lessonGrades[index].grade;
                  final letterGrade = _calculateTotal.getLetterGrade(grade!);
                  final score = _calculateTotal.getScore(letterGrade);
                  final status = _calculateTotal.getStatus(letterGrade);

                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${lessonGrades[index].name}:',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      myStatWidget(
                          grade: grade,
                          letterGrade: letterGrade,
                          score: score,
                          status: status),
                    ],
                  );
                },
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                width: double.infinity,
                decoration: MyBoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Dönem Ortalaman: ',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    Text(
                      '$_average',
                      style: const TextStyle(fontSize: 25.0),
                    )
                  ],
                ),
              ),
            ),
            myRecordButtonWidget(
                uid: uid, selectedTerm: _selectedTerm, average: _average),
          ],
        ),
      ),
    );
  }
}
