import 'package:amun/models/category.dart';

class Category {
  final String id;
  final String title;
  final String image;
  const Category({this.id, this.title, this.image});
}

List<Category> categories = [
  Category(id: '1', title: "Blood Glocose", image: 'assets/images/glocose.jpg'),
  Category(id: '2', title: "Blood Pressure", image: 'assets/images/pressure.jpg'),
  Category(id: '3', title: "Prescription", image: 'assets/images/pres.png'),
  Category(id: '4', title: "Reminders", image: 'assets/images/appointment.png'),
  Category(id: '5', title: "Radiograph", image: 'assets/images/radiograph.png'),
  Category(id: '6', title: "Lab Test", image: 'assets/images/lab.png'),
];
