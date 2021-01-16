import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manga/homepage.dart';
import 'package:manga/models/anime.dart';

class Detailspage extends StatefulWidget {
  @override
  _DetailspageState createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(children: [
      Column(children: [
        SizedBox(
          height: 290,
          child: Stack(
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            AssetImage('assets/imagess/mangapics/manga2.jpg'))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => HomePage()));
                              }),
                          IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                              onPressed: () {})
                        ],
                      ),
                    ]),
              ),
              Positioned(
                top: 100,
                left: 10,
                child: Container(
                  height: 190,
                  width: 120,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(.47),
                        spreadRadius: 7.7,
                        blurRadius: 15,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            AssetImage('assets/imagess/mangapics/manga1.jpg')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    ])));
  }
}
