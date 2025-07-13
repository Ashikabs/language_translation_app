import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageTranslateScreen extends StatefulWidget {
  const LanguageTranslateScreen({super.key});

  @override
  State<LanguageTranslateScreen> createState() =>
      _LanguageTranslateScreenState();
}

class _LanguageTranslateScreenState extends State<LanguageTranslateScreen> {
  final translator = GoogleTranslator();
  final translationController = TextEditingController();

  String inputText = '';
  String fromLanguage = 'English';
  String toLanguage = 'French';
  bool isLoading = false;

  final Map<String, String> languageMap = {
    'English': 'en',
    'French': 'fr',
    'German': 'de',
    'Japanese': 'ja',
    'Chinese': 'zh',
    'Hindi': 'hi',
  };

  textTranslator() async {
    if (inputText.trim().isEmpty) return;

    setState(() {
      isLoading = true;
    });

    final translation = await translator.translate(
      inputText,
      from: languageMap[fromLanguage]!,
      to: languageMap[toLanguage]!,
    );

    setState(() {
      translationController.text = translation.text;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f1f22),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Heading
                Center(
                  child: Text(
                    "🗣️ Let's Translate Magic!",
                    style: GoogleFonts.fredoka(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 🔹 Input Label
                Text(
                  "Your Text:",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 6),

                // 🔹 Input Box
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    maxLines: 5,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      setState(() {
                        inputText = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type something to translate...",
                      hintStyle: TextStyle(color: Colors.white38),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔹 Language Pickers
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // From Language
                    Column(
                      children: [
                        Text("From", style: GoogleFonts.poppins(color: Colors.white70)),
                        DropdownButton<String>(
                          value: fromLanguage,
                          dropdownColor: Colors.black,
                          style: const TextStyle(color: Colors.white),
                          items: languageMap.keys.map((lang) {
                            return DropdownMenuItem<String>(
                              value: lang,
                              child: Text(lang),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              fromLanguage = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    const Icon(Icons.swap_horiz, color: Colors.white),
                    const SizedBox(width: 20),
                    // To Language
                    Column(
                      children: [
                        Text("To", style: GoogleFonts.poppins(color: Colors.white70)),
                        DropdownButton<String>(
                          value: toLanguage,
                          dropdownColor: Colors.black,
                          style: const TextStyle(color: Colors.white),
                          items: languageMap.keys.map((lang) {
                            return DropdownMenuItem<String>(
                              value: lang,
                              child: Text(lang),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              toLanguage = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 🔹 Output Label
                Text(
                  "Translated Text:",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 6),

                // 🔹 Output Box
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: translationController,
                    maxLines: 5,
                    readOnly: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Translation appears here...",
                      hintStyle: TextStyle(color: Colors.white38),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // 🔹 Translate Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: textTranslator,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Icon(Icons.translate, color: Colors.white),
                    label: Text(
                      isLoading ? "Translating..." : "✨ Translate Now",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                if (isLoading)
                  const SizedBox(height: 20),
                if (isLoading)
                  const Center(child: CircularProgressIndicator(color: Colors.pinkAccent)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
