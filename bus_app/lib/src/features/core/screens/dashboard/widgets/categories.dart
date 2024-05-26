import 'package:flutter/material.dart';

// Sample list item model
class ListItem {
  final String title;
  final String heading;
  final String subHeading;
  final VoidCallback onPress;

  ListItem({required this.title, required this.heading, required this.subHeading, required this.onPress});
}

class Categories extends StatelessWidget {
  final List<ListItem> list;

  const Categories({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 45,
      child: ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: list[index].onPress,
          child: SizedBox(
            width: 170,
            height: 45,
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black, // Replace with your desired color
                  ),
                  child: Center(
                    child: Text(
                      list[index].title,
                      style: txtTheme.headlineSmall?.apply(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        list[index].heading,
                        style: txtTheme.headlineSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        list[index].subHeading,
                        style: txtTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
