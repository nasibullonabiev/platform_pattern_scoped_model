import 'dart:math';
import 'package:flutter/material.dart';
import 'package:platform_pattern_scoped_model/scopes/detail_scope.dart';

import '../models/post_model.dart';
import '../services/network_service.dart';

enum DetailState { create, update }

class DetailPage extends StatefulWidget {
  final Post? post;
  final DetailState state;

  const DetailPage({Key? key, this.post, this.state = DetailState.create})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
   DetailScoped detailScoped = DetailScoped();

  void init() {
    if (widget.state == DetailState.update) {
      detailScoped.titleController = TextEditingController(text: widget.post!.title);
      detailScoped.bodyController = TextEditingController(text: widget.post!.body);
    }
  }



  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: widget.state == DetailState.create
            ? const Text("Add post")
            : const Text("Update post"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: detailScoped.titleController,
                  decoration: InputDecoration(
                      label: const Text("Title"),
                      hintText: "Title",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: detailScoped.bodyController,
                  decoration: InputDecoration(
                      label: const Text("Body"),
                      hintText: "Body",
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(height: 20,),
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    if (widget.state == DetailState.create) {
                      detailScoped.addPage(context);
                    } else {
                      detailScoped.updatePost(context);
                    }
                  },
                  child: const Text("Submit Text"),
                )
              ],
            ),
          ),
          Visibility(
            visible: detailScoped.isLoading,
            child: const CircularProgressIndicator(
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}