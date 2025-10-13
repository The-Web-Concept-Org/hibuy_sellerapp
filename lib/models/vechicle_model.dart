class VehicleType {
  bool? success;
  String? message;
  List<VehicleData>? data;

  VehicleType({this.success, this.message, this.data});

  VehicleType.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? '';
    if (json['data'] != null) {
      data = <VehicleData>[];
      json['data'].forEach((v) {
        data!.add(VehicleData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VehicleData {
  int? id;
  String? vehicleType;
  double? minWeight;
  double? maxWeight;
  double? maxLength;
  double? maxWidth;
  double? maxHeight;

  VehicleData({
    this.id,
    this.vehicleType,
    this.minWeight,
    this.maxWeight,
    this.maxLength,
    this.maxWidth,
    this.maxHeight,
  });

  VehicleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleType = json['vehicle_type'];
    minWeight = (json['min_weight'] ?? 0).toDouble();
    maxWeight = (json['max_weight'] ?? 0).toDouble();
    maxLength = (json['max_length'] ?? 0).toDouble();
    maxWidth = (json['max_width'] ?? 0).toDouble();
    maxHeight = (json['max_height'] ?? 0).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['vehicle_type'] = vehicleType;
    data['min_weight'] = minWeight;
    data['max_weight'] = maxWeight;
    data['max_length'] = maxLength;
    data['max_width'] = maxWidth;
    data['max_height'] = maxHeight;
    return data;
  }
}
