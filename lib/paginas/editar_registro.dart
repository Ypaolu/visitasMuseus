import 'package:flutter/material.dart';
import 'package:myapp/database.dart';

class Editar extends StatefulWidget {
  final Map<String, dynamic> docData;
  final String id;

  const Editar({super.key, required this.docData, required this.id});

  @override
  State<Editar> createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  TextEditingController nomemuseucontroller = TextEditingController();
  TextEditingController descricaocontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    nomemuseucontroller.text = widget.docData['Nome Museu'] ?? '';
    descricaocontroller.text = widget.docData['Descrição'] ?? '';
  }

  uploadData() async {
    Map<String, dynamic> uploaddata = {
      'Nome Museu': nomemuseucontroller.text,
      'Descrição': descricaocontroller.text,
    };

    await DatabaseMethods().UpdateMuseuData(nomemuseucontroller.text, descricaocontroller.text, widget.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "MUSEU FOI EDITADO COM SUCESSO!",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF935731),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9B7A5E),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'EDITAR MUSEU',
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
                'Museu',
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
                'Descrição',
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
            SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                onTap: () {
                  if (nomemuseucontroller.text == '' || descricaocontroller.text == '') {
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
            ],)
            
          ],
        ),
      ),
    );
  }
}
