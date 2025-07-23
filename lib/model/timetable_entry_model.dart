//This iss how Naveen's API returns the timetable data.

class TimetableEntry {
  final String startTime;
  final String endTime;
  final String fullClassDetails; 
 
  // final String courseCode;
  // final String courseName;
  // final String? type;
  // final String? roomNo;


  TimetableEntry({
    required this.startTime,
    required this.endTime,
    required this.fullClassDetails,
    // this.courseCode,
    // this.courseName,
    // this.type,
    // this.roomNo,
  });

  factory TimetableEntry.fromJson(Map<String, dynamic> json) {
    String classStr = json['class'] as String;
    String timeStr = json['time'] as String;

    List<String> timeParts = timeStr.split(' - ');
    String startTime = timeParts[0].trim();
    String endTime = timeParts.length > 1 ? timeParts[1].trim() : '';
    

    // complex parsing can be added if needed later.

    // List<String> classComponents = classStr.split(',').map((s) => s.trim()).toList();
    // String extractedCourseCode = classComponents.isNotEmpty ? classComponents[0] : classStr;
    // String extractedCourseName = classComponents.length > 1 ? classComponents[1] : (classComponents.isNotEmpty ? classComponents[0] : classStr) ;


    return TimetableEntry(
      startTime: startTime,
      endTime: endTime,
      fullClassDetails: classStr,
      // courseCode: extractedCourseCode,
      // courseName: extractedCourseName,
      // type/room cab be added if parsing is consistent. for safe side, avoiding it now.
    );
  }
}
