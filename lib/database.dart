import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  // Função que adiciona um novo museu
  Future addMuseuDetails(Map<String, dynamic> museuInfoMap) async {
    return await FirebaseFirestore.instance
    .collection('Museus')
    .doc()
    .set(museuInfoMap);
  }

  // Função que edita um museu
  Future UpdateMuseuData(String nomeMuseu, String descricaoMuseu, String id) async {
    return await FirebaseFirestore.instance
        .collection("Museus")
        .doc(id)
        .update({'Descrição': descricaoMuseu, 'Nome Museu': nomeMuseu});
  }

  // Função que deleta um museu
  Future DeleteMuseuData(String id)async{
    return await FirebaseFirestore.instance
    .collection("Museus")
    .doc(id)
    .delete();
  }
}