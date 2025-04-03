import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

class UserService {
  final Client client = Client();
  final Account account;

  UserService()
      : account = Account(Client()
          ..setEndpoint(
              'https://cloud.appwrite.io/v1') // Replace with your Appwrite endpoint
          ..setProject(
              '67b199c1000934958d6a')); // Replace with your Appwrite Project ID

  Future<String?> getCurrentUserName() async {
    try {
      models.User user =
          await account.get(); // Fetch the currently logged-in user
      return user.name; // Return the logged-in user's name
    } catch (e) {
      print('Error fetching current user: $e');
      return null;
    }
  }
}
