import 'package:flutter/material.dart';
import 'dart:io';
// import 'package:image_picker/image_picker.dart';

/// **CreateMemorialScreen**
/// This screen allows users to create a memorial by entering details 
/// about the deceased, choosing a category, selecting a memorial type, 
/// writing a biography, and adding memories (photos and videos).
class CreateMemorialScreen extends StatefulWidget {
  const CreateMemorialScreen({super.key});

  @override
  State<CreateMemorialScreen> createState() => _CreateMemorialScreenState();
}

class _CreateMemorialScreenState extends State<CreateMemorialScreen> {
  // ✅ Controllers for input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _deathdateController = TextEditingController();
  final TextEditingController _causeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _biographyController = TextEditingController();
  final TextEditingController _quoteController = TextEditingController();
  

  // ✅ Default selections
  String _selectedCategory = "Historical";
  String _selectedMemorialType = "Virtual Memorial";
  

  // ✅ Lists of selectable categories and memorial types
  final List<String> categories = ["Historical", "Genealogical", "Wealthy & Powerful", "Mass Death"];
  final List<String> memorialTypes = ["Virtual Memorial", "Physical Plaque", "Interactive Museum/Memorial"];

  // ✅ List of uploaded memory files
  final List<File> _souvenirFiles = [];

  // Future implementation for image picker
  // final ImagePicker _picker = ImagePicker();

  /// ✅ **Handles memorial submission**
  void _submitMemorial() {
    // TODO: Send the data to a database or API
    print("Memorial created for ${_nameController.text}");
  }

  /// ✅ **Displays category selection modal**
  void _showCategoryDialog() {
    _showSelectionDialog("Select the category of the deceased", categories, (value) {
      setState(() {
        _selectedCategory = value;
      });
    });
  }

  /// ✅ **Displays memorial type selection modal**
  void _showMemorialTypeDialog() {
    _showSelectionDialog("Select the type of memorial", memorialTypes, (value) {
      setState(() {
        _selectedMemorialType = value;
      });
    });
  }

  /// ✅ **Builds section titles**
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  /// ✅ **Builds an uploaded souvenir item**
  Widget _buildSouvenirItem(File file) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Image.file(file, width: 50, height: 50, fit: BoxFit.cover),
        title: const Text("Added Memory"),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            setState(() {
              _souvenirFiles.remove(file);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create a Memorial")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Information about the Deceased"),
            _buildTextField(_nameController, "Name of the deceased"),
            _buildTextField(_birthdateController, "Date of Birth"),
            _buildTextField(_deathdateController, "Date of Death"),
            _buildTextField(_causeController, "Cause of Death"),
            _buildTextField(_locationController, "Place of Death"),

            const SizedBox(height: 10),
            _buildSectionTitle("Category of the Deceased"),
            _buildSelectionTile(_selectedCategory, _showCategoryDialog),

            _buildSectionTitle("Type of Memorial"),
            _buildSelectionTile(_selectedMemorialType, _showMemorialTypeDialog),

            _buildSectionTitle("Short Biography"),
            _buildTextField(_biographyController, "Brief summary of their life", maxLines: 3),

            _buildSectionTitle("Famous Quote of the Deceased"),
            _buildTextField(_quoteController, "E.g., 'Impossible is not French'"),

            const SizedBox(height: 20),

            // ✅ Memory Store (Adding Memories)
            _buildSectionTitle("Add Memories"),
            _buildUploadButton("Add Photo Memory", Icons.add_photo_alternate, () {}),
            _buildUploadButton("Add Video Memory", Icons.video_call_outlined, () {}),

            // ✅ Display added memory files
            Column(children: _souvenirFiles.map((file) => _buildSouvenirItem(file)).toList()),

            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitMemorial,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Create Memorial", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ **Reusable method for text fields**
  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1}) {
    return TextField(controller: controller, maxLines: maxLines, decoration: InputDecoration(labelText: label));
  }

  /// ✅ **Reusable method for selection tiles (category & memorial type)**
  Widget _buildSelectionTile(String selectedValue, VoidCallback onTap) {
    return ListTile(
      title: Text(selectedValue),
      trailing: const Icon(Icons.arrow_drop_down),
      onTap: onTap,
    );
  }

  /// ✅ **Reusable method for uploading buttons**
  Widget _buildUploadButton(String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  /// ✅ **Reusable method for selection dialogs**
  void _showSelectionDialog(String title, List<String> options, Function(String) onSelected) {
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
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(options[index]),
                      onTap: () {
                        onSelected(options[index]);
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
}
