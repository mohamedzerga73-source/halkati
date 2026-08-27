# حَلْقَتِي + Firebase

من داخل مجلد المشروع:
1. `firebase login`
2. `dart pub global activate flutterfire_cli`
3. `flutter pub get`
4. `flutterfire configure`
5. في Firebase Console فعّل Authentication > Email/Password.
6. أنشئ Cloud Firestore.
7. `firebase deploy --only firestore`
8. `flutter run`

بنية Firestore:
users/{uid}: name, email, role, createdAt
students/{id}: name, guardianUid, teacherUid, halaqaId, memorizedJuz, attendancePercent
memorization/{id}: studentId, teacherUid, surah, fromAyah, toAyah, amount, rating, notes, date
reviews/{id}: studentId, teacherUid, surah, range, level, notes, date
attendance/{id}: studentId, teacherUid, halaqaId, date, status, excuse

ملاحظة: `lib/firebase_options.dart` يُنشأ بواسطة `flutterfire configure` لأنه مرتبط بمشروع Firebase وحسابك.
