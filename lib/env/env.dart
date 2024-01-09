// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'PORT')
  static const String port = _Env.port;
  @EnviedField(varName: 'MONGO_URL')
  static const String MONGO_URL = _Env.MONGO_URL;
  @EnviedField(varName: 'SECRET')
  static const String secret = _Env.secret;
  @EnviedField(varName: 'JWT_SEC')
  static const String jwt = _Env.jwt;
  @EnviedField(varName: 'USERNAME')
  static const String username = _Env.username;
  @EnviedField(varName: 'PASSWORD')
  static const String password = _Env.password;
  @EnviedField(varName: 'NAME_DB')
  static const String database = _Env.database;
}
