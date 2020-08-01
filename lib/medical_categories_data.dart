import 'package:flutter/material.dart';
import './models/category.dart';

List<Category> categories = [
  Category(
      color: Colors.greenAccent,
      id: '1',
      title: "Blood Glocose",
      image: 'images/glocose.jpg'),
  Category(
      color: Colors.redAccent,
      id: '2',
      title: "Blood Pressure",
      image: 'images/pressure.jpg'),
  Category(
      color: Colors.blueAccent,
      id: '3',
      title: "Prescription",
      image: 'images/pres.png'),
  Category(
      color: Colors.cyan,
      id: '4',
      title: "Reminders",
      image: 'images/appointment.png'),
  Category(
      color: Colors.black12,
      id: '5',
      title: "Radiograph",
      image: 'images/radiograph.png'),
];
