// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimetableAdapter extends TypeAdapter<Timetable> {
  @override
  final int typeId = 1;

  @override
  Timetable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Timetable(
      batch: fields[2] as int,
      classid: fields[1] as String,
      day: fields[0] as String,
      first: fields[3] as Subject,
      second: fields[4] as Subject,
      third: fields[5] as Subject,
      fourth: fields[6] as Subject,
      fifth: fields[7] as Subject,
    );
  }

  @override
  void write(BinaryWriter writer, Timetable obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.classid)
      ..writeByte(2)
      ..write(obj.batch)
      ..writeByte(3)
      ..write(obj.first)
      ..writeByte(4)
      ..write(obj.second)
      ..writeByte(5)
      ..write(obj.third)
      ..writeByte(6)
      ..write(obj.fourth)
      ..writeByte(7)
      ..write(obj.fifth);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimetableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
