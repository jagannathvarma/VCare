import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcare/chat.dart';

class Profile extends StatefulWidget {

    final DocumentReference ref;
    final String email;

    @override
    _ProfileState createState() => _ProfileState(ref, email);

    Profile(this.ref, this.email);
}

class _ProfileState extends State<Profile> {
    _ProfileState(this.ref, this.email);

    DocumentReference ref;
    String email;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.teal.shade600,
            appBar: AppBar(
                title: Text(
                    "Doctor's Profile",
                    style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        fontSize: ScreenUtil().setSp(20),
                        fontWeight: FontWeight.bold,
                    ),
                ),
                backgroundColor: Colors.teal.shade700,
            ),
            body: StreamBuilder<DocumentSnapshot>(
                    stream: ref.snapshots(),
                    builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (!snapshot.hasData || snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                                child: Container(
                                    width: ScreenUtil().setWidth(20),
                                    height: ScreenUtil().setWidth(20),
                                    child: CircularProgressIndicator(),
                                ),
                            );
                        } else {
                            return Container(
                                padding: EdgeInsets.fromLTRB(
                                        ScreenUtil().setWidth(20),
                                        ScreenUtil().setHeight(20),
                                        ScreenUtil().setWidth(20),
                                        ScreenUtil().setHeight(20)
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Container(
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.fromLTRB(
                                                    ScreenUtil().setWidth(10),
                                                    ScreenUtil().setHeight(0),
                                                    ScreenUtil().setWidth(10),
                                                    ScreenUtil().setHeight(10)
                                            ),
                                            child: CircleAvatar(
                                                radius: 70.0,
                                                backgroundImage: AssetImage('images/doc.jpg'),
                                            ),
                                        ),
                                        Container(
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            child: Text(snapshot.data.data()["Name"].toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Source Sans Pro',
                                                    color: Colors.white,
                                                    fontSize: ScreenUtil().setSp(30),
                                                    fontWeight: FontWeight.normal,
                                                ),
                                            ),
                                        ),
                                        Container(
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            child: Text(snapshot.data.id.toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Source Sans Pro',
                                                    color: Colors.white,
                                                    fontSize: ScreenUtil().setSp(15),
                                                    fontWeight: FontWeight.normal,
                                                ),
                                            ),
                                        ),
                                        SizedBox(
                                            height: ScreenUtil().setHeight(20),
                                        ),
                                        Row(
                                            children: [
                                                Container(
                                                    height: ScreenUtil().setHeight(1),
                                                    width: ScreenUtil().setWidth(300),
                                                    color: Colors.white,
                                                ),
                                                SizedBox(
                                                    width: ScreenUtil().setWidth(10),
                                                ),
                                                FloatingActionButton(
                                                    onPressed: (){
                                                        ref.collection("Patients").doc(email).get().then((value) {
                                                            Navigator.push(
                                                                context,
                                                                new MaterialPageRoute(
                                                                    builder: (context) => Chat(value.reference),
                                                                ),
                                                            );
                                                        });
                                                    },
                                                    child: Icon(Icons.chat_bubble_rounded),
                                                    backgroundColor: Colors.green,
                                                ),
                                            ],
                                        ),
                                        SizedBox(
                                            height: ScreenUtil().setHeight(20),
                                        ),
                                        Expanded(
                                            child: SingleChildScrollView(
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                        Text("Specialization : ",
                                                            style: TextStyle(
                                                                fontFamily: 'Source Sans Pro',
                                                                color: Colors.white,
                                                                fontSize: ScreenUtil().setSp(18),
                                                                fontWeight: FontWeight.bold,
                                                            ),
                                                        ),
                                                        Text(snapshot.data.data()["Specialization"].toString(),
                                                            style: TextStyle(
                                                                fontFamily: 'Source Sans Pro',
                                                                color: Colors.white,
                                                                fontSize: ScreenUtil().setSp(15),
                                                                fontWeight: FontWeight.normal,
                                                            ),),
                                                        SizedBox(
                                                            height: ScreenUtil().setHeight(30),
                                                        ),
                                                        Text("Qualifications : ",
                                                            style: TextStyle(
                                                                fontFamily: 'Source Sans Pro',
                                                                color: Colors.white,
                                                                fontSize: ScreenUtil().setSp(18),
                                                                fontWeight: FontWeight.bold,
                                                            ),
                                                        ),
                                                        Text(snapshot.data.data()["Qualifications"].toString(),
                                                            style: TextStyle(
                                                                fontFamily: 'Source Sans Pro',
                                                                color: Colors.white,
                                                                fontSize: ScreenUtil().setSp(15),
                                                                fontWeight: FontWeight.normal,
                                                            ),
                                                        ),
                                                        SizedBox(
                                                            height: ScreenUtil().setHeight(30),
                                                        ),
                                                        Text("Certificates :",
                                                            style: TextStyle(
                                                                fontFamily: 'Source Sans Pro',
                                                                color: Colors.white,
                                                                fontSize: ScreenUtil().setSp(18),
                                                                fontWeight: FontWeight.bold,
                                                            ),
                                                        ),
                                                        Text(snapshot.data.data()["Certificates"].toString(),
                                                            style: TextStyle(
                                                                fontFamily: 'Source Sans Pro',
                                                                color: Colors.white,
                                                                fontSize: ScreenUtil().setSp(15),
                                                                fontWeight: FontWeight.normal,
                                                            ),
                                                        ),
                                                        SizedBox(
                                                            height: ScreenUtil().setHeight(30),
                                                        ),
                                                        Text("Accomplishments :",
                                                            style: TextStyle(
                                                                fontFamily: 'Source Sans Pro',
                                                                color: Colors.white,
                                                                fontSize: ScreenUtil().setSp(18),
                                                                fontWeight: FontWeight.bold,
                                                            ),
                                                        ),
                                                        Text(
                                                            snapshot.data.data()["Accomplishments"].toString(),
                                                            style: TextStyle(
                                                                fontFamily: 'Source Sans Pro',
                                                                color: Colors.white,
                                                                fontSize: ScreenUtil().setSp(15),
                                                                fontWeight: FontWeight.normal,
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                            ),
                                        ),

                                    ],
                                ),
                            );
                        }
                    }
            ),
        );
    }
}
