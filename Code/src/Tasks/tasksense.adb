With Ada.Real_Time; use Ada.Real_Time;
with MicroBit; use MicroBit;
With MicroBit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;

package body TaskSense is

    task body sense is
      myClock : Time;
      package Sensor1 is new Ultrasonic (MB_P16, MB_P0); -- Left
      package Sensor2 is new Ultrasonic (MB_P15, MB_P1); -- Right
      package Sensor3 is new Ultrasonic (MB_P13, MB_P12); -- Center
   begin
      
      null; 
      
      loop
         myClock := Clock; 

         Brain.SetMeasurementSensor1 (Integer(Sensor1.Read));
         Brain.SetMeasurementSensor2 (Integer(Sensor2.Read)); 
         Brain.SetMeasurementSensor3 (Integer(Sensor3.Read)); 
            
         delay until myClock + Milliseconds(100); 
      end loop;
   end sense;

end TaskSense;