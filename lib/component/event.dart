import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wanted/models/model.dart';
import 'package:wanted/screens/event_participation_screen.dart';

/// ✅ **EventCard - Unified Event Display**
/// This widget presents an **event card** with media preview, title, description,
/// actions (like, comment, share), and participants list.
class EventCard extends StatelessWidget {
  final EventModel event;
  final UserModel creator;

  const EventCard({
    super.key,
    required this.event,
    required this.creator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(
        width: 400,
        height: 650, // Fixed height
      ),
      decoration: const BoxDecoration(
        border: BorderDirectional(
          top: BorderSide(color: Colors.black),
          //bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: Column(
        children: [
          _buildCreatorSection(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 25,right: 25, bottom: 20),
                color: Colors.grey,
                width: 1.5,
                height: 545,
              ),
              Column(children: [
                _buildMediaSection(context),
                _buildActionButtons(),
                _buildType(),
                _buildDescription(context),
                _buildMainActionButton(context),
                _buildParticipants(),
              ])
            ],
          )
        ],
      ),
    );
  }

  /// ✅ **Displays the Event Creator Section**
  Widget _buildCreatorSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: creator.profilePicture.isNotEmpty
                    ? NetworkImage(creator.profilePicture)
                    : null,
                child: creator.profilePicture.isEmpty
                    ? const Icon(Icons.person_rounded)
                    : null,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    creator.username,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    event.location.isNotEmpty ? event.location : 'Lieu inconnu',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {}, // TODO: Open event options
            icon: const Icon(Icons.expand_circle_down_outlined),
          ),
        ],
      ),
    );
  }

  /// ✅ **Displays the Event Media Section**
  Widget _buildMediaSection(BuildContext context) {
    if (event.media.isNotEmpty) {
      String? mediaUrl = event.media.first["url"];
      String? mediaType = event.media.first["type"];

      return GestureDetector(
        onTap: () {
          // ✅ Navigate to full media gallery
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MediaGalleryScreen(mediaList: event.media),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 5, right: 16, left: 20),
          constraints: const BoxConstraints.expand(width: 300, height: 375),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: mediaType == 'image'
                ? DecorationImage(
                    image: NetworkImage(mediaUrl!), fit: BoxFit.cover)
                : null,
          ),
          child: mediaType == 'video'
              ? const Center(
                  child: Icon(Icons.play_circle_fill,
                      size: 50, color: Colors.white))
              : null,
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(bottom: 5, right: 16),
        constraints: const BoxConstraints.expand(width: 330, height: 350),
        color: Colors.grey[300],
        child: const Center(child: Text('Aucun média disponible')),
      );
    }
  }

  /// ✅ **Displays the Event Title**
  Widget _buildType() {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      constraints: const BoxConstraints.expand(width: 300, height: 35),
      child: TextButton(
        onPressed: () {},
        child: Text(event.type.isNotEmpty ? event.type : 'Sans titre'),
      ),
    );
  }

  /// ✅ **Displays the Event Description (Expandable if Long)**
  Widget _buildDescription(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isOverflowing = event.description.length > 200;

        return Container(
          margin: const EdgeInsets.only(top: 5, right: 16),
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(maxWidth: 325, maxHeight: 250),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Text(
                event.description.length > 200
                    ? "${event.description.substring(0, 200)}..."
                    : event.description,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
              if (isOverflowing) // ✅ Show "See More" if text is long
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: TextButton.icon(
                    onPressed: () => _showFullDescription(context),
                    icon: const Icon(Icons.expand_circle_down,
                        color: Colors.blue),
                    label: const Text("Voir plus",
                        style: TextStyle(color: Colors.blue)),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  /// ✅ **Displays Full Event Description in Dialog**
  void _showFullDescription(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Description complète"),
          content: SingleChildScrollView(child: Text(event.description)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Fermer"),
            ),
          ],
        );
      },
    );
  }

  /// ✅ **Displays Event Main Action Button**
  Widget _buildMainActionButton(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(10),
      margin: const EdgeInsets.only(right: 16,top: 5, bottom: 5),
      constraints: const BoxConstraints.expand(width: 330, height: 35),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EventGriefScreen(event: event, creator: creator),
            ),
          );
        },
        child: const Text('Participer'),
      ),
    );
  }

  /// ✅ **Displays Like, Comment, Share Buttons**
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildIconButton(FontAwesomeIcons.handFist, 2000),
        _buildIconButton(FontAwesomeIcons.message, 500),
        _buildIconButton(FontAwesomeIcons.repeat, 300),
        IconButton(
          onPressed: () {},
          icon: const FaIcon(FontAwesomeIcons.paperPlane),
          iconSize: 20,
        ),
      ],
    );
  }

  /// ✅ **Displays Event Participants**
  Widget _buildParticipants() {
    return TextButton(
      onPressed: () {},
      child: Wrap(
        spacing: 10,
        children: event.participants
            .take(3)
            .map((participant) => Chip(label: Text(participant)))
            .toList(),
      ),
    );
  }

  /// ✅ **Helper Widget for Icon Buttons**
  Widget _buildIconButton(IconData icon, int count) {
    return Row(children: [
      IconButton(onPressed: () {}, icon: FaIcon(icon), iconSize: 20),
      Text('$count'),
    ]);
  }
}

/// ✅ **Media Gallery Screen**
/// Displays all media files associated with an event in a grid format.
class MediaGalleryScreen extends StatelessWidget {
  final List<Map<String, String>> mediaList;

  const MediaGalleryScreen({super.key, required this.mediaList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Médias")),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: mediaList.length,
        itemBuilder: (context, index) {
          String mediaUrl = mediaList[index]["url"]!;
          return GestureDetector(
            onTap: () {},
            child: Image.network(mediaUrl, fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}