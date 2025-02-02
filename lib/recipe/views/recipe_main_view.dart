import 'package:wtfc_provider_app/export.dart';

class RecipeAppMainView extends StatefulWidget {
  const RecipeAppMainView({super.key});

  @override
  State<RecipeAppMainView> createState() => _RecipeAppMainViewState();
}

class _RecipeAppMainViewState extends State<RecipeAppMainView> {
  int selectedIndex = 0;
  late final List<Widget> page;
  @override
  void initState() {
    page = [
      const MyRecipeAppHomeScreen(),
      const RecipeFavoriteScreen(),
      navBarPage(Iconsax.calendar5),
      navBarPage(Iconsax.setting_21),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconSize: 28,
          currentIndex: selectedIndex,
          selectedItemColor: RecipeAppPallete.kprimaryColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
              color: RecipeAppPallete.kprimaryColor,
              fontWeight: FontWeight.w600),
          unselectedLabelStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          onTap: (value) {
            setState(() {
              selectedIndex = value;
              print('SelectedIndex is: ${selectedIndex}');
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                selectedIndex == 0 ? Iconsax.home5 : Iconsax.home_1,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(selectedIndex == 1 ? Iconsax.heart5 : Iconsax.heart),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 2 ? Iconsax.calendar5 : Iconsax.calendar),
              label: 'Meal Plan',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 3 ? Iconsax.setting_21 : Iconsax.setting_2),
              label: 'Settings',
            ),
          ]),
      body: page[selectedIndex],
    );
  }

  navBarPage(iconName) {
    return Center(
      child: Icon(
        iconName,
        size: 100,
        color: RecipeAppPallete.kprimaryColor,
      ),
    );
  }
}
