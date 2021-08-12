import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/components/MyText.dart';

class CacheValue extends StatefulWidget {
  final String cardName;
  const CacheValue({
    Key? key,
    required this.cardName,
  }) : super(key: key);

  @override
  CacheValueState createState() => CacheValueState();
}

class CacheValueState extends State<CacheValue> {
  @override
  Widget build(BuildContext context) {
    return (ScreenController.actualView != "LoginView")
        ? FutureBuilder<String>(
            future: getCacheDatas(),
            builder: (cacheContext, cache) {
              // ? When loading is complete
              if (cache.hasData) {
                if (cache.data != null &&
                    cache.data != 'null' &&
                    cache.data.toString() != 'null') {
                  return MyText(
                    text: cache.data.toString(),
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
              }
              // ? In loading case...
              return MyText(
                text: '0',
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w800,
              );
            },
          )
        : Container();
  }

  //todo: Get datas from cache
  Future<String> getCacheDatas() async {
    // ? Get previous datas from the phone cache
    try {
      // load SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Get actual card data from the cache
      int? cacheData = prefs.getInt(widget.cardName);
      print('[Cache] Get Cache Data -> ' + widget.cardName + ' -> $cacheData');
      // Return it
      return cacheData.toString();
    } catch (e) {
      print('[Cache] Get Cache Data Error -> $e');
      return '0';
    }
  }
}
