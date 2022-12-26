// ignore_for_file: public_member_api_docs, sort_constructors_first
class RenewTokenDto {
  RenewTokenDto({required this.refreshToken});

  final String refreshToken;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'refreshToken': refreshToken,
    };
  }
}
