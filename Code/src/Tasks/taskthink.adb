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
   Distance1 : Integer:= 30;
   Distance2 : Integer := 10;


   LeftDistanceClose : Boolean := false;
   RightDistanceClose : Boolean := false;
   BackDistanceClose : Boolean := false;
   LeftDistanceVeryClose : Boolean := false;
   RightDistanceVeryClose : Boolean := false;
   BackDistanceVeryClose : Boolean := false;



   begin

   MotorDriver.SetDirection(Forward);
      loop
         
         myClock := Clock;
         StartTime := Clock;
         Sensor1 := Brain.GetMeasurementSensor1;
         Sensor2 := Brain.GetMeasurementSensor2;
         Sensor3 := Brain.GetMeasurementSensor3;

         LeftDistanceClose := (Sensor1 < Distance1 and Sensor1 /= 0);
         RightDistanceClose := (Sensor2 < Distance1 and Sensor2 /= 0);
         BackDistanceClose := (Sensor3 < Distance1 and Sensor3 /= 0);
         LeftDistanceVeryClose := (Sensor1 < Distance2 and Sensor1 /= 0);
         RightDistanceVeryClose := (Sensor2 < Distance2 and Sensor2 /= 0);
         BackDistanceVeryClose := (Sensor3 < Distance2 and Sensor3 /= 0);



         case MotorDriver.GetDirection is
            when Forward =>
               if(LeftDistanceClose or RightDistanceClose) then
                  MotorDriver.SetDirection(stop);

               end if;
            when Stop =>
               if(not LeftDistanceClose and not RightDistanceClose) then
                  MotorDriver.SetDirection(Forward);
               elsif((LeftDistanceVeryClose or RightDistanceVeryClose) and not BackDistanceClose) then
                  MotorDriver.SetDirection(Backward);
               elsif(RightDistanceClose) then
                  MotorDriver.SetDirection(Left);
               elsif(LeftDistanceClose) then
                  MotorDriver.SetDirection(Right);
               end if;
            when Left | Right =>
               if(LeftDistanceVeryClose or RightDistanceVeryClose or BackDistanceVeryClose) then
                  MotorDriver.SetDirection(stop);
               elsif((Sensor1 > Distance1 or Sensor1 = 0) or (Sensor2 > Distance1 or Sensor2 = 0) or (Sensor3 > Distance1 or Sensor3 = 0)) then
                  MotorDriver.SetDirection(Stop);
               end if;

            when Backward =>
               if((not LeftDistanceClose and not RightDistanceClose) or (BackDistanceVeryClose)) then
                  MotorDriver.SetDirection(stop);

               end if;
            
         end case;

         EndTime := Clock;
         ElapsedTime := EndTime - StartTime;
         --Put_Line("Elapsed time (ms):" &Duration'Image (To_Duration (ElapsedTime) * 1_000.0));
         
         delay until myClock + Milliseconds(100);  --random period
      end loop;
   end think;


end TaskThink;