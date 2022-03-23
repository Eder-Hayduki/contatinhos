import 'package:flutter/material.dart';
import 'package:contatinhos/cadastrar.dart';
import 'alterar.dart';
import 'components/progress.dart';
import 'database/dao/contatinhos_dao.dart';
import 'models/contact.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<HomePage> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Meus Contatos');

  final ContatinhosDao dao = ContatinhosDao();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(
                    () {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    customSearchBar = const ListTile(
                      leading: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                      title: TextField(
                        decoration: InputDecoration(
                          hintText: 'Nome ou telefone',
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontStyle: FontStyle.italic),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    customIcon = const Icon(Icons.search);
                    customSearchBar = const Text('Contatinhos');
                  }
                },
              );
            },
            icon: customIcon,
          ),
        ],
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: const [],
        future: dao.searchContact(),
        builder: (context, AsyncSnapshot snapshot) {
          // ignore: missing_enum_constant_in_switch
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              /*return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading')
                  ],
                ),
              );*/
              break;
            /*case ConnectionState.active:
              break;*/
            case ConnectionState.done:
              final List<Contact>? contactList = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contactList![index];
                  return _ContactItem(contact);
                },
                itemCount: contactList != null ? contactList.length: 0,
              );

          }
          return const Progress();
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: 'Adicionar contato',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => CadastrarContato()))
              .then((newContact) {
            if (newContact != null) {
              setState(() {
                /*contactList.add(newContact);
                mensagemDeResposta(
                    context, '${newContact.nome} foi Cadastrado com sucesso!');*/
              });
            }
          });
        },
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contactItem;
  final ContatinhosDao dao = ContatinhosDao();

  _ContactItem(this.contactItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contactItem.nome,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          contactItem.phone.toString(),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () => editContact(context),
                icon: const Icon(
                  Icons.edit,
                  color: Colors.lightBlueAccent,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        AlertDialog(
                          title: const Text('Excluir contato:'),
                          content: Text(
                              'Você deseja realmente excluir o contato ${contactItem
                                  .nome}?'
                                  'A ação é irreversível.'),
                          actions: [
                            TextButton(
                              child: const Text('NÃO, CANCELAR!'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                              child: const Text('SIM, EXCLUIR'),
                              onPressed: () {
                                dao.deleteContact(contactItem.id);
                                Navigator.pop(context);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()));
                              },

                            ),
                          ],
                        ),
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void editContact (BuildContext context) {
    final contactEdit = Contact(contactItem.id, contactItem.nome, contactItem.email, contactItem.phone);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AlterarContato(modifiedContact: contactEdit),
      ),
    );
  }

}
