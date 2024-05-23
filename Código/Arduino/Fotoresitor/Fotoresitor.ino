const int LED1 =2;
const int LED2 =4;
const int LED3 =7;
const int LED4 =8;
const int LED5 =12;
const int LED6 =13;

int LDR =0;
int valLDR=0;

void setup(){
  pinMode(LED1,OUTPUT);
  pinMode(LED2,OUTPUT);
  pinMode(LED3,OUTPUT);
  pinMode(LED4,OUTPUT);
  pinMode(LED5,OUTPUT);
  pinMode(LED6,OUTPUT);
  Serial.begin(9600);
}

void loop(){
  digitalWrite(LED1,LOW);
  digitalWrite(LED2,LOW);
  digitalWrite(LED3,LOW);
  digitalWrite(LED4,LOW);
  digitalWrite(LED5,LOW);
  digitalWrite(LED6,LOW);
  valLDR=analogRead(LDR);
  Serial.println(valLDR);
  if(valLDR>600){
    digitalWrite(LED1,HIGH);
  } 
  if(valLDR>700){
    digitalWrite(LED2,HIGH);
  } 
  if(valLDR>800){
    digitalWrite(LED3,HIGH);
  }
  if(valLDR>900){
    digitalWrite(LED4,HIGH);
  } 
  if(valLDR>1000){
    digitalWrite(LED5,HIGH);
  } 
  if(valLDR>1023){
    digitalWrite(LED6,HIGH);
  }
  delay(200);
}