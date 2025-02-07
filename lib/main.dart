import 'package:wtfc_provider_app/export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //use for firebase login
  await Firebase.initializeApp();
  //use for the file storage app
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //?Habit Tracker
        ChangeNotifierProvider(
          create: (_) => HabitProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => expTrackerTractionProvider(),
        ),

        //?Voting
        ChangeNotifierProvider(
          create: (_) => VotingProvider(),
        ),

        //?Recipe
        ChangeNotifierProvider(
          create: (_) => RecipeFavoriteProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RecipeQuantityProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Provider Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //!file storage app
        routes: {
          '/': (context) => const SGCheckUserState(),
          '/home': (context) => const MainHomePage(),
          '/loginform': (context) => const SGLoginPage(),
          '/signupform': (context) => const SGSignUpPage(),
          '/voting': (context) => const VotingScreen(),
          '/recipe': (context) => const RecipeAppMainView(),
          '/habittracker': (context) => const HabitListScreen(),
          '/filestorage': (context) => const FileStorageHome(),
          '/fsupload': (context) => const FSUploadArea(),
          '/bookingevent': (context) => const EventBottomNav(),
          '/expensetracker': (context) => const ExpenseTrackerScreen(),
          '/signout': (context) => const AuthHomeScreen(),
        },
        // home: StreamBuilder(
        //     stream: FirebaseAuth.instance.authStateChanges(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         return const AuthHomeScreen();
        //       } else {
        //         return const SignInScreen();
        //       }
        //     })

        // const SignupScreen(),

        //const BookingEventSignup(),
        // EventBookingDetailPage(),
        // home: const EventBottomNav(),
        //!Recipe App
        // const RecipeAppMainView(),
      ),
    );
  }
}

class SGCheckUserState extends StatefulWidget {
  const SGCheckUserState({super.key});

  @override
  State<SGCheckUserState> createState() => _SGCheckUserStateState();
}

class _SGCheckUserStateState extends State<SGCheckUserState> {
  @override
  void initState() {
    AuthServices().isLoggedin().then((value) {
      print('Is user login: ${value}');
      if (value) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/loginform');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CircularProgressIndicator(),
    );
  }
}
