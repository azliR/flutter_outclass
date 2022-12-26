class HttpResponse {
  const HttpResponse({
    required this.success,
    this.message,
    this.data,
  });

  factory HttpResponse.fromMap(Map<String, dynamic> map) => HttpResponse(
        success: map['success'] as bool,
        message: map['message'] as String?,
        data: map['data'] as Map<String, dynamic>?,
      );

  final bool success;
  final String? message;
  final Map<String, dynamic>? data;

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data,
      };
}
