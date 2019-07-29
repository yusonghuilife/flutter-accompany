import 'package:flutter/material.dart';
import 'package:trip/pages/doctor/diagnosis_info.dart';
import 'package:trip/pages/doctor/patient_alert.dart';
import 'package:trip/pages/doctor/patient_list.dart';

class DoctorTabNavigator extends StatefulWidget{
  DoctorTabNavigator({Key key,this.index,this.tel,this.id,this.pass}): super(key:key);
  final int index;
  final String tel;
  final String id;
  final String pass;
  @override
  _DoctorTabNavigatorState createState() => _DoctorTabNavigatorState();

}

class _DoctorTabNavigatorState extends State<DoctorTabNavigator> {
  final _defalutColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = widget.index;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          PatientList(tel:widget.tel,pass:widget.pass,doctorId: widget.id,),
          DiagnosisInfo(id:widget.id),
          PatientAlert(tel:widget.tel,id: widget.id,pass: widget.pass)
        ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.star, color: _defalutColor),
            activeIcon: Icon(Icons.star, color: _activeColor),
            title: Text('病人列表',style: TextStyle(
                color: _currentIndex!=0 ?_defalutColor:_activeColor
              )
            )
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: _defalutColor),
              activeIcon: Icon(Icons.account_circle, color: _activeColor),
              title: Text('就诊信息',style: TextStyle(
                  color: _currentIndex!=1 ?_defalutColor:_activeColor
              )
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.crop_square, color: _defalutColor),
              activeIcon: Icon(Icons.crop_square, color: _activeColor),
              title: Text('病人警报',style: TextStyle(
                  color: _currentIndex!=2 ?_defalutColor:_activeColor
              )
              )
          ),
        ]
      ,)
    );
  }

}