import 'package:wtfc_provider_app/export.dart';

class EventBookingDetailPage extends StatefulWidget {
  const EventBookingDetailPage({super.key});

  @override
  State<EventBookingDetailPage> createState() => _EventBookingDetailPageState();
}

class _EventBookingDetailPageState extends State<EventBookingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'images/event.jpg',
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  //bring the event title down below the pictures
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //back icon
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(top: 40, left: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(color: Colors.black54),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dua Lipa Concert',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.calendar_month, color: Colors.white),
                                SizedBox(width: 5),
                                Text(
                                  '32 March 2025',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.location_on_outlined,
                                    color: Colors.white),
                                SizedBox(width: 5),
                                Text(
                                  'Mumbaio, India',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'About Event',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus viverra, nibh at pretium aliquet, nunc massa rhoncus mi, at malesuada lectus justo vestibulum erat. Donec cursus sit amet risus eget dictum. Maecenas pharetra dolor in iaculis gravida. Ut pharetra metus id libero molestie pretium. Vivamus semper odio elementum dictum tincidunt. Nam blandit, tellus quis interdum porta, ex arcu venenatis elit, vel lacinia dolor mauris et eros. ',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Number of Tickets',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    children: [
                      //TODO: Can convert this to icon
                      Text(
                        '+',
                        style: TextStyle(color: Colors.black, fontSize: 25.0),
                      ),
                      Text(
                        '3',
                        style:
                            TextStyle(color: Color(0xff6351ec), fontSize: 25),
                      ),
                      Text(
                        '-',
                        style: TextStyle(color: Colors.black, fontSize: 25.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Amount: \$150',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff6351ec)),
                  ),
                  Container(
                    width: 175,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff6351ec),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Book Now',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
