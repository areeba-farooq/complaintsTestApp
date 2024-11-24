import 'package:test_app/models/complaint_model.dart';

abstract class ComplaintState {}

class ComplaintLoading extends ComplaintState {}

class ComplaintLoaded extends ComplaintState {
  final List<Complaint> complaints;
  ComplaintLoaded(this.complaints);
}

class ComplaintError extends ComplaintState {
  final String message;
  ComplaintError(this.message);
}
