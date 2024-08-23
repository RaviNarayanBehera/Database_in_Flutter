import 'package:database_in_flutter/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main()
{
  runApp(const BudgetTracker());
}

class BudgetTracker extends StatelessWidget {
  const BudgetTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => const HomePage(),),
      ],
    );
  }
}