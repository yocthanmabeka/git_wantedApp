import 'package:flutter/material.dart';
import 'package:wanted/component/component.dart';
import 'package:wanted/models/model.dart';

class EventListView extends StatelessWidget {
  final List<EventModel> event;
  final List<UserModel> creator;

  const EventListView({super.key, required this.event, required this.creator});

  @override
  Widget build(BuildContext context) {
    if (event.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "📭 Aucun événement disponible.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(), // ✅ Défilement fluide
        scrollDirection: Axis.vertical,
        itemCount: event.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10), // ✅ Espacement entre éléments
        itemBuilder: (context, index) {
          final currentEvent = event[index];
          final creatorData = creator.firstWhere(
            (user) => user.id == currentEvent.creatorId,
            orElse: () => UserModel.defaultUser(),
          );

          return EventCard(event: currentEvent, creator: creatorData);
        },
      ),
    );
  }
}
