/// **LiveModel**
/// Represents a live event session, including its metadata, participants, media, and visibility settings.
class LiveModel {
  final String id; // Unique identifier for the live session
  final String eventId; // ID of the linked event
  final String hostId; // ID of the user hosting the live session
  final String title; // Title of the live session
  final String description; // Description of the live session
  final String status; // Status of the live session: "live", "ended", "scheduled"
  final int viewers; // Number of current live viewers
  final List<String> participants; // List of user IDs participating in the live session
  final String streamUrl; // URL link to the streaming source
  final String startTime; // Start date and time of the live session
  final String? endTime; // End date and time (nullable)
  final String? duration; // Total duration of the live session (nullable)
  final String visibility; // Visibility level: "public", "private", "family-only"
  final List<LiveMedia> media; // List of associated media files (images/videos)
  final String? linkedMemorial; // ID of an associated memorial (nullable)

  /// **Constructor**
  LiveModel({
    required this.id,
    required this.eventId,
    required this.hostId,
    required this.title,
    required this.description,
    required this.status,
    required this.viewers,
    required this.participants,
    required this.streamUrl,
    required this.startTime,
    this.endTime,
    this.duration,
    required this.visibility,
    required this.media,
    this.linkedMemorial,
  });

  /// **Factory method to create a `LiveModel` from JSON**
  factory LiveModel.fromJson(Map<String, dynamic> json) {
    return LiveModel(
      id: json['id'] ?? '',
      eventId: json['eventId'] ?? '',
      hostId: json['hostId'] ?? '',
      title: json['title'] ?? 'Unknown Live Session',
      description: json['description'] ?? '',
      status: json['status'] ?? 'inactive',
      viewers: json['viewers'] ?? 0,
      participants: List<String>.from(json['participants'] ?? []),
      streamUrl: json['streamUrl'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'],
      duration: json['duration'],
      visibility: json['visibility'] ?? 'public',
      media: (json['media'] as List<dynamic>?)
              ?.map((m) => LiveMedia.fromJson(m))
              .toList() ??
          [],
      linkedMemorial: json['linkedMemorial'],
    );
  }

  /// **Convert `LiveModel` to JSON**
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "eventId": eventId,
      "hostId": hostId,
      "title": title,
      "description": description,
      "status": status,
      "viewers": viewers,
      "participants": participants,
      "streamUrl": streamUrl,
      "start_time": startTime,
      "end_time": endTime,
      "duration": duration,
      "visibility": visibility,
      "media": media.map((m) => m.toJson()).toList(),
      "linkedMemorial": linkedMemorial,
    };
  }

  /// **Default LiveModel instance in case of errors or missing data**
  static LiveModel defaultLive() {
    return LiveModel(
      id: "default",
      eventId: "default_event",
      hostId: "default_host",
      title: "Unknown Live Session",
      description: "No description available",
      status: "inactive",
      viewers: 0,
      participants: [],
      streamUrl: "",
      startTime: "0000-00-00T00:00:00Z",
      endTime: null,
      duration: null,
      visibility: "public",
      media: [],
      linkedMemorial: null,
    );
  }
}

/// **LiveMedia Class**
/// Represents a media file (image or video) associated with a live session.
class LiveMedia {
  final String type; // Type of media: "image" or "video"
  final String url; // URL link to the media file

  /// **Constructor**
  LiveMedia({
    required this.type,
    required this.url,
  });

  /// **Factory method to create a `LiveMedia` object from JSON**
  factory LiveMedia.fromJson(Map<String, dynamic> json) {
    return LiveMedia(
      type: json['type'] ?? 'image',
      url: json['url'] ?? '',
    );
  }

  /// **Convert `LiveMedia` to JSON**
  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "url": url,
    };
  }
}
