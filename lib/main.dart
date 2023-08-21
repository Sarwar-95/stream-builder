import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  List<String> language = [];
  final TextEditingController _textEditingController = TextEditingController();

  StreamController _streamController = StreamController();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Stream"),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              TextField(
                controller: _textEditingController,
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    final input = _textEditingController.text;
                    language.add(input);
                    _streamController.sink.add(language);
                    _textEditingController.clear();
                  },
                  child: const Text("Insert Data")),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                  child: Container(
                color: Colors.blue[100],
                child: StreamBuilder(
                    stream: _streamController.stream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 0.5,
                                child: ListTile(
                                  tileColor: Colors.amberAccent[900],
                                  title: Text(snapshot.data[index]),
                                  trailing: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ),
                              );
                            });
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
