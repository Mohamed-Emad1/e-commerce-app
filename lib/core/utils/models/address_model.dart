import 'package:hive/hive.dart';

part 'address_model.g.dart';

@HiveType(typeId: 0)
class AddressModel extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? phoneNumber;
  @HiveField(2)
  String? address;
  @HiveField(3)
  String? city;
  @HiveField(4)
  String? streetAddress;
  @HiveField(5)
  String? country;
  @HiveField(6)
  String? postalCode;
  AddressModel({
    required this.name,
    required this.address,
    required this.city,
    required this.streetAddress,
    required this.country,
    required this.postalCode,
    required this.phoneNumber,
  });
}
