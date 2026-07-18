import 'package:flutter/material.dart';
import 'models/flashcard.dart';
import 'widgets/flip_card.dart';
import 'screens/edit_card_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';


void main() {
  
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const FlashcardApp(),
    ));
}

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF3D5AFE),
        scaffoldBackgroundColor: const Color(0xFFF7F6FB),
      ),
         locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
      home: const FlashcardHomePage(),
    );
  }
}

class FlashcardHomePage extends StatefulWidget {
  const FlashcardHomePage({super.key});

  @override
  State<FlashcardHomePage> createState() => _FlashcardHomePageState();
}

class _FlashcardHomePageState extends State<FlashcardHomePage> {
  final List<Flashcard> _cards = [
    Flashcard(
      question: 'What is the capital of Egypt?',
      answer: 'Cairo',
    ),
    Flashcard(
      question: 'What does CPU stand for?',
      answer: 'Central Processing Unit',
    ),
    Flashcard(
      question: 'What is 12 x 8?',
      answer: '96',
    ),
    Flashcard(
      question: 'Who developed the Flutter framework?',
      answer: 'Google',
    ),
  ];

  int _currentIndex = 0;
  bool _showAnswer = false;

  void _toggleAnswer() {
    setState(() => _showAnswer = !_showAnswer);
  }

  void _next() {
    if (_cards.isEmpty) return;
    setState(() {
      _currentIndex = (_currentIndex + 1) % _cards.length;
      _showAnswer = false;
    });
  }

  void _previous() {
    if (_cards.isEmpty) return;
    setState(() {
      _currentIndex = (_currentIndex - 1 + _cards.length) % _cards.length;
      _showAnswer = false;
    });
  }

  Future<void> _addCard() async {
    final newCard = await Navigator.push<Flashcard>(
      context,
      MaterialPageRoute(builder: (_) => const EditCardScreen()),
    );
    if (newCard != null) {
      setState(() {
        _cards.add(newCard);
        _currentIndex = _cards.length - 1;
        _showAnswer = false;
      });
    }
  }

  Future<void> _editCard() async {
    if (_cards.isEmpty) return;
    final updatedCard = await Navigator.push<Flashcard>(
      context,
      MaterialPageRoute(
        builder: (_) => EditCardScreen(existingCard: _cards[_currentIndex]),
      ),
    );
    if (updatedCard != null) {
      setState(() {
        _cards[_currentIndex] = updatedCard;
        _showAnswer = false;
      });
    }
  }

  void _deleteCard() {
    if (_cards.isEmpty) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Flashcard'),
        content: const Text('Are you sure you want to delete this card?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _cards.removeAt(_currentIndex);
                if (_currentIndex >= _cards.length && _cards.isNotEmpty) {
                  _currentIndex = _cards.length - 1;
                }
                _showAnswer = false;
              });
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard Quiz'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (_cards.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: _editCard,
              tooltip: 'Edit card',
            ),
          if (_cards.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _deleteCard,
              tooltip: 'Delete card',
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: _cards.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.style_outlined,
                          size: 64, color: colorScheme.primary.withOpacity(0.4)),
                      const SizedBox(height: 16),
                      const Text(
                        'No flashcards yet.\nTap + to add your first card.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Text(
                      'Card ${_currentIndex + 1} of ${_cards.length}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FlipCard(
                      card: _cards[_currentIndex],
                      showAnswer: _showAnswer,
                      onToggle: _toggleAnswer,
                    ),
                    const SizedBox(height: 16),
                    TextButton.icon(
                      onPressed: _toggleAnswer,
                      icon: Icon(
                        _showAnswer
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      label: Text(_showAnswer ? 'Hide Answer' : 'Show Answer'),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _previous,
                            icon: const Icon(Icons.arrow_back_ios_rounded, size: 16),
                            label: const Text('Previous'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _next,
                            icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                            label: const Text('Next'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCard,
        backgroundColor: colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
