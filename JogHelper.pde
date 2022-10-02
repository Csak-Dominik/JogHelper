ArrayList<Theme> themes = new ArrayList<Theme>();

Question currentQuestion;

void setup() {
    size(800, 600);
    themes = ParseTextFile("jog.txt");

    println("Available fonts:");
    String[] fontList = PFont.list();
    printArray(fontList);

    //textFont(loadFont("ArialMT-48.vlw"), 12f);
    textSize(20);

    currentQuestion = RandomQuestionInThemeRange(0, 1);
}

void draw() {
    background(0);
    DisplayQuestion(currentQuestion);
}

Question RandomQuestionInThemeRange(int minIndex, int maxIndex) {
    int rndTheme = floor(random(minIndex, maxIndex+1));
    Theme t = themes.get(rndTheme);
    int rndQuestion = floor(random(0, t.questions.size()));
    Question q = t.questions.get(rndQuestion);

    return q;
}

void DisplayQuestion(Question q) {
    fill(255);
    textAlign(CENTER, BASELINE);
    text(q.questionCode, width/2, height/2-(q.answers.size()*20)-60);
    text(q.questionText, width/2, height/2-(q.answers.size()*20)-40);

    int index = 0;
    for (Answer a : q.answers) {
        boolean horizHover = mouseX >= width/2-textWidth(a.answerText)/2f && mouseX < width/2+textWidth(a.answerText)/2f;
        boolean vertHover = mouseY >= height/2-(q.answers.size()/2f * 20)+(index * 20) - 20 && mouseY < height/2-(q.answers.size()/2f * 20)+(index * 20);
        if (horizHover && vertHover) {
            fill(255, 255, 0);
        } else {
            fill(255);
        }
         text(a.answerText, width/2, height/2-(q.answers.size()/2f * 20)+(index * 20));

         index++;
    }
}

enum ParsePhase {
    THEME,
    QUESTION_CODE,
    QUESTION_TEXT,
    ANSWER
}

 ArrayList<Theme> ParseTextFile(String name) {
    String[] lines = loadStrings(name);
    if (lines == null) return null;
    
    ParsePhase phase = ParsePhase.THEME;

    ArrayList<Theme> parseThemes = new ArrayList<Theme>();

    Theme theme = new Theme();
    Question question = new Question();

    int lineNumber = 1;
    for (String line : lines) {
        print("Line: "+lineNumber+" - ");
        lineNumber++;

        switch(phase) {
            case THEME:
            {
                if (line.substring(0, 2).equals("--")) {
                    println("Ended theme name parsing...");
                    phase = ParsePhase.QUESTION_CODE;
                } else {
                    println("Parsing theme name...");
                    theme = new Theme();
                    parseThemes.add(theme);
                    theme.themeName = line;
                }
                break;
            }
            case QUESTION_CODE:
            {
                println("Parsing question code...");
                question = new Question();
                theme.questions.add(question);
                question.questionCode = line;
                phase = ParsePhase.QUESTION_TEXT;
                break;
            }
             case QUESTION_TEXT:
            {
                println("Parsing question text...");
                question.questionText = line;
                phase = ParsePhase.ANSWER;
                break;
            }
            case ANSWER:
            {   
                if (line.equals("")) {
                    println("Jumping to new question parsing...");
                    phase = ParsePhase.QUESTION_CODE;
                    break;
                }
                if (line.substring(0, 2).equals("--")) {
                    println("Jumping to new theme parsing...");
                    phase = ParsePhase.THEME;
                    break;
                }

                println("Parsing answer...");

                Answer ans = new Answer();
                question.answers.add(ans);
                if (line.substring(0, 1).equals("-")) {
                    ans.answerText = line.substring(1, line.length());
                    ans.correctAnswer = true;
                } else {
                    ans.answerText = line;
                    ans.correctAnswer = false;
                }
                break;
            }
            default:
            {
                println("ParsePhase not in switch statement!");
            }
        }
    }

    return parseThemes;
}
