public class MoveServo 
{ 
	public static void main(String[] args) 
	{ 
		RXTXRobot r = new ArduinoNano(); // Create RXTXRobot object 
		r.setPort("COM3"); // Set the port to COM3; don't know which port we will have to set it to
		r.setVerbose(true); // Turn on debugging messages 
		r.connect(); 
		r.attachServo(RXTXRobot.SERVO1, 9); //Connect the servos to the Arduino; might be SERVO2 instead of SERVO1
		r.moveServo(RXTXRobot.SERVO1, 30); // Move Servo 1 to location 30; might have to experiment to see if default position is 90 degrees
		r.close(); // Moves the servo back to its default position; might delete this part
	} 
} 
