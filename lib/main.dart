import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'TechHub Pro',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemBlue,
        scaffoldBackgroundColor: Color(0xFF0A0A0A),
        barBackgroundColor: Color(0xFF1C1C1E),
        textTheme: CupertinoTextThemeData(
          primaryColor: CupertinoColors.white,
        ),
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFF0A0A0A),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF007AFF), Color(0xFF5856D6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF007AFF).withOpacity(0.3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      CupertinoIcons.device_laptop,
                      size: 60,
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'TechHub Pro',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.white,
                  ),
                ),
              ),
              SizedBox(height: 8),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Plataforma Tecnológica Avanzada',
                  style: TextStyle(
                    fontSize: 16,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),
              SizedBox(height: 60),
              _buildTextField('Email', _emailController, CupertinoIcons.mail),
              SizedBox(height: 20),
              _buildTextField('Contraseña', _passwordController, CupertinoIcons.lock, isPassword: true),
              SizedBox(height: 40),
              _buildLoginButton(),
              SizedBox(height: 20),
              CupertinoButton(
                child: Text(
                  '¿No tienes cuenta? Regístrate',
                  style: TextStyle(color: Color(0xFF007AFF)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String placeholder, TextEditingController controller, IconData icon, {bool isPassword = false}) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF2C2C2E), width: 1),
      ),
      child: CupertinoTextField(
        controller: controller,
        placeholder: placeholder,
        obscureText: isPassword,
        prefix: Padding(
          padding: EdgeInsets.only(left: 16),
          child: Icon(icon, color: Color(0xFF007AFF), size: 20),
        ),
        decoration: BoxDecoration(),
        style: TextStyle(color: CupertinoColors.white),
        placeholderStyle: TextStyle(color: CupertinoColors.systemGrey),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 56,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF007AFF), Color(0xFF5856D6)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF007AFF).withOpacity(0.3),
                blurRadius: 15,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Iniciar Sesión',
              style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(builder: (context) => MainTabScreen()),
          );
        },
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFF0A0A0A),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color(0xFF1C1C1E),
        middle: Text('Registro', style: TextStyle(color: CupertinoColors.white)),
        leading: CupertinoNavigationBarBackButton(
          color: Color(0xFF007AFF),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF30D158), Color(0xFF32D74B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  CupertinoIcons.person_add,
                  size: 40,
                  color: CupertinoColors.white,
                ),
              ),
              SizedBox(height: 40),
              _buildTextField('Nombre completo', _nameController, CupertinoIcons.person),
              SizedBox(height: 20),
              _buildTextField('Email', _emailController, CupertinoIcons.mail),
              SizedBox(height: 20),
              _buildTextField('Contraseña', _passwordController, CupertinoIcons.lock, isPassword: true),
              SizedBox(height: 20),
              _buildTextField('Confirmar contraseña', _confirmPasswordController, CupertinoIcons.lock_shield, isPassword: true),
              SizedBox(height: 40),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String placeholder, TextEditingController controller, IconData icon, {bool isPassword = false}) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF2C2C2E), width: 1),
      ),
      child: CupertinoTextField(
        controller: controller,
        placeholder: placeholder,
        obscureText: isPassword,
        prefix: Padding(
          padding: EdgeInsets.only(left: 16),
          child: Icon(icon, color: Color(0xFF30D158), size: 20),
        ),
        decoration: BoxDecoration(),
        style: TextStyle(color: CupertinoColors.white),
        placeholderStyle: TextStyle(color: CupertinoColors.systemGrey),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      width: double.infinity,
      height: 56,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF30D158), Color(0xFF32D74B)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              'Crear Cuenta',
              style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(builder: (context) => MainTabScreen()),
          );
        },
      ),
    );
  }
}

class MainTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Color(0xFF1C1C1E),
        activeColor: Color(0xFF007AFF),
        inactiveColor: CupertinoColors.systemGrey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.question_circle),
            label: 'FAQ',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add_circled),
            label: 'Registro',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.number_square), // ícono alternativo
            label: 'Calculadora',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar),
            label: 'Calendario',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (_) => HomeScreen());
          case 1:
            return CupertinoTabView(builder: (_) => FAQScreen());
          case 2:
            return CupertinoTabView(builder: (_) => RegistryScreen());
          case 3:
            return CupertinoTabView(builder: (_) => CalculatorScreen());
          case 4:
            return CupertinoTabView(builder: (_) => CalendarScreen());
          default:
            return CupertinoTabView(builder: (_) => HomeScreen());
        }
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFF0A0A0A),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color(0xFF1C1C1E),
        middle: Text('TechHub Pro', style: TextStyle(color: CupertinoColors.white)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Bienvenido',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Gestiona tus herramientas tecnológicas',
                style: TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              SizedBox(height: 40),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildFeatureCard(
                      'Preguntas Frecuentes',
                      CupertinoIcons.question_circle_fill,
                      Color(0xFF007AFF),
                    ),
                    _buildFeatureCard(
                      'Registro de Datos',
                      CupertinoIcons.doc_text_fill,
                      Color(0xFF30D158),
                    ),
                    _buildFeatureCard(
                      'Calculadora',
                      CupertinoIcons.number_square,
                      Color(0xFFFF9500),
                    ),
                    _buildFeatureCard(
                      'Calendario',
                      CupertinoIcons.calendar_today,
                      Color(0xFFFF3B30),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF2C2C2E), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              size: 30,
              color: color,
            ),
          ),
          SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class FAQScreen extends StatelessWidget {
  final List<FAQItem> faqs = [
    FAQItem(
      question: '¿Cómo puedo restablecer mi contraseña?',
      answer:
          'Puedes restablecer tu contraseña desde la pantalla de login tocando "¿Olvidaste tu contraseña?" e ingresando tu email.',
      icon: CupertinoIcons.lock_rotation,
    ),
    FAQItem(
      question: '¿La aplicación funciona sin internet?',
      answer:
          'Algunas funciones como la calculadora y el calendario funcionan offline, pero necesitas conexión para sincronizar datos.',
      icon: CupertinoIcons.wifi_slash,
    ),
    FAQItem(
      question: '¿Cómo contactar soporte técnico?',
      answer:
          'Puedes contactar nuestro soporte técnico a través del email yadhira.alcantara@tecsup.edu.pe o llamando a +51 999899999',
      icon: CupertinoIcons.headphones,
    ),
    FAQItem(
      question: '¿Mis datos están seguros?',
      answer:
          'Sí, utilizamos encriptación de extremo a extremo y cumplimos con los estándares internacionales de seguridad de datos.',
      icon: CupertinoIcons.shield_lefthalf_fill,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFF0A0A0A),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color(0xFF1C1C1E),
        middle: Text(
          'Preguntas Frecuentes',
          style: TextStyle(color: CupertinoColors.white),
        ),
      ),
      child: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            return _FAQTile(faq: faqs[index]);
          },
        ),
      ),
    );
  }
}

class _FAQTile extends StatefulWidget {
  final FAQItem faq;
  const _FAQTile({required this.faq});

  @override
  State<_FAQTile> createState() => _FAQTileState();
}

class _FAQTileState extends State<_FAQTile> with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF2C2C2E), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() => _expanded = !_expanded);
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFF007AFF).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(widget.faq.icon, color: Color(0xFF007AFF), size: 20),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.faq.question,
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: _expanded ? pi : 0,
                  child: Icon(CupertinoIcons.chevron_down, color: Color(0xFF007AFF)),
                ),
              ],
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                widget.faq.answer,
                style: TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;
  final IconData icon;

  FAQItem({
    required this.question,
    required this.answer,
    required this.icon,
  });
}

class RegistryScreen extends StatefulWidget {
  @override
  _RegistryScreenState createState() => _RegistryScreenState();
}

class _RegistryScreenState extends State<RegistryScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<RegistryItem> _items = [];
  String _selectedCategory = 'General';
  final List<String> _categories = ['General', 'Trabajo', 'Personal', 'Proyecto'];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFF0A0A0A),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color(0xFF1C1C1E),
        middle: Text('Registro de Datos', style: TextStyle(color: CupertinoColors.white)),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.add, color: Color(0xFF007AFF)),
          onPressed: _showAddItemDialog,
        ),
      ),
      child: SafeArea(
        child: _items.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return _buildRegistryCard(_items[index], index);
                },
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              CupertinoIcons.doc_text,
              size: 50,
              color: Color(0xFF007AFF),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'No hay registros',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Toca el botón + para agregar tu primer registro',
            style: TextStyle(
              fontSize: 16,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRegistryCard(RegistryItem item, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF2C2C2E), width: 1),
      ),
      child: CupertinoListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _getCategoryColor(item.category).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getCategoryIcon(item.category),
            color: _getCategoryColor(item.category),
            size: 24,
          ),
        ),
        title: Text(
          item.title,
          style: TextStyle(
            color: CupertinoColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.description,
              style: TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${item.category} • ${_formatDate(item.createdAt)}',
              style: TextStyle(
                color: CupertinoColors.systemGrey2,
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.delete,
            color: CupertinoColors.destructiveRed,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              _items.removeAt(index);
            });
          },
        ),
      ),
    );
  }

  void _showAddItemDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Nuevo Registro'),
        content: Column(
          children: [
            SizedBox(height: 16),
            CupertinoTextField(
              controller: _titleController,
              placeholder: 'Título',
              style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
            ),
            SizedBox(height: 12),
            CupertinoTextField(
              controller: _descriptionController,
              placeholder: 'Descripción',
              maxLines: 3,
              style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              child: CupertinoPicker(
                itemExtent: 32,
                onSelectedItemChanged: (index) {
                  _selectedCategory = _categories[index];
                },
                children: _categories.map((category) => 
                  Center(child: Text(category, style: TextStyle(fontSize: 16)))
                ).toList(),
              ),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: Text('Agregar'),
            onPressed: () {
              if (_titleController.text.isNotEmpty) {
                setState(() {
                  _items.add(RegistryItem(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    category: _selectedCategory,
                    createdAt: DateTime.now(),
                  ));
                });
                _titleController.clear();
                _descriptionController.clear();
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Trabajo': return Color(0xFF007AFF);
      case 'Personal': return Color(0xFF30D158);
      case 'Proyecto': return Color(0xFFFF9500);
      default: return Color(0xFFFF3B30);
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Trabajo': return CupertinoIcons.briefcase;
      case 'Personal': return CupertinoIcons.person;
      case 'Proyecto': return CupertinoIcons.hammer;
      default: return CupertinoIcons.doc_text;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class RegistryItem {
  final String title;
  final String description;
  final String category;
  final DateTime createdAt;

  RegistryItem({
    required this.title,
    required this.description,
    required this.category,
    required this.createdAt,
  });
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> with TickerProviderStateMixin {
  String _display = '0';
  String _previousNumber = '';
  String _operation = '';
  bool _isNewNumber = true;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFF0A0A0A),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color(0xFF1C1C1E),
        middle: Text('Calculadora', style: TextStyle(color: CupertinoColors.white)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Display
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (_previousNumber.isNotEmpty && _operation.isNotEmpty)
                      Text(
                        '$_previousNumber $_operation',
                        style: TextStyle(
                          fontSize: 24,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    SizedBox(height: 8),
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 1.0 + (_animationController.value * 0.1),
                          child: Text(
                            _display,
                            style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.w300,
                              color: CupertinoColors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Buttons
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildButtonRow(['C', '±', '%', '÷']),
                    _buildButtonRow(['7', '8', '9', '×']),
                    _buildButtonRow(['4', '5', '6', '-']),
                    _buildButtonRow(['1', '2', '3', '+']),
                    _buildLastRow(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        children: buttons.map((button) => 
          Expanded(child: _buildButton(button))
        ).toList(),
      ),
    );
  }

  Widget _buildLastRow() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildButton('0', isWide: true),
          ),
          Expanded(child: _buildButton('.')),
          Expanded(child: _buildButton('=')),
        ],
      ),
    );
  }

  Widget _buildButton(String text, {bool isWide = false}) {
    Color buttonColor;
    Color textColor = CupertinoColors.white;
    
    if (['C', '±', '%'].contains(text)) {
      buttonColor = Color(0xFF505050);
    } else if (['÷', '×', '-', '+', '='].contains(text)) {
      buttonColor = Color(0xFF007AFF);
    } else {
      buttonColor = Color(0xFF1C1C1E);
    }

    return Container(
      margin: EdgeInsets.all(4),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(isWide ? 35 : 35),
            boxShadow: [
              BoxShadow(
                color: buttonColor.withOpacity(0.3),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
          ),
        ),
        onPressed: () => _onButtonPressed(text),
      ),
    );
  }

  void _onButtonPressed(String buttonText) {
    _animationController.forward().then((_) => _animationController.reverse());
    
    setState(() {
      if (buttonText == 'C') {
        _display = '0';
        _previousNumber = '';
        _operation = '';
        _isNewNumber = true;
      } else if (buttonText == '±') {
        if (_display != '0') {
          if (_display.startsWith('-')) {
            _display = _display.substring(1);
          } else {
            _display = '-$_display';
          }
        }
      } else if (buttonText == '%') {
        double value = double.parse(_display) / 100;
        _display = _formatResult(value);
      } else if (['÷', '×', '-', '+'].contains(buttonText)) {
        _previousNumber = _display;
        _operation = buttonText;
        _isNewNumber = true;
      } else if (buttonText == '=') {
        if (_previousNumber.isNotEmpty && _operation.isNotEmpty) {
          double prev = double.parse(_previousNumber);
          double current = double.parse(_display);
          double result = 0;
          
          switch (_operation) {
            case '+':
              result = prev + current;
              break;
            case '-':
              result = prev - current;
              break;
            case '×':
              result = prev * current;
              break;
            case '÷':
              result = current != 0 ? prev / current : 0;
              break;
          }
          
          _display = _formatResult(result);
          _previousNumber = '';
          _operation = '';
          _isNewNumber = true;
        }
      } else if (buttonText == '.') {
        if (!_display.contains('.')) {
          if (_isNewNumber) {
            _display = '0.';
            _isNewNumber = false;
          } else {
            _display += '.';
          }
        }
      } else {
        if (_isNewNumber) {
          _display = buttonText;
          _isNewNumber = false;
        } else {
          if (_display.length < 10) {
            _display = _display == '0' ? buttonText : _display + buttonText;
          }
        }
      }
    });
  }

  String _formatResult(double result) {
    if (result == result.toInt()) {
      return result.toInt().toString();
    } else {
      return result.toStringAsFixed(8).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');

    }
  }
}

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  Map<DateTime, List<CalendarEvent>> _events = {};

  @override
  void initState() {
    super.initState();
    _loadSampleEvents();
  }

  void _loadSampleEvents() {
    final today = DateTime.now();
    _events = {
      DateTime(today.year, today.month, today.day): [
        CalendarEvent('Reunión de equipo', '10:00', Color(0xFF007AFF)),
        CalendarEvent('Revisión de proyecto', '14:30', Color(0xFF30D158)),
      ],
      DateTime(today.year, today.month, today.day + 1): [
        CalendarEvent('Presentación cliente', '09:00', Color(0xFFFF9500)),
      ],
      DateTime(today.year, today.month, today.day + 2): [
        CalendarEvent('Workshop tecnológico', '16:00', Color(0xFF5856D6)),
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFF0A0A0A),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color(0xFF1C1C1E),
        middle: Text('Calendario', style: TextStyle(color: CupertinoColors.white)),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.add, color: Color(0xFF007AFF)),
          onPressed: _showAddEventDialog,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildCalendarHeader(),
            _buildCalendarGrid(),
            _buildEventsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(CupertinoIcons.chevron_left, color: Color(0xFF007AFF)),
            onPressed: () {
              setState(() {
                _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1);
              });
            },
          ),
          Text(
            _getMonthYearString(_selectedDate),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.white,
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(CupertinoIcons.chevron_right, color: Color(0xFF007AFF)),
            onPressed: () {
              setState(() {
                _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildWeekDaysHeader(),
          SizedBox(height: 10),
          _buildDaysGrid(),
        ],
      ),
    );
  }

  Widget _buildWeekDaysHeader() {
    final weekDays = ['D', 'L', 'M', 'M', 'J', 'V', 'S'];
    return Row(
      children: weekDays.map((day) => 
        Expanded(
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ).toList(),
    );
  }

  Widget _buildDaysGrid() {
    final firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final lastDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);
    final startDate = firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday % 7));
    
    return Container(
      height: 300,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1,
        ),
        itemCount: 42,
        itemBuilder: (context, index) {
          final date = startDate.add(Duration(days: index));
          final hasEvents = _events[DateTime(date.year, date.month, date.day)]?.isNotEmpty ?? false;
          final isCurrentMonth = date.month == _selectedDate.month;
          final isToday = _isSameDay(date, DateTime.now());
          final isSelected = _isSameDay(date, _selectedDate);
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
            },
            child: Container(
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF007AFF) : 
                       isToday ? Color(0xFF007AFF).withOpacity(0.3) :
                       Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      color: isCurrentMonth ? CupertinoColors.white : CupertinoColors.systemGrey,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  if (hasEvents)
                    Container(
                      width: 6,
                      height: 6,
                      margin: EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        color: Color(0xFF30D158),
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEventsList() {
    final selectedEvents = _events[DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day)] ?? [];
    
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Eventos - ${_formatSelectedDate(_selectedDate)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.white,
              ),
            ),
            SizedBox(height: 16),
            selectedEvents.isEmpty
                ? _buildNoEventsState()
                : Expanded(
                    child: ListView.builder(
                      itemCount: selectedEvents.length,
                      itemBuilder: (context, index) {
                        return _buildEventCard(selectedEvents[index]);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoEventsState() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.calendar_badge_plus,
              size: 64,
              color: CupertinoColors.systemGrey,
            ),
            SizedBox(height: 16),
            Text(
              'No hay eventos',
              style: TextStyle(
                fontSize: 18,
                color: CupertinoColors.systemGrey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Toca + para agregar un evento',
              style: TextStyle(
                fontSize: 14,
                color: CupertinoColors.systemGrey2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(CalendarEvent event) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF2C2C2E), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: event.color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: CupertinoColors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  event.time,
                  style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEventDialog() {
    final titleController = TextEditingController();
    final timeController = TextEditingController();
    
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Nuevo Evento'),
        content: Column(
          children: [
            SizedBox(height: 16),
            CupertinoTextField(
              controller: titleController,
              placeholder: 'Título del evento',
              style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
            ),
            SizedBox(height: 12),
            CupertinoTextField(
              controller: timeController,
              placeholder: 'Hora (ej: 14:30)',
              style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: Text('Agregar'),
            onPressed: () {
              if (titleController.text.isNotEmpty && timeController.text.isNotEmpty) {
                final eventDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
                
                setState(() {
                  if (_events[eventDate] == null) {
                    _events[eventDate] = [];
                  }
                  _events[eventDate]!.add(CalendarEvent(
                    titleController.text,
                    timeController.text,
                    Color(0xFF007AFF),
                  ));
                });
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  String _getMonthYearString(DateTime date) {
    final months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  String _formatSelectedDate(DateTime date) {
    final months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return '${date.day} de ${months[date.month - 1]}';
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
}

class CalendarEvent {
  final String title;
  final String time;
  final Color color;

  CalendarEvent(this.title, this.time, this.color);
}