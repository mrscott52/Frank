import rxtxrobot.*; 
 
public class RunBothEncodedMotors 
{ 
	public static void main(String[] args) 
	{ 
		//To run both motors and move forward, use the RunBothMotors.java command from the website (Shocker, a true shocker)
		RXTXRobot r = new ArduinoNano(); // Create RXTXRobot object 
		r.setPort("COM2"); // Set port to COM2 
		r.connect(); 
		//We don't have to attach anything because these motors are 
		//attached by default 
		r.runEncodedMotor(RXTXRobot.MOTOR1, 255, 100, RXTXRobot.MOTOR2, 255, 100); // Run both motors forward, one for 100,000 ticks and one for 100,000 ticks. 
		r.close(); 
	} 
} 
