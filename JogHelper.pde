ArrayList<Theme> themes = new ArrayList<Theme>();

void setup() {
    size(640, 480);
    ParseTextFile("jog.txt");
}

void draw() {
    background(0);
}

void ParseTextFile(String name){
    String[] lines = loadStrings(name);
    if (lines == null) return;

    for (String line : lines) {
        
    }
}
