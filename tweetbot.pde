//// robot_02 ////
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License Version 2
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//
// You will find the latest version of this code at the following address:
// http://github.com/pchretien
//
// You can contact me at the following email address:
// philippe.chretien@gmail.com

#include <Servo.h> 

#define MOTOR_1A 2
#define MOTOR_1B 3
#define MOTOR_2A 4
#define MOTOR_2B 5

#define TURN_DELAY 2000
#define RUN_DELAY 4000

Servo servo;

void forward()
{
  digitalWrite(MOTOR_1A, LOW);
  digitalWrite(MOTOR_1B, HIGH);
  digitalWrite(MOTOR_2A, LOW);
  digitalWrite(MOTOR_2B, HIGH);
}

void backward()
{
  digitalWrite(MOTOR_1A, HIGH);
  digitalWrite(MOTOR_1B, LOW);
  digitalWrite(MOTOR_2A, HIGH);
  digitalWrite(MOTOR_2B, LOW);
}

void right()
{
  digitalWrite(MOTOR_1A, LOW);
  digitalWrite(MOTOR_1B, HIGH);
  digitalWrite(MOTOR_2A, HIGH);
  digitalWrite(MOTOR_2B, LOW);
}

void left()
{
  digitalWrite(MOTOR_1A, HIGH);
  digitalWrite(MOTOR_1B, LOW);
  digitalWrite(MOTOR_2A, LOW);
  digitalWrite(MOTOR_2B, HIGH);
}

void stop()
{
  digitalWrite(MOTOR_1A, LOW);
  digitalWrite(MOTOR_1B, LOW);
  digitalWrite(MOTOR_2A, LOW);
  digitalWrite(MOTOR_2B, LOW);
}

void setup()
{
  servo.attach(9);
  servo.write(90);
  
  pinMode(MOTOR_1A, OUTPUT);
  pinMode(MOTOR_1B, OUTPUT);
  pinMode(MOTOR_2A, OUTPUT);
  pinMode(MOTOR_2B, OUTPUT);
  
  pinMode(10, OUTPUT); // To L293 pin #1
  pinMode(11, OUTPUT); // To L293 pin #9
  //analogWrite(10, 185); // Faster motor at 72% of its full speed
  //analogWrite(11, 255); // Slower motor at 100% of its full speed
  digitalWrite(10,HIGH);
  digitalWrite(11,HIGH);

  // For debug
  Serial.begin(19200);
}

void loop()
{     
  if ( Serial.available()) 
  {
    char ch = Serial.read();

    switch(ch) 
    {
      case '1': // forward
        servo.write(90);
        forward();
        delay(RUN_DELAY);
        stop();
        break;
      case '2': // backward
        servo.write(90);
        backward();
        delay(RUN_DELAY);
        stop();
        break;
      case '3': // right
        servo.write(180);
        right();
        delay(TURN_DELAY);
        forward();
        delay(RUN_DELAY);
        stop();
        break;
      case '4': // left
        servo.write(0);
        left();
        delay(TURN_DELAY);
        forward();
        delay(RUN_DELAY);
        stop();
        break;
      case '5': // left-right
        servo.write(0);
        left();
        delay(TURN_DELAY);
        servo.write(180);
        right();
        delay(2*TURN_DELAY);
        stop();
        break;
      case '6': // left-right
        servo.write(0);
        left();
        delay(4*TURN_DELAY);
        stop();
        break;
    }
  }
}

