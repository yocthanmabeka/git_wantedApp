import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wanted/models/model.dart';
import 'package:wanted/screens/memorial_detail_screen.dart';
import 'package:wanted/screens/live_screen.dart';

class ActivityItem extends StatelessWidget {
  final Activity activity;

  const ActivityItem({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleActivityTap(context),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
          color: Colors.grey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (activity.hashtag != null)
              Text(
                activity.hashtag!,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: activity.user.profilePicture.isNotEmpty
                          ? NetworkImage(activity.user.profilePicture)
                          : null,
                      child: activity.user.profilePicture.isEmpty
                          ? const Icon(Icons.person_rounded)
                          : null,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      activity.user.username,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Se lier"),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 33, right: 5),
                    child: Text(
                      activity.description ?? activity.message ?? "",
                      style: const TextStyle(fontSize: 14),
                      softWrap: true,
                    ),
                  ),
                ),
                if (activity.media != null && activity.media!.isNotEmpty)
                  _buildMediaPreview(),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(right: 16),
              width: 330,
              height: 35,
              child: TextButton(
                onPressed: () => _handleActivityTap(context),
                child: const Text('Voir plus'),
              ),
            ),
            if (activity.actions != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _interactionButton(FontAwesomeIcons.handFist, activity.actions!.like),
                  _interactionButton(FontAwesomeIcons.message, activity.actions!.comment),
                  _interactionButton(FontAwesomeIcons.repeat, activity.actions!.share),
                  IconButton(
                    onPressed: () {},
                    iconSize: 20,
                    icon: const FaIcon(FontAwesomeIcons.paperPlane),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _handleActivityTap(BuildContext context) {
    if (activity.type == "commemoration" && activity.memorial != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MemorialDetailScreen(
            memorial: MemorialModel.fromJson(activity.memorial!.toJson()),
          ),
        ),
      );
    } else if (activity.type == "event_participation" && activity.event != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EventDetailScreen(
            event: EventModel.fromJson(activity.event!.toJson()),
          ),
        ),
      );
    } else if (activity.type == "live_notification") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LiveScreen(closePage: () {}),
        ),
      );
    }
  }

  Widget _buildMediaPreview() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 110,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[400],
            image: DecorationImage(
              image: NetworkImage(activity.media![0].url),
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (activity.media!.length > 1)
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "+${activity.media!.length - 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _interactionButton(IconData icon, int count) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          iconSize: 20,
          icon: FaIcon(icon),
        ),
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class EventDetailScreen extends StatelessWidget {
  final EventModel event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implémenter le partage de l'événement
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Image principale de l'événement
            if (event.media.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  event.media.first["url"]!,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            
            const SizedBox(height: 16),

            // ✅ Informations de l'événement
            _buildSectionTitle("Détails de l'événement"),
            Text(event.description, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 16),

            _buildSectionTitle("Date et lieu"),
            Text("📅 ${event.date}", style: const TextStyle(fontSize: 16)),
            Text("📍 ${event.location}", style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 16),

            // ✅ Participants
            if (event.participants.isNotEmpty)
              _buildSectionTitle("Participants"),
            Wrap(
              spacing: 10,
              children: event.participants
                  .map((participant) => Chip(label: Text(participant)))
                  .toList(),
            ),

            const SizedBox(height: 16),

            // ✅ Hashtags
            if (event.hashtags.isNotEmpty)
              _buildSectionTitle("Hashtags"),
            Wrap(
              spacing: 10,
              children: event.hashtags
                  .map((tag) => Chip(label: Text("#$tag")))
                  .toList(),
            ),

            const SizedBox(height: 16),

            // ✅ Documents associés
            if (event.documents.isNotEmpty)
              _buildSectionTitle("Documents"),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: event.documents
                  .map((doc) => Text("📄 $doc", style: const TextStyle(fontSize: 16)))
                  .toList(),
            ),

            const SizedBox(height: 16),

            // ✅ Bouton de participation
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implémenter la logique d'inscription à l'événement
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Participer à l'événement", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Widget pour afficher les titres des sections
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
