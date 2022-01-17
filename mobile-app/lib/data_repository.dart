import 'package:amplify_flutter/amplify.dart';
import 'package:mobile_app/models/ModelProvider.dart';

class DataRepository {
  Future<User?> getUserById(String userId) async {
    try {
      final users = await Amplify.DataStore.query(
        User.classType,
        where: User.ID.eq(userId),
      );
      return users.isNotEmpty ? users.first : null;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> createUser({
    String? userId,
    required String firstName,
    required String lastName,
    String? bio,
  }) async {

    // todo: placeholder -> how is this handled?
    List<Permission> permissions = [Permission(allowedEntities: const [""], permissionType: PermissionType.ADMIN)];
    
    final newUser = User(id: userId, 
      firstName: firstName, 
      lastName: lastName, 
      permissions: permissions,
      bio: bio,
    );
    try {
      await Amplify.DataStore.save(newUser);
      return newUser;
    } catch (e) {
      rethrow;
    }
  }
}