import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({Key? key}) : super(key: key);

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _contentController;
  List<PlatformFile>? _selectedFiles;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    // Staggered animation
    _headerController.forward().then((_) => _contentController.forward());
  }

  @override
  void dispose() {
    _headerController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        _selectedFiles = result.files;
      });
    } else {
      Fluttertoast.showToast(
        msg: "No file selected",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
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
              AnimatedBuilder(
                animation: _headerController,
                builder: (context, child) {
                  return AnimatedOpacity(
                    opacity: _headerController.value,
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedScale(
                      scale: 0.95 + 0.05 * _headerController.value,
                      duration: const Duration(milliseconds: 500),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  "Send Files",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Center(
                  child: AnimatedBuilder(
                    animation: _contentController,
                    builder: (context, child) {
                      return AnimatedOpacity(
                        opacity: _contentController.value,
                        duration: const Duration(milliseconds: 400),
                        child: AnimatedScale(
                          scale: 0.95 + 0.05 * _contentController.value,
                          duration: const Duration(milliseconds: 400),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.07),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.upload_file_rounded,
                            color: Colors.white.withOpacity(0.92),
                            size: 52,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "Select files to send",
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white.withOpacity(0.96),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Tap below to choose files from your device.",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: 180,
                            height: 48,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF606c88),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                textStyle: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: _pickFiles,
                              icon: const Icon(Icons.add_rounded, size: 26),
                              label: const Text("Pick Files"),
                            ),
                          ),
                          if (_selectedFiles != null && _selectedFiles!.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _selectedFiles!.length,
                                itemBuilder: (context, index) {
                                  final file = _selectedFiles![index];
                                  return Text(
                                    file.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ],
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