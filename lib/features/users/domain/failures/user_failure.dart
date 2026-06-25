sealed class UserFailure implements Exception {
  final String message;
  const UserFailure(this.message);
}

class UserNetworkFailure extends UserFailure {
  const UserNetworkFailure()
      : super('Sem conexão. Verifique sua internet.');
}

class UserServerFailure extends UserFailure {
  final int statusCode;
  const UserServerFailure(this.statusCode)
      : super('Erro no servidor ($statusCode).');
}

class UserParseFailure extends UserFailure {
  const UserParseFailure() : super('Resposta inválida do servidor.');
}
