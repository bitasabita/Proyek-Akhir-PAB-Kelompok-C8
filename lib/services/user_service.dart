import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/app_user_model.dart';

class UserService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<AppUserModel>> getEmployees() async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('role', 'employee')
        .order('created_at', ascending: false);

    return (response as List)
        .map((e) => AppUserModel.fromJson(e))
        .toList();
  }

  Future<void> updateEmployee({
    required String id,
    required String name,
    required String email,
  }) async {
    final session = _client.auth.currentSession;
    final accessToken = session?.accessToken;

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Sesi login tidak ditemukan. Silakan login ulang.');
    }

    final response = await _client.functions.invoke(
      'update-employee',
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      body: {
        'employee_id': id,
        'name': name,
        'email': email,
      },
    );

    if (response.status != 200) {
      final data = response.data;

      if (data is Map && data['error'] != null) {
        throw Exception(data['error']);
      }

      throw Exception('Gagal memperbarui data karyawan');
    }
  }

  Future<void> deleteEmployee(String employeeId) async {
    final session = _client.auth.currentSession;
    final accessToken = session?.accessToken;

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Sesi login tidak ditemukan. Silakan login ulang.');
    }

    final response = await _client.functions.invoke(
      'delete-employee',
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      body: {
        'employee_id': employeeId,
      },
    );

    if (response.status != 200) {
      final data = response.data;

      if (data is Map && data['error'] != null) {
        throw Exception(data['error']);
      }

      throw Exception('Gagal menghapus karyawan');
    }
  }
}