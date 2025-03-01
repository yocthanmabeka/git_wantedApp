import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wanted/models/model.dart';

// **Widget qui affiche un live individuel**
class EventLive extends StatelessWidget {
  final VoidCallback closePage;
  final EventModel event;
  final UserModel creator;
  final LiveModel liveData;

  const EventLive({
    super.key,
    required this.closePage,
    required this.event,
    required this.creator,
    required this.liveData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fond sombre pour immersion
      body: Stack(
        children: [
          // **1. Fond d'écran du live (image ou couleur)**
          // Positioned.fill(
          //   child: liveData.coverImage.isNotEmpty
          //       ? Image.network(
          //           liveData.coverImage,
          //           fit: BoxFit.cover,
          //         )
          //       : Container(color: Colors.black54),
          // ),

          // **2. Barre supérieure avec infos streamer + bouton quitter**
          _buildLiveHeader(),

          // **3. Zone d'interactions et champ de texte**
          _buildLiveActions(),
        ],
      ),
    );
  }

  /// **Widget : En-tête du Live (Infos du streamer + Quitter)**
  Widget _buildLiveHeader() {
    return Positioned(
      top: 10,
      left: 5,
      right: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // **Profil du streamer**
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: creator.profilePicture.isNotEmpty
                    ? NetworkImage(creator.profilePicture)
                    : null,
                child: creator.profilePicture.isEmpty
                    ? const Icon(Icons.person_rounded, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // **Nom de l'hôte du live**
                  Text(
                    creator.username,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),

                  // **Nombre de spectateurs**
                  Text("55k",
                    //"${liveData.viewersCount} spectateurs",
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(width: 10),

              // **Bouton "Se lier" ou "En direct"**
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text("Se lier"),
              ),
            ],
          ),

          // **Icônes du haut à droite**
          Row(
            children: [
              IconButton(
                onPressed: () {}, // Recherche ?
                icon: const Icon(Icons.search_rounded, color: Colors.white),
              ),
              IconButton(
                onPressed: closePage,
                icon: const Icon(Icons.cancel_outlined, color: Colors.red, size: 25),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// **Widget : Barre d'interactions + champ de saisie pour le chat**
  Widget _buildLiveActions() {
    return Positioned(
      bottom: 10,
      left: 5,
      right: 5,
      child: Row(
        children: [
          // **Champ de texte pour les messages**
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Écrire un message...",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blueAccent),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          // **Icônes d'interactions**
          IconButton(
            onPressed: () {}, // Réactions "like"
            icon: const FaIcon(FontAwesomeIcons.handFist, color: Colors.white),
          ),
          IconButton(
            onPressed: () {}, // Cagnotte
            icon: const Icon(Icons.attach_money_rounded, color: Colors.white),
          ),
          IconButton(
            onPressed: () {}, // Options
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }
}