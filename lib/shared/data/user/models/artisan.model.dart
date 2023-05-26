import 'package:flutter/foundation.dart';
import 'package:handees/shared/data/handees/job_category.dart';

class ArtisanModel {
  final String artisanId;
  // final DateTime artisanCreatedAt;
  final double hourlyRate;
  final bool isVerified;
  final JobCategory? jobCategory;
  final String jobTitle;
  final int jobsCompleted;
  // TODO: Add ratings back
  //final List<double> ratings;
  final DateTime artisanSignupDate;

  ArtisanModel(
      {required this.artisanId,
      // required this.artisanCreatedAt,
      required this.hourlyRate,
      required this.isVerified,
      required this.jobCategory,
      required this.jobTitle,
      required this.jobsCompleted,
      // required this.ratings,
      required this.artisanSignupDate});

  ArtisanModel.fromJson(Map<String, dynamic> json)
      : artisanId = json["artisan_id"],
        //artisanCreatedAt = DateTime.parse(json["created_at"]),
        hourlyRate = json["hourly_rate"],
        isVerified = json["is_verified"],
        //jobCategory = jobCategoriesMap[json["job_category_id"]],
        jobCategory = jobCategories
            .firstWhere((category) => category.id == json["job_category"]),
        jobTitle = json["job_title"] ?? "",
        jobsCompleted = json["jobs_completed"],
        //  ratings = List<double>.from(json["ratings"] as List),
        artisanSignupDate = DateTime.parse(json["sign_up_date"]);
}
