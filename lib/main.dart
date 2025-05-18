import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
void main()
{
  runApp(WordScrambleApp());
}
class SplashScreen extends StatefulWidget
{
  final VoidCallback onContinue;
  const SplashScreen({super.key, required this.onContinue});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen>
{
  @override
  void initState()
  {
    super.initState();
    Future.delayed(const Duration(seconds: 7), widget.onContinue);
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full-screen splash image
          Image.asset(
            'assets/splash.png',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
class WordScrambleApp extends StatefulWidget
{
  const WordScrambleApp({Key? key}) : super(key: key);
  @override
  State<WordScrambleApp> createState() => _WordScrambleAppState();
}
class _WordScrambleAppState extends State<WordScrambleApp>
{
  bool isDarkMode = false;
  bool showSplash = true;
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Word Scramble',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor:
        isDarkMode ? Colors.grey.shade900 : Colors.pink.shade50,
        textTheme: GoogleFonts.comicNeueTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: isDarkMode ? Colors.white : Colors.deepPurple.shade900,
            displayColor: isDarkMode ? Colors.white : Colors.deepPurple.shade900,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData
          (
          style: ElevatedButton.styleFrom
          (
            backgroundColor: isDarkMode ? Colors.deepPurple.shade300 : Colors.deepPurple,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: showSplash
          ? SplashScreen(onContinue: () {
        setState(() {
          showSplash = false;
        });
      })
          : WordScrambleGame(
        isDarkMode: isDarkMode,
        onToggleTheme: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
    );
  }
}

class WordScrambleGame extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  const WordScrambleGame({
    Key? key,
    required this.isDarkMode,
    required this.onToggleTheme,
  }) : super(key: key);

  @override
  State<WordScrambleGame> createState() => _WordScrambleGameState();
}

class _WordScrambleGameState extends State<WordScrambleGame> {
  final List<Map<String, String>> data = [
    {"question": "Which red fruit has seeds on the outside?", "word": "strawberry"},
    {"question": "Which animal says 'meow'?", "word": "cat"},
    {"question": "Which animal is known as man's best friend?", "word": "dog"},
    {"question": "Which fruit keeps the doctor away?", "word": "apple"},
    {"question": "Which fruit is a great source of Vitamin C?", "word": "orange"},
    {"question": "Which yellow fruit is shaped like a crescent?", "word": "banana"},
    {"question": "Which bird can mimic human speech?", "word": "parrot"},
    {"question": "Which animal is the largest land mammal?", "word": "elephant"},
    {"question": "Which animal is known for its black and white stripes?", "word": "zebra"},
    {"question": "Which animal is famous for its humps?", "word": "camel"},
    {"question": "Which fruit is small, red, and often comes in bunches?", "word": "cherry"},
    {"question": "Which vegetable is orange and good for eyesight?", "word": "carrot"},
    {"question": "Which planet is known as the Red Planet?", "word": "mars"},
    {"question": "Which star lights up our day?", "word": "sun"},
    {"question": "Which fruit has a crown and is spiky on the outside?", "word": "pineapple"},
    {"question": "Which season comes after winter?", "word": "spring"},
    {"question": "Which day comes after Monday?", "word": "tuesday"},
    {"question": "Which shape has three sides?", "word": "triangle"},
    {"question": "Which insect makes honey?", "word": "bee"},
    {"question": "Which sea creature has eight legs?", "word": "octopus"},
    {"question": "Which bird is known for its beautiful tail feathers?", "word": "peacock"},
    {"question": "Which vehicle flies in the sky?", "word": "airplane"},
    {"question": "Which object tells time?", "word": "clock"},
    {"question": "Which color do you get when you mix red and blue?", "word": "purple"},
    {"question": "Which place has sand and camels?", "word": "desert"},
    {"question": "Which tool is used to cut paper?", "word": "scissors"},
    {"question": "Which room in the house is used for cooking?", "word": "kitchen"},
    {"question": "Which pet purrs when happy?", "word": "cat"},
    {"question": "Which month comes after June?", "word": "july"},
    {"question": "Which animal has a long neck and eats leaves?", "word": "giraffe"},
    {"question": "Which cold treat is eaten in summer?", "word": "ice cream"},
    {"question": "Which machine helps you talk to someone far away?", "word": "phone"},
    {"question": "Which item do you use to write on paper?", "word": "pen"},
    {"question": "Which color do you get when you mix blue and yellow?", "word": "green"},
    {"question": "Which holiday has a red-suited man named Santa?", "word": "christmas"},
    {"question": "Which drink is made from oranges?", "word": "juice"},
    {"question": "Which animal is known for jumping and having a pouch?", "word": "kangaroo"},
    {"question": "Which natural satellite orbits the Earth?", "word": "moon"},
    {"question": "Which day is the first of the week?", "word": "sunday"},
    {"question": "Which object helps you see distant things?", "word": "telescope"},
    {"question": "Which tool is used to eat soup?", "word": "spoon"},
    {"question": "Which flower is red and symbolizes love?", "word": "rose"},
    {"question": "Which liquid falls from the sky when it rains?", "word": "water"},
    {"question": "Which animal is black and white and eats bamboo?", "word": "panda"},
    {"question": "Which shape has four equal sides?", "word": "square"},
    {"question": "Which animal is called the king of the jungle?", "word": "lion"},
    {"question": "Which fruit is green on the outside and red on the inside?", "word": "watermelon"},
    {"question": "Which insect glows in the dark?", "word": "firefly"},
    {"question": "Which animal is slow and carries its home on its back?", "word": "turtle"}
  ];
  int currentIndex = 0;
  String scrambledWord = "";
  final TextEditingController controller = TextEditingController();
  int score = 0;

  late ConfettiController _confettiController;
  @override

  void initState() {
    super.initState();
    data.shuffle();
    loadNewWord();
    _confettiController = ConfettiController(duration: Duration(seconds: 1));
  }
  @override
  void dispose()
  {
    controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }
  void loadNewWord()
  {
    if (currentIndex >= data.length)
    {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => VictoryScreen(
            score: score,
            total: data.length,
            onRestart: () {
              setState(() {
                score = 0;
                currentIndex = 0;
                loadNewWord();
              });
              Navigator.pop(context);
            },
          ),
        ),
      );
      return;
    }
    final word = data[currentIndex]["word"]!;
    scrambledWord = shuffleWord(word);
    controller.clear();
    setState(() {});
  }

  String shuffleWord(String word) {
    final chars = word.split('');
    do {
      chars.shuffle(Random());
    } while (chars.join() == word);
    return chars.join();
  }
  void checkAnswer() {
    final userAnswer = controller.text.trim().toLowerCase();
    final correctAnswer = data[currentIndex]["word"]!.toLowerCase();
    if (userAnswer == correctAnswer)
    {
      score++;
      _confettiController.play();
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Correct! 🎉", style: TextStyle(color: Colors.green)),
          content: Text("Answer was: $correctAnswer"),
          actions: [
            TextButton(
              child: const Text("Next"),
              onPressed: () {
                Navigator.pop(context);
                if ((currentIndex + 1) % 5 == 0 && currentIndex + 1 != data.length)
                {
                  showScoreChart();
                }
                else
                {
                  currentIndex++;
                  loadNewWord();
                }
              },
            ),
          ],
        ),
      );
    }
    else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Oops! ❌", style: TextStyle(color: Colors.redAccent)),
          content: const Text("Your answer is incorrect. Would you like to try again or see the answer?"),
          actions: [
            TextButton(
              child: const Text("Please Try Again"),
              onPressed: () {
                Navigator.pop(context);
                // Just close dialog, let user try again
              },
            ),
            TextButton(
              child: const Text("Show Answer"),
              onPressed: () {
                Navigator.pop(context);
                // Show the correct answer, then move to next question
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Correct Answer"),
                    content: Text("The correct answer is: $correctAnswer"),
                    actions: [
                      TextButton(
                        child: const Text("Next"),
                        onPressed: () {
                          Navigator.pop(context);
                          currentIndex++;
                          loadNewWord();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
  }

  void showScoreChart() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Score Chart"),
        content: Text("You've answered ${currentIndex + 1} questions!\n"
            "Current Score: $score / ${currentIndex + 1}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              currentIndex++;
              loadNewWord();
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (currentIndex >= data.length) return const SizedBox.shrink();
    final item = data[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Word Scramble"),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight),
            onPressed: widget.onToggleTheme,
            tooltip: widget.isDarkMode ? 'Light Mode' : 'Dark Mode',
          )
        ],
      ),
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              widget.isDarkMode ? 'assets/bg_dark.jpg' : 'assets/bg_light.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Game Content with ScrollView
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: widget.isDarkMode
                        ? [Colors.deepPurple.shade400, Colors.deepPurple.shade900]
                        : [Colors.pink.shade100, Colors.pink.shade300],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.isDarkMode ? Colors.black54 : Colors.pink.shade200,
                      offset: const Offset(0, 8),
                      blurRadius: 15,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ConfettiWidget(
                        confettiController: _confettiController,
                        blastDirectionality: BlastDirectionality.explosive,
                        shouldLoop: false,
                        numberOfParticles: 30,
                        maxBlastForce: 10,
                        minBlastForce: 5,
                        emissionFrequency: 0.05,
                        gravity: 0.2,
                      ),
                      Text(
                        item["question"] ?? "",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: 20),
                      AnimatedScrambledWord(
                        scrambledWord: scrambledWord,
                        isDarkMode: widget.isDarkMode,
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: controller,
                        style: TextStyle(
                          color: widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: widget.isDarkMode ? Colors.deepPurple.shade800 : Colors.white,
                          hintText: "Type your answer",
                          hintStyle: TextStyle(
                            color: widget.isDarkMode ? Colors.white70 : Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => checkAnswer(),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.isDarkMode
                              ? Colors.deepPurple.shade300  // Dark button in dark mode
                              : Colors.white,               // White button in light mode
                          foregroundColor: widget.isDarkMode
                              ? Colors.white                // White text in dark mode
                              : Colors.black,              // Black text in light mode
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                          shadowColor: widget.isDarkMode
                              ? Colors.black54
                              : Colors.pink.shade100,
                        ),
                        onPressed: checkAnswer,
                        child: const Text("Check Answer"),
                      ),

                      const SizedBox(height: 20),
                      Text(
                        "Score: $score / ${data.length}",
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}

// Animated Scrambled Word Widget
class AnimatedScrambledWord extends StatelessWidget {
  final String scrambledWord;
  final bool isDarkMode;

  const AnimatedScrambledWord({
    super.key,
    required this.scrambledWord,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: scrambledWord
          .split('')
          .map(
            (char) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.deepPurple.shade700 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: isDarkMode ? Colors.black26 : Colors.pink.shade200,
                blurRadius: 6,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Text(
            char.toUpperCase(),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      )
          .toList(),
    );
  }
}

// Victory Screen
class VictoryScreen extends StatelessWidget {
  final int score;
  final int total;
  final VoidCallback onRestart;

  const VictoryScreen({
    super.key,
    required this.score,
    required this.total,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events, size: 100, color: Colors.amber),
              const SizedBox(height: 20),
              const Text(
                "🎉 Congratulations! 🎉",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "You completed the game with a score of",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "$score / $total",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: onRestart,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 6,
                ),
                child: const Text(
                  "Play Again",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}