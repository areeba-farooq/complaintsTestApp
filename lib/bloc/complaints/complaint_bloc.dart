import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/bloc/complaints/complaint_event.dart';
import 'package:test_app/bloc/complaints/complaint_state.dart';
import 'package:test_app/models/complaint_model.dart';
import 'package:test_app/services/complaint_service.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  final ComplaintService complaintService;
  @override
  ComplaintState get initialState => ComplaintLoaded([]);

  ComplaintBloc(this.complaintService) : super(ComplaintLoading()) {
    on<LoadComplaints>((event, emit) async {
      emit(ComplaintLoading());
      try {
        final complaints = await complaintService.fetchComplaints();

        emit(ComplaintLoaded(complaints));
      } catch (error) {
        emit(ComplaintError("Failed to load complaints: $error"));
      }
    });

    on<AddComplaint>((event, emit) async {
      try {
        await complaintService.addComplaint(event.complaint);
        final currentState = state;
        if (currentState is ComplaintLoaded) {
          final updatedComplaints =
              List<Complaint>.from(currentState.complaints);
          updatedComplaints.insert(0, event.complaint);
          emit(ComplaintLoaded(updatedComplaints));
        }
      } catch (error) {
        emit(ComplaintError("Failed to add complaint: $error"));
      }
    });

    on<SearchComplaint>((event, emit) async {
      emit(ComplaintLoading());
      try {
        final complaints =
            await complaintService.fetchComplaintById(event.complaintId);
        emit(ComplaintLoaded(complaints));
      } catch (error) {
        emit(ComplaintError("Failed to search complaints: $error"));
      }
    });

    //updateComplaint
    on<UpdateComplaint>((event, emit) async {
      try {
        final response = await complaintService.updateComplaint(
          complaintId: event.complaintId,
          statusId: event.statusId,
          comment: event.comment,
        );
        if (response) {
          final currentState = state;
          if (currentState is ComplaintLoaded) {
            final updatedComplaints = currentState.complaints.map((complaint) {
              if (complaint.complaintId == event.complaintId) {
                return complaint.copyWith(
                  statusId: event.statusId,
                  complaintDescription: event.comment,
                );
              }
              return complaint;
            }).toList();

            emit(ComplaintLoaded(updatedComplaints));
          }
        }
      } catch (error) {
        emit(ComplaintError("Failed to update complaint: $error"));
      }
    });
  }
}
