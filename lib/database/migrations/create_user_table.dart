import 'package:vania/vania.dart';

class CreateUserTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTable('users', () {
      id();
      text('name');
    });
  }

    @override
  Future<void> down() async{
    super.down();
    await dropIfExists('users');
  }
}
