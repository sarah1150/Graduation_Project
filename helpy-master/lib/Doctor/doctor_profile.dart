import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/Reviews/AdminViewReview.dart';
import 'file:///C:/Users/abdos/AndroidStudioProjects/helpy/lib/chat/chatScreen.dart';
import 'package:intl/intl.dart';
import 'choose_day.dart';

import '../main.dart';

class DoctorProfile extends StatefulWidget {
  String id;
  DoctorProfile(this.id);
  @override
_DoctorProfileState createState() => _DoctorProfileState();
  }
FirebaseAuth instance = FirebaseAuth.instance;
final userRef = FirebaseFirestore.instance.collection("doctors");


class _DoctorProfileState extends State<DoctorProfile> {

  CollectionReference documents = FirebaseFirestore.instance.collection('DoctorsReviews');

  String Comment = "null";
  final _formKey = GlobalKey<FormState>();
  int Rate = 0;
  var Y=Colors.yellow;
  var DefaultColor1 = Colors.white;
  var DefaultColor2 = Colors.white;
  var DefaultColor3 = Colors.white;
  var DefaultColor4 = Colors.white;
  var DefaultColor5 = Colors.white;

  Future<void> addReview(String id) {
    // Call the user's CollectionReference to add a new user
    return documents
        .add({'comment': Comment, 'rate': Rate,'doctorId' : id,'email':instance.currentUser.email,'date':DateFormat('yyyy-MM-dd').format(DateTime.now()),})
        .then((value) => print("Review Added Successfully"))
        .catchError((error) => print("Failed to add Review: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Rest of your Code
      appBar: AppBar(
        backgroundColor: MainColor,
        title: Text(
          "Doctors",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.logout,
                size: 30.0,
              ),
              onPressed: () {
                instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Login()));
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').doc(widget.id).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('loading');
            return Container(
              color: Colors.white54,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.all(25),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 10,
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(snapshot.data['imageurl']),
                                      radius: 70.0,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(snapshot.data['name'],
                                        style: TextStyle(
                                          color: MainColor,
                                          fontSize: 25,
                                        )),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        for(int i=0;i<snapshot.data['rate'];i++)
                                        Icon(Icons.star,
                                            color: Colors.amberAccent, size: 25.0),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 50, top: 20, right: 50, bottom: 30),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.local_hospital,
                                        color: MainColor,
                                        size: 25,
                                      ),
                                      Text(
                                        snapshot.data['Specialization'],
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: MainColor,
                                        size: 25,
                                      ),
                                      Text(
                                        snapshot.data['address'],
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.email,
                                        color: MainColor,
                                        size: 25,
                                      ),
                                      Text(
                                        snapshot.data['email'],
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone_android,
                                        color: MainColor,
                                        size: 25,
                                      ),
                                      Text(
                                        snapshot.data['phone'],
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.monetization_on_sharp,
                                        color: MainColor,
                                        size: 25,
                                      ),
                                      Text(
                                        "Fees "+snapshot.data['Fees']+" LE",
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(20)),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 25),
                                              color: Colors.redAccent,
                                              child: Text(
                                                'Book',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => ChooseDay(widget.id,snapshot.data['name'])));
                                              })),
                                      Container(
                                          margin: EdgeInsets.only(top: 20,left: 10),
                                          child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(20)),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 17, horizontal: 25),
                                              color: MainColor,
                                              child: Icon(Icons.message,size: 20,color: Colors.white,),
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => ChatScreen(widget.id,snapshot.data['name'])));
                                              })),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 250,
                            height: 3,
                            color: MainColor,
                            margin: EdgeInsets.only(bottom: 30),
                          ),
                          Text(
                            'Add Review',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Form(
                            key: _formKey,
                            child: Container(
                              width: 350,
                              margin: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '*Required Field';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  Comment = value;
                                },
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusColor: Colors.blue,
                                  fillColor: Colors.red,
                                  hintText: 'Add Your Review',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            width: 270,
                            decoration: BoxDecoration(
                                color: MainColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.star, color: DefaultColor1),
                                  onPressed: () {
                                    setState(() {
                                      Rate = 1;
                                      DefaultColor1 = Y;
                                      DefaultColor2 = Colors.white;
                                      DefaultColor3 = Colors.white;
                                      DefaultColor4 = Colors.white;
                                      DefaultColor5 = Colors.white;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.star, color: DefaultColor2),
                                  onPressed: () {
                                    setState(() {
                                      Rate = 2;
                                      DefaultColor1 = Y;
                                      DefaultColor2 = Y;
                                      DefaultColor3 = Colors.white;
                                      DefaultColor4 = Colors.white;
                                      DefaultColor5 = Colors.white;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.star, color: DefaultColor3),
                                  onPressed: () {
                                    setState(() {
                                      Rate = 3;
                                      DefaultColor1 = Y;
                                      DefaultColor2 = Y;
                                      DefaultColor3 = Y;
                                      DefaultColor4 = Colors.white;
                                      DefaultColor5 = Colors.white;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.star, color: DefaultColor4),
                                  onPressed: () {
                                    setState(() {
                                      Rate = 4;
                                      DefaultColor1 = Y;
                                      DefaultColor2 = Y;
                                      DefaultColor3 = Y;
                                      DefaultColor4 = Y;
                                      DefaultColor5 = Colors.white;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.star, color: DefaultColor5),
                                  onPressed: () {
                                    setState(() {
                                      Rate = 5;
                                      DefaultColor1 = Y;
                                      DefaultColor2 = Y;
                                      DefaultColor3 = Y;
                                      DefaultColor4 = Y;
                                      DefaultColor5 = Y;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            child: RaisedButton(
                                padding:
                                EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                child: Text("Submit",
                                    style: TextStyle(color: Colors.white, fontSize: 20)),
                                color: MainColor,
                                onPressed: (){
                                  if (Comment == null||Rate ==0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                                '*Required Field',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.0))));
                                  }else{
                                    addReview(widget.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(backgroundColor: Colors.green,content: Text('Review is Added Successfully')));
                                    Comment =null;
                                    Rate=0;
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(25),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star_half,
                                    color: MainColor,
                                    size: 30,
                                  ),

                                  SizedBox(
                                    width: 5,
                                  ),

                                  Text(
                                    "Reviews",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 200, // card height
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection('DoctorsReviews').where('doctorId',isEqualTo: widget.id).snapshots(),
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Something went wrong');
                                    }

                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Text("Loading");
                                    }
                                    if(snapshot.data.docs.isNotEmpty){
                                      return PageView.builder(
                                        itemCount: snapshot.data.size,
                                        controller: PageController(viewportFraction: 0.9),
                                        itemBuilder: (_, i) {
                                          return Transform.scale(
                                            scale: 0.98,
                                            child: Card(
                                              elevation: 16,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12)),
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Stack(
                                                        alignment: Alignment.bottomLeft,
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.only(
                                                                left: 25,
                                                                top: 5,
                                                                right: 30,
                                                                bottom: 2),

                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                for(int j=0;j<snapshot.data.docs[i]['rate'];j++)
                                                                Icon(Icons.star,
                                                                    color: Colors.amberAccent,
                                                                    size: 25.0),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 30,
                                                            top: 10,
                                                            right: 30,
                                                            bottom: 10),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              snapshot.data.docs[i]['comment'],
                                                              style: TextStyle(
                                                                  color: Colors.black38,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 25),
                                                            ),
                                                            SizedBox(height: 20,),
                                                            Text(
                                                              snapshot.data.docs[i]['date'],
                                                              style: TextStyle(
                                                                  color: Colors.black38,
                                                                  fontSize: 18),
                                                            ),

                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // child: Text(
                                                //   "Card ${i + 1}",
                                                //   style: TextStyle(fontSize: 32),
                                                // ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                    else{
                                      return Card(
                                        elevation: 10,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 100),
                                          padding: EdgeInsets.symmetric(horizontal: 80),
                                          child: Text("No Reviews",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                        ),
                                      );
                                    }
                                  }
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
    ),
    );
  }
}
