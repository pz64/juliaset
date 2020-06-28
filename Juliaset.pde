
int MAX_ITERATION = 100;

double tx = 2;
double ty = 2;

double zoom = 4f;

float  angle = 0.0;

double w, h, xMin, yMin, xMax, yMax, dx, dy;

void setup() {
    size(512, 512);
    colorMode(HSB);
    
    w = zoom;
    h = (w * height) / width;

    xMin = -w/tx;
    yMin = -h/ty;

    xMax = xMin + w;
    yMax = yMin + h;

    dx = (xMax - xMin) / width;
    dy = (yMax - yMin) / height;
    
}

void draw() {

    background(255);

    double cR = 0.7886* sin(angle);

    double cI = 0.7886* cos(angle);

    loadPixels();

    angle += 0.05;

    double y = yMin;
    for (int j = 0; j < height; ++j) {
        double x = xMin;
        for (int i = 0; i < width; ++i) {
            
            int currentIteration = 0;

            double a = x;
            double b = y;

            while (currentIteration < MAX_ITERATION) {

                double aS = a * a;
                double bS = b * b;

                if (aS + bS > 4) {
                    break;
                }

                double twoAB = 2 * a * b;
                a = aS - bS + cR ;
                b = twoAB + cI;

                currentIteration++;
            }
            
           if(currentIteration >= MAX_ITERATION) {
                pixels[i + j*width] = color(254, 0, 0);
            } else {
                 float c1 = map (sin(currentIteration + cos(currentIteration)), -1, 1, 0, 255);
                pixels[i + j*width] = color(c1 , 255 - c1, 255 - c1);
            } 
            x += dx; 
        }
        y += dy;   
    }

    updatePixels();
}

