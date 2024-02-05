// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dog_data/core/api_constants.dart';
import 'package:dog_data/model/dog_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ApiProvider extends ChangeNotifier {
  final Dio _dio;
  ApiProvider(this._dio);

  int _index = 0;

  int get index => _index;

  int incrementIndex() {
    _index++;
    return index;
  }

  Future<String?> fetchDogImage() async {
    try {
      final Response response = await _dio.get(apiEndpoint);

      if (response.statusCode == 200) {
        final image = response.data['message'];
        log(image);
        await storeDogImage(image);

        return image;
      } else {
        throw Exception(
            'Failed to load dog image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      log('Error fetching dog image: $error');
      return null;
    }
  }

  Future<void> storeDogImage(String image) async {
    try {
      final Box<Dog> dogBox = await Hive.openBox('dogs');
      final dog = Dog(image);
      dogBox.add(dog);
      log('data added successfully');
    } catch (error) {
      log('Error storing dog image in Hive: $error');
    }
  }

  Future<List<Dog>> getDogs() async {
    try {
      final Box<Dog> dogBox = await Hive.openBox('dogs');
      final List<Dog> dogs = dogBox.values.toList();
      log(dogs.toString());
      return dogs;
    } catch (error) {
      log('Error loading dogs from Hive: $error');
      return [];
    }
  }

  Future<void> delete(int index) async {
    final Box<Dog> dogBox = await Hive.openBox('dogs');
    await dogBox.deleteAt(index);
    notifyListeners();
  }

  Future<void> addToCart(
      String image, String price, BuildContext context) async {
    try {
      final Box<dynamic> cartBox = await Hive.openBox<dynamic>('cart');
      final Map<String, dynamic> cartItem = {
        'image': image,
        'price': price,
      };
      await cartBox.add(cartItem);
      log('Added to cart successfully');
      Navigator.pushNamed(context, '/cart');
    } catch (error) {
      log('Error adding to cart in Hive: $error');
    }
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    try {
      final Box<dynamic> cartBox = await Hive.openBox<dynamic>('cart');
      final List<Map<String, dynamic>> cartItems = cartBox.values
          .map((dynamic item) => Map<String, dynamic>.from(item))
          .toList();
      log(cartItems.toString());
      log('cart added successfully');
      return cartItems;
    } catch (error) {
      log('Error loading cart items from Hive: $error');
      return [];
    }
  }
}
