// ignore_for_file: public_member_api_docs, sort_constructors_first
class RenewTokenDto {
  final String refreshToken;

  RenewTokenDto({required this.refreshToken});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'refresh_token': refreshToken,
    };
  }
}
