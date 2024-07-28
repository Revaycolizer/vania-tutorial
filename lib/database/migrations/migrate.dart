import 'dart:io';
import 'package:todo/database/migrations/create_personal_access_tokens_table.dart';
import 'package:vania/vania.dart';
import 'create_user_table.dart';
import 'create_product_table.dart';
import 'create_user_product.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
		 await CreatePersonalAccessTokensTable().up();
		await CreateUserTable().up();
		 await CreateProductTable().up();
		 await CreateUserProduct().up();
	}

    dropTables() async {
		 await CreateUserProduct().down();
		 await CreateProductTable().down();
		 await CreateUserTable().down();
	 }
}
