// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String errMessage;
  CustomError({
    this.errMessage = '',
  });

  @override
  List<Object?> get props => [errMessage];

  @override
  bool get stringify => true;
}
