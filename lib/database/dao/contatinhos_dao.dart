import 'package:contatinhos/database/app_database.dart';
import 'package:contatinhos/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContatinhosDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY kEY, '
      '$_nome TEXT,'
      '$_email TEXT,'
      '$_phone TEXT)';

  static const String _tableName = 'contatinhos';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _email = 'email';
  static const String _phone = 'phone';

  //FUNÇÃO SALVAR CONTATO
  Future<int> saveContact(Contact contact) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_tableName, contactMap);
  }

  //FUNÇÃO MAPEAR NA LISTA DE CONTATOS
  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = {};
    contactMap[_nome] = contact.nome;
    contactMap[_email] = contact.email;
    contactMap[_phone] = contact.phone;
    return contactMap;
  }

  //FUNÇÃO PROCURAR CONTATO
  Future<List<Contact>> searchContact() async {
    final Database db = await getDatabase();
    List<Contact> listContact = await _toList(db);
    return listContact;
  }

  //FUNÇÃO MODIFICAR CONTATO
  Future<int> modifyContact(Contact contact) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> contactMap = _toMap(contact);

    return db.update(
      _tableName,
      contactMap,
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  //FUNÇÃO DELETAR CONTATO
  Future<int> deleteContact(int id) async {
    final Database db = await getDatabase();

    return db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //FUNÇÃO LISTAR CONTATOS DO BANCO NA PÁGINA INICIAL DO APP
  Future<List<Contact>> _toList(Database db) async {
    final List<Contact> contactList = [];
    for(Map<String, dynamic> line in await db.query(_tableName)) {
      final Contact contact = Contact(
        line[_id],
        line[_nome],
        line[_email],
        line[_phone],
      );
      contactList.add(contact);
    }
    return contactList;
  }
}


