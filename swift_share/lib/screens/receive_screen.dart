import 'package:flutter/material.dart';
import 'dart:ui';

class ReceiveScreen extends StatefulWidget {
  const ReceiveScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> with SingleTickerProviderStateMixin {
  double _headerOpacity = 0;
  double _cardOpacity = 0;
  double _cardScale = 0.95;

  @override
  void initState() {
    super.initState();
    // Animate header and card on mount.
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _headerOpacity = 1;
      });
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        _cardOpacity = 1;
        _cardScale = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
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
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              AnimatedOpacity(
                opacity: _headerOpacity,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                child: Text(
                  'Receive Files',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 64),
              Expanded(
                child: Center(
                  child: AnimatedOpacity(
                    opacity: _cardOpacity,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    child: AnimatedScale(
                      scale: _cardScale,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOutBack,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  '📥',
                                  style: TextStyle(fontSize: 48),
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  'Waiting for sender…',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[900],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Keep this screen open to receive files',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[600],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}