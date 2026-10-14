With Ada.Real_Time; use Ada.Real_Time;
with microBit.Console; use MicroBit.Console;
with MyMotorDriver; use MyMotorDriver;

package body TaskThink is

  task body think is
   Sensor1 : Integer;
   Sensor2 : Integer;
   Sensor3 : Integer;
   myClock : Time;
   StartTime : Time;
   EndTime : Time;
   ElapsedTime: Time_Span;
   Distance1 : Integer:= 20;
   Distance2 : Integer := 10;

   begin
      loop
         
         myClock := Clock;
         Sensor1 := Brain.GetMeasurementSensor1;
         Sensor2 := Brain.GetMeasurementSensor2;
         Sensor3 := Brain.GetMeasurementSensor3;
         --StartTime := Clock;
         MotorDriver.SetDirection(Forward);
         case MotorDriver.GetDirection is
            when Forward =>
               if((Sensor1 /= 0 and Sensor2 /= 0) and (Sensor1 < Distance2 or Sensor2 < Distance2)) then
                  MotorDriver.SetDirection(Backward);
               elsif(Sensor2 /= 0 and Sensor2 < Distance1) then
                  MotorDriver.SetDirection(Left);
               elsif(Sensor1 /= 0 and Sensor1 < Distance1) then
                  MotorDriver.SetDirection(Right);
               end if;
            when Stop =>
               Put_Line ("Current Direction is: Stop");
            when Left =>
               if((Sensor1 /= 0 and Sensor2 /= 0) and (Sensor1 < Distance2 or Sensor2 < Distance2)) then
                  MotorDriver.SetDirection(Backward);
               elsif((Sensor1 = 0 and Sensor2 = 0) or (Sensor1 > Distance1 and Sensor2 > Distance1)) then
               MotorDriver.SetDirection(Forward);
               end if;
            when Right =>
               if((Sensor1 /= 0 and Sensor2 /= 0) and (Sensor1 < Distance2 or Sensor2 < Distance2)) then
                  MotorDriver.SetDirection(Backward);
               elsif((Sensor1 = 0 and Sensor2 = 0) or (Sensor1 > Distance1 and Sensor2 > Distance1)) then
               MotorDriver.SetDirection(Forward);
               end if;
            when Backward =>
               if(Sensor3 /= 0 and Sensor3 < Distance2) then
                  MotorDriver.SetDirection(Forward);
               elsif((Sensor1 = 0 and Sensor2 = 0) or (Sensor1 > Distance1 and Sensor2 > Distance1)) then
               MotorDriver.SetDirection(Forward);
               end if;
            
         end case;

         --if((Sensor1 = 0 and Sensor2 = 0) or (Sensor1 > 20 and Sensor2 > 20)) then
            --MotorDriver.SetDirection(Forward);
         --elsif(Sensor1 < Sensor2) then
            --MotorDriver.SetDirection(Right);
         --elsif(Sensor1 > Sensor2) then
            --MotorDriver.SetDirection(Left);
         --else
            --MotorDriver.SetDirection(Stop);
         --end if;
         --EndTime := Clock;
         --ElapsedTime := EndTime - StartTime;
         --Put_Line ("Elapsed Time: " & Time_Span'Image (ElapsedTime));
         
         delay until myClock + Milliseconds(100);  --random period
      end loop;
   end think;


end TaskThink;