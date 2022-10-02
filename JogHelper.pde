ArrayList<Theme> themes = new ArrayList<Theme>();

void setup() {
    size(640, 480);
    ParseTextFile("jog.txt");
}

void draw() {
    background(0);
}

enum ParsePhase {
    THEME,
    QUESTION_CODE,
    QUESTION_TEXT,
    ANSWER
}

 ArrayList<Theme> ParseTextFile(String name) {
    String[] lines = loadStrings(name);
    if (lines == null) return;
    
    ParsePhase phase = ParsePhase.THEME;

    ArrayList<Theme> parseThemes = new ArrayList<Theme>();

    Theme theme;
    Question question;

    for (String line : lines) {
        switch(phase) {
            case THEME:
            {
                if (line.substring(0, 2).equals("--")) {
                    println("Ended theme name parsing...");
                    phase = ParsePhase.QUESTION_CODE;
                } else {
                    println("Parsing theme name...");
                    theme = new Theme();
                    theme.themeName = line;
                }
                break;
            }
            case QUESTION_CODE:
            {
                question = new Question(),
                question.questionCode = line;
                phase = 
                break;
            }
             case QUESTION_TEXT:
            {
                break;
            }
            case ANSWER:
            {
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
