import 'package:wtfc_provider_app/export.dart';

class AuthForgotPassword extends StatefulWidget {
  const AuthForgotPassword({super.key});

  @override
  State<AuthForgotPassword> createState() => _AuthForgotPasswordState();
}

class _AuthForgotPasswordState extends State<AuthForgotPassword> {
  TextEditingController emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            authMyDialogBox(context);
          },
          child: const Text(
            'Forgot Password?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  void authMyDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      const Text(
                        'Forgott your password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your email',
                      hintText: 'eg abc@gmail.com',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () async {
                      await auth
                          .sendPasswordResetEmail(email: emailController.text)
                          .then((value) {
                        showSnackBar(context,
                            "We have sent you the password link to your email. Please check your email.");
                      }).onError((error, stackTrace) {
                        showSnackBar(context, error.toString());
                      });

                      Navigator.pop(context);
                      emailController.clear();
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
