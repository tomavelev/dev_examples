class QueryResult<T> {
  List<T> list = [];
  var count = 0;

  QueryResult(this.list, this.count);
}

class Profile {
  int id;
  String name;
  String? summary;
  String picture;

  Profile({
    required this.id,
    required this.name,
    this.summary,
    required this.picture,
  });
}
