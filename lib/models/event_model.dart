/// **EventModel**
/// Represents an event within the Wanted platform, including its details, participants, media, and interactions.
class EventModel {
  final String id; // Unique identifier for the event
  final String title; // Title of the event
  final String description; // Description of the event
  final String type; // Type of event (e.g., "live", "commemoration", "post")
  final String date; // Date of the event (format: YYYY-MM-DD)
  final String creatorId; // ID of the user who created the event
  final List<String> participants; // List of participant user IDs
  final String location; // Event location (could be a city or virtual)
  final List<Map<String, String>> media; // List of associated media (images/videos)
  final List<String> comments; // List of comment IDs linked to this event
  final Map<String, int> reactions; // Map of reactions (e.g., {"like": 10, "love": 5})
  final String privacy; // Event visibility: "public", "private", "family-only"
  final String status; // Event status: "active", "inactive", "completed"
  final List<String> hashtags; // List of hashtags related to the event
  final List<String> documents; // List of document URLs linked to the event
  final List<String> tags; // List of tagged user IDs
  final List<String> lives; // List of live session IDs linked to the event

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
    required this.media,
    required this.comments,
    required this.reactions,
    required this.privacy,
    required this.status,
    required this.hashtags,
    required this.documents,
    required this.tags,
    required this.lives,
  });

  /// **Static method for a default event instance**
  /// Useful for handling cases where event data is missing or invalid.
  static EventModel defaultEvent() {
    return EventModel(
      id: "default",
      title: "Unknown Event",
      description: "No information available",
      type: "live",
      date: "",
      creatorId: "",
      participants: [],
      location: "Unknown",
      media: [],
      comments: [],
      reactions: {},
      privacy: "public",
      status: "inactive",
      hashtags: [],
      documents: [],
      tags: [],
      lives: [],
    );
  }

  /// **Factory method to create an `EventModel` from JSON data**
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? 'post',
      date: json['date'] ?? '',
      creatorId: json['createdBy'] ?? '',
      participants: List<String>.from(json['participants'] ?? []),
      location: json['location'] ?? '',
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
    );
  }
}
