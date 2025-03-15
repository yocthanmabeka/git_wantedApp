import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wanted/models/model.dart';
import 'package:wanted/screens/event_participation_screen.dart';
import 'package:wanted/screens/screens.dart';

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
    return ChangeNotifierProvider(
      create: (context) => EventManager(),
      child: Consumer<EventManager>(
        builder: (context, eventManager, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            constraints: BoxConstraints.expand(
              width: 400,
              height: eventManager.cardHeight, // Hauteur dynamique
            ),
            decoration: const BoxDecoration(
              border: BorderDirectional(
                top: BorderSide(color: Colors.black),
              ),
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  _buildCreatorSection(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin:
                            const EdgeInsets.only(left: 25, right: 25, bottom: 20),
                        color: Colors.grey,
                        width: 1.5,
                        height: eventManager.lineHeight, // Hauteur dynamique ajustée
                      ),
                      Expanded(
                        child: Column(children: [
                          _buildMediaSection(context),
                          _buildType(),
                          _buildDescription(context),
                          _buildActionButtons(context),
                          _buildMainActionButton(context),
                          _buildParticipants(),
                        ]),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

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
          // ✅ Naviguer vers la galerie de médias
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MediaGalleryScreen(mediaList: event.media),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 5, right: 16, left: 20),
          constraints: const BoxConstraints.expand(width: 300, height: 330),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: mediaType == 'image'
                ? (mediaUrl!.startsWith("assets/")
                    ? DecorationImage(
                        image: AssetImage(mediaUrl), fit: BoxFit.cover)
                    : DecorationImage(
                        image: NetworkImage(mediaUrl), fit: BoxFit.cover))
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
        constraints: const BoxConstraints.expand(width: 330, height: 30),
        color: Colors.grey[300],
        child: const Center(child: Text('Aucun média disponible')),
      );
    }
  }

    /// ✅ **Displays the Event Title**
  Widget _buildType() {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      constraints: const BoxConstraints.expand(width: 300, height: 30),
      child: TextButton(
        onPressed: () {},
        child: Text(
            event.type.isNotEmpty ? event.type : 'Sans titre'),
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
  return Consumer<EventManager>(
    builder: (context, eventManager, child) {
      return GestureDetector(
        onTap: eventManager.toggleExpand,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          constraints: BoxConstraints(
            maxWidth: 325,
            maxHeight: eventManager.isExpanded ? eventManager.expandedHeight : eventManager.baseHeight,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  child: Text(
                    event.description,
                    maxLines: eventManager.isExpanded ? null : 4,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              if (event.description.length > 200)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    color: Colors.grey[200],
                    child: TextButton.icon(
                      onPressed: eventManager.toggleExpand,
                      style: TextButton.styleFrom(backgroundColor: Colors.transparent),
                      icon: Icon(
                          eventManager.isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.blue,
                          size: 18),
                      label: Text(
                        eventManager.isExpanded ? "Réduire ▲" : "Voir plus ▼",
                        style: const TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}


  Widget _buildActionButtons(BuildContext context) {
  return Consumer<EventManager>(
    builder: (context, eventManager, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton.icon(
              onPressed: eventManager.incrementLikes,
              label: Text('${eventManager.likes}'),
              icon: FaIcon(FontAwesomeIcons.handFist)),
          TextButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateScreen()));
              },
              label: Text('${eventManager.comments}'),
              icon: FaIcon(FontAwesomeIcons.message)),
          TextButton.icon(
              onPressed: eventManager.incrementShares,
              label: Text('${eventManager.shares}'),
              icon: FaIcon(FontAwesomeIcons.repeat)),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.paperPlane),
            iconSize: 15,
          ),
        ],
      );
    },
  );
}


  Widget _buildMainActionButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16, top: 5, bottom: 5),
      constraints: const BoxConstraints.expand(width: 330, height: 30),
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
          bool isAsset = mediaUrl.startsWith("assets/");

          return GestureDetector(
            onTap: () {},
            child: isAsset
                ? Image.asset(mediaUrl, fit: BoxFit.cover)
                : Image.network(mediaUrl, fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:wanted/models/model.dart';
// import 'package:wanted/screens/event_participation_screen.dart';
// import 'package:wanted/screens/screens.dart';

// /// ✅ **EventCard - Unified Event Display**
// /// This widget presents an **event card** with media preview, title, description,
// /// actions (like, comment, share), and participants list.
// class EventCard extends StatefulWidget {
//   final EventModel event;
//   final UserModel creator;

//   const EventCard({
//     super.key,
//     required this.event,
//     required this.creator,
//   });

//   @override
//   State<EventCard> createState() => _EventCardState();
// }

// class _EventCardState extends State<EventCard> {
//   bool _isExpanded = false;
//   double _lineHeight = 540; // Hauteur initiale de la barre
//   double baseHeight = 80; // Hauteur normale de la description
//   double expandedHeight = 200; // Hauteur quand "Voir plus" est activé
//   double _cardHeight = 625; // Hauteur dynamique

//   void _toggleExpand() {
//     setState(() {
//       _isExpanded = !_isExpanded;
//       double heightDiff = expandedHeight - baseHeight;
//       _lineHeight = _isExpanded ? 540 + heightDiff : 540;
//       _cardHeight = _isExpanded
//           ? 625 + heightDiff
//           : 625; // ✅ Correction de l'erreur de calcul
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200), // Animation fluide
//       constraints: BoxConstraints.expand(
//         width: 400,
//         height: _cardHeight, // Hauteur dynamique
//       ),
//       decoration: const BoxDecoration(
//         border: BorderDirectional(
//           top: BorderSide(color: Colors.black),
//         ),
//       ),
//       child: IntrinsicHeight(
//         child: Column(
//           children: [
//             _buildCreatorSection(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // ✅ Barre verticale qui s'adapte à la description
//                 AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   margin:
//                       const EdgeInsets.only(left: 25, right: 25, bottom: 20),
//                   color: Colors.grey,
//                   width: 1.5,
//                   height: _lineHeight, // Hauteur dynamique ajustée
//                 ),
//                 Expanded(
//                   child: Column(children: [
//                     _buildMediaSection(context),
//                     _buildActionButtons(),
//                     _buildType(),
//                     _buildDescription(),
//                     _buildMainActionButton(context),
//                     _buildParticipants(),
//                   ]),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   /// ✅ **Displays the Event Creator Section**
//   Widget _buildCreatorSection() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: widget.creator.profilePicture.isNotEmpty
//                     ? NetworkImage(widget.creator.profilePicture)
//                     : null,
//                 child: widget.creator.profilePicture.isEmpty
//                     ? const Icon(Icons.person_rounded)
//                     : null,
//               ),
//               const SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.creator.username,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     widget.event.location.isNotEmpty
//                         ? widget.event.location
//                         : 'Lieu inconnu',
//                     style: const TextStyle(fontSize: 12, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           IconButton(
//             onPressed: () {}, // TODO: Open event options
//             icon: const Icon(Icons.expand_circle_down_outlined),
//           ),
//         ],
//       ),
//     );
//   }

//   /// ✅ **Displays the Event Media Section**
//   Widget _buildMediaSection(BuildContext context) {
//     if (widget.event.media.isNotEmpty) {
//       String? mediaUrl = widget.event.media.first["url"];
//       String? mediaType = widget.event.media.first["type"];

//       return GestureDetector(
//         onTap: () {
//           // ✅ Naviguer vers la galerie de médias
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   MediaGalleryScreen(mediaList: widget.event.media),
//             ),
//           );
//         },
//         child: Container(
//           margin: const EdgeInsets.only(bottom: 5, right: 16, left: 20),
//           constraints: const BoxConstraints.expand(width: 300, height: 330),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             image: mediaType == 'image'
//                 ? (mediaUrl!.startsWith("assets/")
//                     ? DecorationImage(
//                         image: AssetImage(mediaUrl), fit: BoxFit.cover)
//                     : DecorationImage(
//                         image: NetworkImage(mediaUrl), fit: BoxFit.cover))
//                 : null,
//           ),
//           child: mediaType == 'video'
//               ? const Center(
//                   child: Icon(Icons.play_circle_fill,
//                       size: 50, color: Colors.white))
//               : null,
//         ),
//       );
//     } else {
//       return Container(
//         margin: const EdgeInsets.only(bottom: 5, right: 16),
//         constraints: const BoxConstraints.expand(width: 330, height: 30),
//         color: Colors.grey[300],
//         child: const Center(child: Text('Aucun média disponible')),
//       );
//     }
//   }

//   /// ✅ **Displays the Event Title**
//   Widget _buildType() {
//     return Container(
//       margin: const EdgeInsets.only(right: 16),
//       constraints: const BoxConstraints.expand(width: 300, height: 30),
//       child: TextButton(
//         onPressed: () {},
//         child: Text(
//             widget.event.type.isNotEmpty ? widget.event.type : 'Sans titre'),
//       ),
//     );
//   }

//   /// ✅ **Affichage de la description avec expansion fluide**
//   Widget _buildDescription() {
//     return GestureDetector(
//       onTap: _toggleExpand,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         curve: Curves.easeInOut,
//         constraints: BoxConstraints(
//           maxWidth: 325,
//           maxHeight: _isExpanded ? expandedHeight : baseHeight,
//         ),
//         decoration: BoxDecoration(
//           //color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Stack(
//           children: [
//             Positioned.fill(
//               child: SingleChildScrollView(
//                 child: Text(
//                   widget.event.description,
//                   maxLines: _isExpanded ? null : 4,
//                   style: const TextStyle(fontSize: 14),
//                 ),
//               ),
//             ),
//             if (widget.event.description.length > 200)
//               Positioned(
//                 bottom: 0,
//                 right: 0,
//                 child: Container(
//                   color: Colors.grey[200],
//                   child: TextButton.icon(
//                     onPressed: _toggleExpand,
//                     style: TextButton.styleFrom(
//                         backgroundColor: Colors.transparent),
//                     icon: Icon(
//                         _isExpanded ? Icons.expand_less : Icons.expand_more,
//                         color: Colors.blue,
//                         size: 18),
//                     label: Text(
//                       _isExpanded ? "Réduire ▲" : "Voir plus ▼",
//                       style: const TextStyle(color: Colors.blue, fontSize: 12),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// ✅ **Displays Event Main Action Button**
//   Widget _buildMainActionButton(BuildContext context) {
//     return Container(
//       //padding: EdgeInsets.all(10),
//       margin: const EdgeInsets.only(right: 16, top: 5, bottom: 5),
//       constraints: const BoxConstraints.expand(width: 330, height: 30),
//       child: ElevatedButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => EventGriefScreen(
//                   event: widget.event, creator: widget.creator),
//             ),
//           );
//         },
//         child: const Text('Participer'),
//       ),
//     );
//   }

//   /// ✅ **Displays Like, Comment, Share Buttons**
//   Widget _buildActionButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         TextButton.icon(
//             onPressed: () {},
//             label: Text('2000'),
//             icon: FaIcon(FontAwesomeIcons.handFist)),
//         TextButton.icon(
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => CreateScreen()));
//             },
//             label: Text('500'),
//             icon: FaIcon(FontAwesomeIcons.message)),
//         TextButton.icon(
//             onPressed: () {},
//             label: Text('300'),
//             icon: FaIcon(FontAwesomeIcons.repeat)),
//         IconButton(
//           onPressed: () {},
//           icon: const FaIcon(FontAwesomeIcons.paperPlane),
//           iconSize: 15,
//         ),
//       ],
//     );
//   }

//   /// ✅ **Displays Event Participants**
//   Widget _buildParticipants() {
//     return TextButton(
//       onPressed: () {},
//       child: Wrap(
//         spacing: 10,
//         children: widget.event.participants
//             .take(3)
//             .map((participant) => Chip(label: Text(participant)))
//             .toList(),
//       ),
//     );
//   }

//   //Widget _Answer() {}
// }

// /// ✅ **Media Gallery Screen**
// /// Displays all media files associated with an event in a grid format.
// class MediaGalleryScreen extends StatelessWidget {
//   final List<Map<String, String>> mediaList;

//   const MediaGalleryScreen({super.key, required this.mediaList});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Médias")),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(10),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//         ),
//         itemCount: mediaList.length,
//         itemBuilder: (context, index) {
//           String mediaUrl = mediaList[index]["url"]!;
//           bool isAsset = mediaUrl.startsWith("assets/");

//           return GestureDetector(
//             onTap: () {},
//             child: isAsset
//                 ? Image.asset(mediaUrl, fit: BoxFit.cover)
//                 : Image.network(mediaUrl, fit: BoxFit.cover),
//           );
//         },
//       ),
//     );
//   }
// }
