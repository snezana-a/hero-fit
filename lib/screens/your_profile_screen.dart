import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hero_fit/models/UserProfile.dart';

import '../adapters/user_profile_adapter.dart';

class YourProfileScreen extends StatefulWidget {
  const YourProfileScreen({super.key});

   @override
   _YourProfileScreenState createState() => _YourProfileScreenState();
}


 class _YourProfileScreenState extends State<YourProfileScreen> {

   final FirebaseAuth _auth = FirebaseAuth.instance;
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   UserProfile _userProfile = UserProfile(
     age: '',
     gender: '',
     weight: '',
     height: '',
     activityLevel: '',
     goal: '',
   );

   @override
   void initState() {
     super.initState();
     _loadUserData();
   }

   Future<void> _loadUserData() async {
     final user = _auth.currentUser;
     if (user == null) {
       return;
     }
     try {
       final userData = await _firestore.collection('users').doc(user.uid).get();

         final userParams = userData.data() as Map<String, dynamic>;
         final userProfile = UserProfileAdapter.fromMap(userParams);

       setState(() {
         _userProfile = userProfile;
       });
     } catch (e) {
       print('Error loading user data: $e');
     }
   }

   @override
   Widget build(BuildContext context) {
     return Stack(
       children: <Widget>[
         Image.asset(
           'assets/background_1.jpg',
           fit: BoxFit.cover,
           width: double.infinity,
           height: double.infinity,
         ),
         Scaffold(
           backgroundColor: Colors.transparent,
           body: Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: <Widget>[
               const SizedBox(height: 10.0),
               Row(
                 children: <Widget>[
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: Image.asset(
                         'assets/logo.png',
                         width: 150,
                         height: 150,
                       ),
                     ),
                   ),
                   const Text(
                     'Your Profile',
                     style: TextStyle(
                       fontSize: 30,
                       fontWeight: FontWeight.bold,
                       color: Color.fromARGB(255, 4, 171, 157),
                     ),
                   ),
                 ],
               ),
               ListTile(
                 title: Row(
                   children: [
                     Text(
                       'Age: ',
                       style: TextStyle(
                         fontSize: 24,
                         color: Colors.black,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     Text(
                       _userProfile.age,
                       style: TextStyle(
                         fontSize: 24,
                         color: Colors.teal,
                       ),
                     ),
                   ],
                 ),
               ),
               ListTile(
                 title: Row(
                   children: [
                     Text(
                       'Gender: ',
                       style: TextStyle(
                         fontSize: 24,
                         color: Colors.black,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     Text(
                       _userProfile.gender,
                       style: TextStyle(
                         fontSize: 24,
                         color: Colors.teal,
                       ),
                     ),
                   ],
                 ),
               ),
               Positioned(
                 bottom: 0,
                 left: 0,
                 right: 0,
                 child: Image.asset(
                   'assets/people_exercising.png',
                   width: double.infinity,
                   height: 150,
                   fit: BoxFit.cover,
                 ),
               ),
             ],
           ),
         ),
       ],
     );
   }
}