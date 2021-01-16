class NavBar {
  final String path;
  final String name;

  const NavBar({
    this.name,
    this.path,
  });
}

const ItemNavBar = const [
  NavBar(
    name: "Home",
    path: 'assets/svgs/home.svg',
  ),
  NavBar(
    name: "Favorite",
    path: 'assets/svgs/star.svg',
  ),
  NavBar(
    name: "Profile",
    path: 'assets/svgs/profile.svg',
  ),
  NavBar(
    name: "Search",
    path: 'assets/svgs/search.svg',
  )
];
