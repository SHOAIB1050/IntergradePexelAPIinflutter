import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class SetWalpaper extends StatefulWidget {
  const SetWalpaper({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  State<SetWalpaper> createState() => _SetWalpaperState();
}

class _SetWalpaperState extends State<SetWalpaper> {
  @override
  Future<void> setbackground()async{
    int location  = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    final String result =
    (await WallpaperManager.setWallpaperFromFile(
        file.path, location)) as String;
  
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        body: Column(
          children: [
            Expanded(child: Container(
              child: Image.network(widget.imageUrl),
            )),
            InkWell(
              onTap:() {
                setbackground();
              },
              child: Container(
                color: Colors.pink,
                height: 60,
                width: double.infinity,
                child: const Center(
                  child: Text(
                    "Set Wallpaper",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}