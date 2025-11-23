import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool agreeToTerms = false;

  final RegExp _emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Повідомлення'),
          content: Text(message),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('OK')),
          ],
        );
      },
    );
  }

  void _onSignup() {
    if (!_formKey.currentState!.validate()) return;
    if (!agreeToTerms) {
      _showMessage('Потрібно погодитись з умовами');
      return;
    }

    _showMessage("Користувача ${nameController.text} зареєстровано");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Реєстрація')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          children: [
            const Text(
              'Створення акаунту',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 32),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Ім\'я користувача',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return 'Поле обов\'язкове';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Логін (email)',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return 'Поле обов\'язкове';
                      if (!_emailRegExp.hasMatch(value.trim())) return 'Невірний формат email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Пароль',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Поле обов\'язкове';
                      if (value.length < 7) return 'Пароль має бути мінімум 7 символів';
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Checkbox(
                        value: agreeToTerms,
                        onChanged: (v) => setState(() => agreeToTerms = v ?? false),
                      ),
                      const Expanded(
                        child: Text('Я погоджуюсь з умовами використання сервісу'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _onSignup,
                    child: const SizedBox(width: double.infinity, child: Center(child: Text('Зареєструватися'))),
                  ),

                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const SizedBox(width: double.infinity, child: Center(child: Text('Повернутися до входу'))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
