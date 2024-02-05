import 'package:dio/dio.dart';
import 'package:dog_data/controller/api_provider.dart';
import 'package:dog_data/model/dog_model.dart';
import 'package:dog_data/screens/cart/add_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  final ApiProvider apiProvider = ApiProvider(Dio());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Dog>>(
          future: Provider.of<ApiProvider>(context).getDogs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Dog>? dogs = snapshot.data;
              return ListView.builder(
                itemCount: dogs!.length,
                itemBuilder: (context, index) {
                  Dog dog = dogs[index];
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onLongPress: () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Delete image'),
                              content: const SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                        'This is the content of the alert dialog.'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Provider.of<ApiProvider>(context,
                                            listen: false)
                                        .delete(index);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Ok'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddCart(
                                      image: dog.image,
                                      )));
                        },
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(dog.image),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
