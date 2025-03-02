import 'package:flutter/material.dart';
import 'package:wanted/component/payment_page.dart';
import 'package:wanted/models/event_model.dart';
import 'package:wanted/models/user_model.dart';

class EventGriefScreen extends StatelessWidget {
  final EventModel event;
  final UserModel creator;

  const EventGriefScreen({
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
            _buildEventHeader(), // ✅ Informations sur le défunt
            _buildLiveStreamingSection(context), // ✅ Lives et Médias
            _buildCategorySection(), // ✅ Catégories du défunt
            _buildCeremonyDetails(), // ✅ Détails de la cérémonie
            _buildCustomizationAndRituals(), // ✅ Personnalisation et rituels
            _buildParticipantsAndAccess(), // ✅ Participants et Accès
            _buildCommemorationCreation(),
            _buildMemorialTribute(), // ✅ Hommage
            _buildCondolenceBook(),
            _buildContribution(context), // ✅ Contribution
          ],
        ),
      ),
    );
  }

  /// ✅ **1️⃣ Informations sur le défunt**
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

  /// ✅ **2️⃣ Lives et Médias**
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

  /// ✅ **3️⃣ Catégories du défunt**
  Widget _buildCategorySection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Catégories du défunt",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: event.categories.map((category) {
              return Chip(label: Text(category, style: const TextStyle(color: Colors.white)));
            }).toList(),
          ),
          const Divider(color: Colors.white24, thickness: 1, height: 25),
        ],
      ),
    );
  }

  /// ✅ **4️⃣ Détails de la cérémonie**
  Widget _buildCeremonyDetails() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Détails de la cérémonie",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          Text("Type : ${event.ceremonyType}", style: const TextStyle(color: Colors.white70)),
          Text("Date : ${event.date}", style: const TextStyle(color: Colors.white70)),
          Text("Lieu : ${event.location}", style: const TextStyle(color: Colors.white70)),
          const Divider(color: Colors.white24, thickness: 1, height: 25),
        ],
      ),
    );
  }

  /// ✅ **5️⃣ Personnalisation et Rituels**
  Widget _buildCustomizationAndRituals() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Personnalisation et Rituels",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          Text("Thème : ${event.theme}", style: const TextStyle(color: Colors.white70)),
          Text("Musique : ${event.music}", style: const TextStyle(color: Colors.white70)),
          const Divider(color: Colors.white24, thickness: 1, height: 25),
        ],
      ),
    );
  }

  /// ✅ **6️⃣ Participants et Accès**
  Widget _buildParticipantsAndAccess() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Participants et Accès",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          Text("Accès : ${event.accessType}", style: const TextStyle(color: Colors.white70)),
          const Divider(color: Colors.white24, thickness: 1, height: 25),
        ],
      ),
    );
  }

  /// ✅ **7️⃣ Hommage**
  Widget _buildMemorialTribute() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Hommage",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
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

  Widget _buildCommemorationCreation() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Créer une commémoration",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Naviguer vers la création du mémorial
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text("Créer une commémoration"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
        ],
      ),
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
            "Mettre des hommages",
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

  /// ✅ ** Contribution**
  Widget _buildContribution(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            // ✅ Correction : context est maintenant disponible
            Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()));
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
          child: const Text("Contribuer"),
        ),
      ],
    ),
  );
}

}

class EventCommemorationScreen extends StatelessWidget {
  final EventModel event;
  final UserModel creator;

  const EventCommemorationScreen({
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
            _buildEventHeader(), // ✅ Informations sur le défunt
            _buildCommemoFrequency(), // ✅ Fréquence et Date de la Commémoration
            _buildLiveStreamingSection(context), // ✅ Lives et Médias
            _buildCategorySection(), // ✅ Catégories du défunt
            _buildCeremonyDetails(), // ✅ Détails de la cérémonie
            _buildCommemoLocation(), // ✅ Lieu et Mode de Commémoration
            _buildCustomizationAndActivities(), // ✅ Personnalisation et Activités
            _buildMemorialCreation(), // ✅ Exposition ou Création du Mémorial
            _buildMemorialTribute(), // ✅ Hommage
            _buildCondolenceBook(),
            _buildContribution(context), // ✅ Contribution
          ],
        ),
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

  /// ✅ **1️⃣ Informations sur le défunt**
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

  /// ✅ **2️⃣ Fréquence et Date de la Commémoration**
  Widget _buildCommemoFrequency() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Fréquence et Date de la Commémoration",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          Text("Date : ${event.date}", style: const TextStyle(color: Colors.white70)),
          Text("Fréquence : ${event.recurrence}", style: const TextStyle(color: Colors.white70)),
          const Divider(color: Colors.white24, thickness: 1, height: 25),
        ],
      ),
    );
  }

  /// ✅ **3️⃣ Lives et Médias**
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

  /// ✅ **4️⃣ Catégories du défunt**
  Widget _buildCategorySection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Catégories du défunt",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          Wrap(
            spacing: 8,
            children: event.categories.map((category) {
              return Chip(label: Text(category, style: const TextStyle(color: Colors.white)));
            }).toList(),
          ),
          const Divider(color: Colors.white24, thickness: 1, height: 25),
        ],
      ),
    );
  }

  /// ✅ **5️⃣ Détails de la cérémonie**
  Widget _buildCeremonyDetails() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Détails de la cérémonie",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          Text("Type : ${event.ceremonyType}", style: const TextStyle(color: Colors.white70)),
          Text("Date : ${event.date}", style: const TextStyle(color: Colors.white70)),
          const Divider(color: Colors.white24, thickness: 1, height: 25),
        ],
      ),
    );
  }

  /// ✅ **6️⃣ Lieu et Mode de Commémoration**
  Widget _buildCommemoLocation() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Lieu et Mode de Commémoration",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          Text("Lieu : ${event.location}", style: const TextStyle(color: Colors.white70)),
          const Divider(color: Colors.white24, thickness: 1, height: 25),
        ],
      ),
    );
  }

  /// ✅ **7️⃣ Personnalisation et Activités**
  Widget _buildCustomizationAndActivities() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Personnalisation et Activités",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          Text("Thème : ${event.theme}", style: const TextStyle(color: Colors.white70)),
          const Divider(color: Colors.white24, thickness: 1, height: 25),
        ],
      ),
    );
  }

  /// ✅ **8️⃣ Exposition ou Création du Mémorial**
  Widget _buildMemorialCreation() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Exposition ou Création du Mémorial",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Naviguer vers la création du mémorial
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text("Créer un Mémorial"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildMemorialTribute() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Hommage",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
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
  /// ✅ **Livre d'or pour messages de condoléances**
  Widget _buildCondolenceBook() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Mettre des hommages",
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

  /// ✅ ** Contribution**
  Widget _buildContribution(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            // ✅ Correction : context est maintenant disponible
            Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()));
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
          child: const Text("Contribuer"),
        ),
      ],
    ),
  );
}
}


// import 'package:flutter/material.dart';
// import 'package:wanted/models/event_model.dart';
// import 'package:wanted/models/user_model.dart';

// class EventParticipationScreen extends StatelessWidget {
//   final EventModel event;
//   final UserModel creator;

//   const EventParticipationScreen({
//     super.key,
//     required this.event,
//     required this.creator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text("Participation à l'événement"),
//         backgroundColor: Colors.black,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.share, color: Colors.white),
//             onPressed: () {
//               // TODO: Implémenter le partage de l'événement
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             _buildEventHeader(),
//             _buildLiveStreamingSection(context),
//             _buildParticipationOptions(context),
//             _buildMemorialTribute(),
//             _buildCondolenceBook(),
//           ],
//         ),
//       ),
//     );
//   }

//   /// ✅ **Affichage des informations principales du défunt et de l'événement**
//   Widget _buildEventHeader() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           CircleAvatar(
//             radius: 60,
//             backgroundImage: NetworkImage(event.media.isNotEmpty ? event.media.first["url"]! : ""),
//             backgroundColor: Colors.white24,
//           ),
//           const SizedBox(height: 12),
//           Text(
//             event.title,
//             style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             "${event.date} - ${event.location}",
//             style: const TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             event.description,
//             style: const TextStyle(fontSize: 14, color: Colors.white70),
//             textAlign: TextAlign.center,
//           ),
//           const Divider(color: Colors.white24, thickness: 1, height: 25),
//         ],
//       ),
//     );
//   }

//   /// ✅ **Section pour la diffusion en direct ou la rediffusion**
//   Widget _buildLiveStreamingSection(BuildContext context) {
//     return event.media.isNotEmpty
//         ? Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Stack(
//                 children: [
//                   Image.network(event.media.first["url"]!, fit: BoxFit.cover, width: double.infinity, height: 220),
//                   Positioned(
//                     bottom: 10,
//                     right: 10,
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         // TODO: Lancer la diffusion en direct ou vidéo
//                       },
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
//                       icon: const Icon(Icons.play_arrow, color: Colors.white),
//                       label: const Text("Regarder"),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         : const SizedBox.shrink();
//   }

//   /// ✅ **Options de participation à l'événement**
//   Widget _buildParticipationOptions(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           ElevatedButton.icon(
//             onPressed: () {
//               // TODO: Implémenter l'allumage de bougie virtuelle
//             },
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
//             icon: const Icon(Icons.local_fire_department, color: Colors.white),
//             label: const Text("Allumer une bougie virtuelle"),
//           ),
//           const SizedBox(height: 8),
//           ElevatedButton.icon(
//             onPressed: () {
//               // TODO: Implémenter la donation
//             },
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
//             icon: const Icon(Icons.volunteer_activism, color: Colors.white),
//             label: const Text("Faire un don"),
//           ),
//         ],
//       ),
//     );
//   }

//   /// ✅ **Hommage mémoriel avec objets symboliques**
//   Widget _buildMemorialTribute() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Text(
//             "Hommage Mémoriel",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           const SizedBox(height: 8),
//           Wrap(
//             spacing: 12,
//             runSpacing: 12,
//             alignment: WrapAlignment.center,
//             children: [
//               _buildSymbolItem("🕯 Bougie", "Allumez une lumière en sa mémoire"),
//               _buildSymbolItem("📜 Citation", "Un dernier hommage écrit"),
//               _buildSymbolItem("🏵 Fleurs", "Déposer une couronne virtuelle"),
//               _buildSymbolItem("📖 Livre d'or", "Écrire un souvenir"),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSymbolItem(String icon, String label) {
//     return Column(
//       children: [
//         Text(icon, style: const TextStyle(fontSize: 30)),
//         const SizedBox(height: 5),
//         Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
//       ],
//     );
//   }

//   /// ✅ **Livre d'or pour messages de condoléances**
//   Widget _buildCondolenceBook() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Livre d'or",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.white12,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               children: [
//                 TextField(
//                   style: const TextStyle(color: Colors.white),
//                   decoration: const InputDecoration(
//                     hintText: "Écrivez un message en hommage...",
//                     hintStyle: TextStyle(color: Colors.white54),
//                     border: InputBorder.none,
//                   ),
//                   maxLines: 3,
//                 ),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     // TODO: Ajouter le message au livre d'or
//                   },
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
//                   child: const Text("Envoyer"),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
