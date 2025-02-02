import 'package:wtfc_provider_app/export.dart';

class EventBottomNav extends StatefulWidget {
  const EventBottomNav({super.key});

  @override
  State<EventBottomNav> createState() => _EventBottomNavState();
}

class _EventBottomNavState extends State<EventBottomNav> {
  late List<Widget> pages;
  late EventBooking eventBooking;
  late EventBookingProfile eventBookingProfile;
  late EventBookingMainView eventBookingMainView;
  int currentEventTabIndex = 0;

  @override
  void initState() {
    eventBooking = const EventBooking();
    eventBookingProfile = const EventBookingProfile();
    eventBookingMainView = const EventBookingMainView();

    //? This needs to be the same order as the icons within the 'item' section
    pages = [eventBookingMainView, eventBooking, eventBookingProfile];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentEventTabIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.book,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.person_outline,
            color: Colors.white,
            size: 30,
          )
        ],
      ),
      body: pages[currentEventTabIndex],
    );
  }
}
