import 'package:wtfc_provider_app/export.dart';
import 'package:wtfc_provider_app/recipe/views/recipe_detail_screen.dart';

class RecipeFoodItemDisplay extends StatelessWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const RecipeFoodItemDisplay({super.key, required this.documentSnapshot});
//Card for the food items

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeFavoriteProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RecipeDetailScreen(documentSnapshot: documentSnapshot),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 230,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: NetworkImage(documentSnapshot['image']),
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        //image from firestore
                        image: NetworkImage(documentSnapshot['image']),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  documentSnapshot['name'],
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Icon(
                      Iconsax.flash_1,
                      size: 16,
                      color: Colors.grey,
                    ),
                    Text(
                      "${documentSnapshot['cal']} Cal",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
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
                      size: 16,
                      color: Colors.grey,
                    ),
                    Text(
                      "${documentSnapshot['time']} min",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            //? for favorite button,
            Positioned(
              top: 5,
              right: 5,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: InkWell(
                  onTap: () {
                    recipeProvider.recipeToggleFavorite(documentSnapshot);
                  },
                  child: Icon(
                    recipeProvider.isExist(documentSnapshot)
                        ? Iconsax.heart5
                        : Iconsax.heart,
                    color: recipeProvider.isExist(documentSnapshot)
                        ? Colors.red
                        : Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
            //favorite screen
          ],
        ),
      ),
    );
  }
}
