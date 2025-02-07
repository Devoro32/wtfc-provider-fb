import 'package:wtfc_provider_app/export.dart';

//https://youtu.be/7P_IC3dviRk?t=1997
class SGLoginPage extends StatefulWidget {
  const SGLoginPage({super.key});

  @override
  State<SGLoginPage> createState() => _SGLoginPageState();
}

class _SGLoginPageState extends State<SGLoginPage> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void signInUser() async {
    String res = await AuthServices().signInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    //if signup is success, user has been created and navigate to the next screen
    //otherwise show the error message
    if (res == 'success') {
      setState(() {
        isLoading = true;
      });

      //navigate to the next screen
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const AuthHomeScreen(),
      //   ),
      // );
      Navigator.pushNamed(context, '/home');
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formkey,
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                ),
                const Text('Get started with your account'),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Email cannot be empty.' : null,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('email'),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    validator: (value) => value!.length < 7
                        ? 'Password should have at least 7 characters'
                        : null,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('password'),
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: signInUser,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signupform');
                        },
                        child: const Text('Sign up!'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
