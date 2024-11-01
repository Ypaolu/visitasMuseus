import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/paginas/lista_museus.dart';
import 'firebase_options.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ListaMuseus(),
  ));
}

// Paleta:
// Marrom: 0xFF935731
// Marrom Acizentado: 0xFF9B7A5E
// Dourado: 0xFFDCA554
// Amarelo Queimado: 0xFFCC9037
// Amarelo: 0xFFFFA929

// Referencias:
// https://api.flutter.dev/flutter/material/AlertDialog-class.html?gad_source=1&gclid=CjwKCAjwg-24BhB_EiwA1ZOx8gop-hS27eTTirPsl7Gz_X9FvR0-sMw5q3dZfgxHjeXvCHDmWSaf8RoCsm8QAvD_BwE&gclsrc=aw.ds
// https://api.flutter.dev/flutter/material/ListTile-class.html
// https://api.flutter.dev/flutter/material/FloatingActionButton-class.html?gad_source=1&gclid=Cj0KCQjwpvK4BhDUARIsADHt9sSdZcn7xfA8yeqxETbdM8we-k56GdTQuQ54AW73DpI3VNdz4UAbH2kaAgEyEALw_wcB&gclsrc=aw.ds
// https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html?gad_source=1&gclid=Cj0KCQjwpvK4BhDUARIsADHt9sRagIarazCp4NXPMsil28F-rb3ht5SCSaGq8Jk8aGYHsjTMe_RD4XQaAk44EALw_wcB&gclsrc=aw.ds
// https://api.flutter.dev/flutter/material/showDialog.html?gad_source=1&gclid=Cj0KCQjwpvK4BhDUARIsADHt9sTRugdUDrtoAhWHP871Csxzo59sB8iCx_SLAQmPLzAV0iIVFelBe9saAmQcEALw_wcB&gclsrc=aw.ds
// https://docs.flutter.dev/release/breaking-changes/buttons
// https://api.flutter.dev/flutter/material/Material/elevation.html
// https://firebase.google.com/docs/flutter/setup?hl=pt&platform=android
// https://www.youtube.com/watch?v=054Wa-lqA1o&ab_channel=ShivamGupta
// chatgpt.com (Usado para identificar o motivo de determinados erros)
