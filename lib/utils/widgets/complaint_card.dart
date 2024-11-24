import 'package:flutter/material.dart';
import 'package:test_app/models/complaint_model.dart';
import 'package:test_app/utils/constants.dart';
import 'package:test_app/utils/widgets/complaint_crud.dart';

class ComplaintCard extends StatelessWidget {
  final Complaint complaint;
  final String userName;

  const ComplaintCard({super.key, required this.complaint, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Complaint ID and Status
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Complaint Number",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        "#${complaint.complaintId}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 35,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      complaint.status!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Restaurant Name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.roofing_rounded,
                        color: primaryColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        complaint.restaurantName,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: primaryColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 100,
                        height: 20,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            complaint.createdDateString,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Created Date and Time
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Complaint Description",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Description
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                complaint.complaintDescription,
                style: const TextStyle(
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
            ),
         
          if (complaint.restaurantName == userName)
            Align(
                alignment: Alignment.centerRight,
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
                            builder: (context) =>
                                ComplaintCrudScreen(userName: userName,
                                complaints: complaint,
                                ),
                          );
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
