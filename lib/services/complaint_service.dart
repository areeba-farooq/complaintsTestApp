import 'dart:convert';

import 'package:test_app/models/complaint_model.dart';
import 'package:test_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ComplaintService {
  //Fetch List of Complaints Data
  Future<List<Complaint>> fetchComplaints() async {
    final response = await http.get(Uri.parse(
        "$baseURL/Complaint/GetComplaints?ComplaintId=-1&ChefId=$chefID&UserId=$userID&StatusId=$statusID&ComplaintTypeId=-1&FromComplaint=chef"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final List complaintsJson = body['data'];
      return complaintsJson.map((json) => Complaint.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load complaints');
    }
  }

//Add Complaint
  Future<void> addComplaint(Complaint complaint) async {
    final response = await http.post(
      Uri.parse('$baseURL/Complaint/AddComplaint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'ComplaintFrom': complaint.complaintFrom,
        'ComplaintTypeId': complaint.complaintTypeId,
        'ComplaintDescription': complaint.complaintDescription,
      }),
    );

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to add complaint');
    }
  }

//search by id
  Future<List<Complaint>> fetchComplaintById(int complaintId) async {
    final response = await http.get(Uri.parse(
        '$baseURL/Complaint/GetComplaints?ComplaintId=$complaintId&ChefId=$chefID&UserId=$userID&StatusId=$statusID&ComplaintTypeId=-1&FromComplaint=chef'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final List complaintsJson = body['data'];
      return complaintsJson.map((json) => Complaint.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load complaint by ID');
    }
  }

//update complaint
  Future<bool> updateComplaint({
    required int complaintId,
    required int statusId,
    required String comment,
  }) async {
    final response = await http.patch(
      Uri.parse(
          '$baseURL/UpdateComplaint?ComplaintId=$complaintId&StatusId=$statusId&Comment=$comment'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      return body['apiStatusCode'] == 200;
    } else {
      throw Exception('Failed to update complaint');
    }
  }
}
