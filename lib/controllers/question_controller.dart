import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/models/questions_model.dart';

class QuestionController extends GetxController {
  // UI Control
  late PageController _pageController;
  PageController get pageController => _pageController;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  int _correctAns = 0;
  int get correctAns => _correctAns;

  int _selectedAns = 0;
  int get selectedAns => _selectedAns;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  List<Question> _questions = [];
  List<Question> get questions => _questions;

  final TextEditingController questionControllerText = TextEditingController();
  final List<TextEditingController> optionControllers =
      List.generate(4, (index) => TextEditingController());
  final TextEditingController correctAnswerController = TextEditingController();
  final TextEditingController quizCategoryController = TextEditingController();

  // Method to save a question to shared preferences
  Future<void> saveQuestionToSharedPreferences(Question question) async {
    final prefs = await SharedPreferences.getInstance();
    final questions = prefs.getStringList("questions") ?? [];
    questions.add(jsonEncode(question.toJson()));
    await prefs.setStringList("questions", questions);
  }

  // Admin Dashboard
  final String _categoryKey = "category_title";
  final String _subtitleKey = "subtitle";

  TextEditingController categoryTitleController = TextEditingController();
  TextEditingController categorySubtitleController = TextEditingController();

  RxList<String> savedCategories = <String>[].obs;
  RxList<String> savedSubtitles = <String>[].obs;

  // Save a new category to shared preferences
  Future<void> saveCategoryToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    savedCategories.add(categoryTitleController.text);
    savedSubtitles.add(categorySubtitleController.text);

    await prefs.setStringList(_categoryKey, savedCategories);
    await prefs.setStringList(_subtitleKey, savedSubtitles);

    categoryTitleController.clear();
    categorySubtitleController.clear();

    Get.snackbar("Saved", "Category created successfully");
    update(); // Trigger UI update
  }

  // Load categories from shared preferences
  Future<void> loadCategoriesFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final categories = prefs.getStringList(_categoryKey) ?? [];
    final subtitles = prefs.getStringList(_subtitleKey) ?? [];

    savedCategories.assignAll(categories);
    savedSubtitles.assignAll(subtitles);
    update(); // Trigger UI update
  }

  // Load questions from shared preferences
  Future<void> loadQuestionsFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final questionJson = prefs.getStringList("questions") ?? [];
    _questions = questionJson
        .map((json) => Question.fromJson(jsonDecode(json)))
        .toList();
    update(); // Trigger UI update
  }

  // Get questions filtered by category
  List<Question> getQuestionsByCategory(String category) {
    return _questions
        .where((question) => question.category == category)
        .toList();
  }

  // Check the answer selected by the user
  void checkAnswer(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;
    nextQuestion();
  }

  // Proceed to the next question or end the quiz
  void nextQuestion() async {
    if (_questionNumber.value < _questions.length) {
      _isAnswered = false;
      _questionNumber.value++;

      _pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.ease,
      );
    } else {
      Get.snackbar("Quiz Completed",
          "You scored $_numOfCorrectAns out of ${_questions.length}");
    }
  }

  @override
  void onInit() {
    loadCategoriesFromSharedPreferences();
    loadQuestionsFromSharedPreferences();
    _pageController = PageController();
    super.onInit();
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
    update();
  }

  @override
  void dispose() {
    _pageController.dispose();
    categoryTitleController.dispose();
    categorySubtitleController.dispose();
    questionControllerText.dispose();
    optionControllers.forEach((controller) => controller.dispose());
    correctAnswerController.dispose();
    quizCategoryController.dispose();
    super.dispose();
  }
}
