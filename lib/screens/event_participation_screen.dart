import 'package:flutter/material.dart';
import 'package:wanted/component/payment_page.dart';
import 'package:wanted/models/event_model.dart';
import 'package:wanted/models/user_model.dart';

class EventGriefScreen extends StatefulWidget {
  final EventModel event;
  final UserModel creator;

  const EventGriefScreen({
    super.key,
    required this.event,
    required this.creator,
  });

  @override
  State<EventGriefScreen> createState() => _EventGriefScreenState();
}

class _EventGriefScreenState extends State<EventGriefScreen> {
  bool _isExpanded = false;
  double baseHeight = 80; // Hauteur normale de la description
  double expandedHeight = 200; // Hauteur quand "Voir plus" est activé

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

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
            _buildMediaSection(context),
            _buildCategorySection(),
            _buildCeremonyDetails(),
            _buildCustomizationAndRituals(),
            _buildParticipantsAndAccess(),
            _buildCommemorationCreation(),
            _buildMemorialTribute(),
            _buildCondolenceBook(),
            _buildContribution(context),
          ],
        ),
      ),
    );
  }

  /// 🕯️ **Informations sur le défunt**
  Widget _buildEventHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: widget.event.media.isNotEmpty
                ? AssetImage(widget.event.media.first["url"]!)
                : null,
            backgroundColor: Colors.white24,
          ),
          const SizedBox(height: 12),
          Text(
            widget.event.title,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "${widget.event.date} - ${widget.event.location}",
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _toggleExpand,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              constraints: BoxConstraints(
                maxWidth: 325,
                maxHeight: _isExpanded
                    ? expandedHeight
                    : baseHeight, // 🔥 Hauteur dynamique
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  // ✅ Texte scrollable
                  Positioned.fill(
                    child: SingleChildScrollView(
                      child: Text(
                        widget.event.description,
                        maxLines: _isExpanded
                            ? null
                            : 4, // 🔥 Tronquer à 4 lignes avant expansion
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),

                  // ✅ Bouton pour agrandir ou réduire (maintenant bien visible)
                  if (widget.event.description.length > 200)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        //color: Colors.grey[200],
                        child: TextButton.icon(
                          onPressed: _toggleExpand,
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: Icon(
                            _isExpanded ? Icons.expand_less : Icons.expand_more,
                            //color: Colors.blue,
                            size: 18,
                          ),
                          label: Text(
                            _isExpanded ? "Réduire ▲" : "Voir plus ▼",
                            style: const TextStyle(
                                //color: Colors.blue, 
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.white24, thickness: 1, height: 25),
        ],
      ),
    );
  }

  /// 🎥 **Médias et live streaming**
  Widget _buildMediaSection(BuildContext context) {
    return widget.event.media.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(widget.event.media.first["url"]!,
                  fit: BoxFit.cover, width: double.infinity, height: 220),
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
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: widget.event.categories.map((category) {
              return Chip(
                  label: Text(category,
                      style: const TextStyle(color: Colors.white)));
            }).toList(),
          ),
          const Divider(color: Colors.white24, thickness: 1, height: 25),
        ],
      ),
    );
  }

  /// 📜 **Détails de la cérémonie**
  Widget _buildCeremonyDetails() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Détails de la cérémonie",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text("Type : ${widget.event.ceremonyType}",
              style: const TextStyle(color: Colors.white70)),
          Text("Date : ${widget.event.date}",
              style: const TextStyle(color: Colors.white70)),
          Text("Lieu : ${widget.event.location}",
              style: const TextStyle(color: Colors.white70)),
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
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text("Thème : ${widget.event.theme}",
              style: const TextStyle(color: Colors.white70)),
          Text("Musique : ${widget.event.music}",
              style: const TextStyle(color: Colors.white70)),
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
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text("Accès : ${widget.event.accessType}",
              style: const TextStyle(color: Colors.white70)),
          const Divider(color: Colors.white24, thickness: 1, height: 25),
        ],
      ),
    );
  }

  Widget _buildCommemorationCreation() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Créer une commémoration",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
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

  /// ✅ **7️⃣ Hommage**
  Widget _buildMemorialTribute() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Hommage",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _buildSymbolItem(
                  "🕯 Bougie", "Allumez une lumière en sa mémoire"),
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
        Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ],
    );
  }

  /// 📖 **Livre d'or pour messages de condoléances**
  Widget _buildCondolenceBook() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Mettre des hommages",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  child: const Text("Envoyer"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 💰 **Contribution**
  Widget _buildContribution(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PaymentPage()));
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
            child: const Text("Contribuer"),
          ),
        ],
      ),
    );
  }
}

class EventCommemorationScreen extends StatefulWidget {
  final EventModel event;
  final UserModel creator;

  const EventCommemorationScreen({
    super.key,
    required this.event,
    required this.creator,
  });

  @override
  State<EventCommemorationScreen> createState() => _EventCommemorationScreenState();
}

class _EventCommemorationScreenState extends State<EventCommemorationScreen> {
  bool _isExpanded = false;
  double baseHeight = 80; // Hauteur normale de la description
  double expandedHeight = 200; // Hauteur quand "Voir plus" est activé

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Participation à la Commémoration"),
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
            _buildCommemoFrequency(),
            _buildMediaSection(context),
            //_buildLiveStreamingSection(context),
            _buildCategorySection(),
            _buildCeremonyDetails(),
            _buildCommemoLocation(),
            _buildCustomizationAndActivities(),
            _buildMemorialCreation(),
            _buildMemorialTribute(),
            _buildCondolenceBook(),
            _buildContribution(context),
          ],
        ),
      ),
    );
  }

  /// 🕯️ **Informations sur le défunt**
  Widget _buildEventHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: widget.event.media.isNotEmpty
                ? AssetImage(widget.event.media.first["url"]!)
                : null,
            backgroundColor: Colors.white24,
          ),
          const SizedBox(height: 12),
          Text(
            widget.event.title,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "${widget.event.date} - ${widget.event.location}",
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _toggleExpand,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              constraints: BoxConstraints(
                maxWidth: 325,
                maxHeight: _isExpanded
                    ? expandedHeight
                    : baseHeight, // 🔥 Hauteur dynamique
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  // ✅ Texte scrollable
                  Positioned.fill(
                    child: SingleChildScrollView(
                      child: Text(
                        widget.event.description,
                        maxLines: _isExpanded
                            ? null
                            : 4, // 🔥 Tronquer à 4 lignes avant expansion
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),

                  // ✅ Bouton pour agrandir ou réduire (maintenant bien visible)
                  if (widget.event.description.length > 200)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        child: TextButton.icon(
                          onPressed: _toggleExpand,
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: Icon(
                            _isExpanded ? Icons.expand_less : Icons.expand_more,
                            //color: Colors.blue,
                            size: 18,
                          ),
                          label: Text(
                            _isExpanded ? "Réduire ▲" : "Voir plus ▼",
                            style: const TextStyle(
                                //color: Colors.blue, 
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.white24, thickness: 1, height: 25),
        ],
      ),
    );
  }

  Widget _buildCommemoFrequency() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Fréquence et Date de la Commémoration",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text("Date : ${widget.event.date}",
              style: const TextStyle(color: Colors.white70)),
          Text("Fréquence : ${widget.event.recurrence}",
              style: const TextStyle(color: Colors.white70)),
          const Divider(color: Colors.white24, thickness: 1, height: 25),
        ],
      ),
    );
  }

  /// 🎥 **Médias et live streaming**
  Widget _buildMediaSection(BuildContext context) {
    return widget.event.media.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(widget.event.media.first["url"]!,
                  fit: BoxFit.cover, width: double.infinity, height: 220),
            ),
          )
        : const SizedBox.shrink();
  }

  // Widget _buildLiveStreamingSection(BuildContext context) {
  Widget _buildCategorySection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Catégories du défunt",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Wrap(
            spacing: 8,
            children: widget.event.categories.map((category) {
              return Chip(
                  label: Text(category,
                      style: const TextStyle(color: Colors.white)));
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
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text("Type : ${widget.event.ceremonyType}",
              style: const TextStyle(color: Colors.white70)),
          Text("Date : ${widget.event.date}",
              style: const TextStyle(color: Colors.white70)),
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
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text("Lieu : ${widget.event.location}",
              style: const TextStyle(color: Colors.white70)),
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
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text("Thème : ${widget.event.theme}",
              style: const TextStyle(color: Colors.white70)),
          const Divider(color: Colors.white24, thickness: 1, height: 25),
        ],
      ),
    );
  }

  Widget _buildMemorialCreation() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Exposition ou Création du Mémorial",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          ElevatedButton.icon(
            onPressed: () {},
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
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _buildSymbolItem(
                  "🕯 Bougie", "Allumez une lumière en sa mémoire"),
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
        Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.white70)),
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
            "Mettre des hommages",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  child: const Text("Envoyer"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContribution(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PaymentPage()));
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
            child: const Text("Contribuer"),
          ),
        ],
      ),
    );
  }
}
