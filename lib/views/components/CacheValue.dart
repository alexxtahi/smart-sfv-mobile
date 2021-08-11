import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    return FutureBuilder(
      future: getCacheDatas(),
      builder: (cacheContext, cache) {
        if (cache.hasData) {
          return MyText(
            text: cache.data.toString(),
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.w800,
          );
        }
        // ? In loading case...
        return MyText(
          text: '0',
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.w800,
        );
      },
    );
  }

  //todo: Get datas from cache
  Future<String> getCacheDatas() async {
    // ? Get previous datas from the phone cache
    try {
      // load SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Get actual card data from the cache
      String cacheData = prefs.getInt(widget.cardName).toString();
      print('Get Cache Data -> ' + widget.cardName + ' -> $cacheData');
      // Return it
      return cacheData;
    } catch (e) {
      print('Get Cache Data Error -> $e');

      return '000';
    }
  }
}
