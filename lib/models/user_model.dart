import 'dart:convert';

/// **UserModel**
/// Represents a user profile in the application, which can be a living person, deceased person, or historical memorial.
class UserModel {
  final String id;
  final String username;
  final String fullName;
  final String? email;
  final String profilePicture;
  final String bio;
  final String status; // "living", "deceased", "unknown"
  final String accountType; // "personal", "memorial", "historical_memorial"
  final Location location;
  final String birthdate;
  final String? deathdate;
  final Memorial? memorial;
  final List<String>? createdPosthumousAccounts; // Accounts managed by this user posthumously
  final int followers;
  final int following;
  final List<String> eventsCreated;
  final List<String> eventsParticipated;
  final List<String> liveSessions;
  final String lastActive; // Timestamp of last activity
  final bool isVerified; // If the account is verified
  final bool isPrivate; // If the profile is private
  final SocialLinks? socialLinks; // Social media links
  final Preferences preferences; // User's preferences

  /// **Constructor for UserModel**
  UserModel({
    required this.id,
    required this.username,
    required this.fullName,
    this.email,
    required this.profilePicture,
    required this.bio,
    required this.status,
    required this.accountType,
    required this.location,
    required this.birthdate,
    this.deathdate,
    this.memorial,
    this.createdPosthumousAccounts,
    required this.followers,
    required this.following,
    required this.eventsCreated,
    required this.eventsParticipated,
    required this.liveSessions,
    required this.lastActive,
    required this.isVerified,
    required this.isPrivate,
    this.socialLinks,
    required this.preferences,
  });

  /// **Factory method to create a UserModel from JSON**
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      fullName: json['full_name'],
      email: json['email'],
      profilePicture: json['profile_picture'],
      bio: json['bio'],
      status: json['status'],
      accountType: json['account_type'],
      location: Location.fromJson(json['location']),
      birthdate: json['birthdate'],
      deathdate: json['deathdate'],
      memorial: json['memorial'] != null ? Memorial.fromJson(json['memorial']) : null,
      createdPosthumousAccounts: json['created_posthumous_accounts']?.cast<String>(),
      followers: json['followers'],
      following: json['following'],
      eventsCreated: List<String>.from(json['events_created']),
      eventsParticipated: List<String>.from(json['events_participated']),
      liveSessions: List<String>.from(json['live_sessions']),
      lastActive: json['last_active'],
      isVerified: json['is_verified'],
      isPrivate: json['is_private'],
      socialLinks: json['social_links'] != null ? SocialLinks.fromJson(json['social_links']) : null,
      preferences: Preferences.fromJson(json['preferences']),
    );
  }

  /// **Convert UserModel to JSON format**
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'full_name': fullName,
      'email': email,
      'profile_picture': profilePicture,
      'bio': bio,
      'status': status,
      'account_type': accountType,
      'location': location.toJson(),
      'birthdate': birthdate,
      'deathdate': deathdate,
      'memorial': memorial?.toJson(),
      'created_posthumous_accounts': createdPosthumousAccounts,
      'followers': followers,
      'following': following,
      'events_created': eventsCreated,
      'events_participated': eventsParticipated,
      'live_sessions': liveSessions,
      'last_active': lastActive,
      'is_verified': isVerified,
      'is_private': isPrivate,
      'social_links': socialLinks?.toJson(),
      'preferences': preferences.toJson(),
    };
  }

  /// **Convert JSON string to a list of UserModels**
  static List<UserModel> fromJsonList(String jsonStr) {
    final List<dynamic> jsonData = json.decode(jsonStr);
    return jsonData.map((json) => UserModel.fromJson(json)).toList();
  }

  /// **Default User instance for handling unknown users**
  static UserModel defaultUser() {
    return UserModel(
      id: "default",
      username: "Unknown User",
      fullName: "Unknown",
      email: null,
      profilePicture: "",
      bio: "Account does not exist",
      status: "unknown",
      accountType: "personal",
      location: Location(city: "N/A", country: "N/A"),
      birthdate: "0000-00-00",
      deathdate: null,
      memorial: null,
      createdPosthumousAccounts: [],
      followers: 0,
      following: 0,
      eventsCreated: [],
      eventsParticipated: [],
      liveSessions: [],
      lastActive: "0000-00-00T00:00:00Z",
      isVerified: false,
      isPrivate: true,
      socialLinks: null,
      preferences: Preferences(language: "fr", theme: "light", notificationsEnabled: false),
    );
  }
}

/// **Location Class**
/// Represents a user's geographical location.
class Location {
  final String city;
  final String country;

  Location({required this.city, required this.country});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(city: json['city'], country: json['country']);
  }

  Map<String, dynamic> toJson() {
    return {'city': city, 'country': country};
  }
}

/// **Memorial Class**
/// Represents a user's memorial page if applicable.
class Memorial {
  final String createdBy; // User who created the memorial
  final String tributeMessage; // Tribute message for the deceased
  final List<String> familyLinks; // Related family members
  final List<String> tributes; // List of tributes received

  Memorial({
    required this.createdBy,
    required this.tributeMessage,
    required this.familyLinks,
    required this.tributes,
  });

  factory Memorial.fromJson(Map<String, dynamic> json) {
    return Memorial(
      createdBy: json['created_by'],
      tributeMessage: json['tribute_message'],
      familyLinks: List<String>.from(json['family_links']),
      tributes: List<String>.from(json['tributes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'tribute_message': tributeMessage,
      'family_links': familyLinks,
      'tributes': tributes,
    };
  }
}

/// **SocialLinks Class**
/// Represents social media links associated with the user.
class SocialLinks {
  final String? twitter;
  final String? instagram;
  final String? wikipedia;

  SocialLinks({this.twitter, this.instagram, this.wikipedia});

  factory SocialLinks.fromJson(Map<String, dynamic> json) {
    return SocialLinks(
      twitter: json['twitter'],
      instagram: json['instagram'],
      wikipedia: json['wikipedia'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'twitter': twitter,
      'instagram': instagram,
      'wikipedia': wikipedia,
    };
  }
}

/// **Preferences Class**
/// Stores user preferences such as language, theme, and notification settings.
class Preferences {
  final String language;
  final String theme;
  final bool notificationsEnabled;

  Preferences({
    required this.language,
    required this.theme,
    required this.notificationsEnabled,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      language: json['language'],
      theme: json['theme'],
      notificationsEnabled: json['notifications_enabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'theme': theme,
      'notifications_enabled': notificationsEnabled,
    };
  }
}
