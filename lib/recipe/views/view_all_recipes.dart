import 'package:wtfc_provider_app/export.dart';

class ViewAllRecipeItems extends StatefulWidget {
  const ViewAllRecipeItems({super.key});

  @override
  State<ViewAllRecipeItems> createState() => _ViewAllRecipeItemsState();
}

class _ViewAllRecipeItemsState extends State<ViewAllRecipeItems> {
  //?For categories
  final CollectionReference completeApp =
      FirebaseFirestore.instance.collection('recipeItemsCollection');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RecipeAppPallete.kbackgroundColor,
      appBar: AppBar(
        backgroundColor: RecipeAppPallete.kbackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          const SizedBox(
            width: 15,
          ),
          MyRecipeIconButton(
            icon: Icons.arrow_back_ios_new,
            pressed: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          const Text(
            'Quick & Easy',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          MyRecipeIconButton(
            icon: Iconsax.notification,
            pressed: () {},
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 15,
          right: 5,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            StreamBuilder(
              stream: completeApp.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return GridView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.78,
                      ),
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return Column(
                          children: [
                            RecipeFoodItemDisplay(
                                documentSnapshot: documentSnapshot),
                            //TODO: Need to confirm this to widget to be reuse
                            Row(
                              children: [
                                const Icon(
                                  Iconsax.star1,
                                  color: Colors.amberAccent,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  documentSnapshot['rate'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text('/5'),
                                const SizedBox(width: 5),
                                Text(
                                  '${documentSnapshot['reviews'.toString()]} Reviews',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        );
                      });
                }
                //while we are waiting to obtain the categories, show circular progress indicator
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
