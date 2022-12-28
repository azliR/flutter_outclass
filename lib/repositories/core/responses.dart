class HttpResponse<T> {
  const HttpResponse({
    required this.success,
    this.message,
    this.data,
  });

  factory HttpResponse.fromJson(
    Map<String, dynamic>? json,
    T Function(dynamic data)? fromJson,
  ) {
    if (json == null) {
      return const HttpResponse(
        success: false,
      );
    }
    return HttpResponse(
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: json['data'] != null ? fromJson!(json['data']) : null,
    );
  }

  final bool success;
  final String? message;
  final T? data;

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data,
      };
}
