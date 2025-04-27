import 'package:mus/mus_cli.dart';

void main(List<String> arguments) async {
  final cli = MusCli();
  await cli.run(arguments);
}
