import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanted/component/component.dart';
import 'package:wanted/models/model.dart';

/// **MemorialScreen**
/// Affiche les mémoriaux en utilisant un `Consumer`
class MemorialScreen extends StatelessWidget {
  const MemorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MemorialProvider>(
      builder: (context, memorialProvider, child) {
        if (memorialProvider.memorials.isEmpty) {
          return const Center(child: Text("📭 Aucun mémorial trouvé."));
        }

        // ✅ Affiche les mémoriaux sous forme de grille
        return MemorialStaggeredGrid(memorial: memorialProvider.memorials);
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:wanted/api/mock_wanted_service.dart';
// import 'package:wanted/component/component.dart';
// import 'package:wanted/models/model.dart';

// /// **MemorialScreen**
// /// This screen fetches and displays a list of memorials using a staggered grid layout.
// class MemorialScreen extends StatelessWidget {
//   MemorialScreen({super.key});

//   // Instance of the mock service to fetch memorial data
//   final mockWantedService = MockWantedService();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<WantedData>(
//       // Fetches data asynchronously
//       future: mockWantedService.getWantedData(),
//       builder: (context, snapshot) {
//         // ✅ Show a loading indicator while fetching data
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         // ✅ Show an error message or a placeholder if no data is available
//         if (snapshot.hasError || !snapshot.hasData || snapshot.data!.memorialData.isEmpty) {
//           return const Center(child: Text("No memorials found."));
//         }

//         // ✅ Display the list of memorials in a staggered grid format
//         return MemorialStaggeredGrid(memorial: snapshot.data!.memorialData);
//       },
//     );
//   }
// }
