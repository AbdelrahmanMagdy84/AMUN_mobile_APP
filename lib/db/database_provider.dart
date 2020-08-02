import 'package:amun/models/Prescription.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String tablePrescription = "prescription";
  static const String column_Id = "id";
  static const String column_title = "title";
  static const String column_date = "date";
  static const String column_image = "image";
  static const String column_doctorName = "doctor";
  static const String column_note = "note";
  //static const String column_facility = "facility";
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;
  Future<Database> get database async {
   // await _database.query("DROP TABLE IF EXISTS $tablePrescription");
      //here we get the Database object by calling the openDatabase method
      //which receives the path and onCreate function and all the good stuff
      // String dbPath = await getDatabasesPath();
      // await openDatabase(join(dbPath, "AmunDB.db"), version: 1,
      //     onCreate: (Database database, int version)async {
      //   //here we execute a query to drop the table if exists which is called "tableName"
      //   //and could be given as method's input parameter too
      //   print('drop table');
      //   await _database.execute("DROP TABLE IF EXISTS $tablePrescription");
      // });
    

    print("database getter is called");
    if (_database != null) {
      print("there is data in database");
      return _database;
    }
    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();
    return await openDatabase(join(dbPath, "AmunDB.db"), version: 1,
        onCreate: (Database database, int version) async {
      print("creating presciption table");
      await database.execute("DROP TABLE IF EXISTS$tablePrescription");

      await database.execute("CREATE TABLE $tablePrescription("
          "$column_Id INTEGER PRIMARY KEY,"
          "$column_title TEXT,"
          "$column_image TEXT,"
          "$column_date TEXT,"
          "$column_doctorName TEXT,"
          "$column_note TEXT,"
          ")");
    });
  }

  Future<List<Prescription>> getPrescriptions() async {
    final db = await database;
    var prescriptions = await db.query(tablePrescription, columns: [
      column_Id,
      column_title,
      column_image,
      column_date,
      column_doctorName,
      column_note
    ]);
    List<Prescription> prescriptionList = List<Prescription>();
    prescriptions.forEach((currentPrescrption) {
      Prescription prescription = Prescription.fromMap(currentPrescrption);
      prescriptionList.add(prescription);
    });
    return prescriptionList;
  }

  Future<Prescription> insert(Prescription prescription) async {
    final db = await database;
    prescription.id = await db.insert(tablePrescription, prescription.toMap());
    return prescription;
  }
}
