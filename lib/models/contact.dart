class Contact {
  final int id;
  final String nome;
  final String email;
  final String phone;

  Contact(
    this.id,
    this.nome,
    this.email,
    this.phone,
  );

  @override
  String toString() {
    return 'Contact{id: $id, nome: $nome, email: $email, phone: $phone}';
  }
}