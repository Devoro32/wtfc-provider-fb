import 'package:wtfc_provider_app/export.dart';

//?https://youtu.be/EMFri1sc7N4?t=526
class RecipeUploadDataInfirebase extends StatelessWidget {
  const RecipeUploadDataInfirebase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //saveRecipeCategoryToFirebase();
            saveRecipeItemsToFirebase();
          },
          child: const Text('Upload Data'),
        ),
      ),
    );
  }
}
