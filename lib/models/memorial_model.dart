/// **MemorialModel**
/// Represents a memorial profile, containing details about a deceased person.
/// This model includes tributes, media, participants, and more.
class MemorialModel {
  final String id;
  final String name;
  final String tributeMessage;
  final String createdBy;
  final String birthdate;
  final String? deathdate;
  final String visibility; // "public", "private", "family-only"
  final List<String> familyLinks; // Related family members
  final List<Tribute> tributes; // User tributes/messages
  final List<MemorialMedia> media; // Images & Videos
  final List<String> documents; // Related documents
  final List<String> hashtags; // Hashtags used
  final List<String> participants; // Users who participated in the memorial

  /// **Constructor**
  MemorialModel({
    required this.id,
    required this.name,
    required this.tributeMessage,
    required this.createdBy,
    required this.birthdate,
    this.deathdate,
    required this.visibility,
    required this.familyLinks,
    required this.tributes,
    required this.media,
    required this.documents,
    required this.hashtags,
    required this.participants,
  });

  /// **Factory method to create a MemorialModel from JSON**
  factory MemorialModel.fromJson(Map<String, dynamic> json) {
    return MemorialModel(
      id: json['id'] ?? 'unknown',
      name: json['name'] ?? 'Unknown',
      tributeMessage: json['tributeMessage'] ?? 'No tribute available',
      createdBy: json['createdBy'] ?? 'unknown',
      birthdate: json['birthdate'] ?? '0000-00-00',
      deathdate: json['deathdate'],
      visibility: json['visibility'] ?? 'public',
      familyLinks: List<String>.from(json['familyLinks'] ?? []),
      tributes: (json['tributes'] as List<dynamic>?)
              ?.map((t) => Tribute.fromJson(t))
              .toList() ??
          [],
      media: (json['media'] as List<dynamic>?)
              ?.map((m) => MemorialMedia.fromJson(m))
              .toList() ??
          [],
      documents: List<String>.from(json['documents'] ?? []),
      hashtags: List<String>.from(json['hashtags'] ?? []),
      participants: List<String>.from(json['participants'] ?? []),
    );
  }

  /// **Convert MemorialModel to JSON**
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "tributeMessage": tributeMessage,
      "createdBy": createdBy,
      "birthdate": birthdate,
      "deathdate": deathdate,
      "visibility": visibility,
      "familyLinks": familyLinks,
      "tributes": tributes.map((t) => t.toJson()).toList(),
      "media": media.map((m) => m.toJson()).toList(),
      "documents": documents,
      "hashtags": hashtags,
      "participants": participants,
    };
  }

  /// **Default MemorialModel in case of an error or missing data**
  static MemorialModel defaultMemorial() {
    return MemorialModel(
      id: "default",
      name: "Unknown",
      tributeMessage: "No tribute available",
      createdBy: "unknown",
      birthdate: "0000-00-00",
      deathdate: null,
      visibility: "public",
      familyLinks: [],
      tributes: [],
      media: [],
      documents: [],
      hashtags: [],
      participants: [],
    );
  }
}

/// **Tribute Class**
/// Represents a tribute message left by a user for the deceased.
class Tribute {
  final String id;
  final String userId;
  final String message;
  final String date; // Tribute date

  /// **Constructor**
  Tribute({
    required this.id,
    required this.userId,
    required this.message,
    required this.date,
  });

  /// **Factory method to create a Tribute from JSON**
  factory Tribute.fromJson(Map<String, dynamic> json) {
    return Tribute(
      id: json['id'] ?? 'unknown',
      userId: json['userId'] ?? 'unknown',
      message: json['message'] ?? '',
      date: json['date'] ?? '0000-00-00',
    );
  }

  /// **Convert Tribute to JSON**
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "message": message,
      "date": date,
    };
  }
}

/// **MemorialMedia Class**
/// Represents media (images or videos) associated with a memorial.
class MemorialMedia {
  final String type; // "image", "video"
  final String url; // Media URL

  /// **Constructor**
  MemorialMedia({
    required this.type,
    required this.url,
  });

  /// **Factory method to create MemorialMedia from JSON**
  factory MemorialMedia.fromJson(Map<String, dynamic> json) {
    return MemorialMedia(
      type: json['type'] ?? 'image',
      url: json['url'] ?? '',
    );
  }

  /// **Convert MemorialMedia to JSON**
  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "url": url,
    };
  }
}
