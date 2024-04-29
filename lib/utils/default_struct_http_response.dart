class DefaultStructHttpResponse {
  bool success;
  int usuarioId;
  String? message;
  String body;

  DefaultStructHttpResponse({
    this.success = false,
    this.usuarioId = 0,
    this.message = '',
    this.body = '',
  });
}
