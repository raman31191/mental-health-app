import 'package:appwrite/appwrite.dart';

class AppwriteService {
  final Client client = Client();
  final Storage storage;
  final Account account;

  AppwriteService()
      : storage = Storage(Client()
          ..setEndpoint(
              'https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
          ..setProject('67b199c1000934958d6a')), // Your Project ID
        account = Account(Client()
          ..setEndpoint('https://cloud.appwrite.io/v1')
          ..setProject('67b199c1000934958d6a'));

  Future<String?> uploadProfilePicture(String userId, String filePath) async {
    try {
      final result = await storage.createFile(
        bucketId: '67dad5ab0028c02c75b2', // Replace with your bucket ID
        fileId: ID.unique(),
        file: InputFile.fromPath(path: filePath),
      );

      return result.$id; // Return uploaded file ID
    } catch (e) {
      print("Upload Error: $e");
      return null;
    }
  }

  Future<String?> getProfilePictureUrl(String fileId) async {
    return 'https://cloud.appwrite.io/v1/storage/buckets/YOUR_BUCKET_ID/files/$fileId/view?project=YOUR_PROJECT_ID';
  }
}
