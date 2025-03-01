import 'package:flutter/material.dart';
import 'package:wanted/component/access_grid_view.dart';
import 'package:wanted/screens/screens.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _deathdateController = TextEditingController();
  final TextEditingController _causeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _tributeController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _eventTimeController = TextEditingController();

  bool _wantsGenealogyTree = false;
  String? _selectedMemorial;
  bool _isDonationEnabled = false;
  bool _isGuestbookEnabled = false;
  final bool _isPostingEnabled = false;

  final String _selectedCategory = "Historique"; // Valeur par défaut
  final String _selectedCeremonyType = "Hommage privé";

  final String _selectedRecurrence = "Annuel";
  final List<String> _selectedVideos = [];
  final List<String> _selectedMedia = [];

  final List<String> recurrences = [
    "Annuel",
    "Tous les 5 ans",
    "Événement spécial"
  ];

  final Map<String, bool> _selectedCeremonyTypes = {
    "Hommage privé": false,
    "Hommage public": false,
    "Cérémonie religieuse": false,
    "Mémorial collectif": false,
  };

  final List<String> eventTypes = [
    "Post",
    "Deuil",
    "Commémoration",
  ];
  final Map<String, bool> _selectedCategories = {
    "Généalogique": false,
    "Historique": false,
    "Riche & Puissant": false,
    "Mort en Masse": false,
  };

  String _selectedEventType = "Post";

  void _showAccessGridView() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return AccessGridView();
      },
    );
  }

  void _showMemorialSelectionDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sélectionner un Mémorial existant",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: const Text("Mémorial de Napoléon Bonaparte"),
                      onTap: () {
                        setState(() {
                          _selectedMemorial = "Mémorial de Napoléon Bonaparte";
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text("Mémorial d'Albert Einstein"),
                      onTap: () {
                        setState(() {
                          _selectedMemorial = "Mémorial d'Albert Einstein";
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text("Mémorial de Martin Luther King"),
                      onTap: () {
                        setState(() {
                          _selectedMemorial = "Mémorial de Martin Luther King";
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEventTypeDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Choisir un type d'événement",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: eventTypes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(eventTypes[index]),
                      onTap: () {
                        setState(() {
                          _selectedEventType = eventTypes[index];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCategoryDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sélectionner la ou les catégories du défunt",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: _selectedCategories.keys.map((String category) {
                    return CheckboxListTile(
                      title: Text(category),
                      value: _selectedCategories[category],
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedCategories[category] = value!;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCeremonyDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sélectionner la ou les catégories du défunt",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: _selectedCeremonyTypes.keys.map((String ceremony) {
                    return CheckboxListTile(
                      title: Text(ceremony),
                      value: _selectedCeremonyTypes[ceremony],
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedCeremonyTypes[ceremony] = value!;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ✅ **Header (Barre de navigation)**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isPostingEnabled
                          ? Colors.blue
                          : Colors.grey.shade400,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Poster"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          CircleAvatar(child: Icon(Icons.person_rounded)),
                          SizedBox(width: 10),
                          Text('Username',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _eventController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                          hintText: "Décris ton événement ?",
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add_to_photos_outlined),
                            onPressed: () {
                              _showAccessGridView();
                            },
                          ),
                          IconButton(
                            icon:
                                const Icon(Icons.radio_button_checked_rounded),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CreateLiveScreen(),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.tag_rounded),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (_selectedEventType == "Commémoration")
                        _buildCommemorationForm(),
                      if (_selectedEventType == "Deuil") _buildGriefForm(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: _showEventTypeDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('#${_selectedEventType.replaceAll(" ", "")}'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ **Formulaire pour créer un deuil**
  Widget _buildGriefForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("1️⃣ Informations générales sur le défunt",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Nom du défunt")),
        TextField(
            controller: _birthdateController,
            decoration: const InputDecoration(labelText: "Date de naissance")),
        TextField(
            controller: _deathdateController,
            decoration: const InputDecoration(labelText: "Date de décès")),
        TextField(
            controller: _ageController,
            decoration:
                const InputDecoration(labelText: "Âge au moment du décès")),
        TextField(
            controller: _causeController,
            decoration: const InputDecoration(labelText: "Cause du décès")),
        TextField(
            controller: _locationController,
            decoration: const InputDecoration(labelText: "Lieu de décès")),
        const SizedBox(height: 10),
        const Text("2️⃣ Catégorie du défunt",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        InkWell(
          onTap: _showCategoryDialog,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _selectedCategories.entries
                        .where((entry) =>
                            entry.value) // Filtrer ceux qui sont sélectionnés
                        .map((entry) => entry.key)
                        .join(", "), // Convertir en chaîne
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (_selectedCategories["Historique"] == true) ...[
          const Text("📖 Héritage et impact historique",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          TextField(
              decoration: const InputDecoration(
                  labelText: "Portrait et documents d’archives")),
          const Text(
            "Vidéo documentaire sur la vie du défunt",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () async {
              // TODO: Implémenter la sélection de vidéos
              // Simuler une sélection de vidéo (à remplacer par une vraie implémentation)
              String fakeVideoPath =
                  "video_temoignage.mp4"; // Remplacez par File Picker
              setState(() {
                _selectedVideos.add(fakeVideoPath);
              });
            },
            icon: const Icon(Icons.video_camera_back),
            label: const Text("Ajouter une vidéo"),
          ),
          const SizedBox(height: 8),
          if (_selectedVideos.isNotEmpty)
            Column(
                children: _selectedVideos
                    .map((video) => ListTile(
                          leading: const Icon(Icons.video_library),
                          title: Text(video, overflow: TextOverflow.ellipsis),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _selectedVideos.remove(video);
                              });
                            },
                          ),
                        ))
                    .toList()),
        ],
        if (_selectedCategories["Généalogique"] == true) ...[
          SwitchListTile(
            title: const Text("Demander la création d’un Arbre Généalogique"),
            subtitle: const Text("Nous vous contacterons une fois disponible."),
            value: _wantsGenealogyTree,
            onChanged: (bool value) {
              setState(() {
                _wantsGenealogyTree = value;
              });
            },
            secondary: Icon(
              _wantsGenealogyTree ? Icons.check_circle : Icons.info_outline,
              color: _wantsGenealogyTree ? Colors.green : Colors.grey,
            ),
          ),
          const Text(
            "📸🎥 Photos et souvenirs familiaux",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  // TODO: Implémenter la sélection de photos
                  String fakePhotoPath =
                      "photo_souvenir.jpg"; // Remplacez par un vrai file picker
                  setState(() {
                    _selectedMedia.add(fakePhotoPath);
                  });
                },
                icon: const Icon(Icons.image),
                label: const Text("Ajouter une photo"),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () async {
                  // TODO: Implémenter la sélection de vidéos
                  String fakeVideoPath =
                      "video_souvenir.mp4"; // Remplacez par un vrai file picker
                  setState(() {
                    _selectedMedia.add(fakeVideoPath);
                  });
                },
                icon: const Icon(Icons.video_camera_back),
                label: const Text("Ajouter une vidéo"),
              ),
            ],
          ),
          const Text("🏛️ Mémorial interactif ou musée virtuel dédié",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

          Row(
            children: [
              // ✅ Bouton pour créer un nouveau mémorial
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateMemorialScreen(
                        name: _nameController.text,
                        birthdate: _birthdateController.text,
                        deathdate: _deathdateController.text,
                        cause: _causeController.text,
                        location: _locationController.text,
                        category: _selectedCategory,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text("Créer un Mémorial"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
              const SizedBox(width: 10),

              // ✅ Bouton pour choisir un mémorial existant
              ElevatedButton.icon(
                onPressed: () {
                  _showMemorialSelectionDialog();
                },
                icon: const Icon(Icons.search, color: Colors.white),
                label: const Text("Choisir un Mémorial"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ],
          ),

// ✅ Affichage du mémorial sélectionné (si existant)
          if (_selectedMemorial != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "Mémorial sélectionné : $_selectedMemorial",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
        ],
        if (_selectedCategories["Riche & Puissant"] == true) ...[
          const Text("💰 Influence et héritage",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          TextField(
              decoration: const InputDecoration(
                  labelText:
                      "Liste des entreprises et contributions majeures du défunt")),
          TextField(
              decoration: const InputDecoration(
                  labelText:
                      "Lieux influencés par son héritage (fondations, universités, musées)")),
        ],
        if (_selectedCategories["Mort en Masse"] == true) ...[
          const Text("⚰ Hommage collectif",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          TextField(
              decoration: const InputDecoration(
                  labelText: "Liste des victimes commémorées")),
          TextField(
              decoration: const InputDecoration(
                  labelText:
                      "Contexte historique et témoignages de survivants")),
          const Text(
            "Reportage vidéo sur l'événement tragique",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () async {
              // TODO: Implémenter la sélection de vidéos
              // Simuler une sélection de vidéo (à remplacer par une vraie implémentation)
              String fakeVideoPath =
                  "video_temoignage.mp4"; // Remplacez par File Picker
              setState(() {
                _selectedVideos.add(fakeVideoPath);
              });
            },
            icon: const Icon(Icons.video_camera_back),
            label: const Text("Ajouter une vidéo"),
          ),
          const SizedBox(height: 8),
          if (_selectedVideos.isNotEmpty)
            Column(
                children: _selectedVideos
                    .map((video) => ListTile(
                          leading: const Icon(Icons.video_library),
                          title: Text(video, overflow: TextOverflow.ellipsis),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _selectedVideos.remove(video);
                              });
                            },
                          ),
                        ))
                    .toList()),
        ],
        const SizedBox(height: 10),
        const Text("3️⃣ Détails de la cérémonie",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        InkWell(
          onTap: _showCeremonyDialog,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _selectedCeremonyTypes.entries
                        .where((entry) =>
                            entry.value) // Filtrer ceux qui sont sélectionnés
                        .map((entry) => entry.key)
                        .join(", "), // Convertir en chaîne
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        TextField(
            controller: _eventDateController,
            decoration:
                const InputDecoration(labelText: "Date de l'événement")),
        TextField(
            controller: _eventTimeController,
            decoration:
                const InputDecoration(labelText: "Heure de l'événement")),
        TextField(
            controller: _eventTimeController,
            decoration: const InputDecoration(
                labelText: "Lieu de l'événement en présentiel")),
        const SizedBox(height: 10),
        const Text("4️⃣ Personnalisation et Rituels du Deuil",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        TextField(
            controller: _tributeController,
            //maxLines: 3,
            decoration: const InputDecoration(
                labelText:
                    "Thème et ambiance (Sombre, Lumière, Royal, Militaire, Spirituel, etc.)")),
        TextField(
            controller: _tributeController,
            //maxLines: 3,
            decoration: const InputDecoration(
                labelText:
                    "Musique et chants funéraires (Requiem, Gospel, Musique traditionnelle...)")),
        TextField(
            controller: _tributeController,
            //maxLines: 3,
            decoration: const InputDecoration(
                labelText:
                    "Emoji symboliques (Bougies, photos, drapeaux, médailles, fleurs...)")),
        TextField(
            controller: _tributeController,
            //maxLines: 3,
            decoration: const InputDecoration(
                labelText:
                    "Citations (Ex : Un grand homme qui a marqué l'histoire)")),
        const Text(
          "📹 Témoignages vidéo des descendants et proches",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () async {
            // TODO: Implémenter la sélection de vidéos
            // Simuler une sélection de vidéo (à remplacer par une vraie implémentation)
            String fakeVideoPath =
                "video_temoignage.mp4"; // Remplacez par File Picker
            setState(() {
              _selectedVideos.add(fakeVideoPath);
            });
          },
          icon: const Icon(Icons.video_camera_back),
          label: const Text("Ajouter une vidéo"),
        ),
        const SizedBox(height: 8),
        if (_selectedVideos.isNotEmpty)
          Column(
              children: _selectedVideos
                  .map((video) => ListTile(
                        leading: const Icon(Icons.video_library),
                        title: Text(video, overflow: TextOverflow.ellipsis),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _selectedVideos.remove(video);
                            });
                          },
                        ),
                      ))
                  .toList()),
        const SizedBox(height: 10),
        const Text("5️⃣ Participants et Accès",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Text(
          "Prix ou récompenses posthumes (ex : médaille, reconnaissance officielle)",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                // TODO: Implémenter la sélection de photos
                String fakePhotoPath =
                    "photo_souvenir.jpg"; // Remplacez par un vrai file picker
                setState(() {
                  _selectedMedia.add(fakePhotoPath);
                });
              },
              icon: const Icon(Icons.image),
              label: const Text("Ajouter une photo"),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () async {
                // TODO: Implémenter la sélection de vidéos
                String fakeVideoPath =
                    "video_souvenir.mp4"; // Remplacez par un vrai file picker
                setState(() {
                  _selectedMedia.add(fakeVideoPath);
                });
              },
              icon: const Icon(Icons.video_camera_back),
              label: const Text("Ajouter une vidéo"),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text("6️⃣ Participants et Accès",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Text(
            "Livre d’or numérique (chacun peut laisser un message ou une anecdote)",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Column(
          children: [
            RadioListTile<bool>(
              title: const Text("Activé"),
              value: true,
              groupValue: _isGuestbookEnabled,
              onChanged: (bool? value) {
                setState(() {
                  _isGuestbookEnabled = value!;
                });
              },
            ),
            RadioListTile<bool>(
              title: const Text("Désactivé"),
              value: false,
              groupValue: _isGuestbookEnabled,
              onChanged: (bool? value) {
                setState(() {
                  _isGuestbookEnabled = value!;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text("7 Tarification & Accès Premium",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Text("Activer la contribution au deuil ?",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Column(
          children: [
            RadioListTile<bool>(
              title: const Text("Activé"),
              value: true,
              groupValue: _isDonationEnabled,
              onChanged: (bool? value) {
                setState(() {
                  _isDonationEnabled = value!;
                });
              },
            ),
            RadioListTile<bool>(
              title: const Text("Désactivé"),
              value: false,
              groupValue: _isDonationEnabled,
              onChanged: (bool? value) {
                setState(() {
                  _isDonationEnabled = value!;
                });
              },
            ),
          ],
        ),
        if (_isDonationEnabled) // ✅ Afficher le champ de lien de dons uniquement si activé

          const SizedBox(height: 20),
      ],
    );
  }

  /// ✅ **Formulaire pour créer une commémoration**
  Widget _buildCommemorationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("1️⃣ Informations générales sur la personne commémorée",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextField(
            controller: _nameController,
            decoration: const InputDecoration(
                labelText: "Nom de la personne commémorée")),
        TextField(
            controller: _birthdateController,
            decoration: const InputDecoration(labelText: "Date de naissance")),
        TextField(
            controller: _deathdateController,
            decoration: const InputDecoration(labelText: "Date de décès")),
        TextField(
            controller: _ageController,
            decoration:
                const InputDecoration(labelText: "Âge au moment du décès")),
        TextField(
            controller: _causeController,
            decoration: const InputDecoration(labelText: "Cause du décès")),
        TextField(
            controller: _locationController,
            decoration: const InputDecoration(labelText: "Lieu de décès")),
        const SizedBox(height: 10),
        const Text("2️⃣ Fréquence et Date de la Commémoration",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        TextField(
            controller: _eventDateController,
            decoration:
                const InputDecoration(labelText: "Date de commémoration")),
        ListTile(
          title: Text(_selectedRecurrence),
          trailing: const Icon(Icons.arrow_drop_down),
          onTap: () {},
        ),
        const SizedBox(height: 10),
        const Text("3️⃣ Catégorie du défunt",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        InkWell(
          onTap: _showCategoryDialog,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _selectedCategories.entries
                        .where((entry) =>
                            entry.value) // Filtrer ceux qui sont sélectionnés
                        .map((entry) => entry.key)
                        .join(", "), // Convertir en chaîne
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (_selectedCategories["Historique"] == true) ...[
          const Text("📖 Héritage et impact historique",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          TextField(
              decoration: const InputDecoration(
                  labelText: "Portrait et documents d’archives")),
          const Text(
            "Vidéo documentaire sur la vie du défunt",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () async {
              // TODO: Implémenter la sélection de vidéos
              // Simuler une sélection de vidéo (à remplacer par une vraie implémentation)
              String fakeVideoPath =
                  "video_temoignage.mp4"; // Remplacez par File Picker
              setState(() {
                _selectedVideos.add(fakeVideoPath);
              });
            },
            icon: const Icon(Icons.video_camera_back),
            label: const Text("Ajouter une vidéo"),
          ),
          const SizedBox(height: 8),
          if (_selectedVideos.isNotEmpty)
            Column(
                children: _selectedVideos
                    .map((video) => ListTile(
                          leading: const Icon(Icons.video_library),
                          title: Text(video, overflow: TextOverflow.ellipsis),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _selectedVideos.remove(video);
                              });
                            },
                          ),
                        ))
                    .toList()),
        ],
        if (_selectedCategories["Généalogique"] == true) ...[
          SwitchListTile(
            title: const Text("Demander la création d’un Arbre Généalogique"),
            subtitle: const Text("Nous vous contacterons une fois disponible."),
            value: _wantsGenealogyTree,
            onChanged: (bool value) {
              setState(() {
                _wantsGenealogyTree = value;
              });
            },
            secondary: Icon(
              _wantsGenealogyTree ? Icons.check_circle : Icons.info_outline,
              color: _wantsGenealogyTree ? Colors.green : Colors.grey,
            ),
          ),
          const Text(
            "📸🎥 Photos et souvenirs familiaux",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  // TODO: Implémenter la sélection de photos
                  String fakePhotoPath =
                      "photo_souvenir.jpg"; // Remplacez par un vrai file picker
                  setState(() {
                    _selectedMedia.add(fakePhotoPath);
                  });
                },
                icon: const Icon(Icons.image),
                label: const Text("Ajouter une photo"),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () async {
                  // TODO: Implémenter la sélection de vidéos
                  String fakeVideoPath =
                      "video_souvenir.mp4"; // Remplacez par un vrai file picker
                  setState(() {
                    _selectedMedia.add(fakeVideoPath);
                  });
                },
                icon: const Icon(Icons.video_camera_back),
                label: const Text("Ajouter une vidéo"),
              ),
            ],
          ),
          const Text("🏛️ Mémorial interactif ou musée virtuel dédié",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

          Row(
            children: [
              // ✅ Bouton pour créer un nouveau mémorial
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateMemorialScreen(
                        name: _nameController.text,
                        birthdate: _birthdateController.text,
                        deathdate: _deathdateController.text,
                        cause: _causeController.text,
                        location: _locationController.text,
                        category: _selectedCategory,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text("Créer un Mémorial"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
              const SizedBox(width: 10),

              // ✅ Bouton pour choisir un mémorial existant
              ElevatedButton.icon(
                onPressed: () {
                  _showMemorialSelectionDialog();
                },
                icon: const Icon(Icons.search, color: Colors.white),
                label: const Text("Choisir un Mémorial"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ],
          ),

// ✅ Affichage du mémorial sélectionné (si existant)
          if (_selectedMemorial != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "Mémorial sélectionné : $_selectedMemorial",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
        ],
        if (_selectedCategories["Riche & Puissant"] == true) ...[
          const Text("💰 Influence et héritage",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          TextField(
              decoration: const InputDecoration(
                  labelText:
                      "Liste des entreprises et contributions majeures du défunt")),
          TextField(
              decoration: const InputDecoration(
                  labelText:
                      "Lieux influencés par son héritage (fondations, universités, musées)")),
        ],
        if (_selectedCategories["Mort en Masse"] == true) ...[
          const Text("⚰ Hommage collectif",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          TextField(
              decoration: const InputDecoration(
                  labelText: "Liste des victimes commémorées")),
          TextField(
              decoration: const InputDecoration(
                  labelText:
                      "Contexte historique et témoignages de survivants")),
          const Text(
            "Reportage vidéo sur l'événement tragique",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () async {
              // TODO: Implémenter la sélection de vidéos
              // Simuler une sélection de vidéo (à remplacer par une vraie implémentation)
              String fakeVideoPath =
                  "video_temoignage.mp4"; // Remplacez par File Picker
              setState(() {
                _selectedVideos.add(fakeVideoPath);
              });
            },
            icon: const Icon(Icons.video_camera_back),
            label: const Text("Ajouter une vidéo"),
          ),
          const SizedBox(height: 8),
          if (_selectedVideos.isNotEmpty)
            Column(
                children: _selectedVideos
                    .map((video) => ListTile(
                          leading: const Icon(Icons.video_library),
                          title: Text(video, overflow: TextOverflow.ellipsis),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _selectedVideos.remove(video);
                              });
                            },
                          ),
                        ))
                    .toList()),
        ],
        const SizedBox(height: 10),
        const Text("4️⃣ Détails de la cérémonie",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        InkWell(
          onTap: _showCeremonyDialog,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _selectedCeremonyTypes.entries
                        .where((entry) =>
                            entry.value) // Filtrer ceux qui sont sélectionnés
                        .map((entry) => entry.key)
                        .join(", "), // Convertir en chaîne
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        TextField(
            controller: _eventDateController,
            decoration:
                const InputDecoration(labelText: "Date de l'événement")),
        TextField(
            controller: _eventTimeController,
            decoration:
                const InputDecoration(labelText: "Heure de l'événement")),
        TextField(
            controller: _eventTimeController,
            decoration: const InputDecoration(
                labelText: "Lieu de l'événement en présentiel")),
        const SizedBox(height: 10),
        const Text("5️⃣ Lieu et Mode de Commémoration",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        TextField(
            controller: _locationController,
            decoration:
                const InputDecoration(labelText: "Lieu de commémoration")),
        const SizedBox(height: 10),
        const Text("6️⃣ Personnalisation et Activités",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),        
        const Text(
            "Livre d’or numérique (chacun peut laisser un message ou une anecdote)",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Column(
          children: [
            RadioListTile<bool>(
              title: const Text("Activé"),
              value: true,
              groupValue: _isGuestbookEnabled,
              onChanged: (bool? value) {
                setState(() {
                  _isGuestbookEnabled = value!;
                });
              },
            ),
            RadioListTile<bool>(
              title: const Text("Désactivé"),
              value: false,
              groupValue: _isGuestbookEnabled,
              onChanged: (bool? value) {
                setState(() {
                  _isGuestbookEnabled = value!;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text("7 Tarification & Accès Premium",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Text("Activer la contribution au deuil ?",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Column(
          children: [
            RadioListTile<bool>(
              title: const Text("Activé"),
              value: true,
              groupValue: _isDonationEnabled,
              onChanged: (bool? value) {
                setState(() {
                  _isDonationEnabled = value!;
                });
              },
            ),
            RadioListTile<bool>(
              title: const Text("Désactivé"),
              value: false,
              groupValue: _isDonationEnabled,
              onChanged: (bool? value) {
                setState(() {
                  _isDonationEnabled = value!;
                });
              },
            ),
          ],
        ),
        if (_isDonationEnabled) // ✅ Afficher le champ de lien de dons uniquement si activé

          const SizedBox(height: 20),
      ],
    );
  }
}

// ✅ Écran de création de Mémorial (exemple simplifié)
class CreateMemorialScreen extends StatelessWidget {
  final String name;
  final String birthdate;
  final String deathdate;
  final String cause;
  final String location;
  final String category;

  const CreateMemorialScreen({
    super.key,
    required this.name,
    required this.birthdate,
    required this.deathdate,
    required this.cause,
    required this.location,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Créer un Mémorial")),
      body: Center(
        child: Text("Mémorial pour $name (Catégorie : $category)"),
      ),
    );
  }
}
