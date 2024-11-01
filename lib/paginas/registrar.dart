import 'package:flutter/material.dart';
import 'package:myapp/database.dart';


class Registrar extends StatefulWidget {
  const Registrar({super.key});

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  bool? jaVisitado;
  uploadData() async {
    Map<String, dynamic> uploaddata = {
      'Nome Museu': nomemuseucontroller.text,
      'Descrição': descricaocontroller.text,
      'jaVisitado': jaVisitado,
    };

    await DatabaseMethods().addMuseuDetails(uploaddata);
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "MUSEU ADICIONADO COM SUCESSO!",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF935731),
        duration: Duration(seconds: 2),
      ),
    );
  }

  TextEditingController nomemuseucontroller = new TextEditingController();
  TextEditingController descricaocontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9B7A5E),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'REGISTRAR MUSEU',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF935731),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 380,
                child: Text(
                  'MUSEU',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                child: TextField(
                  controller: nomemuseucontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.museum,
                      color: Color(0xFF935731),
                    ),
                    hintText: 'Nome do Museu',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 380,
                child: Text(
                  'DESCRIÇÃO',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                child: TextField(
                  controller: descricaocontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.notes,
                      color: Color(0xFF935731),
                    ),
                    hintText: 'Descrição do Museu',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'VOCÊ JÁ VISITOU ESSE MUSEU?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          jaVisitado = true;
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: jaVisitado == true
                              ? Color(0xFFDCA554)
                              : Color(0xFF935731), // Cor de fundo
                          borderRadius:
                              BorderRadius.circular(8), // Bordas arredondadas
                        ),
                        child: Text(
                          'JÁ VISITEI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          jaVisitado = false;
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: jaVisitado == false
                              ? Color(0xFFDCA554)
                              : Color(0xFF935731), // Cor de fundo
                          borderRadius:
                              BorderRadius.circular(8), // Bordas arredondadas
                        ),
                        child: Text(
                          'AINDA NÃO VISITEI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (nomemuseucontroller.text == '' ||
                          descricaocontroller.text == '') {
                         ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "PREENCHA TODOS OS CAMPOS!",
                              style: TextStyle(color: Colors.white),
                            ),      
                            backgroundColor: Color(0xFF935731),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        uploadData();
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFDCA554),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'SALVAR',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFDCA554),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'CANCELAR',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
