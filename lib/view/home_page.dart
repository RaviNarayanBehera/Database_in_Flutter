import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/db_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Budget Tracker'),
      ),
      body: Obx(
        () => Column(
          children: [
            Card(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Income : ₹ '+controller.totalIncome.value.toString()),
                Text('Expense : ₹ '+controller.totalExpense.value.toString()),
              ],
            )),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => Card(
                  color: controller.data[index]['isIncome'] == 1
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  child: ListTile(
                    leading: Text(controller.data[index]['id'].toString()),
                    title: Text(controller.data[index]['amount'].toString()),
                    subtitle:
                        Text(controller.data[index]['category'].toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Update Details'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: controller.txtAmount,
                                        decoration: const InputDecoration(
                                            hintText: 'Amount'),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextField(
                                        controller: controller.txtCategory,
                                        decoration: const InputDecoration(
                                            hintText: 'Category'),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Obx(
                                        () => SwitchListTile(
                                          title: const Text('Income/Expense'),
                                          value: controller.isIncome.value,
                                          onChanged: (value) {
                                            controller.setIncome(value);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text('Cancel')),
                                    TextButton(
                                        onPressed: () {
                                          controller.updateRecord(
                                            double.parse(
                                                controller.txtAmount.text),
                                            controller.isIncome.value ? 1 : 0,
                                            controller.txtCategory.text,
                                            controller.data[index]['id'],
                                          );
                                          Get.back();
                                          controller.txtAmount.clear();
                                          controller.txtCategory.clear();
                                          controller.isIncome.value = false;
                                        },
                                        child: const Text('Save')),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit)),
                        // edit
                        InkWell(
                            onTap: () {
                              controller
                                  .removeRecord(controller.data[index]['id']);
                            },
                            child: const Icon(Icons.delete)),
                        // delete
                      ],
                    ),
                  ),
                ),
                itemCount: controller.data.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Details'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller.txtAmount,
                    decoration: const InputDecoration(labelText: 'Amount'),
                  ),
                  TextField(
                    controller: controller.txtCategory,
                    decoration: const InputDecoration(labelText: 'Category'),
                  ),
                  Obx(
                    () => SwitchListTile(
                      title: const Text('Income/Expense'),
                      value: controller.isIncome.value,
                      onChanged: (value) {
                        controller.setIncome(value);
                      },
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      double amount = double.parse(controller.txtAmount.text);
                      int isIncome = controller.isIncome.value ? 1 : 0;
                      String category = controller.txtCategory.text;
                      controller.insertRecord(amount, isIncome, category);

                      controller.txtAmount.clear();
                      controller.txtCategory.clear();
                      controller.setIncome(false);
                      Get.back();
                    },
                    child: const Text('Save'))
              ],
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}

// IconButton(
// onPressed: () {
// showDialog(
// context: context,
// builder: (context) => AlertDialog(
// title: const Text('Update details'),
// content: Form(
// key: formKey,
// child: Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// buildTextFormField(
// label: 'Amount',
// controller: controller.txtAmount,
// ),
// const SizedBox(
// height: 10,
// ),
// buildTextFormField(
// label: 'Category',
// controller: controller.txtCategory,
// ),
// Obx(
// () => SwitchListTile(
// activeTrackColor: Colors.green,
// title: const Text('Income'),
// value: controller.isIncome.value,
// onChanged: (value) {
// controller.setIsIncome(value);
// },
// ),
// ),
// ],
// ),
// ),
// actions: [
// TextButton(
// onPressed: () {
// Get.back();
// },
// child: const Text(
// 'Cancel',
// style: TextStyle(color: Colors.black),
// ),
// ),
// TextButton(
// onPressed: () {
// bool response =
// formKey.currentState!.validate();
// if (response) {
// controller.updateRecord(
// controller.data[index]['id'],
// double.parse(
// controller.txtAmount.text),
// controller.isIncome.value ? 1 : 0,
// controller.txtCategory.text,
// );
// }
// Get.back();
// controller.txtAmount.clear();
// controller.txtCategory.clear();
// controller.isIncome.value = false;
// },
// child: const Text(
// 'OK',
// style: TextStyle(color: Colors.black),
// ),
// ),
// ],
// ),
// );
// },
// icon: const Icon(
// Icons.edit,
// color: Colors.black,
// ),
// ),
// IconButton(
// onPressed: () {
// controller
//     .deleteRecord(controller.data[index]['id']);
// },
// icon: Icon(
// Icons.delete,
// color: Colors.red[900],
// ),
// ),
