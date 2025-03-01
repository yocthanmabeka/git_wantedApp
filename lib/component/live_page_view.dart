import 'package:flutter/material.dart';
import 'package:wanted/component/component.dart';
import 'package:wanted/models/model.dart';

/// **LivePageView**
/// This widget displays a **PageView** where users can **scroll vertically** through different live events.
class LivePageView extends StatelessWidget {
  final VoidCallback closePage; // Function to close the live page
  final List<EventModel> event; // List of events associated with live sessions
  final List<UserModel> creator; // List of users who created the live sessions
  final List<LiveModel> live; // List of live sessions

  /// **Constructor**
  /// Requires lists of `EventModel`, `UserModel`, and `LiveModel`.
  LivePageView({
    super.key,
    required this.closePage,
    required this.event,
    required this.creator,
    required this.live,
  });

  // **Controller for vertical scrolling between live sessions**
  final PageController _liveController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _liveController, // ✅ Enables vertical scrolling
      scrollDirection: Axis.vertical, // ✅ Scrolls through lives vertically
      itemCount: live.length, // ✅ Total number of live sessions
      itemBuilder: (context, pages) {
        final lives = live[pages]; // ✅ Gets the current live session

        // ✅ Find the associated event (or return a default event if not found)
        final eventHemo = event.firstWhere(
          (e) => e.id == lives.eventId,
          orElse: () => EventModel.defaultEvent(),
        );

        // ✅ Find the host/creator of the live session (or return a default user if not found)
        final creatorHemo = creator.firstWhere(
          (user) => user.id == lives.hostId,
          orElse: () => UserModel.defaultUser(),
        );

        // ✅ Display the `EventLive` widget for the current live session
        return EventLive(
          closePage: closePage,
          event: eventHemo,
          creator: creatorHemo,
          liveData: lives,
        );
      },
    );
  }
}
