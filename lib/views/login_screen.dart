import 'package:alive_app/views/home_screen.dart';
import 'package:flutter/material.dart';

/// ─────────────────────────────────────────────
///  LOGIN SCREEN TEMPLATE
///  Style : Material Design
///  State : setState
///
///  HOW TO USE:
///  1. Replace _handleLogin() logic with your auth call.
///  2. Update navigation routes at the bottom.
///  3. Add Google/Facebook buttons if needed (section marked below).
///  4. Customize colors via your MaterialApp theme.
/// ─────────────────────────────────────────────

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ── Form & Controllers ───────────────────────
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // ── State ────────────────────────────────────
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;

  // ── CONFIG ──────────────────────────────────
  static const String _appName = 'AppName'; // 🔧 Change this
  // ────────────────────────────────────────────

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ── LOGIN LOGIC ──────────────────────────────
  Future<void> _handleLogin() async {
    _navigateToHome();
    
  }

  void _navigateToHome() {
     Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const HomeScreen(),
  ),
);
  }

  void _navigateToSignup() {
    // Navigator.pushNamed(context, '/signup');
    debugPrint('Navigate to Signup');
  }

  void _navigateToForgotPassword() {
    // 🔧 Replace with your route:
    // Navigator.pushNamed(context, '/forgot-password');
    debugPrint('Navigate to Forgot Password');
  }

  

  // ── VALIDATORS ───────────────────────────────
  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  // ── BUILD ────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ───────────────────────
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset('assets/alive_logo.png'),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Welcome back ',
                        style: textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign in to your $_appName account',
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 48),

                // ── Email Field ──────────────────
                Text("EmailID or Phone Number",style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 4,),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: _validateEmail,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'you@example.com',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ── Password Field ───────────────
                 Text("Password",style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 4,),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleLogin(),
                  validator: _validatePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: '••••••••',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () => setState(
                        () => _isPasswordVisible = !_isPasswordVisible,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ── Remember Me + Forgot Password ─
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (v) =>
                          setState(() => _rememberMe = v ?? false),
                    ),
                    const Text('Remember me'),
                    const Spacer(),
                    TextButton(
                      onPressed: _navigateToForgotPassword,
                      child: const Text('Forgot password?'),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // ── Login Button ─────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    child: _isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 24),

                // ── Divider ───────────────────────
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 24),

                // ── Social Login Buttons ──────────
                OutlinedButton.icon(
                  onPressed: () => debugPrint('Google Sign-In'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                  ),
                  icon: const Icon(Icons.g_mobiledata, size: 28,color: Colors.blue,),
                  label: const Text('Continue with Google'),
                ),

                 const SizedBox(height: 24),

                 OutlinedButton.icon(
                  onPressed: () => debugPrint('Facebook Sign-In'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                  ),
                  icon: const Icon(Icons.facebook, size: 28,color: Colors.blue,),
                  label: const Text('Continue with Facebook'),
                ),

                const SizedBox(height: 40),

                // ── Sign Up Link ─────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: _navigateToSignup,
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}