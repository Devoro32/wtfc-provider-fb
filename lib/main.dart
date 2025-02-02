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
          '/': (context) => const SGLoginPage(),
          //(context) => const FileStorageHome(),
          '/fsupload': (context) => const FSUploadArea(),
          '/loginform': (context) => const SGLoginPage(),
          '/signupform': (context) => const SGSignUpPage(),
          '/voting': (context) => const VotingScreen(),
          '/recipe': (context) => const RecipeAppMainView(),
          '/habittracker': (context) => const HabitListScreen(),
          '/filestorage': (context) => const FileStorageHome(),
          '/bookingevent': (context) => const EventBottomNav(),
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
