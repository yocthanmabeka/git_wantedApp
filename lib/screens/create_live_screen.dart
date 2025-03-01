import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';

/// **CreateLiveScreen**
/// This screen allows users to start a live streaming event. 
/// It includes tools for video, audio, casting, interactions, 
/// and a chat feature.
class CreateLiveScreen extends StatefulWidget {
  const CreateLiveScreen({super.key});

  @override
  State<CreateLiveScreen> createState() => _CreateLiveScreenState();
}

class _CreateLiveScreenState extends State<CreateLiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // ✅ Set background to black for live mode
      body: Stack(
        children: [
          _buildLiveHeader(),  // ✅ Header with event type and profile
          _buildLiveTools(),   // ✅ Live stream control tools (video, mic, camera, etc.)
          _buildLiveBottom(),  // ✅ Interaction bar (chat, donation, exit)
        ],
      ),
    );
  }

  /// ✅ **Live Header (Top Bar)**
  /// Displays the event type and profile options.
  Widget _buildLiveHeader() {
    return Positioned(
      top: 10,
      left: 5,
      right: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // **Live Event Type**
          Row(
            children: [
              TextButton(onPressed: () {}, child: const Text('Event type')),
              const SizedBox(width: 10),
            ],
          ),

          // **Top Right Icons (Profile, Search, etc.)**
          Row(
            children: [
              IconButton(
                onPressed: () {}, // TODO: Open user profile
                icon: const Icon(Icons.person_rounded, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ✅ **Live Stream Controls (Right Side)**
  /// Includes buttons for video, mic, casting, camera rotation, effects, and posts.
  Widget _buildLiveTools() {
    return Positioned(
      top: 50,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {}, // TODO: Start/stop video
            icon: const FaIcon(FontAwesomeIcons.video, color: Colors.white),
          ),
          IconButton(
            onPressed: () {}, // TODO: Toggle microphone
            icon: const Icon(Icons.mic_rounded, color: Colors.white),
          ),
          IconButton(
            onPressed: () {}, // TODO: Cast live stream
            icon: const Icon(Icons.cast_rounded, color: Colors.white),
          ),
          IconButton(
            onPressed: () {}, // TODO: Rotate camera
            icon: const FaIcon(FontAwesomeIcons.cameraRotate, color: Colors.white),
          ),
          IconButton(
            onPressed: () {}, // TODO: Apply effects or lightning
            icon: const FaIcon(FontAwesomeIcons.bolt, color: Colors.white),
          ),
          IconButton(
            onPressed: () {}, // TODO: Create a post during live
            icon: const Icon(Icons.post_add_rounded, color: Colors.white),
          ),
          IconButton(
            onPressed: () {}, // TODO: User reactions (like, support, etc.)
            icon: const FaIcon(FontAwesomeIcons.handFist, color: Colors.white),
          ),
        ],
      ),
    );
  }

  /// ✅ **Live Interaction Bar (Bottom)**
  /// Includes chat input, donation, and exit options.
  Widget _buildLiveBottom() {
    return Positioned(
      bottom: 10,
      left: 5,
      right: 5,
      child: Row(
        children: [
          // **Chat Input Field**
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black54, // Semi-transparent background
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Write a message...",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blueAccent),
                    onPressed: () {}, // TODO: Send message in live chat
                  ),
                ],
              ),
            ),
          ),

          // **Live Interaction Icons**
          IconButton(
            onPressed: () {}, // TODO: Open group interaction panel
            icon: const Icon(Icons.groups_rounded, color: Colors.white),
          ),
          IconButton(
            onPressed: () {}, // TODO: Open donation feature
            icon: const Icon(Icons.attach_money_rounded, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context); // ✅ Close live screen
            },
            icon: const Icon(Icons.cancel_outlined, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
