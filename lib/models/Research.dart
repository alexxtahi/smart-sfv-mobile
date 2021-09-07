class Research {
  static String type = '';
  static String searchBy = '';
  static String value = '';
  //todo: Methods
  // Reset method
  static void reset() {
    Research.type = '';
    Research.searchBy = '';
    Research.value = '';
    print("Research -> RESET");
  }

  // Find method
  static void find(String type, String value, {String searchBy = ''}) {
    Research.type = type;
    Research.searchBy = searchBy;
    Research.value = value;
    print("Research -> FIND");
  }
}
