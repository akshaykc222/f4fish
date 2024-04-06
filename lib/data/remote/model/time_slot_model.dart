// class TimeSlotResults {
//   TimeSlotResults({
//     required this.results,
//   });
//
//   List<TimeSlotModel> results;
//
//   factory TimeSlotResults.fromJson(Map<String, dynamic> json) =>
//       TimeSlotResults(
//         results: List<TimeSlotModel>.from(
//             json["results"].map((x) => TimeSlotModel.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "results": List<dynamic>.from(results.map((x) => x.toJson())),
//       };
// }

class TimeSlotModel {
  TimeSlotModel(
      {required this.id,
      required this.startTime,
      required this.endTime,
      this.date});

  int id;
  String startTime;
  String endTime;
  DateTime? date;

  factory TimeSlotModel.fromJson(Map<String, dynamic> json, DateTime s) =>
      TimeSlotModel(
          id: json["id"],
          startTime: json["start_time"],
          endTime: json["end_time"],
          date: s);

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_time": startTime,
        "end_time": endTime,
      };
}
