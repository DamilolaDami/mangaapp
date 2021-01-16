import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manga/animeuicolors.dart';
import 'package:manga/models/anime.dart';
import 'package:manga/models/navbar.dart';
import 'package:manga/models/recents.dart';
import 'package:manga/silverheader.dart';
import 'package:dio/dio.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      const Body(),
      NavBar(),
    ])));
  }
}

class NavBar extends StatelessWidget {
  NavBar({Key key}) : super(key: key);

  final _index = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: kBottomNavigationBarHeight * 1.4,
          decoration: BoxDecoration(
              color: AnimeUiForYoutubeColors.background,
              boxShadow: [
                BoxShadow(
                  color: AnimeUiForYoutubeColors.cyan.withOpacity(.47),
                  spreadRadius: 7.7,
                  blurRadius: 15,
                )
              ]),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: List.generate(
              ItemNavBar.length,
              (index) => Expanded(
                  child: ValueListenableBuilder<int>(
                      valueListenable: _index,
                      builder: (_, value, __) {
                        return GestureDetector(
                            onTap: () => _index.value = value,
                            child: Material(
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      ItemNavBar[index].path,
                                      width: 20,
                                      color: (index == value)
                                          ? AnimeUiForYoutubeColors.cyan
                                          : Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      ItemNavBar[index].name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .button
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                    )
                                  ],
                                )));
                      })),
            ),
          ),
        ));
  }
}

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      const Header(),
      const Trends(),
      const Recents(),
      const Aviable(),
      SliverToBoxAdapter(
        child: SizedBox(
          height: kBottomNavigationBarHeight * 1.4,
        ),
      )
    ]);
  }
}

class Aviable extends StatelessWidget {
  const Aviable({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                'Aviable: Black Clover ',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Image.asset(
                    'assets/imagess/mangapics/manga3.jpg',
                    fit: BoxFit.cover,
                  )),
                  Align(
                    child: SvgPicture.asset(
                      'assets/svgs/star.svg',
                      width: 79,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Trends extends StatelessWidget {
  const Trends({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: AspectRatio(
          aspectRatio: 16 / 12,
          child: Column(
            children: [
              const HeaderTrends(),
              const ListTrends(),
            ],
          ),
        ),
      ),
    );
  }
}

class Recents extends StatelessWidget {
  const Recents({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: AspectRatio(
          aspectRatio: 16 / 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Recently Added',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Expanded(child: LayoutBuilder(builder: (_, constraints) {
                return ListView.builder(
                    itemCount: recentsData.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: SizedBox(
                          height: constraints.maxHeight,
                          width: constraints.maxWidth * .25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(recentsData[index].poster,
                                fit: BoxFit.cover),
                          ),
                        ),
                      );
                    });
              }))
            ],
          ),
        ),
      ),
    );
  }
}

class ListTrends extends StatelessWidget {
  const ListTrends({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(builder: (_, BoxConstraints constraints) {
        return ListView.builder(
          itemCount: trendsData.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(
            top: 10,
            left: 20,
          ),
          itemBuilder: (_, int index) {
            final anime = trendsData[index];
            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                height: constraints.maxHeight,
                width: constraints.maxWidth * .375,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          anime.poster,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      anime.name,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 7.8,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/add.svg',
                            color: Colors.white,
                            height: 12,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            ' score: ${anime.score}',
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(
                            width: 7.5,
                          ),
                          Text(
                            ' # ${anime.number}',
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: AnimeUiForYoutubeColors.cyan,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class HeaderTrends extends StatelessWidget {
  const HeaderTrends({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Trends For You',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Text(
            'View All',
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: AnimeUiForYoutubeColors.cyan,
                  fontWeight: FontWeight.w700,
                ),
          )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        floating: true,
        delegate: SliverCustomHeaderDelegate(
            minHeight: 60,
            maxHeight: 60,
            child: Container(
              color: AnimeUiForYoutubeColors.background,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Mangaven',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: AnimeUiForYoutubeColors.cyan,
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                      )),
                      SvgPicture.asset(
                        'assets/svgs/search.svg',
                        width: 27,
                        color: Colors.white,
                      )
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text('What are we reading today?',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.white,
                          ))
                ],
              ),
            )));
  }
}
