import 'package:wtfc_provider_app/export.dart';

class AuthHomeScreen extends StatelessWidget {
  const AuthHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Congratulation \n You have successfully login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            AuthButton(
                onTap: () async {
                  await AuthServices().SignOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ));
                },
                text: 'Log Out'),
            AuthButton(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BKUploadEvent()));
                },
                text: 'Booking Event')
          ],
        ),
      ),
    );
  }
}
