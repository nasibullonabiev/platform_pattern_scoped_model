import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:platform_pattern_scoped_model/scopes/home_scope.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/post_model.dart';
import '../services/network_service.dart';
import '../views/item_of_post.dart';
import 'detail_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
HomeScoped homeScoped = HomeScoped();

  @override
  void initState() {
    super.initState();
    homeScoped.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ScopedModel<HomeScoped>(
        model: homeScoped,
        child: ScopedModelDescendant<HomeScoped>(
          builder: (context,child,model){
           return Stack(
             children: [
               ListView.builder(
                   itemCount: homeScoped.items.length,
                   itemBuilder: (context, index) {
                     return itemsOfPost(homeScoped,homeScoped.items[index]);
                   }),
               Visibility(
                 visible: homeScoped.isLoading,
                 child: const Center(
                   child: CircularProgressIndicator(
                     color: Colors.red,
                   ),
                 ),
               )
             ],
           );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          homeScoped.goToDetailPage(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }


}