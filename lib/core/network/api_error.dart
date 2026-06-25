sealed class ApiError implements Exception {
  final String message;
  const ApiError(this.message);
}

class NetworkError extends ApiError {
  const NetworkError() : super('Sem conexão. Verifique sua internet.');
}

class ServerError extends ApiError {
  final int statusCode;
  const ServerError(this.statusCode)
      : super('Erro no servidor ($statusCode).');
}

class ParseError extends ApiError {
  const ParseError() : super('Resposta inválida do servidor.');
}
