part of 'owner_booking_bloc_bloc.dart';

sealed class OwnerBookingBlocEvent extends Equatable {
  const OwnerBookingBlocEvent();

  @override
  List<Object> get props => [];
}

class GetOwnerBookingList extends OwnerBookingBlocEvent {}
