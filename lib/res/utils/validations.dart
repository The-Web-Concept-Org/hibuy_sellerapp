class KycValidator {
  static String? validate(String field, String? value) {
    if (value == null || value.isEmpty) {
      return "$field is required";
    }

    switch (field) {
      // -------------------- PERSONAL INFO --------------------
      case "personal_status":
        if (!_inList(value, ["pending", "approved", "rejected"])) {
          return "Invalid status";
        }
        break;

      case "personal_full_name":
        if (value.length > 255) return "Full name too long";
        break;

      case "personal_address":
        if (value.length > 500) return "Address too long";
        break;

      case "personal_phone_no":
        if (!_isNumeric(value) || value.length < 8 || value.length > 15) {
          return "Invalid phone number";
        }
        break;

      case "personal_email":
        if (!_isValidEmail(value)) return "Invalid email";
        break;

      case "personal_cnic":
        if (!_isNumeric(value) || value.length < 8 || value.length > 15) return "Invalid CNIC";
        break;

      // -------------------- STORE INFO --------------------
      case "store_status":
        if (!_inList(value, ["pending", "approved", "rejected"])) {
          return "Invalid store status";
        }
        break;

      case "store_type":
        if (!_inList(value, ["Retail", "Wholesale"])) {
          return "Invalid store type";
        }
        break;

      case "store_phone_no":
        if (!_isNumeric(value) || value.length < 8 || value.length > 15) {
          return "Invalid store phone number";
        }
        break;

      case "store_email":
        if (!_isValidEmail(value)) return "Invalid store email";
        break;

      case "store_zip_code":
        if (value.length > 10) return "Invalid zip code";
        break;

      case "store_address":
        if (value.length > 500) return "Address too long";
        break;

      case "store_pin_location":
        if (!_isLatLong(value)) return "Invalid coordinates";
        break;

      // -------------------- DOCUMENTS --------------------
      case "documents_status":
        if (!_inList(value, ["pending", "approved", "rejected"])) {
          return "Invalid documents status";
        }
        break;

      case "documents_country":
      case "documents_province":
      case "documents_city":
        if (value.length > 100) return "Too long";
        break;

      case "documents_file":
      case "cnic_front_image":
      case "cnic_back_image":
      case "store_license_image":
        if (!_isValidImageFile(value)) {
          return "Invalid or unsupported file type (only JPG, PNG, PDF allowed)";
        }
        break;

      // -------------------- BANK --------------------
      case "bank_status":
        if (!_inList(value, ["pending", "approved", "rejected"])) {
          return "Invalid bank status";
        }
        break;

      case "bank_account_type":
        if (!_inList(value, ["savings", "current"])) {
          return "Invalid account type";
        }
        break;

      case "bank_branch_phone":
        if (!_isNumeric(value) || value.length < 8 || value.length > 15) {
          return "Invalid branch phone number";
        }
        break;

      case "bank_account_title":
        if (value.length > 255) return "Title too long";
        break;

      case "bank_account_no":
      case "bank_iban_no":
        if (value.length > 50) return "Invalid number";
        break;

      // -------------------- BUSINESS --------------------
      case "business_status":
        if (!_inList(value, ["pending", "approved", "rejected"])) {
          return "Invalid business status";
        }
        break;

      case "business_business_name":
      case "business_owner_name":
        if (value.length > 255) return "Too long";
        break;

      case "business_phone_no":
        if (!_isNumeric(value) || value.length < 8 || value.length > 15) {
          return "Invalid phone number";
        }
        break;

      case "business_reg_no":
      case "business_tax_no":
        if (value.length > 100) return "Invalid number";
        break;

      case "business_address":
        if (value.length > 500) return "Address too long";
        break;

      case "business_pin_location":
        if (!_isLatLong(value)) return "Invalid coordinates";
        break;
    }

    return null; // ✅ Pass
  }

  // -------------------- HELPERS --------------------
  static bool _isNumeric(String s) => RegExp(r'^[0-9]+$').hasMatch(s);

  static bool _isValidEmail(String s) =>
      RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(s);

  static bool _isLatLong(String s) =>
      RegExp(r'^-?\d{1,2}(\.\d+)?,\s*-?\d{1,3}(\.\d+)?$').hasMatch(s);

  static bool _inList(String s, List<String> allowed) =>
      allowed.contains(s.toLowerCase());

  static bool _isValidImageFile(String s) {
    final allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf'];
    final ext = s.split('.').last.toLowerCase();
    return allowedExtensions.contains(ext);
  }
}
