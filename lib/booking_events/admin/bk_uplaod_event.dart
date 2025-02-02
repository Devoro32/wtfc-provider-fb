import 'package:flutter/foundation.dart';
import 'package:wtfc_provider_app/export.dart';

class BKUploadEvent extends StatefulWidget {
  const BKUploadEvent({super.key});

  @override
  State<BKUploadEvent> createState() => _BKUploadEventState();
}

class _BKUploadEventState extends State<BKUploadEvent> {
  final List<String> eventcategory = ['Music', 'Food', 'Clothing', 'Festival'];
  String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(top: 40, left: 20.0, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios_new_outlined)),
              SizedBox(
                width: MediaQuery.of(context).size.width / 4.0,
              ),
              const Text(
                'Upload Event',
                style: TextStyle(
                  color: Color(0xff6251ec),
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black54,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.camera_alt_outlined),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Event Name',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0xffececf8),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter event name',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Ticket Price',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0xffececf8),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter ticket price',
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Select Category',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xffececf8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                items: eventcategory
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: ((value) => setState(() {
                      this.value = value;
                    })),
                dropdownColor: Colors.white,
                hint: const Text('Slect category'),
                iconSize: 36,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
                value: value,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Event Detail:',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0xffececf8),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              maxLines: 6,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter event information',
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff6351ec),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50,
              width: 200,
              child: Center(
                child: Text(
                  'Upload',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
