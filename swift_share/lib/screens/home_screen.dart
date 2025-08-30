

import 'package:flutter/material.dart';
import 'receive_screen.dart';
import 'send_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  double _sendScale = 1.0;
  double _receiveScale = 1.0;
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    // Animate in the title after a short delay.
    Future.delayed(const Duration(milliseconds: 350), () {
      setState(() {
        _showTitle = true;
      });
    });
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    required double scale,
    required void Function(bool) onHoverOrTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      onTapDown: (_) => onHoverOrTap(true),
      onTapUp: (_) => onHoverOrTap(false),
      onTapCancel: () => onHoverOrTap(false),
      child: MouseRegion(
        onEnter: (_) => onHoverOrTap(true),
        onExit: (_) => onHoverOrTap(false),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 170),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.ease,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.23),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 22),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 30),
                const SizedBox(width: 18),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3E7CFA),
              Color(0xFF4FC3F7),
              Color(0xFFE3F2FD),
            ],
            stops: [0.06, 0.55, 1],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Hero-style Title
                AnimatedOpacity(
                  opacity: _showTitle ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeInOut,
                  child: AnimatedScale(
                    scale: _showTitle ? 1.0 : 0.85,
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.elasticOut,
                    child: Hero(
                      tag: 'swiftshare-title',
                      child: Text(
                        'SwiftShare',
                        style: theme.textTheme.displayLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 48,
                              letterSpacing: 2.0,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.18),
                                  blurRadius: 18,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ) ??
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 48,
                            ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                AnimatedOpacity(
                  opacity: _showTitle ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeIn,
                  child: Text(
                    "Fast, seamless file sharing.",
                    style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white70,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ) ??
                        const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                  ),
                ),
                const SizedBox(height: 54),
                // Animated Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildActionButton(
                      icon: Icons.send_rounded,
                      label: "Send",
                      color: const Color(0xFF3E7CFA),
                      scale: _sendScale,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SendScreen(),
                          ),
                        );
                      },
                      onHoverOrTap: (hovered) {
                        setState(() {
                          _sendScale = hovered ? 1.09 : 1.0;
                        });
                      },
                    ),
                    const SizedBox(width: 32),
                    _buildActionButton(
                      icon: Icons.download_rounded,
                      label: "Receive",
                      color: const Color(0xFF00BFAE),
                      scale: _receiveScale,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ReceiveScreen(),
                          ),
                        );
                      },
                      onHoverOrTap: (hovered) {
                        setState(() {
                          _receiveScale = hovered ? 1.09 : 1.0;
                        });
                      },
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