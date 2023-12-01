import 'package:flutter/material.dart';

class OtherBusniness extends StatefulWidget {
  const OtherBusniness({
    super.key,
  });

  @override
  _OtherBusninessState createState() => _OtherBusninessState();
}

class _OtherBusninessState extends State<OtherBusniness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(""),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          _buildPromotionCard(
            'assets/images/user1.jpeg',
            "Software Engineer",
            "31-Oct-2023",
            "Honner of Software Company",
          ),
          _buildPromotionCard(
            'assets/images/user2.jpeg',
            "Teacher",
            "5-Nov-2023",
            "Passionate and Motivated",
          ),
          _buildPromotionCard(
            'assets/images/user3.jpeg',
            "Cardiologists",
            "28-Oct-2023",
            "A doctor in CMH",
          ),
          _buildPromotionCard(
            'assets/images/user4.jpeg',
            "Cook",
            "31-Sep-2023",
            "Always in the mood for food",
          ),
          _buildPromotionCard(
            'assets/images/user5.jpeg',
            "Singer",
            "3-June-2023",
            "Always in the mood for Song",
          ),
          _buildPromotionCard(
            'assets/images/user6.jpeg',
            "Dancer",
            "4-Aug-2023",
            "Show me stage",
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionCard(
    String imagePath,
    String title,
    String date,
    String subtitle,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 1000),
        tween: Tween<double>(begin: 0.0, end: 1.0),
        builder: (BuildContext context, double value, Widget? child) {
          return Transform.scale(
            scale: value,
            child: Card(
              child: SizedBox(
                width: double.infinity,
                height: 450.0,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          height: 300.0,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(15, 175, 150, 1),
                                      fontFamily: 'Sora-VariableFont_wght.ttf',
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    date,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    subtitle,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
