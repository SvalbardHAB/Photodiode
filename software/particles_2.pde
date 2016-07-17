bool inEvent = false;
long eventStart = 0;
int eventPeak = 0;

int avg;
const int delta = 14;

void setup() {
  Serial.begin(115200);
  Serial.println("calibrating average level");
  long sum = 0;
  for(int i = 0; i < 100000; i++) {
     sum += analogRead(A0); 
  }
  avg = sum / 100000;
  Serial.print("avg = ");
  Serial.println(avg);
  Serial.println("started event detection");
  pinMode(13, OUTPUT);
  digitalWrite(13, LOW);
}

void loop() {
  long t = micros();
  int val = analogRead(A0);
  if(inEvent) {
   if(val <= (avg + delta)) {
     inEvent = false;
    // Serial.print("p=");
     Serial.print(millis() / 1000);
     Serial.print("\t");
     Serial.print(eventPeak - avg);
     Serial.print("\t");
     Serial.println(t - eventStart);
   } else if(val > eventPeak) {
     eventPeak = val; 
   }
  } else {
   if(val > (avg + delta)) {
    digitalWrite(13, HIGH);
    inEvent = true;
    eventStart = t;
    eventPeak = val; 
   }
  } 
  if((!inEvent) && ((t - eventStart) > 300000)) {
   eventStart = t; 
   digitalWrite(13, LOW);
  }
}
