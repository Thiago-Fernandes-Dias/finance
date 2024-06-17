part of 'models.dart';

class CurrentUserInfo implements Equatable {
  CurrentUserInfo({required this.userId, required this.email});

  final String userId;
  final String email;
  
  @override
  List<Object?> get props => [userId, email];
  
  @override
  bool? get stringify => false;
}
