import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'admob/ad_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  // TODO: Add _bannerAd
  late BannerAd _bannerAd;

  // TODO: Add _isBannerAdReady
  bool _isBannerAdReady = false;
  @override
  void initState() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
    super.initState();
  }

  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("deneme"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  if (index != 0 && index % 5 == 0) {
                    _bannerAd = BannerAd(
                      adUnitId: AdHelper.bannerAdUnitId,
                      request: AdRequest(),
                      size: AdSize.banner,
                      listener: BannerAdListener(
                        onAdLoaded: (_) {
                          setState(() {
                            _isBannerAdReady = true;
                          });
                        },
                        onAdFailedToLoad: (ad, err) {
                          print('Failed to load a banner ad: ${err.message}');
                          _isBannerAdReady = false;
                          ad.dispose();
                        },
                      ),
                    );
                    _bannerAd.load();
                    return Column(
                      children: <Widget>[
                        Container(
                          child: StatefulBuilder(
                            builder: (context, setState) => Container(
                              child: AdWidget(ad: _bannerAd),
                              width: _bannerAd.size.width.toDouble(),
                              height: 100.0,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text("index " + index.toString()),
                        ),
                      ],
                    );
                  }
                  return ListTile(
                    title: Text("index " + index.toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
