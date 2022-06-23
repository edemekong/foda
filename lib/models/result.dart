import 'package:equatable/equatable.dart';

class ErrorHandler extends Equatable implements Exception {
  final String message;

  const ErrorHandler({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
