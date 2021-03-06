import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vcare/HomeScreen.dart';
import 'package:vcare/Shared_pref.dart';
import 'package:vcare/screens/Register.dart';

class Login extends StatefulWidget {
    @override
    _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

    TextEditingController emailCon = new TextEditingController();
    TextEditingController passCon = new TextEditingController();
    FocusNode node = new FocusNode();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.teal,
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(10),
                                ScreenUtil().setHeight(10),
                                ScreenUtil().setWidth(10),
                                ScreenUtil().setHeight(10)
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: AssetImage('images/VCare.jpg'),
                                ),
                                Text(
                                    'VCare',
                                    style: TextStyle(
                                        fontFamily: 'Pacifico',
                                        fontSize: ScreenUtil().setSp(40),
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                                Text(
                                    'Virtual Health CheckUp',
                                    style: TextStyle(
                                        fontFamily: 'Source Sans Pro',
                                        color: Colors.teal.shade100,
                                        fontSize: ScreenUtil().setSp(20),
                                        letterSpacing: 2.5,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),

                                SizedBox(
                                    height: ScreenUtil().setHeight(20),
                                    width: ScreenUtil().setWidth(150),
                                    child: Divider(
                                        color: Colors.teal.shade100,
                                    ),
                                ),

                                TextFormField(
                                    controller: emailCon,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(15),
                                    ),
                                    cursorColor: Colors.white,
                                    onEditingComplete: (){
                                        node.requestFocus();
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Enter your email id',
                                        labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(15),
                                        ),
                                    ),
                                ),

                                TextFormField(
                                    controller: passCon,
                                    focusNode: node,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(15),
                                    ),
                                    cursorColor: Colors.white,
                                    onEditingComplete: () {
                                        loginFunc();
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Enter your Password',
                                        labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(15),
                                        ),
                                    ),
                                ),

                                SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                ),

                                ElevatedButton(
                                    onPressed: () {
                                        loginFunc();
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(10),
                                                ScreenUtil().setHeight(10),
                                                ScreenUtil().setWidth(10),
                                                ScreenUtil().setHeight(10)
                                        ),
                                        child: Text(
                                            'Login',
                                            style: TextStyle(
                                                fontSize: ScreenUtil().setSp(20),
                                            ),
                                        ),
                                    ),
                                ),

                                SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                ),

                                FlatButton(
                                    onPressed: () {
                                        Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => Register(),), (route) => false);
                                    },
                                    child: Text(
                                        "New user? Register",
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                ),

                                SizedBox(
                                    height: ScreenUtil().setHeight(240),
                                ),

                                Text(
                                    "Your Health, Our Priority",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Source Sans Pro',
                                        fontSize: ScreenUtil().setSp(20)
                                    ),
                                ),

                            ],
                        ),
                    ),
                ),
            ),
        );
    }

    void loginFunc(){
        FocusScope.of(context).unfocus();
        FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailCon.text.toString(),
            password: passCon.text.toString(),
        ).then((UserCredential user) {
            FirebaseFirestore.instance.collection("Doctors").doc(emailCon.text).get().then((snapshot) {
                if(snapshot.exists){
                    SharedPref.setUser(user.user.email, true, true).then((value) {
                        Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
                    });
                } else {
                    SharedPref.setUser(user.user.email, true, false).then((value) {
                        Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
                    });
                }
            });
        }).catchError((e){
            Fluttertoast.showToast(msg: e.message);
        });

    }

}

