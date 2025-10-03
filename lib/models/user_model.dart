class UserModel {
  bool? success;
  String? message;
  String? accessToken;
  User? user;
  List<StepModel>? steps;
  String? kycApprovedStatus;

  UserModel({
    this.success,
    this.message,
    this.accessToken,
    this.user,
    this.steps,
    this.kycApprovedStatus,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    accessToken = json['access_token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['steps'] != null) {
      steps = <StepModel>[];
      json['steps'].forEach((v) {
        // Handle if v is an integer directly
        if (v is int) {
          steps!.add(StepModel(stepName: v));
        } else if (v is Map<String, dynamic>) {
          steps!.add(StepModel.fromJson(v));
        }
      });
    }
    kycApprovedStatus = json['kyc_approved_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['access_token'] = this.accessToken;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.steps != null) {
      data['steps'] = this.steps!.map((v) => v.stepName).toList();
    }
    data['kyc_approved_status'] = this.kycApprovedStatus;
    return data;
  }
}

class User {
  int? userId;
  String? userName;
  String? userEmail;
  String? userRole;

  User({this.userId, this.userName, this.userEmail, this.userRole});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userRole = json['user_role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['user_role'] = this.userRole;
    return data;
  }
}

class StepModel {
  int? stepName;

  StepModel({this.stepName});

  StepModel.fromJson(Map<String, dynamic> json) {
    stepName = json['step_name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['step_name'] = stepName;
    return data;
  }
}
