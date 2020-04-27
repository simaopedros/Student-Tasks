import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = '';


class TesteApp extends StatefulWidget {
  


  @override
  _TesteAppState createState() => _TesteAppState();
}

class _TesteAppState extends State<TesteApp> {
  static final MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>['Escola', 'Faculdade', 'Cursos', 'Enem'],
    childDirected: true,
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd(){
    return new BannerAd(
      adUnitId: BannerAd.testAdUnitId, 
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event){
        print("Banner Event: $event");
      }
    );
  }


  InterstitialAd crearintertAd(){
    return new InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,       
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event){
        print("Interstitial Event: $event");
      }
    );
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _bannerAd = createBannerAd()
    ..load()
    ..show();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("data") ,),
    );
  }
}