import 'package:wtfc_provider_app/export.dart';

class FBCServices {
  //firebasecollection=>FBC
  User? user = FirebaseAuth.instance.currentUser;

  //save files link to firestore
  Future<void> fsSaveUploadedFilesData(Map<String, String> data) async {
    //we will be saving the link in this location
    //we will create a new collection call 'fsuser-files',
    //the documentID will be the user ID
    //it will then place it in the folder upload with a random document ID

    return FirebaseFirestore.instance
        .collection('fsuser-files')
        .doc(user!.uid)
        .collection('uploads')
        .doc()
        .set(data);
  }

  //read all the uploaded files
  Stream<QuerySnapshot> fsReadUploadedFiles() {
    return FirebaseFirestore.instance
        .collection('fsuser-files')
        .doc(user!.uid)
        .collection('uploads')
        .snapshots();
  }

//https://youtu.be/7P_IC3dviRk?t=4073
//delete a specific document
  Future<bool> deleteFile(String docId, String publicId) async {
//delete the file from cloudinary
    final result = await deleteFromCloudinary(publicId);

    if (result) {
      await FirebaseFirestore.instance
          .collection('fsuser-files')
          .doc(user!.uid)
          .collection('uploads')
          .doc(docId)
          .delete();
      return true;
    }
    return false;
  }
}
//https://youtu.be/7P_IC3dviRk?t=2934
/* Updated the firestore rules to allow to search for user based on the ID
1
rules_version = '2';
2
​
3
service cloud.firestore {
4
  match /databases/{database}/documents {
5
​
6
  // match the 'user-files' collection
7
  match /fsuser-files/{userId} {
8
  // allow access only if the user is authenticated and their UID matches the document ID
9
  allow read, write: if request.auth !=null && request.auth.uid==userId;
10
  
11
  //match any nested collections within the user's document
12
  match /{subCollections=**}{
13
  //apply the same rule for nested collections
14
  allow read, write: if request.auth != null && request.auth.uid==userId;
15
  }
16
    
17
  }
18
}
19
}







*/
