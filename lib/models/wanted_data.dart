import 'model.dart';

class WantedData {
  final List<UserModel> userData;
  final List<EventModel> eventData;
  final List<LiveModel> liveData;
  final List<MemorialModel> memorialData;
  final List<Activity> activities;
  WantedData(this.userData, 
  this.eventData,
  this.liveData,
  this.memorialData, 
  this.activities
  );
}
