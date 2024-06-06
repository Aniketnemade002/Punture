// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:garage/Features/owner/Data/ModalImpl/OwnerBookingModalImpl.dart';
// import 'package:garage/Features/owner/Data/ModalImpl/OwnerHistoryModalImpl.dart';
// import 'package:garage/Features/owner/Data/ModalImpl/OwnerModalImpl.dart';
// import 'package:garage/Features/user/Data/ModalImpl/FeatchGarageModal.dart';
// import 'package:garage/Features/user/Data/ModalImpl/UserBookingHistory.dart';
// import 'package:garage/Features/user/Data/ModalImpl/UserBookingModalIMPL.dart';
// import 'package:garage/Features/user/Data/ModalImpl/UserModalImpl.dart';

// final List<UserBookingDataModal> TestBooking = [
//   L11,
//   // L12,
//   // L11,
//   // L12,
//   // L11,
//   // L12,
//   // L11,
//   // L12
// ];
// final List<UserHistoryModal> TestUHistoy = [L1, L2, L1, L2, L1, L2];
// final List<FeatchGarageMoadlImpl> TestGarages = [G1, G1, G1, G1, G1, G1, G1];
// final List<FeatchSlotImpl> TestSlots = [
//   T1,
//   T1,
//   T1,
//   T1,
//   T1,
//   T1,
//   T1,
//   T1,
//   T1,
// ];

// final List<OwnerBookingModal> TestOwnerBooking = [
//   OB1,
//   OB2,
//   OB1,
//   OB2,
//   OB1,
//   OB2,
//   OB1,
//   OB2,
//   OB1,
//   OB2
// ];

// final List<OwnerHistoryModal> TestOwnerHistory = [
//   OH1,
//   OH1,
//   OH1,
//   OH1,
//   OH1,
//   OH1,
//   OH1,
//   OH1,
//   OH1,
//   OH1
// ];

// ///
// ///
// ///
// ///
// ///
// ///
// ///
// ///

// final MainUserModal TestUser = MainUserModal(
//     fcm: 'FCM',
//     village: 'Wagholi',
//     wallet: 200,
//     isProfileCompleted: true,
//     name: 'Aniket Nemade',
//     uid: 'uid',
//     email: 'Aniketnemade007@gmail.com',
//     mobileNo: 7248997200,
//     geoLocation: GeoPoint(18.414351418, 73.849242308),
//     pin: 1121);

// ///
// ///
// ///
// ///
// ///
// ///
// final MainOwnerModal TestOwner = MainOwnerModal(
//     fcm: 'FCM',
//     village: 'Wagholi',
//     wallet: 200,
//     isProfileCompleted: true,
//     ownername: 'Aniket Nemade',
//     email: 'Aniketnemade007@gmail.com',
//     mobileNo: 7248997200,
//     geoLocation: GeoPoint(18.414351418, 73.849242308),
//     pin: 1121,
//     garageName: '',
//     serviceCost: 250,
//     Address: 'WaGoli',
//     SID: 2,
//     LastSlotTime: Timestamp.now());

// ///
// ///
// ///
// ///
// ///
// ///

// final UserHistoryModal L1 = UserHistoryModal(
//     garageName: "Om Garage",
//     serviceCost: 200,
//     ownername: "Purushottm Patil",
//     username: 'Aniket Nemade',
//     useruid: 'ID1',
//     owneruid: 'owneruid',
//     OwnerMobileNo: 7248997200,
//     userMobileNo: 72389928,
//     GarageLocation: GeoPoint(18.514351418, 73.849242308),
//     CurrentLocation: GeoPoint(18.5809284, 73.981914),
//     BookingId: 'BookingId',
//     Discription: 'Break Faild',
//     Vehical_No: 'MH 123345',
//     Address:
//         'Shop No 1, M No 1/0709, Jai Anand Complex Nagar Rd, near PDCC Bank, Wagholi Pune, Maharashtra 412207 India',
//     SlotTime: Timestamp.now());

// final UserHistoryModal L2 = UserHistoryModal(
//     garageName: "masala Garage",
//     serviceCost: 240,
//     ownername: "Mayuri  Patil",
//     username: 'Aniket Nemade',
//     useruid: 'ID2',
//     owneruid: 'owneruid',
//     OwnerMobileNo: 7248997200,
//     userMobileNo: 72389928,
//     GarageLocation: GeoPoint(18.414351418, 73.849242308),
//     CurrentLocation: GeoPoint(18.4809284, 73.981914),
//     BookingId: 'BookingId',
//     Discription: 'Break Faild',
//     Vehical_No: 'MH PS 345',
//     Address:
//         'Shop No 1, M No 1/0709, Jai Anand Complex Nagar Rd, near PDCC Bank, Wagholi Pune, Maharashtra 412207 India',
//     SlotTime: Timestamp.now());

// final UserBookingDataModal L11 = UserBookingDataModal(
//     garageName: "masala Garage",
//     serviceCost: 240,
//     ownername: "Mayuri  Patil",
//     username: 'Aniket Nemade',
//     useruid: 'ID2',
//     owneruid: 'owneruid',
//     OwnerMobileNo: 7248997200,
//     userMobileNo: 72389928,
//     GarageLocation: GeoPoint(18.414351418, 73.849242308),
//     CurrentLocation: GeoPoint(18.4809284, 73.981914),
//     BookingId: 'BookingId',
//     Discription: 'Break Faild',
//     Vehical_No: 'MH PS 345',
//     Address:
//         'Shop No 1, M No 1/0709, Jai Anand Complex Nagar Rd, near PDCC Bank, Wagholi Pune, Maharashtra 412207 India',
//     SlotTime: Timestamp.now());

// final UserBookingDataModal L12 = UserBookingDataModal(
//     garageName: "Om Garage",
//     serviceCost: 200,
//     ownername: "Purushottm Patil",
//     username: 'Aniket Nemade',
//     useruid: 'ID1',
//     owneruid: 'owneruid',
//     OwnerMobileNo: 7248997200,
//     userMobileNo: 72389928,
//     GarageLocation: GeoPoint(18.514351418, 73.849242308),
//     CurrentLocation: GeoPoint(18.5809284, 73.981914),
//     BookingId: 'BookingId',
//     Discription: 'Break Faild',
//     Vehical_No: 'MH 123345',
//     Address:
//         'Shop No 1, M No 1/0709, Jai Anand Complex Nagar Rd, near PDCC Bank, Wagholi Pune, Maharashtra 412207 India',
//     SlotTime: Timestamp.now());

// final OwnerBookingModal OB1 = OwnerBookingModal(
//     garageName: "Om Garage",
//     serviceCost: 200,
//     ownername: "Purushottm Patil",
//     username: 'Aniket Nemade',
//     useruid: 'ID1',
//     owneruid: 'owneruid',
//     OwnerMobileNo: 7248997200,
//     userMobileNo: 72389928,
//     GarageLocation: GeoPoint(18.514351418, 73.849242308),
//     CurrentLocation: GeoPoint(18.5809284, 73.981914),
//     BookingId: 'BookingId',
//     Discription: 'Break Faild',
//     Vehical_No: 'MH 123345',
//     Address:
//         'Shop No 1, M No 1/0709, Jai Anand Complex Nagar Rd, near PDCC Bank, Wagholi Pune, Maharashtra 412207 India',
//     SlotTime: Timestamp.now());

// final OwnerBookingModal OB2 = OwnerBookingModal(
//     garageName: "Om Garage",
//     serviceCost: 200,
//     ownername: "Purushottm Patil",
//     username: 'Aniket Nemade',
//     useruid: 'ID1',
//     owneruid: 'owneruid',
//     OwnerMobileNo: 7248997200,
//     userMobileNo: 72389928,
//     GarageLocation: GeoPoint(18.514351418, 73.849242308),
//     CurrentLocation: GeoPoint(18.5809284, 73.981914),
//     BookingId: 'BookingId',
//     Discription: 'Break Faild',
//     Vehical_No: 'MH 123345',
//     Address:
//         'Shop No 1, M No 1/0709, Jai Anand Complex Nagar Rd, near PDCC Bank, Wagholi Pune, Maharashtra 412207 India',
//     SlotTime: Timestamp.now());

// final OwnerHistoryModal OH1 = OwnerHistoryModal(
//     garageName: "Om Garage",
//     serviceCost: 200,
//     ownername: "Purushottm Patil",
//     username: 'Aniket Nemade',
//     useruid: 'ID1',
//     owneruid: 'owneruid',
//     OwnerMobileNo: 7248997200,
//     userMobileNo: 72389928,
//     GarageLocation: GeoPoint(18.514351418, 73.849242308),
//     CurrentLocation: GeoPoint(18.5809284, 73.981914),
//     BookingId: 'BookingId',
//     Discription: 'Break Faild',
//     Vehical_No: 'MH 123345',
//     Address:
//         'Shop No 1, M No 1/0709, Jai Anand Complex Nagar Rd, near PDCC Bank, Wagholi Pune, Maharashtra 412207 India',
//     SlotTime: Timestamp.now());

// final FeatchGarageMoadlImpl G1 = FeatchGarageMoadlImpl(
//     fcm: 'fcm',
//     UID: 'UID',
//     village: 'Wagholi',
//     address:
//         'Shop No 1, M No 1/0709, Jai Anand Complex Nagar Rd, near PDCC Bank, Wagholi Pune, Maharashtra 412207 India',
//     serviceCost: 500,
//     wallet: 2000,
//     isProfileCompleted: true,
//     ownerName: 'Mayuri Patil',
//     garageName: 'Sid_garage',
//     email: ' Mayuri@gmail.com',
//     mobileNo: 7248997200,
//     geoLocation: GeoPoint(18.5809284, 73.981914),
//     pin: 1212,
//     SID: 21,
//     lastSlotTime: Timestamp.now(),
//     noOfSlots: 4,
//     currentGeopoint: GeoPoint(18.514351418, 73.849242308));

// final FeatchSlotImpl T1 =
//     FeatchSlotImpl(SlotID: '1212', SlotTime: Timestamp.now());
