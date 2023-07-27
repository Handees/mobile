import 'package:flutter/material.dart';
import 'ui/profileEdit_options_nav/profile.edit.options.dart';


const String testProfileImage = "https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg";


Map profileOptionsList = {
  "Hourly Rate": "Add your rate",
  "Services offered": "Services offered",
  "Mobile Number": "Mobile Number",
  "Email Address": "Add Email",
  "Valid Identification": "Documents",
  "Payments & Card Details": "Bank Details"
};

final Map<dynamic, dynamic> profileToolBarList = {
  Icons.edit: {
    "option": "Edit Profile",
    "action": const EditProfileOptions()
  },
  Icons.code: {
    "option": "Handees",
    "action": const EditProfileOptions()
  }
};

final Map editProfileOptionsRef = {
  "Basic Information": "Name & Contact Information",
  "Document Uploaded": "Valid means of identification",
  "Handee Details": "payment rate & skills",
  "Payment Details": "Bank Account"
};
