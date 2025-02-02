import 'package:wtfc_provider_app/export.dart';

//https://github.com/Nabinji/Flutter_UI-Design/tree/main/lib
//https://github.com/Nabinji/Complete-Flutter-App/blob/main/lib/Views/recipe_detail_screen.dart
class MyRecipeAppHomeScreen extends StatefulWidget {
  const MyRecipeAppHomeScreen({super.key});

  @override
  State<MyRecipeAppHomeScreen> createState() => _MyRecipeAppHomeScreenState();
}

class _MyRecipeAppHomeScreenState extends State<MyRecipeAppHomeScreen> {
  String category = 'All';
  //?For categories
  final CollectionReference categoriesItems =
      FirebaseFirestore.instance.collection('recipeCategoryCollection');
  //? For all items display
  Query get filteredRecipesItem =>
      FirebaseFirestore.instance.collection('recipeItemsCollection').where(
            'category',
            isEqualTo: category,
          );
  Query get allRecipes =>
      FirebaseFirestore.instance.collection('recipeItemsCollection');
  Query get selectedRecipes =>
      category == 'All' ? allRecipes : filteredRecipesItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RecipeAppPallete.kbackgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerParts(),
                  mySearchBar(),
                  //?for banner
                  const BannerToExplore(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //?for category
                  selectedCategory(),

                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Quick & Easy",
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 0.1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ViewAllRecipeItems()));
                        },
                        child: const Text(
                          "View all",
                          style: TextStyle(
                            color: RecipeAppPallete.kBannerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            StreamBuilder(
              stream: selectedRecipes.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> recipes =
                      snapshot.data?.docs ?? [];
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 15,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: recipes
                            .map((e) =>
                                RecipeFoodItemDisplay(documentSnapshot: e))
                            .toList(),
                      ),
                    ),
                  );
                }
                //while we are waiting to obtain the categories, show circular progress indicator
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      )),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> selectedCategory() {
    return StreamBuilder(
      stream: categoriesItems.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                streamSnapshot.data!.docs.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      category = streamSnapshot.data!.docs[index]['name'];
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color:
                          category == streamSnapshot.data!.docs[index]['name']
                              ? RecipeAppPallete.kprimaryColor
                              : Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    margin: const EdgeInsets.only(right: 20),
                    child: Text(
                      streamSnapshot.data!.docs[index]['name'],
                      style: TextStyle(
                          color: category ==
                                  streamSnapshot.data!.docs[index]['name']
                              ? Colors.white
                              : Colors.grey.shade600,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        //while we are waiting to obtain the categories, show circular progress indicator
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Padding mySearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          prefixIcon: const Icon(
            Iconsax.search_normal,
          ),
          fillColor: Colors.white,
          border: InputBorder.none,
          hintText: 'Search any recipes',
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Row headerParts() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "What are you \ncooking today?",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
        ),
        MyRecipeIconButton(
          icon: Iconsax.notification,
          pressed: () {},
        ),
      ],
    );
  }
}
