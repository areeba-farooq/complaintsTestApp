import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/bloc/complaints/complaint_bloc.dart';
import 'package:test_app/bloc/complaints/complaint_event.dart';
import 'package:test_app/bloc/complaints/complaint_state.dart';
import 'package:test_app/models/complaint_model.dart';
import 'package:test_app/utils/constants.dart';
import 'package:test_app/utils/widgets/complaint_card.dart';
import 'package:test_app/utils/widgets/complaint_crud.dart';

class ComplaintListScreen extends StatefulWidget {
  final String userName;
  const ComplaintListScreen({super.key, required this.userName});

  @override
  State<ComplaintListScreen> createState() => _ComplaintListScreenState();
}

class _ComplaintListScreenState extends State<ComplaintListScreen> {
  String searchQuery = "";
  String sortBy = "";
  final Complaint complaint = Complaint(
    complaintId: 0,
    complaintNo: "",
    complaintFrom: "",
    complaintTypeId: 0,
    complaintDescription: "",
    statusId: 0,
    chefId: 0,
    userId: 0,
    status: "",
    restaurantName: "",
    customerName: "",
    complaintType: "",
    createdDateString: DateTime.now().toString(),
  );

  @override
  void initState() {
    super.initState();
    // Trigger the LoadComplaints event when the screen is initialized
    context.read<ComplaintBloc>().add(LoadComplaints());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(300),
          child: Container(
            height: 500,
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(70),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  // Heading
                  const Positioned(
                    top: 40,
                    child: Column(
                      children: [
                        Text(
                          "Create your ",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        Text(
                          "Complaints",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Have something to rant about?",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Search bar
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        onChanged: (query) {
                          setState(() {
                            searchQuery = query;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Search...",
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Positioned(
                    top: 90,
                    right: 20,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 3),
                            color: Colors.black38,
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => ComplaintCrudScreen(
                              userName: widget.userName,
                              complaints: null,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 20.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: DropdownButton<String>(
                  value: sortBy.isEmpty ? null : sortBy,
                  hint: const Text(
                    "Sort by",
                    style: TextStyle(color: primaryColor),
                  ),
                  style: const TextStyle(color: primaryColor),
                  items: const [
                    DropdownMenuItem(
                        value: "date", child: Text("Sort by Date")),
                    DropdownMenuItem(
                        value: "status", child: Text("Sort by Status")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      sortBy = value ?? "";
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ComplaintBloc, ComplaintState>(
                builder: (context, state) {
                  if (state is ComplaintLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: primaryColor,
                    ));
                  } else if (state is ComplaintLoaded) {
                    List<Complaint> filteredComplaints = state.complaints
                        .where((complaint) =>
                            complaint.complaintNo.contains(searchQuery))
                        .toList();
                    if (sortBy == "date") {
                      filteredComplaints.sort((a, b) => a.createdDateString
                          .compareTo(b.createdDateString)); // Sort by date
                    } else if (sortBy == "status") {
                      filteredComplaints.sort((a, b) =>
                          a.status!.compareTo(b.status!)); // Sort by status
                    }

                    return ListView.builder(
                      itemCount: filteredComplaints.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ComplaintCard(
                            complaint: filteredComplaints[index],
                            userName: widget.userName,
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: Text("No Complaints"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
