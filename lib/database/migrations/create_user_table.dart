import 'package:vania/vania.dart';

class CreateUserTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTable('users', () {
      uuid('id');
      string('name',length: 100);
      text('password');
      date('createdAt');
      date('updatedAt');
    });
  }

    @override
  Future<void> down() async{
    super.down();
    await dropIfExists('users');
  }
}
