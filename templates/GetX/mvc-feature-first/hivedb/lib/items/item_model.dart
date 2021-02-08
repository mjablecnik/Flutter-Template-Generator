class Item {
  String name;

  DateTime created = DateTime.now();

  DateTime lastChange = DateTime.now();

  Item(this.name, {this.created, this.lastChange});
}
