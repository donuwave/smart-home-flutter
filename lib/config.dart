class AppConfig {
  static late String apiUrl;

  static Future<void> setup() async {
    const env = String.fromEnvironment('ENV', defaultValue: 'dev');

    if (env == 'prod') {
      apiUrl = 'https://prod-api.example.com';
    } else {
      apiUrl = 'http://localhost:8003';
    }
  }
}
