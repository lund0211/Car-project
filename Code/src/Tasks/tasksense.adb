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
      StartTime : Time;
      EndTime : Time;
      ElapsedTime: Time_Span;
   begin
      
      null; -- note that you can place Setup code here that is only run once for the entire task
      
      loop
         myClock := Clock; --important to get current time such that the period is exactly 200ms.
                           --you need to make sure that the instruction NEVER takes more than this period. 
                           --make sure to measure how long the task needs, see Tasking_Calculate_Execution_Time example in the repository.
                           --What if for some known or unknown reason the execution time becomes larger?
                           --When Worst Case Execution Time (WCET) is overrun so higher than your set period, see : https://www.sigada.org/ada_letters/dec2003/07_Puente_final.pdf
                           --In this template we put the responsiblity on the designer/developer.
         
         --delay (0.024); --simulate a sensor eg the ultrasonic sensors needs at least 24ms for 400cm range, replace with your code!!!
                        -- to integrate for example an ultrasonic sensor: copy paste the ultrasonic package for the ultrasonic example to the src directory
                        -- include it using  "with ultrasonic; use ultrasonic". The ultrasonic sensor uses type Distance_CM how can we make that compatible with our Brain.SetMeasurementSensor1?  
         --put_Line("TaskSense: Sense and send to Brain");
         --StartTime := Clock;
         Brain.SetMeasurementSensor1 (Integer(Sensor1.Read)); -- random value, hook up a sensor here note that you might need to either cast to integer OR -better- change type of Brain.SetMeasurementSensor1
         Brain.SetMeasurementSensor2 (Integer(Sensor2.Read)); -- random value, hook up another sensor here
         Brain.SetMeasurementSensor3 (Integer(Sensor3.Read)); -- random value, hook up the third sensor here

         --EndTime := Clock;
         --ElapsedTime := EndTime - StartTime;
         --Put_Line ("Elapsed Time: " & Duration'Image (To_Duration(ElapsedTime)));
         --Put_Line ("Left Distance:  " & Integer'Image (Integer(Sensor1.Read)));
         --Put_Line ("Right Distance:  " & Integer'Image (Integer(Sensor2.Read)));
            
         delay until myClock + Milliseconds(200); --random period
      end loop;
   end sense;

end TaskSense;