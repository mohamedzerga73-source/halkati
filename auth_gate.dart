import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'teacher_home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override Widget build(BuildContext context) => StreamBuilder<User?>(
    stream: AuthService().authStateChanges,
    builder: (context, s) {
      if (s.connectionState == ConnectionState.waiting)
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      return s.hasData ? const TeacherHome() : const LoginScreen();
    });
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController(), password = TextEditingController();
  String? error; bool loading = false;

  Future<void> login() async {
    setState(() {loading=true; error=null;});
    try { await AuthService().signIn(email.text, password.text); }
    on FirebaseAuthException catch(e) { setState(()=>error=e.message ?? 'تعذر تسجيل الدخول'); }
    finally { if(mounted) setState(()=>loading=false); }
  }

  @override Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(body: Center(child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(children: [
        const Icon(Icons.menu_book_rounded, size:80, color:Color(0xFF087A52)),
        const Text('حَلْقَتِي', style:TextStyle(fontSize:40,fontWeight:FontWeight.bold,color:Color(0xFF087A52))),
        const SizedBox(height:25),
        TextField(controller:email, decoration:const InputDecoration(labelText:'البريد الإلكتروني',border:OutlineInputBorder())),
        const SizedBox(height:12),
        TextField(controller:password, obscureText:true, decoration:const InputDecoration(labelText:'كلمة المرور',border:OutlineInputBorder())),
        if(error!=null) Text(error!, style:const TextStyle(color:Colors.red)),
        const SizedBox(height:16),
        FilledButton(onPressed:loading?null:login, child:Text(loading?'جارٍ الدخول...':'دخول')),
      ]))));
}
