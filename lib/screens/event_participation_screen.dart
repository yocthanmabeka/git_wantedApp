import 'package:flutter/material.dart';
import 'package:wanted/models/event_model.dart';
import 'package:wanted/models/user_model.dart';

class EventParticipationScreen extends StatelessWidget {
  final EventModel event;
  final UserModel creator;

  const EventParticipationScreen({
    super.key,
    required this.event,
    required this.creator,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Participation à l'événement"),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // TODO: Implémenter le partage de l'événement
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildEventHeader(),
            _buildLiveStreamingSection(context),
            _buildParticipationOptions(context),
            _buildMemorialTribute(),
            _buildCondolenceBook(),
          ],
        ),
      ),
    );
  }

  /// ✅ **Affichage des informations principales du défunt et de l'événement**
  Widget _buildEventHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(event.media.isNotEmpty ? event.media.first["url"]! : ""),
            backgroundColor: Colors.white24,
          ),
          const SizedBox(height: 12),
          Text(
            event.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "${event.date} - ${event.location}",
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            event.description,
            style: const TextStyle(fontSize: 14, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const Divider(color: Colors.white24, thickness: 1, height: 25),
        ],
      ),
    );
  }

  /// ✅ **Section pour la diffusion en direct ou la rediffusion**
  Widget _buildLiveStreamingSection(BuildContext context) {
    return event.media.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Image.network(event.media.first["url"]!, fit: BoxFit.cover, width: double.infinity, height: 220),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Lancer la diffusion en direct ou vidéo
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                      icon: const Icon(Icons.play_arrow, color: Colors.white),
                      label: const Text("Regarder"),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  /// ✅ **Options de participation à l'événement**
  Widget _buildParticipationOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implémenter l'allumage de bougie virtuelle
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
            icon: const Icon(Icons.local_fire_department, color: Colors.white),
            label: const Text("Allumer une bougie virtuelle"),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implémenter la donation
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
            icon: const Icon(Icons.volunteer_activism, color: Colors.white),
            label: const Text("Faire un don"),
          ),
        ],
      ),
    );
  }

  /// ✅ **Hommage mémoriel avec objets symboliques**
  Widget _buildMemorialTribute() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Hommage Mémoriel",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _buildSymbolItem("🕯 Bougie", "Allumez une lumière en sa mémoire"),
              _buildSymbolItem("📜 Citation", "Un dernier hommage écrit"),
              _buildSymbolItem("🏵 Fleurs", "Déposer une couronne virtuelle"),
              _buildSymbolItem("📖 Livre d'or", "Écrire un souvenir"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSymbolItem(String icon, String label) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 30)),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ],
    );
  }

  /// ✅ **Livre d'or pour messages de condoléances**
  Widget _buildCondolenceBook() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Livre d'or",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Écrivez un message en hommage...",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Ajouter le message au livre d'or
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                  child: const Text("Envoyer"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:wanted/models/event_model.dart';
// import 'package:wanted/models/user_model.dart';

// class EventParticipationScreen extends StatefulWidget {
//   final EventModel event;
//   final UserModel creator;

//   const EventParticipationScreen({
//     super.key,
//     required this.event,
//     required this.creator,
//   });

//   @override
//   State<EventParticipationScreen> createState() => _EventParticipationScreenState();
// }

// class _EventParticipationScreenState extends State<EventParticipationScreen> {
//   bool isParticipating = false;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     isParticipating = widget.event.participants.contains(widget.creator.id);
//   }

//   void _toggleParticipation() async {
//     setState(() {
//       isLoading = true;
//     });

//     await Future.delayed(const Duration(seconds: 1)); // Simulate API request

//     setState(() {
//       isParticipating = !isParticipating;
//       isLoading = false;
//     });

//     // TODO: Update database with new participation status
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.event.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Event Title
//             Text(
//               widget.event.title,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
            
//             // Event Description
//             Text(
//               widget.event.description,
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 10),
            
//             // Event Date & Location
//             Row(
//               children: [
//                 const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
//                 const SizedBox(width: 5),
//                 Text(widget.event.date),
//               ],
//             ),
//             const SizedBox(height: 5),
//             Row(
//               children: [
//                 const Icon(Icons.location_pin, size: 18, color: Colors.grey),
//                 const SizedBox(width: 5),
//                 Text(widget.event.location),
//               ],
//             ),
//             const SizedBox(height: 20),
            
//             // Event Type
//             Row(
//               children: [
//                 const Icon(Icons.lock, size: 18, color: Colors.grey),
//                 const SizedBox(width: 5),
//                 Text("Type: ${widget.event.privacy.toUpperCase()}",
//                     style: const TextStyle(fontWeight: FontWeight.bold)),
//               ],
//             ),
//             const SizedBox(height: 20),
            
//             // Participants
//             Text("Participants: ${widget.event.participants.length}",
//                 style: const TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),

//             Wrap(
//               spacing: 8,
//               children: widget.event.participants
//                   .take(5)
//                   .map((id) => CircleAvatar(child: Text(id[0])))
//                   .toList(),
//             ),
//             const Spacer(),

//             // Participate Button
//             ElevatedButton(
//               onPressed: isLoading ? null : _toggleParticipation,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: isParticipating ? Colors.red : Colors.blue,
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//               child: isLoading
//                   ? const CircularProgressIndicator(color: Colors.white)
//                   : Text(isParticipating ? "Se désinscrire" : "Participer"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
