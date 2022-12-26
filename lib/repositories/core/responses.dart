class HttpResponse {
  const HttpResponse({
    required this.success,
    this.message,
    this.data,
  });

  factory HttpResponse.fromMap(Map<String, dynamic>? json) {
    if (json == null) {
      return const HttpResponse(
        success: false,
      );
    }
    return HttpResponse(
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  final bool success;
  final String? message;
  final Map<String, dynamic>? data;

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data,
      };
}
