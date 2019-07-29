import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip/pages/patient/current_state.dart';
import 'package:trip/pages/patient/patient_drug.dart';
import 'package:trip/pages/patient/patient_info.dart';

class PatientTabNavigator extends StatefulWidget{
  PatientTabNavigator({Key key,this.index,this.patientId,this.name,this.gender,this.age,this.tel}): super(key:key);
  final int index;
  final String patientId;
  final String name;
  final String gender;
  final String age;
  final String tel;
  @override
  _PatientTabNavigator createState() {
    return new _PatientTabNavigator();
  }

}

class _PatientTabNavigator extends State<PatientTabNavigator> {
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
              PatientDrug(patientId:widget.patientId,name:widget.name,gender:widget.gender,age:widget.age,tel:widget.tel),
              PatientInfo(patientId:widget.patientId),
              CurrentState(patientId:widget.patientId,name:widget.name,gender:widget.gender,age:widget.age,tel:widget.tel)
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
                title: Text('医嘱',style: TextStyle(
                    color: _currentIndex!=0 ?_defalutColor:_activeColor
                )
                )
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, color: _defalutColor),
                activeIcon: Icon(Icons.account_circle, color: _activeColor),
                title: Text('病历',style: TextStyle(
                    color: _currentIndex!=1 ?_defalutColor:_activeColor
                )
                )
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.crop_square, color: _defalutColor),
                activeIcon: Icon(Icons.crop_square, color: _activeColor),
                title: Text('当前状态',style: TextStyle(
                    color: _currentIndex!=2 ?_defalutColor:_activeColor
                )
                )
            ),
          ]
          ,)
    );
  }

}