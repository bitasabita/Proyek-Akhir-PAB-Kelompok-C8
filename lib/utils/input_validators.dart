import 'package:flutter/services.dart';

class InputValidators {
  static const int maxProductPrice = 100000;
  static const int maxStock = 3000;

  static String normalizeText(String value) {
    return value.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  static String stripCurrencyFormatting(String? value) {
    return (value ?? '').replaceAll('.', '').trim();
  }

  static bool containsEmoji(String value) {
    final emojiRegex = RegExp(
      r'[\u{1F300}-\u{1FAFF}\u{2600}-\u{27BF}]',
      unicode: true,
    );
    return emojiRegex.hasMatch(value);
  }

  static bool hasLetter(String value) {
    return RegExp(r'[A-Za-z]').hasMatch(value);
  }

  static bool hasDigit(String value) {
    return RegExp(r'\d').hasMatch(value);
  }

  static String? validateName(String? value, {String label = 'Nama'}) {
    final raw = value ?? '';
    final text = normalizeText(raw);

    if (text.isEmpty) {
      return '$label wajib diisi';
    }

    if (text.length < 2) {
      return '$label minimal 2 karakter';
    }

    if (containsEmoji(text)) {
      return '$label tidak boleh memakai emoji';
    }

    if (RegExp(r'[^A-Za-z0-9\s]').hasMatch(text)) {
      return '$label hanya boleh huruf, angka, dan spasi';
    }

    if (!hasLetter(text)) {
      return '$label tidak boleh angka semua';
    }

    return null;
  }

  static String? validateEmployeeName(String? value) {
    final raw = value ?? '';
    final text = normalizeText(raw);

    if (text.isEmpty) {
      return 'Nama karyawan wajib diisi';
    }

    if (text.length < 2) {
      return 'Nama karyawan minimal 2 karakter';
    }

    if (containsEmoji(text)) {
      return 'Nama karyawan tidak boleh memakai emoji';
    }

    if (RegExp(r'[^A-Za-z\s]').hasMatch(text)) {
      return 'Nama karyawan hanya boleh huruf dan spasi';
    }

    return null;
  }

  static String? validateCustomerName(String? value) {
    final raw = value ?? '';
    final text = normalizeText(raw);

    if (text.isEmpty) {
      return 'Nama pelanggan wajib diisi';
    }

    if (text.length < 2) {
      return 'Nama pelanggan minimal 2 karakter';
    }

    if (containsEmoji(text)) {
      return 'Nama pelanggan tidak boleh memakai emoji';
    }

    if (RegExp(r'[^A-Za-z0-9\s]').hasMatch(text)) {
      return 'Nama pelanggan hanya boleh huruf, angka, dan spasi';
    }

    if (!hasLetter(text)) {
      return 'Nama pelanggan tidak boleh angka semua';
    }

    return null;
  }

  static String? validateProductName(String? value) {
    final raw = value ?? '';
    final text = normalizeText(raw);

    if (text.isEmpty) {
      return 'Nama produk wajib diisi';
    }

    if (text.length < 2) {
      return 'Nama produk minimal 2 karakter';
    }

    if (containsEmoji(text)) {
      return 'Nama produk tidak boleh memakai emoji';
    }

    if (RegExp(r'[^A-Za-z0-9\s]').hasMatch(text)) {
      return 'Nama produk hanya boleh huruf, angka, dan spasi';
    }

    if (!hasLetter(text)) {
      return 'Nama produk tidak boleh angka semua';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    final text = (value ?? '').trim();

    if (text.isEmpty) {
      return 'Email wajib diisi';
    }

    if (containsEmoji(text)) {
      return 'Email tidak boleh memakai emoji';
    }

    final validPattern = RegExp(
      r'^[A-Za-z0-9._\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$',
    );

    if (!validPattern.hasMatch(text)) {
      return 'Format email tidak valid';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    final text = (value ?? '').trim();

    if (text.isEmpty) {
      return 'Password wajib diisi';
    }

    if (containsEmoji(text)) {
      return 'Password tidak boleh memakai emoji';
    }

    if (RegExp(r'[^A-Za-z0-9]').hasMatch(text)) {
      return 'Password hanya boleh huruf dan angka';
    }

    if (text.length < 6) {
      return 'Password minimal 6 karakter';
    }

    if (!hasLetter(text) || !hasDigit(text)) {
      return 'Password harus campuran huruf dan angka';
    }

    final uniqueChars = text.split('').toSet().length;
    if (uniqueChars < 2) {
      return 'Password harus terdiri dari karakter yang berbeda';
    }

    return null;
  }

  static String? validatePositivePrice(
    String? value, {
    String label = 'Harga',
  }) {
    final text = stripCurrencyFormatting(value);

    if (text.isEmpty) {
      return '$label wajib diisi';
    }

    if (!RegExp(r'^\d+$').hasMatch(text)) {
      return '$label harus berupa angka';
    }

    final number = int.tryParse(text);
    if (number == null) {
      return '$label tidak valid';
    }

    if (number <= 0) {
      return '$label harus lebih dari 0';
    }

    if (number > maxProductPrice) {
      return '$label maksimal Rp100.000';
    }

    return null;
  }

  static String? validateCostPriceNotGreaterThanPrice({
    required String? priceValue,
    required String? costPriceValue,
  }) {
    final cleanedPrice = stripCurrencyFormatting(priceValue);
    final cleanedCostPrice = stripCurrencyFormatting(costPriceValue);

    if (cleanedPrice.isEmpty || cleanedCostPrice.isEmpty) {
      return null;
    }

    final price = int.tryParse(cleanedPrice);
    final costPrice = int.tryParse(cleanedCostPrice);

    if (price == null || costPrice == null) {
      return null;
    }

    if (costPrice > price) {
      return 'Harga modal tidak boleh lebih besar dari harga jual';
    }

    return null;
  }

  static String? validateStock(String? value) {
    final text = (value ?? '').trim();

    if (text.isEmpty) {
      return 'Stok wajib diisi';
    }

    if (!RegExp(r'^\d+$').hasMatch(text)) {
      return 'Stok harus berupa angka';
    }

    final stock = int.tryParse(text);
    if (stock == null) {
      return 'Stok tidak valid';
    }

    if (stock < 0) {
      return 'Stok tidak boleh negatif';
    }

    if (stock > maxStock) {
      return 'Stok maksimal 3000';
    }

    return null;
  }

  static List<TextInputFormatter> productNameInputFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9 ]')),
    ];
  }

  static List<TextInputFormatter> employeeNameInputFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z ]')),
    ];
  }

  static List<TextInputFormatter> customerNameInputFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9 ]')),
    ];
  }

  static List<TextInputFormatter> emailInputFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9@._-]')),
    ];
  }

  static List<TextInputFormatter> passwordInputFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
    ];
  }

  static List<TextInputFormatter> stockInputFormatters() {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(4),
      _MaxValueInputFormatter(maxStock),
    ];
  }

  static List<TextInputFormatter> priceInputFormatters() {
    return [
      FilteringTextInputFormatter.digitsOnly,
      _MaxValueInputFormatter(maxProductPrice),
    ];
  }
}

class _MaxValueInputFormatter extends TextInputFormatter {
  final int maxValue;

  _MaxValueInputFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    final rawValue = newValue.text.replaceAll('.', '');
    final value = int.tryParse(rawValue);

    if (value == null) return oldValue;
    if (value > maxValue) return oldValue;

    return newValue;
  }
}