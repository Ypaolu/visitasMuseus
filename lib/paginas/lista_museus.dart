import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/database.dart';
import 'package:myapp/paginas/editar_registro.dart';
import 'package:myapp/paginas/registrar.dart';

class ListaMuseus extends StatefulWidget {
  const ListaMuseus({super.key});

  @override
  State<ListaMuseus> createState() => _ListaMuseusState();
}

class _ListaMuseusState extends State<ListaMuseus> {
  TextEditingController textcontroller = new TextEditingController();

  updateData() async {
    Map<String, dynamic> updatedata = {
      'Nome Museu': nomemuseucontroller.text,
      'Descrição': descricaocontroller.text,
    };

    await DatabaseMethods().addMuseuDetails(updatedata);
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

  TextEditingController nomemuseucontroller = new TextEditingController();
  TextEditingController descricaocontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9B7A5E),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'LISTA DE MUSEUS',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF935731),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Museus').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final docData = documents[index].data() as Map<String, dynamic>;
              final String id = documents[index].id;

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Color(0xFFDCA554),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    docData['Nome Museu'],
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(docData['Descrição'],
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 15,
                      )),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: docData['jaVisitado'] ?? false
                                ? Color(0xFFFFA929)
                                : Color(0xFFCC9037), // Muda a cor do botão
                          ),
                          child: Text(
                            docData['jaVisitado'] ?? false
                                ? "VISITADO"
                                : "NÃO VISITADO",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            // Atualiza o Firestore
                            FirebaseFirestore.instance
                                .collection('Museus')
                                .doc(id)
                                .update({
                              'jaVisitado': !(docData['jaVisitado'] ??
                                  false), // Inverte o valor
                            });
                          }),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Color(0xFFFFFFFF),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Editar(
                                docData: docData,
                                id: id,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Color(0xFF000000)),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Color(0xFFDCA554),
                                  title: Text(
                                    'Excluir o ' + docData['Nome Museu'],
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 20,
                                    ),
                                  ),
                                  content: Text(
                                    'Tem certeza que deseja excluir este registro?',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 18,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Container(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            await DatabaseMethods()
                                                .DeleteMuseuData(id);
                                             ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "MUSEU FOI DELETADO COM SUCESSO!",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                backgroundColor: Color(0xFF935731),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'CONFIRMAR',
                                            style: TextStyle(
                                              color: Color(0xFFFFFFFF),
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'CANCELAR',
                                              style: TextStyle(
                                                color: Color(0xFFFFFFFF),
                                                fontSize: 18,
                                              ),
                                            )),
                                      ],
                                    )),
                                  ],
                                );
                              });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Material(
        elevation: 0,
        color: Colors.transparent,
        child: FloatingActionButton(
            shape: CircleBorder(
              side: BorderSide(
                color: Color(0xFF9B7A5E),
                width: 3,
              ),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 50,
            ),
            backgroundColor: Color(0xFFDCA554),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Registrar()),
              );
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF935731),
        height: 50,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
