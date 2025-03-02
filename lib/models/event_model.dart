/// **EventModel**
/// Represents an event within the Wanted platform, including its details, participants, media, and interactions.
class EventModel {
  final String id; // Unique identifier for the event
  final String title; // Title of the event
  final String description; // Description of the event
  final String type; // Type of event (e.g., "event", "deuil", "commemoration")
  final String date; // Date of the event (format: YYYY-MM-DD)
  final String creatorId; // ID of the user who created the event
  final List<String> participants; // List of participant user IDs
  final String location; // Event location (could be a city or virtual)
  final List<String> categories; // Categories of the event
  final String ceremonyType; // Type of ceremony (e.g., "Funérailles d'État", "Hommage académique")
  final String theme; // Theme of the event
  final String music; // Music associated with the event
  final String accessType; // Type of access (e.g., "public", "private", "family-only")
  final String recurrence; // Recurrence of the event (e.g., "Ponctuel", "Annuel")
  final List<Map<String, String>> media; // List of associated media (images/videos)
  final List<String> comments; // List of comment IDs linked to this event
  final Map<String, int> reactions; // Map of reactions (e.g., {"like": 10, "support": 5})
  final String privacy; // Event visibility: "public", "private", "family-only"
  final String status; // Event status: "active", "inactive", "completed"
  final List<String> hashtags; // List of hashtags related to the event
  final List<String> documents; // List of document URLs linked to the event
  final List<String> tags; // List of tagged user IDs
  final List<String> lives; // List of live session IDs linked to the event

  /// ✅ **Additional fields for "deuil" & "commemoration" types**
  final Defunct? defunct; // Information about the deceased (for "deuil" and "commemoration")
  final Ceremony? ceremony; // Details about the ceremony (for "deuil" and "commemoration")
  final Memorial? memorial; // Link to an interactive memorial (if applicable)
  final Guestbook? guestbook; // Digital guestbook for messages
  final Contribution? contribution; // Information about donations

  /// **Constructor**
  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.date,
    required this.creatorId,
    required this.participants,
    required this.location,
    required this.categories,
    required this.ceremonyType,
    required this.theme,
    required this.music,
    required this.accessType,
    required this.recurrence,
    required this.media,
    required this.comments,
    required this.reactions,
    required this.privacy,
    required this.status,
    required this.hashtags,
    required this.documents,
    required this.tags,
    required this.lives,
    this.defunct,
    this.ceremony,
    this.memorial,
    this.guestbook,
    this.contribution,
  });

  /// **Static method for a default event instance**
  /// Useful for handling cases where event data is missing or invalid.
  static EventModel defaultEvent() {
    return EventModel(
      id: "default",
      title: "Unknown Event",
      description: "No information available",
      type: "event",
      date: "",
      creatorId: "",
      participants: [],
      location: "Unknown",
      categories: [],
      ceremonyType: "",
      theme: "",
      music: "",
      accessType: "public",
      recurrence: "Ponctuel",
      media: [],
      comments: [],
      reactions: {},
      privacy: "public",
      status: "inactive",
      hashtags: [],
      documents: [],
      tags: [],
      lives: [],
      defunct: null,
      ceremony: null,
      memorial: null,
      guestbook: null,
      contribution: null,
    );
  }


  /// **Factory method to create an `EventModel` from JSON data**
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? 'event',
      date: json['date'] ?? '',
      creatorId: json['createdBy'] ?? '',
      participants: List<String>.from(json['participants'] ?? []),
      location: json['location'] ?? '',
      categories: List<String>.from(json['categories'] ?? []),
      ceremonyType: json['ceremonyType'] ?? '',
      theme: json['theme'] ?? '',
      music: json['music'] ?? '',
      accessType: json['accessType'] ?? 'public',
      recurrence: json['recurrence'] ?? 'Ponctuel',
      media: (json['media'] as List<dynamic>?)
              ?.map((e) => {
                    "type": e["type"] as String,
                    "url": e["url"] as String,
                  })
              .toList() ??
          [],
      comments: List<String>.from(json['comments'] ?? []),
      reactions: Map<String, int>.from(json['reactions'] ?? {}),
      privacy: json['visibility'] ?? 'public',
      status: json['status'] ?? 'active',
      hashtags: List<String>.from(json['hashtags'] ?? []),
      documents: List<String>.from(json['documents'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      lives: List<String>.from(json['linkedLiveSessions'] ?? []),
      defunct: json['defunct'] != null ? Defunct.fromJson(json['defunct']) : null,
      ceremony: json['ceremony'] != null ? Ceremony.fromJson(json['ceremony']) : null,
      memorial: json['memorial'] != null ? Memorial.fromJson(json['memorial']) : null,
      guestbook: json['guestbook'] != null ? Guestbook.fromJson(json['guestbook']) : null,
      contribution: json['contribution'] != null ? Contribution.fromJson(json['contribution']) : null,
    );
  }
}

/// **Defunct Model** (for "deuil" and "commemoration")
class Defunct {
  final String name;
  final String birthdate;
  final String deathdate;
  final int age;
  final String cause;
  final String location;
  final List<String> categories;

  Defunct({
    required this.name,
    required this.birthdate,
    required this.deathdate,
    required this.age,
    required this.cause,
    required this.location,
    required this.categories,
  });

  factory Defunct.fromJson(Map<String, dynamic> json) {
    return Defunct(
      name: json['name'] ?? '',
      birthdate: json['birthdate'] ?? '',
      deathdate: json['deathdate'] ?? '',
      age: json['age'] ?? 0,
      cause: json['cause'] ?? '',
      location: json['location'] ?? '',
      categories: List<String>.from(json['categories'] ?? []),
    );
  }
}

/// **Ceremony Model**
class Ceremony {
  final String? recurrence;
  final String date;
  final String? time;
  final String location;
  final String? theme;
  final List<String>? symbols;
  final List<String>? citations;

  Ceremony({
    this.recurrence,
    required this.date,
    this.time,
    required this.location,
    this.theme,
    this.symbols,
    this.citations,
  });

  factory Ceremony.fromJson(Map<String, dynamic> json) {
    return Ceremony(
      recurrence: json['recurrence'],
      date: json['date'] ?? '',
      time: json['time'],
      location: json['location'] ?? '',
      theme: json['theme'],
      symbols: List<String>.from(json['symbols'] ?? []),
      citations: List<String>.from(json['citations'] ?? []),
    );
  }
}

/// **Memorial Model**
class Memorial {
  final String type;
  final String link;

  Memorial({
    required this.type,
    required this.link,
  });

  factory Memorial.fromJson(Map<String, dynamic> json) {
    return Memorial(
      type: json['type'] ?? '',
      link: json['link'] ?? '',
    );
  }
}

/// **Guestbook Model**
class Guestbook {
  final bool enabled;
  final List<String> messages;

  Guestbook({
    required this.enabled,
    required this.messages,
  });

  factory Guestbook.fromJson(Map<String, dynamic> json) {
    return Guestbook(
      enabled: json['enabled'] ?? false,
      messages: List<String>.from(json['messages'] ?? []),
    );
  }
}

/// **Contribution Model**
class Contribution {
  final bool enabled;
  final String? donationLink;

  Contribution({
    required this.enabled,
    this.donationLink,
  });

  factory Contribution.fromJson(Map<String, dynamic> json) {
    return Contribution(
      enabled: json['enabled'] ?? false,
      donationLink: json['donation_link'],
    );
  }
}



// /// **EventModel**
// /// Represents an event within the Wanted platform, including its details, participants, media, and interactions.
// class EventModel {
//   final String id; // Unique identifier for the event
//   final String title; // Title of the event
//   final String description; // Description of the event
//   final String type; // Type of event (e.g., "live", "commemoration", "post")
//   final String date; // Date of the event (format: YYYY-MM-DD)
//   final String creatorId; // ID of the user who created the event
//   final List<String> participants; // List of participant user IDs
//   final String location; // Event location (could be a city or virtual)
//   final List<Map<String, String>> media; // List of associated media (images/videos)
//   final List<String> comments; // List of comment IDs linked to this event
//   final Map<String, int> reactions; // Map of reactions (e.g., {"like": 10, "love": 5})
//   final String privacy; // Event visibility: "public", "private", "family-only"
//   final String status; // Event status: "active", "inactive", "completed"
//   final List<String> hashtags; // List of hashtags related to the event
//   final List<String> documents; // List of document URLs linked to the event
//   final List<String> tags; // List of tagged user IDs
//   final List<String> lives; // List of live session IDs linked to the event

//   /// **Constructor**
//   EventModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.type,
//     required this.date,
//     required this.creatorId,
//     required this.participants,
//     required this.location,
//     required this.media,
//     required this.comments,
//     required this.reactions,
//     required this.privacy,
//     required this.status,
//     required this.hashtags,
//     required this.documents,
//     required this.tags,
//     required this.lives,
//   });

//   /// **Static method for a default event instance**
//   /// Useful for handling cases where event data is missing or invalid.
//   static EventModel defaultEvent() {
//     return EventModel(
//       id: "default",
//       title: "Unknown Event",
//       description: "No information available",
//       type: "live",
//       date: "",
//       creatorId: "",
//       participants: [],
//       location: "Unknown",
//       media: [],
//       comments: [],
//       reactions: {},
//       privacy: "public",
//       status: "inactive",
//       hashtags: [],
//       documents: [],
//       tags: [],
//       lives: [],
//     );
//   }

//   /// **Factory method to create an `EventModel` from JSON data**
//   factory EventModel.fromJson(Map<String, dynamic> json) {
//     return EventModel(
//       id: json['id'] ?? '',
//       title: json['title'] ?? '',
//       description: json['description'] ?? '',
//       type: json['type'] ?? 'post',
//       date: json['date'] ?? '',
//       creatorId: json['createdBy'] ?? '',
//       participants: List<String>.from(json['participants'] ?? []),
//       location: json['location'] ?? '',
//       media: (json['media'] as List<dynamic>?)
//               ?.map((e) => {
//                     "type": e["type"] as String,
//                     "url": e["url"] as String,
//                   })
//               .toList() ??
//           [],
//       comments: List<String>.from(json['comments'] ?? []),
//       reactions: Map<String, int>.from(json['reactions'] ?? {}),
//       privacy: json['visibility'] ?? 'public',
//       status: json['status'] ?? 'active',
//       hashtags: List<String>.from(json['hashtags'] ?? []),
//       documents: List<String>.from(json['documents'] ?? []),
//       tags: List<String>.from(json['tags'] ?? []),
//       lives: List<String>.from(json['linkedLiveSessions'] ?? []),
//     );
//   }
// }
