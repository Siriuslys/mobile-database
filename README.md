# To-Do App with Isar Database 

Nama: Audrey Sasqhia Wijaya
<br>
NRP: 5025221055

## Create Flutter Project

   ```bash
   flutter create name_app
   ```
   
   ```bash
   cd name_app
   ```
## Installing Isar Database <br>

   There are two ways to installing Isar Database to your flutter project <br> 
   - Terminal <br>
   
      ```bash 
      flutter pub add isar isar_flutter_libs path_provider
      
      flutter pub add -d isar_generator build_runner
      ```

   - Edit file pubspec.yaml <br>
      
      ```yaml
      dependencies:
         flutter:
            sdk: flutter
         cupertino_icons: ^1.0.8
         isar: ^3.1.0+1
         isar_flutter_libs: ^3.1.0+1
         path_provider: ^2.1.5


      dev_dependencies:
         flutter_test:
            sdk: flutter
            flutter_lints: ^5.0.0
            isar_generator: ^3.1.0+1
            build_runner: ^2.4.13   
      ``` 
      <br>
   
   After that run this command
   ```bash
   flutter pub get
   ```

## Define the Model <br>

   Create a todo.dart (models) file to define your Isar data model. Use @collection to annotate your class.

   ```dart
   import 'package:isar/isar.dart';
   import 'package:mobile_db/models/enums.dart';

   part 'todo.g.dart';

   @Collection()
   class Todo {
   Id id = Isar.autoIncrement;

   @Index(type: IndexType.value)
   String? content;

   @enumerated
   Status status = Status.pending;

   DateTime createdAt = DateTime.now();
   DateTime updatedAt = DateTime.now();


   Todo copyWith({
      String? content,
      Status? status,
   }) {
      return Todo()
         ..id = id
         ..createdAt = createdAt
         ..updatedAt = DateTime.now()
         ..content = content ?? this.content
         ..status = status ?? this.status;
         
   }
   }
   ```

   Create enums.dart untuk status to do

   ```dart
   enum Status {
      completed,
      inProgress,
      pending,
   }
   ```

   Generate the code:

   ```bash
   flutter pub run build_runner build
   ```

## Initialize Isar <br>
   ```dart
   import 'package:isar/isar.dart';
   import 'package:mobile_db/models/todo.dart';
   import 'package:path_provider/path_provider.dart';

   class DatabaseService{

   static late final Isar db;
   
   static Future<void> setup() async{
      final appDir = await getApplicationDocumentsDirectory();
      db = await Isar.open(
         [
         TodoSchema,
         ],
         directory: appDir.path,
      );
   }
   }
   ```


##  Main Entry

   Main.dart
   ```dart
   void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await DatabaseService.setup();
   runApp(const MyApp());
   }
   ```

## 🖼️ UI and Functionality

### `pages/home_page.dart`

   To **add or edit**:
   ```dart
      if (todo != null) {
      newTodo = todo.copyWith(
         content: contentController.text,
         status: status,
      );
      } else {
      newTodo = Todo().copyWith(
         content: contentController.text,
         status: status,
      );
      }

      await DatabaseService.db.writeTxn(() async {
      await DatabaseService.db.todos.put(newTodo);
      });
   ```

To **read**:
   ```dart
      DatabaseService.db.todos
      .buildQuery<Todo>()
      .watch(fireImmediately: true)
      .listen((data) {
         setState(() {
            todos = data;
         });
      });
   ```

   To **delete**:
   ```dart
   await DatabaseService.db.writeTxn(() async {
   await DatabaseService.db.todos.delete(todo.id);
   });
   ```

### `models/todo.dart`

```dart
 Todo copyWith({
    String? content,
    Status? status,
  }) {
    return Todo()
      ..id = id
      ..createdAt = createdAt
      ..updatedAt = DateTime.now()
      ..content = content ?? this.content
      ..status = status ?? this.status;
      
  }
```

