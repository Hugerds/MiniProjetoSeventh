class LoginNaoRealizadoException extends FormatException {
  LoginNaoRealizadoException() : super("Login não realizado");
}

class VideoNaoEncontradoException extends FormatException {
  VideoNaoEncontradoException() : super("Vídeo não encontrado");
}

class NaoFoiPossivelCarregarVideoException extends FormatException {
  NaoFoiPossivelCarregarVideoException() : super("Não foi possível carregar o vídeo");
}

class FormularioInvalidoException extends FormatException {
  FormularioInvalidoException() : super("Formulário inválido");
}
