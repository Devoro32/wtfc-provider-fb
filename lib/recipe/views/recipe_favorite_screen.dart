import 'package:wtfc_provider_app/export.dart';

class RecipeFavoriteScreen extends StatefulWidget {
  const RecipeFavoriteScreen({super.key});

  @override
  State<RecipeFavoriteScreen> createState() => _RecipeFavoriteScreenState();
}

class _RecipeFavoriteScreenState extends State<RecipeFavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeFavoriteProvider>(context);

    //final recipeProvier= RecipeFavoriteProvider.of(context);
    final recipeFavoriteItems = recipeProvider.favorites;

    return Scaffold(
      backgroundColor: RecipeAppPallete.kbackgroundColor,
      appBar: AppBar(
        backgroundColor: RecipeAppPallete.kbackgroundColor,
        centerTitle: true,
        title: const Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: recipeFavoriteItems.isEmpty
          ? const Center(
              child: Text(
                'No favorites yet',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: recipeFavoriteItems.length,
              itemBuilder: (context, index) {
                String recipefavorite = recipeFavoriteItems[index];
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('recipeItemsCollection')
                      .doc(recipefavorite)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(
                        child: Text('Error loading favorites'),
                      );
                    }
                    var recipefavoriteItem = snapshot.data!;
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      //increase the image so it fits the height of the entire container
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          recipefavoriteItem['image']),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      recipefavoriteItem['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Icon(
                                          Iconsax.flash_1,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          "${recipefavoriteItem['cal']} Cal",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.grey),
                                        ),
                                        const Text(
                                          '.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.grey),
                                        ),
                                        const SizedBox(width: 5),
                                        const Icon(
                                          Iconsax.clock,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          "${recipefavoriteItem['time']} min",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        //delete button
                        Positioned(
                            top: 50,
                            right: 35,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  recipeProvider
                                      .recipeToggleFavorite(recipefavoriteItem);
                                });
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ))
                      ],
                    );
                  },
                );
              },
            ),
    );
  }
}
