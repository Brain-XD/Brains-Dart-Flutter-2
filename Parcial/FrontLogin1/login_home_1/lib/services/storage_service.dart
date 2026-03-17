import 'package:shared_preferences/shared_preferences.dart';

/// Servicio para persistir el JWT token en el dispositivo.
/// Usa SharedPreferences (equivalente a localStorage en web).
class StorageService {
  static const String _tokenKey = 'jwt_token';

  /// Guarda el token JWT en el dispositivo.
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// Lee el token guardado. Retorna null si no existe.
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Borra el token (usada al cerrar sesión).
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
