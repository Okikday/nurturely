import 'package:custom_widgets_toolkit/custom_widgets_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:techstars_hackathon/common/colors.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText("Notifications", fontSize: 14, fontWeight: FontWeight.bold), centerTitle: true, iconTheme: IconThemeData(color: Colors.black),),

      body: Column(
        children: [
          const Divider(),
          for (int i = 0; i < 5; i++)
            Column(
              children: [
                NotificationListTile(title: "You CT Scans at the Health Center are ready", index: i,),
                const Divider(),
              ],
            )
        ],
      ),
    );
  }
}


class NotificationListTile extends StatelessWidget {
  final int index;
  final String title;
  const NotificationListTile({
    super.key,
    required this.title,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: CustomText(index.toString(), fontWeight: FontWeight.bold, fontSize: 14), backgroundColor: TechStarsColors.lighterTeal,),
      title: CustomText(title),
      trailing: CustomText("5m ago", color: TechStarsColors.altLightGray, fontSize: 10),
    );
  }
}