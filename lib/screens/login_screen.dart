import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/api_service.dart';
import 'home_screen.dart';
import 'waiting_screen.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithEmail(BuildContext context) async {
    try {
      // 이메일 로그인
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: "test@example.com", // 사용자 입력값
        password: "password123", // 사용자 입력값
      );

      final User? user = userCredential.user;
      if (user != null) {
        // API 호출
        final name = await ApiService.fetchNameFromApi(user.email!);
        if (name != null) {
          // 이름이 있으면 Firebase에 이름 저장
          await user.updateDisplayName(name);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          // 이름이 없으면 대기 화면으로 이동
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => WaitingScreen()),
          );
        }
      }
    } catch (e) {
      print("Login Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => signInWithEmail(context),
          child: Text('Login with Email'),
        ),
      ),
    );
  }
}
