class Company {
  String? name;
  String? catchPhrase;
  String? bs;
  Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  Company copyWith({
    String? name,
    String? catchPhrase,
    String? bs,
  }) {
    return Company(
      name: name ?? this.name,
      catchPhrase: catchPhrase ?? this.catchPhrase,
      bs: bs ?? this.bs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'catchPhrase': catchPhrase,
      'bs': bs,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      name: map['name'],
      catchPhrase: map['catchPhrase'],
      bs: map['bs'],
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory Company.fromJson(Map<String, dynamic> source) {
    return Company.fromMap(source);
  }

  @override
  String toString() =>
      'Company(name: $name, catchPhrase: $catchPhrase, bs: $bs)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Company &&
        other.name == name &&
        other.catchPhrase == catchPhrase &&
        other.bs == bs;
  }

  @override
  int get hashCode => name.hashCode ^ catchPhrase.hashCode ^ bs.hashCode;
}

class Post {
  int? userId;
  int? id;
  String? title;
  String? body;
  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  Post copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) {
    return Post(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory Post.fromJson(Map<String, dynamic> source) {
    return Post.fromMap(source);
  }

  @override
  String toString() {
    return 'Post(userId: $userId, id: $id, title: $title, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.userId == userId &&
        other.id == id &&
        other.title == title &&
        other.body == body;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ id.hashCode ^ title.hashCode ^ body.hashCode;
  }
}

class Album {
  int? userId;
  int? id;
  String? title;
  Album({
    this.userId,
    this.id,
    this.title,
  });

  Album copyWith({
    int? userId,
    int? id,
    String? title,
  }) {
    return Album(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory Album.fromJson(Map<String, dynamic> source) {
    return Album.fromMap(source);
  }

  @override
  String toString() => 'Album(userId: $userId, id: $id, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Album &&
        other.userId == userId &&
        other.id == id &&
        other.title == title;
  }

  @override
  int get hashCode => userId.hashCode ^ id.hashCode ^ title.hashCode;
}
