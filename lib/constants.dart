import 'package:flutter/material.dart';



const String dbPwd = "XtJFLzJH5UdsDEyh";
const String usn = "gdscevents";

// const String MONGO_URL = "mongodb+srv://$usn:$dbPwd@tedxiare.xelovad.mongodb.net/events?retryWrites=true&w=majority";
const String MONGO_URL = "mongodb+srv://gdscevents:$dbPwd@eventsapp.liuvkb7.mongodb.net/CommUnity?retryWrites=true&w=majority";
const String COLLECTION_NAME = "Unity1020223";




const KTextFieldDecoration = InputDecoration(
  
  hintText: 'Enter your email',
  
  contentPadding:
      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);