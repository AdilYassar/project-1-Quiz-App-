import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/question_controller.dart';
import 'package:flutter_application_1/views/admin/admin_screen.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final QuestionController questionController = Get.find<QuestionController>();

  @override
  void initState() {
    super.initState();
    questionController
        .loadCategoriesFromSharedPreferences(); // Load saved categories when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
      ),
      body: GetBuilder<QuestionController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.savedCategories.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    Get.to(() => AdminScreen(
                        quizCategory: controller.savedCategories[index]));
                  },
                  leading: const Icon(Icons.question_answer),
                  title: Text(controller
                      .savedCategories[index]), // Show dynamic category title
                  subtitle: Text(controller
                      .savedSubtitles[index]), // Show dynamic category subtitle
                  trailing: IconButton(
                    onPressed: () {
                      // Add your delete logic here
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialogBox,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDialogBox() {
    Get.defaultDialog(
      title: "Add Quiz",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: questionController.categoryTitleController,
            decoration: const InputDecoration(
              hintText: "Enter the category name",
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: questionController.categorySubtitleController,
            decoration: const InputDecoration(
              hintText: "Enter the category subtitle",
            ),
          ),
        ],
      ),
      textConfirm: "Save",
      onConfirm: () {
        questionController
            .saveCategoryToSharedPreferences(); // Correct method name
        Get.back(); // Close the dialog
      },
      textCancel: "Cancel",
      onCancel: () {
        Get.back(); // Close the dialog
      },
    );
  }
}
