class TempMessageModel {
  int? id;
  String? type;
  String? content;
  String? contentUrl;
  int? timestamp;
  SentFrom? sentFrom;
  RoomId? roomId;
  ReplyTo? replyTo;

  TempMessageModel(
      {this.id,
        this.type,
        this.content,
        this.contentUrl,
        this.timestamp,
        this.sentFrom,
        this.roomId,
        this.replyTo});

  TempMessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    content = json['content'];
    contentUrl = json['contentUrl'];
    timestamp = json['timestamp'];
    sentFrom = json['sentFrom'] != null
        ? new SentFrom.fromJson(json['sentFrom'])
        : null;
    roomId =
    json['roomId'] != null ? new RoomId.fromJson(json['roomId']) : null;
    replyTo =
    json['replyTo'] != null ? new ReplyTo.fromJson(json['replyTo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['content'] = this.content;
    data['contentUrl'] = this.contentUrl;
    data['timestamp'] = this.timestamp;
    if (this.sentFrom != null) {
      data['sentFrom'] = this.sentFrom!.toJson();
    }
    if (this.roomId != null) {
      data['roomId'] = this.roomId!.toJson();
    }
    if (this.replyTo != null) {
      data['replyTo'] = this.replyTo!.toJson();
    }
    return data;
  }
}

class SentFrom {
  int? id;
  String? name;
  String? email;
  String? type;
  String? pushToken;
  bool? registered;
  String? dp;
  bool? emailVerified;

  SentFrom(
      {this.id,
        this.name,
        this.email,
        this.type,
        this.pushToken,
        this.registered,
        this.dp,
        this.emailVerified});

  SentFrom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    type = json['type'];
    pushToken = json['pushToken'];
    registered = json['registered'];
    dp = json['dp'];
    emailVerified = json['emailVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['type'] = this.type;
    data['pushToken'] = this.pushToken;
    data['registered'] = this.registered;
    data['dp'] = this.dp;
    data['emailVerified'] = this.emailVerified;
    return data;
  }
}

class RoomId {
  int? id;
  String? name;
  String? description;
  String? type;
  String? dpUrl;
  int? timestamp;

  RoomId(
      {this.id,
        this.name,
        this.description,
        this.type,
        this.dpUrl,
        this.timestamp});

  RoomId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    dpUrl = json['dpUrl'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['dpUrl'] = this.dpUrl;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class ReplyTo {
  int? id;
  String? type;
  String? content;
  String? contentUrl;
  int? timestamp;
  SentFrom? sentFrom;
  RoomId? roomId;
  Null replyTo;

  ReplyTo(
      {this.id,
        this.type,
        this.content,
        this.contentUrl,
        this.timestamp,
        this.sentFrom,
        this.roomId,
        this.replyTo});

  ReplyTo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    content = json['content'];
    contentUrl = json['contentUrl'];
    timestamp = json['timestamp'];
    sentFrom = json['sentFrom'] != null
        ? new SentFrom.fromJson(json['sentFrom'])
        : null;
    roomId =
    json['roomId'] != null ? new RoomId.fromJson(json['roomId']) : null;
    replyTo = json['replyTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['content'] = this.content;
    data['contentUrl'] = this.contentUrl;
    data['timestamp'] = this.timestamp;
    if (this.sentFrom != null) {
      data['sentFrom'] = this.sentFrom!.toJson();
    }
    if (this.roomId != null) {
      data['roomId'] = this.roomId!.toJson();
    }
    data['replyTo'] = this.replyTo;
    return data;
  }
}