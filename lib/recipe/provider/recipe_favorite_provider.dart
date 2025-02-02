import 'package:wtfc_provider_app/export.dart';

class RecipeFavoriteProvider extends ChangeNotifier {
  List<String> _favoriteIds = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> get favorites => _favoriteIds;

  RecipeFavoriteProvider() {
    loadRecipeFavorite();
  }

  //toggle favorites states
  void recipeToggleFavorite(DocumentSnapshot product) async {
    String productId = product.id;
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
      await _removeRecipeFavorite(productId);
    } else {
      _favoriteIds.add(productId);
      await _addRecipeFavorite(productId);
    }
    notifyListeners();
  }

  //check if a product is a favorited
  bool isExist(DocumentSnapshot product) {
    return _favoriteIds.contains(product.id);
  }

  //add favorite to firestore

  Future<void> _addRecipeFavorite(String productId) async {
    try {
      await _firestore.collection('recipeUserFavorite').doc(productId).set({
        'isFavorite': true,
        //create the userFavorite collection and add item as favorites in firestores
      });
    } catch (e) {
      print(e);
    }
  }

  //remove from favorite
  Future<void> _removeRecipeFavorite(String productId) async {
    try {
      await _firestore.collection('recipeUserFavorite').doc(productId).delete();
    } catch (e) {
      print(e);
    }
  }

  //load favories from firestore (store favorite or not)
  Future<void> loadRecipeFavorite() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection('recipeUserFavorite').get();
      _favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  //Static method ot access the provider from any context
  static RecipeFavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<RecipeFavoriteProvider>(
      context,
      listen: listen,
    );
  }
}
