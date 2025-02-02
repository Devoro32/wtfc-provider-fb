import 'package:wtfc_provider_app/export.dart';

class SGSignUpPage extends StatefulWidget {
  const SGSignUpPage({super.key});

  @override
  State<SGSignUpPage> createState() => _SGSignUpPageState();
}

class _SGSignUpPageState extends State<SGSignUpPage> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                        value!.isEmpty ? 'name cannot be empty.' : null,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('name'),
                    ),
                  ),
                ),
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
                    onPressed: () {},
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
                    const Text('Already have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/loginform');
                        },
                        child: const Text('Log in!'))
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
