import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class TeacherHome extends StatelessWidget {
  const TeacherHome({super.key});
  @override Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return Directionality(textDirection:TextDirection.rtl, child:Scaffold(
      appBar:AppBar(title:const Text('حَلْقَتِي - المعلم'),
        backgroundColor:const Color(0xFF087A52),foregroundColor:Colors.white,
        actions:[IconButton(onPressed:()=>AuthService().signOut(),icon:const Icon(Icons.logout))]),
      body:StreamBuilder(
        stream:FirestoreService().studentsForTeacher(uid),
        builder:(context,s) {
          if(!s.hasData) return const Center(child:CircularProgressIndicator());
          final docs=s.data!.docs;
          return ListView(padding:const EdgeInsets.all(16),children:[
            Card(child:ListTile(leading:const Icon(Icons.groups,color:Color(0xFF087A52)),
              title:const Text('طلاب الحلقة'),subtitle:Text('${docs.length} طالب'))),
            ...docs.map((d)=>Card(child:ListTile(
              title:Text(d.data()['name'] ?? ''),
              subtitle:Text('المحفوظ: ${d.data()['memorizedJuz'] ?? 0} أجزاء')))),
          ]);
        }),
    ));
  }
}
