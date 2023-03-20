import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/authPages/welcome_page.dart';
import '../../view/lessonGradeCalculator_Page.dart';

class myCalculatorButtonWidget extends StatelessWidget {
  const myCalculatorButtonWidget({
    super.key,
    required String? selectedTerm,
    required this.widget,
  }) : _selectedTerm = selectedTerm;

  final String? _selectedTerm;
  final WelcomePage widget;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _selectedTerm == null
          ? null
          : () {
              Get.to(() => LessonGradeCalculator(
                    selectedTerm: _selectedTerm,
                    uid: widget.uid,
                  ));
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedTerm == null ? Colors.grey : Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        'Üniversite Notunu Hesapla',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
