import rxtxrobot.*;
public class getThermistorReading
{
public static int getThermistorReading()
{
	int sum = 0;
	int readingCount = 10;{
	
	for (int i = 0; i < readingCount; i++)
	{
		robot.refreshAnalogPins();
		int reading = robot.getAnalogPin(0).getValue();
		sum += reading;
	}
	return sum / readingCount;
}
}
public static RXTXRobot robot;

public static void main(String[] args)
{
	robot = new ArduinoUno();
	robot.setPort("COM3");
	robot.connect();
	
	int thermistorReading = getThermistorReading();
	
	System.out.println("The probe reads the value: " + thermistorReading);
	System.out.println("In volts: " + (thermistorReading * (5.0/1023.0)));
	robot.close();
}
}
