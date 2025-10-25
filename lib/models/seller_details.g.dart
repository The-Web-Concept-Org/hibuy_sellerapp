// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SellerDetailsAdapter extends TypeAdapter<SellerDetails> {
  @override
  final int typeId = 0;

  @override
  SellerDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SellerDetails(
      name: fields[0] as String,
      email: fields[1] as String,
      phone: fields[2] as int,
      address: fields[3] as String,
      profilePicture: fields[4] as String?,
      referralLink: fields[5] as String,
      encodedUserId: fields[6] as String,
      profileImageFile: fields[7] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, SellerDetails obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.profilePicture)
      ..writeByte(5)
      ..write(obj.referralLink)
      ..writeByte(6)
      ..write(obj.encodedUserId)
      ..writeByte(7)
      ..write(obj.profileImageFile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SellerDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
