//import 'dart:convert';

class ActivityModel {
  List<Activity> activities;

  ActivityModel({required this.activities});

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      activities: List<Activity>.from(json['activities'].map((x) => Activity.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
    };
  }
}

class Activity {
  String type;
  User user;
  String? description;
  List<Media>? media;
  Actions? actions;
  Memorial? memorial;
  Event? event;
  Live? live;
  String? message;
  String? hashtag;

  Activity({
    required this.type,
    required this.user,
    this.description,
    this.media,
    this.actions,
    this.memorial,
    this.event,
    this.live,
    this.message,
    this.hashtag,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      type: json["type"],
      user: User.fromJson(json["user"]),
      description: json["description"],
      media: json["media"] != null ? List<Media>.from(json["media"].map((x) => Media.fromJson(x))) : null,
      actions: json["actions"] != null ? Actions.fromJson(json["actions"]) : null,
      memorial: json["memorial"] != null ? Memorial.fromJson(json["memorial"]) : null,
      event: json["event"] != null ? Event.fromJson(json["event"]) : null,
      live: json["live"] != null ? Live.fromJson(json["live"]) : null,
      message: json["message"],
      hashtag: json["hashtag"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "user": user.toJson(),
      "description": description,
      "media": media != null ? List<dynamic>.from(media!.map((x) => x.toJson())) : null,
      "actions": actions?.toJson(),
      "memorial": memorial?.toJson(),
      "event": event?.toJson(),
      "live": live?.toJson(),
      "message": message,
      "hashtag": hashtag,
    };
  }
}

class User {
  String id;
  String username;
  String profilePicture;

  User({required this.id, required this.username, required this.profilePicture});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["username"],
      profilePicture: json["profilePicture"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "profilePicture": profilePicture,
    };
  }
}

class Media {
  String url;
  String type;

  Media({required this.url, required this.type});

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      url: json["url"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      "type": type,
    };
  }
}

class Actions {
  int like;
  int comment;
  int share;

  Actions({required this.like, required this.comment, required this.share});

  factory Actions.fromJson(Map<String, dynamic> json) {
    return Actions(
      like: json["like"],
      comment: json["comment"],
      share: json["share"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "like": like,
      "comment": comment,
      "share": share,
    };
  }
}

class Memorial {
  String id;
  String name;
  String tributeMessage;

  Memorial({required this.id, required this.name, required this.tributeMessage});

  factory Memorial.fromJson(Map<String, dynamic> json) {
    return Memorial(
      id: json["id"],
      name: json["name"],
      tributeMessage: json["tributeMessage"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "tributeMessage": tributeMessage,
    };
  }
}

class Event {
  String id;
  String title;
  String location;
  String date;

  Event({required this.id, required this.title, required this.location, required this.date});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json["id"],
      title: json["title"],
      location: json["location"],
      date: json["date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "location": location,
      "date": date,
    };
  }
}

class Live {
  String id;
  String title;
  String streamUrl;
  String startTime;

  Live({required this.id, required this.title, required this.streamUrl, required this.startTime});

  factory Live.fromJson(Map<String, dynamic> json) {
    return Live(
      id: json["id"],
      title: json["title"],
      streamUrl: json["streamUrl"],
      startTime: json["start_time"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "streamUrl": streamUrl,
      "start_time": startTime,
    };
  }
}
