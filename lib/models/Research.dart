class Research {
  static String type = '';
  static String searchBy = '';
  static String value = '';
  static DateTime? startDate;
  static DateTime? endDate;
  //todo: Methods
  // Reset method
  static void reset() {
    Research.type = '';
    Research.searchBy = '';
    Research.value = '';
    Research.startDate = null;
    Research.endDate = null;
    print("Research -> RESET");
  }

  // Find method
  static void find(
    String type,
    String value, {
    String searchBy = '',
    DateTime? startDate,
    DateTime? endDate,
  }) {
    Research.type = type;
    Research.searchBy = searchBy;
    Research.value = value;
    if (startDate != null) Research.startDate = startDate;
    if (endDate != null) Research.endDate = endDate;
    print("Research -> FIND");
  }
}
