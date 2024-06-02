import 'package:api/setwalpaper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WallPapers extends StatefulWidget {
  const WallPapers({super.key});

  @override
  State<WallPapers> createState() => _WallPapersState();
}

class _WallPapersState extends State<WallPapers> {
  List images = [];
  int pages = 1;
  @override
  fetchapi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
              'CUCc43amXIuomwyfFkaYdAgiBnFYsHbLAJegJ3XVzDxPUDpk5Jast3nG'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
    });
  }
  load_images()async{
    pages+=1;
    
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?page=$pages&per_page=80'),
        headers: {
          'Authorization':
          'CUCc43amXIuomwyfFkaYdAgiBnFYsHbLAJegJ3XVzDxPUDpk5Jast3nG'
        }).then((value){
       Map result = jsonDecode(value.body);
       setState(() {
         images.addAll(result['photos']);
       });
       
    });
  }

  void initState() {
    setState(() {
      fetchapi();
    });
  }


  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(brightness: Brightness.dark),
        home: Scaffold(
          body: Column(
            children: [
              Expanded(
                  child: Container(
                child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      childAspectRatio: 2 / 3),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>SetWalpaper(
                              imageUrl:images[index]['src']['large2x']
                            ),));
                      },
                      child: Container(
                        color: Colors.white,
                        child: Image.network(images[index]['src']['tiny'],
                        fit: BoxFit.cover,),
                      ),
                    );
                  },
                ),
              )),
              InkWell(
                onTap:() {
                  load_images();
                },
                child: Container(
                  color: Colors.pink,
                  height: 60,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Loading More",
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
        ));
  }
}