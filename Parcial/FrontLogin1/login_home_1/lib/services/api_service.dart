import 'dart:convert';
import 'package:http/http.dart' as http;

/// Base URL del backend.
/// - Dispositivo físico en tu red local → IP de tu PC: 10.1.215.250
/// - Emulador Android → cambiar a: http://10.0.2.2:3000/api_v1
/// - iOS Simulator / Web → cambiar a: http://localhost:3000/api_v1
const String _baseUrl = 'http://10.1.215.250:3000/api_v1';

class ApiService {
  // ─────────────────────────────────────────────────────────────────────
  // LOGIN
  // POST /api_v1/apiUserLogin
  // Body: { "api_user": "...", "api_password": "..." }
  // Respuesta exitosa: { "token": "..." }
  // ─────────────────────────────────────────────────────────────────────
  static Future<String> login(String user, String password) async {
    final uri = Uri.parse('$_baseUrl/apiUserLogin');

    final response = await http
        .post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'api_user': user, 'api_password': password}),
        )
        .timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw Exception('El servidor no responde (timeout)'),
        );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Login exitoso → retorna el token JWT
      return data['token'] as String;
    } else {
      // El backend devuelve { "error": "..." }
      final errorMsg = data['error'] ?? 'Error desconocido';
      throw Exception(errorMsg);
    }
  }

  // ─────────────────────────────────────────────────────────────────────
  // REGISTRO
  // POST /api_v1/apiUser
  // Body: { "user": "...", "password": "...", "status": 1, "role": 1 }
  // Respuesta exitosa: { "data": [...], "status": 201 }
  // ─────────────────────────────────────────────────────────────────────
  static Future<void> register(String user, String password) async {
    final uri = Uri.parse('$_baseUrl/apiUser');

    final response = await http
        .post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'user': user,
            'password': password,
            'status': 1, // valor por defecto: activo
            'role': 1, // valor por defecto: rol básico
          }),
        )
        .timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw Exception('El servidor no responde (timeout)'),
        );

    if (response.statusCode == 201) {
      // Registro exitoso
      return;
    } else {
      final data = jsonDecode(response.body);
      final errorMsg = data['error'] ?? 'Error al registrar usuario';
      throw Exception(errorMsg);
    }
  }
}
