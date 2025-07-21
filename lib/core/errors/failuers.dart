abstract class Failuer {
  final String errorMesssage;

  Failuer({required this.errorMesssage});
}

class ServerFailuer extends Failuer {
  ServerFailuer({required super.errorMesssage});
}
