import 'package:wtfc_provider_app/export.dart';

class RecipeDetailScreen extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;

  const RecipeDetailScreen({
    super.key,
    required this.documentSnapshot,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  void initState() {
    //!Within firebase this should be just double, no tbsp, ml, etc
    //initalize base ingredient amounts in the provider
    // List<double> baseAmount = widget.documentSnapshot['ingredientsAmount']
    //     .map<double>((amount) => double.parse(
    //           amount.toString(),
    //         ))
    //     .toList();
    // Provider.of<RecipeQuantityProvider>(context, listen: false)
    //     .setBaseIngredientAmounts(baseAmount);
    super.initState();
  }

  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeFavoriteProvider>(context);
    final recipeQuantityProvider = Provider.of<RecipeQuantityProvider>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: startCookingAndFavoriteButton(recipeProvider),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                //for image
                Hero(
                  tag: widget.documentSnapshot['image'],
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.documentSnapshot['image']),
                      ),
                    ),
                  ),
                ),
                //for back button
                Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: Row(
                    children: [
                      MyRecipeIconButton(
                        icon: Icons.arrow_back_ios_new,
                        pressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Spacer(),
                      MyRecipeIconButton(
                        icon: Iconsax.notification,
                        pressed: () {},
                      ),
                    ],
                  ),
                ),
                //create the top circle  left/right area below the main image and above the white area
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.width * .96,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            //for drag handle
            Center(
              child: Container(
                width: 40,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    widget.documentSnapshot['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //TODO: make this a widget because we can use this multiple times
                    children: [
                      const Icon(
                        Iconsax.flash_1,
                        size: 20,
                        color: Colors.grey,
                      ),
                      Text(
                        "${widget.documentSnapshot['cal']} Cal",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                      const Text(
                        '.',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, color: Colors.grey),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Iconsax.clock,
                        size: 20,
                        color: Colors.grey,
                      ),
                      Text(
                        "${widget.documentSnapshot['time']} min",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  //for rating
                  Row(
                    children: [
                      const Icon(
                        Iconsax.star1,
                        color: Colors.amberAccent,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.documentSnapshot['rate'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text('/5'),
                      const SizedBox(width: 5),
                      Text(
                        '${widget.documentSnapshot['reviews'.toString()]} Reviews',
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ingredients',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'How many servings?',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      RecipteQuantityIncDec(
                        currentNumber: recipeQuantityProvider.currentNumber,
                        onAdd: () => recipeQuantityProvider.increaseQuantity(),

                        //TODO: Why do we have to put the ()=> in front of the function?
                        onRemove: () =>
                            recipeQuantityProvider.decreaseQuantity(),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  //List of ingredients
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: widget
                                .documentSnapshot['ingredientsImage']
                                .map<Widget>(
                                  (imageUrl) => Container(
                                    height: 50,
                                    width: 60,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          imageUrl,
                                          scale: .5,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(width: 20),
                          //ingridient name
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.documentSnapshot['ingredientsName']
                                .map<Widget>(
                                  (ingredient) => SizedBox(
                                    height: 60,
                                    child: Center(
                                        child: Text(
                                      ingredient,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade400),
                                    )),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(width: 20),
                          //ingridient amount
//! THe calculation does not work because it is in a string with tbsp, g, ml etc, we will need
//! to make another field for the measurement
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                widget.documentSnapshot['ingredientsAmount']
                                    .map<Widget>(
                                      (ingredient) => SizedBox(
                                        height: 60,
                                        child: Center(
                                            child: Text(
                                          ingredient,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey.shade400),
                                        )),
                                      ),
                                    )
                                    .toList(),
                          ),

                          // Column(
                          //   children:
                          //       recipeQuantityProvider.updateIngredientAmounts
                          //           .map<Widget>(
                          //             (amount) => SizedBox(
                          //               height: 60,
                          //               child: Center(
                          //                 child: Text(
                          //                   " ${amount} gm",
                          //                   style: TextStyle(
                          //                       fontSize: 16,
                          //                       color: Colors.grey.shade400),
                          //                 ),
                          //               ),
                          //             ),
                          //           )
                          //           .toList(),
                          // ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  FloatingActionButton startCookingAndFavoriteButton(
      RecipeFavoriteProvider recipeProvider) {
    return FloatingActionButton.extended(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {},
        label: Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: RecipeAppPallete.kprimaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 10,
                ),
                foregroundColor: Colors.white,
              ),
              onPressed: () {},
              child: const Text(
                'Start Cooking',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              style: IconButton.styleFrom(
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.grey.shade300,
                    width: 2,
                  ),
                ),
              ),
              onPressed: () {
                //! Why do we have to use widget for stateful and non widget for statless?
                recipeProvider.recipeToggleFavorite(widget.documentSnapshot);
              },
              icon: Icon(
                recipeProvider.isExist(widget.documentSnapshot)
                    ? Iconsax.heart5
                    : Iconsax.heart,
                color: recipeProvider.isExist(widget.documentSnapshot)
                    ? Colors.red
                    : Colors.black,
                size: 22,
              ),
            ),
          ],
        ));
  }
}
