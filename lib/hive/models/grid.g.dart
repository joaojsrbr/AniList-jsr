// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'grid.dart';

// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************

// class GridModelAdapter extends TypeAdapter<GridModel> {
//   @override
//   final int typeId = 2;

//   @override
//   GridModel read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return GridModel(
//       select: fields[0] as int,
//     );
//   }

//   @override
//   void write(BinaryWriter writer, GridModel obj) {
//     writer
//       ..writeByte(1)
//       ..writeByte(0)
//       ..write(obj.select);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is GridModelAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
