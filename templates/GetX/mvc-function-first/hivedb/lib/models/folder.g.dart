// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FolderAdapter extends TypeAdapter<Folder> {
  @override
  final int typeId = 1;

  @override
  Folder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Folder(
      fields[0] as dynamic,
      path: (fields[1] as List)?.cast<String>(),
      created: fields[2] as DateTime,
      lastChange: fields[3] as DateTime,
    )..items = (fields[50] as List)?.cast<Item>();
  }

  @override
  void write(BinaryWriter writer, Folder obj) {
    writer
      ..writeByte(5)
      ..writeByte(50)
      ..write(obj.items)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.created)
      ..writeByte(3)
      ..write(obj.lastChange);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FolderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
