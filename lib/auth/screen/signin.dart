//https://youtu.be/Txa3sevHSsY?list=PLOEXB48nQMqPgaDB6-rYBxX8AxFGW5lF3
//https://github.com/Nabinji/100-DaysOf-Futter/blob/main/flutter_firebse_project/images/signup1.jpeg
import 'package:wtfc_provider_app/export.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void signInUser() async {
    String res = await AuthServices().signInUser(
      email: emailController.text,
      password: passwordController.text,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: height / 2.7,
                child: Image.asset('images/login.jpg'),
              ),
              AuthTextFieldInput(
                  textEditingController: emailController,
                  hintText: 'Enter your email',
                  icon: Icons.email),
              AuthTextFieldInput(
                  textEditingController: passwordController,
                  hintText: 'Enter your password',
                  isPass: true,
                  icon: Icons.lock),
              const AuthForgotPassword(),
              AuthButton(onTap: signInUser, text: 'Log In'),
              SizedBox(
                height: height / 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Dont have an account?',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()));
                    },
                    child: const Text(
                      ' Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
