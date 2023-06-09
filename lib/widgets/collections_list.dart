import 'package:flutter/material.dart';

class CollectionsList extends StatelessWidget {
  const CollectionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (ctx,index)=>  Card(
      child: SizedBox(
        height: 60,
        child: ListTile(
          title: const Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Text("Electronic Circuits"),),
              Text("Updated 10 days ago",style: TextStyle(fontSize: 10))
            ],
          ),
          subtitle: const Text("10 Notes"),
          onTap: (){
            Navigator.pushNamed(context, "/collection");
          },
        ),
      ),
    ),itemCount: 20,);
  }
}