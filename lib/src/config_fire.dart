import 'package:firebase_core/firebase_core.dart';

final _googleAppID = '1:146671141891:android:48c2291e910f83f6edba36';
final _gcmSenderID = '146671141891';
final _apiKey = 'AIzaSyAp1v5jJnikwdXwqGEGZ7yFxBC52-a4JtA';

final String name = 'foo';
final FirebaseOptions options = FirebaseOptions(
      googleAppID: _googleAppID, gcmSenderID: _gcmSenderID, apiKey: _apiKey);
      
class ConfigFire {
  


  
  Future<FirebaseApp> configure() async {
    final FirebaseApp app = await FirebaseApp.configure(
      name: name,
      options: options,
    );
    
    return app;
  }

  Future<void> allApps() async {
    final List<FirebaseApp> apps = await FirebaseApp.allApps();
    print('Currently configured apps: $apps');
  }

  Future<void> opts() async {
    final FirebaseApp app = await FirebaseApp.appNamed(name);
    final FirebaseOptions options = await app?.options;
    print('Current options for app $name: $options');
  }
}
