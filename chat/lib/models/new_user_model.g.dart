// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewUserModelAdapter extends TypeAdapter<NewUserModel> {
  @override
  final int typeId = 1;

  @override
  NewUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewUserModel(
      id: fields[0] as String,
      fullname: fields[1] as String,
      username: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NewUserModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fullname)
      ..writeByte(2)
      ..write(obj.username);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
