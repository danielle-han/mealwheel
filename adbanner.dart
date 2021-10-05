import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

BannerAd myBanner = BannerAd(
  adUnitId: Platform.isAndroid
      ? 'ca-app-pub-###########################' //removed personal adUnitIds for code displayed on GitHub.
      : 'ca-app-pub-###########################',
  size: AdSize.getSmartBanner(Orientation.portrait),
  request: AdRequest(),
  listener: AdListener(),
);
