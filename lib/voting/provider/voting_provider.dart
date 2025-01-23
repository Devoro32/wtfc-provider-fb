import 'dart:async';

import 'package:wtfc_provider_app/export.dart';

class VotingProvider with ChangeNotifier {
  List<Candidate> _candidateList = [
    Candidate(id: '1', name: 'Candidate 1'),
    Candidate(id: '2', name: 'Candidate 2'),
    Candidate(id: '3', name: 'Candidate 3'),
    Candidate(id: '4', name: 'Candidate 4'),
  ];

  String? selectedCandidateId;

//getter for candiate
  List<Candidate> get candidates => _candidateList;

  //
  void vote(String candidatesId) {
    //go through the candidate via map and see if it matches the input canidates list

    _candidateList = _candidateList.map((candidates) {
      if (candidates.id == candidatesId) {
        candidates.votes += 1;
      }
      return candidates;
    }).toList();

    selectedCandidateId = candidatesId;
    print('In provider selected candidate: ${selectedCandidateId}');
    notifyListeners();
    Timer(const Duration(seconds: 1), () {
      selectedCandidateId = null;
      notifyListeners();
    });
  }

  List<Candidate> get winners {
    if (_candidateList.isEmpty) return [];

//use this to find the highest counts of the values
    int highestVotes =
        _candidateList.map((c) => c.votes).reduce((a, b) => a > b ? a : b);

    if (highestVotes == 0) return [];

    List<Candidate> topCandidates =
        _candidateList.where((c) => c.votes == highestVotes).toList();

    return topCandidates;
  }

//check if the winner list is greater than 1, which indicates a tie
  bool get isTie => winners.length > 1;
}
