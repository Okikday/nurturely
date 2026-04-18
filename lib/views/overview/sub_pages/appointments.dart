import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as TechstarColors;
import 'package:techstars_hackathon/common/colors.dart';

import '../../../common/constants.dart';
import '../../../common/device_utils.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.index = 0;
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);
    final bool isDarkMode = themeData.brightness == Brightness.dark;
    final double width = mediaQuery.size.width;
    final double height = mediaQuery.size.height;

    return Scaffold(
      body: LayoutBuilder(
        builder:
            (context, constraints) => Container(
              width: width,
              height: height,
              child: Column(
                children: [
                  SizedBox(
                    width: width,
                    height: height * 0.1,
                    child: Constants.wrapInPadding(
                      top: 48,
                      Text("Appointments", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: Constants.medium)),
                    ),
                  ),
                  Constants.whiteSpaceVertical(12),
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.fromBorderSide(BorderSide(width: 1, color: TechstarColors.primary)),
                    ),
                    width: width,
                    height: height * 0.05,
                    child: PreferredSize(
                      preferredSize: Size(width, height * 0.05),
                      child: TabBar(
                        dividerColor: TechstarColors.primary,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: TechStarsColors.primary,
                        indicator: BoxDecoration(
                          color: TechstarColors.primary,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.fromBorderSide(BorderSide(width: 1, color: TechstarColors.primary)),
                        ),
                        tabs: const [Tab(text: "Upcoming"), Tab(text: "Completed"), Tab(text: "Cancelled")],
                        controller: tabController,
                        onTap: (value) {
                          tabController.index = value;
                        },
                      ),
                    ),
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: width,
                    height: height - 64 - (height * 0.16) - 48,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        Upcoming(list: AppointmentData.appointment),
                        Completed(list: AppointmentData.appointment),
                        Cancelled(list: AppointmentData.appointment),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}

class Upcoming extends StatefulWidget {
  final List list;
  final double width;
  const Upcoming({super.key, this.width = 200, this.list = const []});

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  late List newList;

  @override
  void initState() {
    super.initState();
    newList = [];
    loadList();
  }

  void loadList() {
    for (int i = 0; i < widget.list.length; i++) {
      if (widget.list[i][2] == "upcoming" && !newList.contains(widget.list[i])) {
        newList.add(widget.list[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    loadList();
    return LayoutBuilder(
      builder: (context, constraints) {
        final parentWidth = constraints.maxWidth;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: parentWidth,
              child: Column(
                children: [
                  for (int i = 0; i < newList.length; i++)
                    Column(
                      children: [
                        Constants.whiteSpaceVertical(12),
                        UpcomingBox(
                          healthimmName: newList[i][0],
                          address: newList[i][1],
                          state: newList[i][2],
                          topic: newList[i][3],
                          date: newList[i][4],
                          price: newList[i][5].toDouble(),
                          assetName: newList[i][6],
                        ),
                        Constants.whiteSpaceVertical(12),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class UpcomingBox extends StatelessWidget {
  final String? healthimmName;
  final String? address;
  final String? state;
  final String? topic;
  final String? date;
  final double? price;
  final String assetName;
  const UpcomingBox({
    super.key,
    required this.healthimmName,
    required this.address,
    required this.state,
    required this.topic,
    required this.date,
    required this.price,
    this.assetName = "",
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);
    final bool isDarkMode = themeData.brightness == Brightness.dark;
    final double width = mediaQuery.size.width;
    final double height = mediaQuery.size.height;
    return LayoutBuilder(
      builder: (context, constraints) {
        final double parentWidth = constraints.maxWidth;
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(border: Border.all(width: 1, color: TechstarColors.primary), borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                color: TechstarColors.primary,
                width: parentWidth,
                child: Constants.wrapInPadding(
                  top: 4,
                  bottom: 4,
                  Text("$topic", style: TextStyle(color: Colors.white, fontSize: Constants.medium)),
                ),
              ),
              Constants.whiteSpaceVertical(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Constants.wrapInPadding(
                    left: 8,
                    right: 8,
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColor)),
                        image: DecorationImage(image: NetworkImage(assetName)),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(healthimmName ?? "", style: TextStyle(color: Colors.black, fontSize: Constants.medium)),
                      Constants.whiteSpaceVertical(12),
                      SizedBox(
                        width: width * 0.6,
                        child: Text(address ?? "Unknown address", style: TextStyle(color: Colors.black, fontSize: Constants.extraSmall)),
                      ),
                      Constants.whiteSpaceVertical(12),
                      Text(date ?? "Date:", style: TextStyle(color: Colors.black, fontSize: Constants.extraSmall)),

                      Constants.whiteSpaceVertical(12),
                      Row(
                        children: [
                          const Icon(Icons.delete_outline_rounded, color: Color.fromARGB(255, 186, 61, 52), size: 24),
                          Text(
                            "Cancel appointment",
                            style: TextStyle(color: const Color.fromARGB(255, 186, 61, 52), fontSize: Constants.smallPlus2),
                          ),
                        ],
                      ),
                      Constants.whiteSpaceVertical(12),
                    ],
                  ),
                ],
              ),
              Divider(height: 1, color: TechstarColors.primary),
              SizedBox(
                height: 48,
                child: Constants.wrapInPadding(
                  left: 8,
                  right: 12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total: #${price ?? 0}", style: TextStyle(color: Colors.black)),
                      Text("View", style: TextStyle(color: Colors.black, fontSize: Constants.smallPlus2)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Cancelled extends StatefulWidget {
  final List list;
  final double width;
  const Cancelled({super.key, this.width = 200, this.list = const []});

  @override
  State<Cancelled> createState() => _CancelledState();
}

class _CancelledState extends State<Cancelled> {
  late List newList;

  @override
  void initState() {
    super.initState();
    newList = [];
    loadList();
  }

  void loadList() {
    for (int i = 0; i < widget.list.length; i++) {
      if (widget.list[i][2] == "cancelled" && !newList.contains(widget.list[i])) {
        newList.add(widget.list[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    loadList();
    return LayoutBuilder(
      builder: (context, constraints) {
        final parentWidth = constraints.maxWidth;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: parentWidth,
              child: Column(
                children: [
                  for (int i = 0; i < newList.length; i++)
                    Column(
                      children: [
                        Constants.whiteSpaceVertical(12),
                        CancelledBox(
                          healthimmName: newList[i][0],
                          address: newList[i][1],
                          state: newList[i][2],
                          topic: newList[i][3],
                          date: newList[i][4],
                          price: newList[i][5].toDouble(),
                        ),
                        Constants.whiteSpaceVertical(12),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CancelledBox extends StatelessWidget {
  final String? healthimmName;
  final String? address;
  final String? state;
  final String? topic;
  final String? date;
  final double? price;
  const CancelledBox({
    super.key,
    required this.healthimmName,
    required this.address,
    required this.state,
    required this.topic,
    required this.date,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final double width = DeviceUtils.getScreenWidth(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final double parentWidth = constraints.maxWidth;
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(border: Border.all(width: 1, color: TechstarColors.primary), borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                color: TechstarColors.primary,
                width: parentWidth,
                child: Constants.wrapInPadding(
                  top: 4,
                  bottom: 4,
                  Text("$topic", style: TextStyle(color: Colors.white, fontSize: Constants.medium)),
                ),
              ),
              Constants.whiteSpaceVertical(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Constants.wrapInPadding(
                    left: 8,
                    right: 8,
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(image: AssetImage("assets/doctor/images/doctor_logo.png")),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(healthimmName ?? "", style: TextStyle(color: Colors.black, fontSize: Constants.medium)),
                      Constants.whiteSpaceVertical(12),
                      SizedBox(
                        width: width * 0.6,
                        child: Text(address ?? "Unknown address", style: TextStyle(color: Colors.black, fontSize: Constants.extraSmall)),
                      ),
                      Constants.whiteSpaceVertical(12),
                      Text(date ?? "Date:", style: TextStyle(color: Colors.black, fontSize: Constants.extraSmall)),

                      Constants.whiteSpaceVertical(24),
                    ],
                  ),
                ],
              ),
              Divider(height: 1, color: TechstarColors.primary),
              SizedBox(
                height: 48,
                child: Constants.wrapInPadding(
                  left: 8,
                  right: 12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total: \$${price ?? 0}", style: TextStyle(color: Colors.black)),
                      Text("View", style: TextStyle(color: Colors.black, fontSize: Constants.smallPlus2)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Completed extends StatefulWidget {
  final List list;
  final double width;
  const Completed({super.key, this.width = 200, this.list = const []});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  late List newList;

  @override
  void initState() {
    super.initState();
    newList = [];
    loadList();
  }

  void loadList() {
    for (int i = 0; i < widget.list.length; i++) {
      if (widget.list[i][2] == "completed" && !newList.contains(widget.list[i])) {
        newList.add(widget.list[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    loadList();
    return LayoutBuilder(
      builder: (context, constraints) {
        final parentWidth = constraints.maxWidth;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: parentWidth,
              child: Column(
                children: [
                  for (int i = 0; i < newList.length; i++)
                    Column(
                      children: [
                        Constants.whiteSpaceVertical(12),
                        CompletedBox(
                          healthimmName: newList[i][0],
                          address: newList[i][1],
                          state: newList[i][2],
                          topic: newList[i][3],
                          date: newList[i][4],
                          price: newList[i][5].toDouble(),
                          assetName: newList[i][6],
                        ),
                        Constants.whiteSpaceVertical(12),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CompletedBox extends StatelessWidget {
  final String? healthimmName;
  final String? address;
  final String? state;
  final String? topic;
  final String? date;
  final double? price;
  final String assetName;
  const CompletedBox({
    super.key,
    required this.healthimmName,
    required this.address,
    required this.state,
    required this.topic,
    required this.date,
    required this.price,
    this.assetName = "doctor_logo.png",
  });

  @override
  Widget build(BuildContext context) {
    final double width = DeviceUtils.getScreenWidth(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final double parentWidth = constraints.maxWidth;
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(border: Border.all(width: 1, color: TechstarColors.primary), borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                color: TechstarColors.primary,
                width: parentWidth,
                child: Constants.wrapInPadding(
                  top: 4,
                  bottom: 4,
                  Text("$topic", style: TextStyle(color: Colors.white, fontSize: Constants.medium)),
                ),
              ),
              Constants.whiteSpaceVertical(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Constants.wrapInPadding(
                    left: 8,
                    right: 8,
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColor)),
                        image: DecorationImage(image: AssetImage("assets/doctor/images/$assetName")),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(healthimmName ?? "", style: TextStyle(color: Colors.black, fontSize: Constants.medium)),
                      Constants.whiteSpaceVertical(12),
                      SizedBox(
                        width: width * 0.6,
                        child: Text(address ?? "Unknown address", style: TextStyle(color: Colors.black, fontSize: Constants.extraSmall)),
                      ),
                      Constants.whiteSpaceVertical(12),
                      Text(date ?? "Date:", style: TextStyle(color: Colors.black, fontSize: Constants.extraSmall)),

                      Constants.whiteSpaceVertical(24),
                    ],
                  ),
                ],
              ),
              Divider(height: 1, color: TechstarColors.primary),
              SizedBox(
                height: 48,
                child: Constants.wrapInPadding(
                  left: 8,
                  right: 12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total: \$${price ?? 0}", style: TextStyle(color: Colors.black)),
                      Text("View", style: TextStyle(color: Colors.black, fontSize: Constants.smallPlus2)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AppointmentData {
  static List appointment = [
    [
      "Lagos Health Clinic",
      "123 Health Avenue, Ikeja, Lagos, Nigeria",
      "upcoming",
      "Pending",
      "01 August 2025 - 15:30 pm",
      15000.0,
      "https://source.unsplash.com/150x150/?clinic"
    ],
    [
      "Abuja Medical Center",
      "45 Mercy Road, Wuse, Abuja, Nigeria",
      "upcoming",
      "Pending",
      "31 July 2025 - 13:30 pm",
      20000.0,
      "https://source.unsplash.com/150x150/?hospital"
    ],
    [
      "Port Harcourt Health Center",
      "789 Wellness Blvd, Port Harcourt, Nigeria",
      "completed",
      "Completed",
      "01 August 2025 - 15:35 pm",
      18000.0,
      "https://source.unsplash.com/150x150/?healthcare"
    ],
    [
      "Kaduna Care Hospital",
      "456 Healing Street, Kaduna, Nigeria",
      "cancelled",
      "Cancelled",
      "01 August 2025 - 15:30 pm",
      22000.0,
      "https://source.unsplash.com/150x150/?clinic,hospital"
    ],
    [
      "Benin City Medical Hub",
      "321 Recovery Road, Benin City, Nigeria",
      "cancelled",
      "Cancelled",
      "31 July 2025 - 13:30 pm",
      30000.0,
      "https://source.unsplash.com/150x150/?medical"
    ],
  ];
}
