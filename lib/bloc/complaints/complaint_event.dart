import 'package:test_app/models/complaint_model.dart';

abstract class ComplaintEvent {}

class LoadComplaints extends ComplaintEvent {}

class AddComplaint extends ComplaintEvent {
  final Complaint complaint;
  AddComplaint(this.complaint);
}

class SearchComplaint extends ComplaintEvent {
  final int complaintId;
  SearchComplaint(this.complaintId);
}

class UpdateComplaint extends ComplaintEvent {
  final int complaintId;
  final int statusId;
  final String comment;

  UpdateComplaint({required this.complaintId, required this.statusId, required this.comment});
}

