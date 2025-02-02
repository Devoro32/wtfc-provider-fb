import 'package:wtfc_provider_app/export.dart';

class BookingEventSignup extends StatefulWidget {
  const BookingEventSignup({super.key});

  @override
  State<BookingEventSignup> createState() => _BookingEventSignupState();
}

class _BookingEventSignupState extends State<BookingEventSignup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(children: [
          Image.asset('images/onboarding.png'),
          SizedBox(
            height: 10,
          ),
          Text(
            'Unlock then Future of ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Event Booking APP ',
            style: TextStyle(
              color: Color(0xff6351ec),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Discover, book, and experience unforgettable moments efforetlssly! ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                color: Color(0xff6351ec),
                borderRadius: BorderRadius.circular(20)),

            //Google Icon
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/google.png',
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 20),
                Text(
                  'Sign in with Google,',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
