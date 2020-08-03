class APIClient {
  static final String baseUrl = "https://amonmr.herokuapp.com/";
  static final APIClient _instance = APIClient._getInstance();

  factory APIClient() {
    return _instance;
  }

  APIClient._getInstance();
}
