import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/bloc/complaints/complaint_bloc.dart';
import 'package:test_app/bloc/complaints/complaint_event.dart';
import 'package:test_app/bloc/complaints/complaint_state.dart';
import 'package:test_app/models/complaint_model.dart';
import 'package:test_app/utils/constants.dart';

class ComplaintCrudScreen extends StatefulWidget {
  final String userName;
  final Complaint? complaints;

  const ComplaintCrudScreen(
      {super.key, required this.userName, required this.complaints});

  @override
  State<ComplaintCrudScreen> createState() => _ComplaintCrudScreenState();
}

class _ComplaintCrudScreenState extends State<ComplaintCrudScreen> {
  // final TextEditingController _categoryController = TextEditingController();

  // final TextEditingController _descriptionController = TextEditingController();
  late TextEditingController _categoryController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    // If complaint is not null, initialize the controllers with existing values
    _categoryController = TextEditingController(
      text: widget.complaints?.complaintType ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.complaints?.complaintDescription ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 120),
                height: 50,
                width: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  "New Complaint",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              )
            ],
          ),
          const SizedBox(height: 35),
          TextField(
            controller: _categoryController,
            decoration: InputDecoration(
              labelText: "Complaint Category",
              hintText: "Payment, Food Quality, etc.",
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              labelStyle: const TextStyle(fontSize: 16, color: Colors.black),
              enabledBorder: textFieldBorder,
              focusedBorder: textFieldBorder,
              border: textFieldBorder,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: "Details",
              hintText: "write your complaint...",
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              labelStyle: const TextStyle(fontSize: 16, color: Colors.black),
              enabledBorder: textFieldBorder,
              focusedBorder: textFieldBorder,
              border: textFieldBorder,
            ),
            maxLines: 5,
          ),
          const SizedBox(height: 16),
          const Text("Attachments"),
          const SizedBox(height: 16),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.add,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(400, 50),
              backgroundColor: primaryColor,
            ),
            onPressed: () {
              // Fetch current complaints list
              final currentState = context.read<ComplaintBloc>().state;
              int newComplaintId = 1;

              if (currentState is ComplaintLoaded &&
                  currentState.complaints.isNotEmpty) {
                // Set new complaint id based on the current length of the list
                newComplaintId = currentState.complaints.length + 1;
              }
              if (widget.complaints != null) {
                print("updating new complaint");

                // Update existing complaint
                final updatedComplaint = widget.complaints!.copyWith(
                  complaintType: _categoryController.text,
                  complaintDescription: _descriptionController.text,
                );
                context.read<ComplaintBloc>().add(UpdateComplaint(
                      complaintId: updatedComplaint.complaintId,
                      statusId: updatedComplaint.statusId,
                      comment: updatedComplaint.complaintDescription,
                    ));
                Navigator.pop(context);
              } else {
                final complaint = Complaint(
                  complaintId: newComplaintId,
                  complaintNo: "$newComplaintId",
                  complaintFrom: widget.userName,
                  complaintTypeId: newComplaintId,
                  complaintDescription: _descriptionController.text,
                  statusId: 1,
                  chefId: 3,
                  userId: 1,
                  status: "Pending",
                  restaurantName: widget.userName,
                  customerName: widget.userName,
                  complaintType: _categoryController.text,
                  createdDateString: DateTime.now().toString(),
                );

                context.read<ComplaintBloc>().add(AddComplaint(complaint));
                Navigator.pop(context);
              }
            },
            child: Text(
              widget.complaints != null ? "Update" : "Submit",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
