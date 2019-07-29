import 'package:flutter/material.dart';

class MedicalRecord extends StatefulWidget{
  @override
  _MedicalRecordState createState() => _MedicalRecordState();

}

class _MedicalRecordState extends State<MedicalRecord> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Text('病历'),
      ),
    );
  }

}