//https://youtu.be/Txa3sevHSsY?list=PLOEXB48nQMqPgaDB6-rYBxX8AxFGW5lF3
//https://github.com/Nabinji/100-DaysOf-Futter/blob/main/flutter_firebse_project/images/signup1.jpeg
import 'package:wtfc_provider_app/auth/services/fb_auth.dart';
import 'package:wtfc_provider_app/export.dart';

//! if you need google sign in then start from
//https://youtu.be/Txa3sevHSsY?list=PLOEXB48nQMqPgaDB6-rYBxX8AxFGW5lF3&t=3089
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();

    super.dispose();
  }

  void signUpUser() async {
    String res = await AuthServices().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );

    //if signup is success, user has been created and navigate to the next screen
    //otherwise show the error message
    if (res == 'success') {
      setState(() {
        isLoading = true;
      });

      //navigate to the next screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AuthHomeScreen(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: height / 2.7,
                  child: Image.asset('images/signup.jpeg'),
                ),
                AuthTextFieldInput(
                    textEditingController: nameController,
                    hintText: 'Enter your name',
                    icon: Icons.email),
                AuthTextFieldInput(
                    textEditingController: emailController,
                    hintText: 'Enter your email',
                    icon: Icons.email),
                AuthTextFieldInput(
                    textEditingController: passwordController,
                    hintText: 'Enter your password',
                    isPass: true,
                    icon: Icons.lock),
                AuthButton(onTap: signUpUser, text: 'Log In'),
                SizedBox(
                  height: height / 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()));
                      },
                      child: const Text(
                        ' Sign in',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
