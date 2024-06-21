import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ManufacturerProfile extends StatefulWidget {
  const ManufacturerProfile({super.key});

  @override
  State<ManufacturerProfile> createState() => _ManufacturerProfileState();
}

class _ManufacturerProfileState extends State<ManufacturerProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  String? _userName;
  String? _userEmail;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _user = user;
      });
      _loadUserData(user.uid);
    }
  }

  Future<void> _loadUserData(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await _firestore.collection('users').doc(uid).get();
    setState(() {
      _userName = userSnapshot.data()?['name'];
      _userEmail = userSnapshot.data()?['email'];
    });
  }

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pop(); // Pop current page (ProfilePage)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _signOut(context), // Pass context to _signOut
          ),
        ],
      ),
      body: Center(
        child: _user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        _user!.photoURL ?? 'https://via.placeholder.com/150'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _userName ?? 'Loading...',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    _userEmail ?? 'Loading...',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
