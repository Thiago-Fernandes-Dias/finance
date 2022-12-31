import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info.freezed.dart';
part 'user_info.g.dart';

@freezed
class UserInfo with _$UserInfo {
  const factory UserInfo({
    required double cash,
    required Map<String, int> stocks,
  }) = _UserInfo;

  factory UserInfo.fromJson(Map<String, Object?> json) => _$UserInfoFromJson(json);
}
