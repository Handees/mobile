import 'package:handees/shared/data/handees/job_category.dart';
import 'package:handees/shared/data/user/models/api_user.model.dart';

class Offer {
  final double lat;
  final double lon;
  final JobCategory? jobCategory;
  final String bookingId;
  final ApiUserModel user;

  Offer(
      {required this.lat,
      required this.lon,
      required this.bookingId,
      required this.jobCategory,
      required this.user});

  Offer.fromJson(Map<String, dynamic> json)
      : lat = json["lat"],
        lon = json["lon"],
        jobCategory = JobCategory.values
            .firstWhere((category) => category.id == json["job_category"]),
        bookingId = json["booking_id"],
        user = ApiUserModel.fromJson(json["user"]);

  Offer.empty()
      : lat = 0,
        lon = 0,
        jobCategory = JobCategory.automobile,
        bookingId = '',
        user = ApiUserModel.empty();
}
