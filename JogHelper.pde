ArrayList<Theme> themes = new ArrayList<Theme>();

void setup() {
    size(640, 480);
    ParseTextFile("jog.txt");
}

void draw() {
    background(0);
}

enum ParsePhase {
    NONE,
    THEME,
    QUESTION,
    ANSWER
}

void ParseTextFile(String name) {
    String[] lines = loadStrings(name);
    if (lines == null) return;
    
    ParsePhase phase = ParsePhase.NONE;
    
    for (String line : lines) {
        switch (phase) {
            case NONE: {
                if () {
                    
                }
                break;
            }
            case THEME: {
                break;
            }
            case QUESTION: {
                break;
            }
            case ANSWER: {
                break;
            }
            default :
            {
                println("ParsePhase not in switch statement!");
            }
        }
    }
}
