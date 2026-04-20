import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/app_user_model.dart';
import '../services/user_service.dart';
import '../theme/app_colors.dart';
import '../utils/input_validators.dart';
import 'add_employee_page.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final UserService _userService = UserService();
  final TextEditingController searchController = TextEditingController();

  List<AppUserModel> employees = [];
  List<AppUserModel> filteredEmployees = [];
  bool isLoading = true;
  bool isCheckingAccess = true;

  @override
  void initState() {
    super.initState();
    _checkAccessAndLoad();
    searchController.addListener(filterEmployees);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _checkAccessAndLoad() async {
    try {
      final client = Supabase.instance.client;
      final user = client.auth.currentUser;

      if (user == null) {
        if (!mounted) return;
        Navigator.pop(context);
        return;
      }

      final profileById = await client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      final profile = profileById ??
          await client
              .from('profiles')
              .select()
              .eq('email', user.email ?? '')
              .maybeSingle();

      final role = (profile?['role'] ?? '').toString();

      if (!mounted) return;

      if (role != 'owner') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Hanya owner yang bisa mengakses halaman ini'),
          ),
        );
        Navigator.pop(context);
        return;
      }

      await fetchEmployees();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memeriksa akses: $e')),
      );
      Navigator.pop(context);
    } finally {
      if (mounted) {
        setState(() => isCheckingAccess = false);
      }
    }
  }

  Future<void> fetchEmployees() async {
    setState(() => isLoading = true);
    try {
      employees = await _userService.getEmployees();
      filteredEmployees = employees;
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil data karyawan: $e')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void filterEmployees() {
    final query = searchController.text.toLowerCase().trim();

    setState(() {
      filteredEmployees = employees.where((employee) {
        return employee.name.toLowerCase().contains(query) ||
            employee.email.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> goToAddEmployeePage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddEmployeePage()),
    );

    if (result == true) {
      await fetchEmployees();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Karyawan berhasil ditambahkan'),
        ),
      );
    }
  }

  Future<void> editEmployeeDialog(AppUserModel employee) async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: employee.name);
    final emailController = TextEditingController(text: employee.email);
    bool isSaving = false;

    await showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setModalState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text('Edit Karyawan'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  inputFormatters: InputValidators.employeeNameInputFormatters(),
                  validator: InputValidators.validateEmployeeName,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    hintText: 'Hanya huruf dan spasi',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: emailController,
                  inputFormatters: InputValidators.emailInputFormatters(),
                  validator: InputValidators.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Contoh: nama123@gmail.com',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isSaving ? null : () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: isSaving
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      final isValid = formKey.currentState?.validate() ?? false;
                      if (!isValid) return;

                      final isConfirmed = await showDialog<bool>(
                        context: dialogContext,
                        builder: (confirmContext) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          title: const Text('Konfirmasi'),
                          content: Text(
                            'Apakah Anda ingin mengedit karyawan ${employee.name}?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(confirmContext, false),
                              child: const Text('Batal'),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  Navigator.pop(confirmContext, true),
                              child: const Text('Ya'),
                            ),
                          ],
                        ),
                      );

                      if (isConfirmed != true) return;

                      setModalState(() => isSaving = true);

                      try {
                        await _userService.updateEmployee(
                          id: employee.id,
                          name: InputValidators.normalizeText(
                            nameController.text,
                          ),
                          email: emailController.text.trim(),
                        );

                        if (!mounted) return;
                        Navigator.pop(dialogContext);
                        await fetchEmployees();

                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Data berhasil diupdate'),
                          ),
                        );
                      } catch (e) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Gagal memperbarui data karyawan: $e'),
                          ),
                        );
                      } finally {
                        if (dialogContext.mounted) {
                          setModalState(() => isSaving = false);
                        }
                      }
                    },
              child: isSaving
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteEmployee(String id) async {
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: const Text('Hapus Karyawan'),
        content: const Text(
          'Yakin ingin menghapus data karyawan ini? Akun login karyawan juga akan ikut dihapus.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);

              try {
                await _userService.deleteEmployee(id);
                await fetchEmployees();

                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Karyawan berhasil dihapus'),
                  ),
                );
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Gagal menghapus karyawan: $e'),
                  ),
                );
              }
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  Widget _headerCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            blurRadius: 18,
            color: AppColors.shadow,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kelola Karyawan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tambahkan, ubah, dan hapus akun karyawan.',
            style: TextStyle(
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBox() {
    return TextField(
      controller: searchController,
      decoration: const InputDecoration(
        hintText: 'Cari nama atau email karyawan',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget _employeeCard(AppUserModel e) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: AppColors.shadow,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.person_outline,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  e.email,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => editEmployeeDialog(e),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () => deleteEmployee(e.id),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.people_outline,
            size: 72,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 14),
          Text(
            'Tidak ada data karyawan',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isCheckingAccess) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Karyawan'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: goToAddEmployeePage,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: fetchEmployees,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _headerCard(),
            const SizedBox(height: 16),
            _searchBox(),
            const SizedBox(height: 16),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (filteredEmployees.isEmpty)
              _emptyState()
            else
              ...filteredEmployees.map(_employeeCard),
          ],
        ),
      ),
    );
  }
}