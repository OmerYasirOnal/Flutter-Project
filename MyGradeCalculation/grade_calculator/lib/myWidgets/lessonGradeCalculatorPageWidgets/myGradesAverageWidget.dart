import 'package:flutter/cupertino.dart';

import '../../constants/constants.dart';

class myGradesAverageWidget extends StatelessWidget {
  myGradesAverageWidget({
    super.key,
    required double average,
  }) : _average = average;

  final double _average;

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
