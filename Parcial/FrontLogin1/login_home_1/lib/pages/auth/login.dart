import 'package:flutter/material.dart';
import '../../widgets/appbar.dart';
import '../../services/api_service.dart';
import '../../services/storage_service.dart';
import '../home/home.dart';
import '../user/form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Indica si hay una petición HTTP en curso (muestra spinner)
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ── Navegar al formulario de registro ──────────────────────────────
  void _navigateToRegister() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserFormScreen()),
    );

    // Si el registro fue exitoso, se llena el campo usuario automáticamente
    if (result != null && result is Map<String, String>) {
      setState(() {
        _usernameController.text = result['username'] ?? '';
        _passwordController.text =
            ''; // Por seguridad no pre-llenamos la contraseña
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Usuario registrado. Ahora inicia sesión.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  // ── Login contra el backend ────────────────────────────────────────
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();

      // Llama al backend: POST /api_v1/apiUserLogin
      final token = await ApiService.login(username, password);

      // Guarda el token JWT en el dispositivo
      await StorageService.saveToken(token);

      // Navega a HomeScreen (reemplaza la pantalla actual)
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomeScreen(username: username, password: password),
        ),
      );
    } catch (e) {
      // Muestra el error devuelto por el backend
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ ${e.toString().replaceAll('Exception: ', '')}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ── UI ─────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Iniciar Sesión'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/img/logos/1.png', height: 100),
              const SizedBox(height: 20),

              // ── Campo usuario ──────────────────────────────────────
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su usuario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // ── Campo contraseña ──────────────────────────────────
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // ── Botón Ingresar / Spinner ──────────────────────────
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Ingresar'),
                    ),
              const SizedBox(height: 20),

              // ── Enlace a registro ─────────────────────────────────
              TextButton(
                onPressed: _isLoading ? null : _navigateToRegister,
                child: const Text('¿No tienes cuenta? Regístrate aquí'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
