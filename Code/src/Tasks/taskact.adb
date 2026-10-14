With Ada.Real_Time; use Ada.Real_Time;
With MicroBit.Console; use MicroBit.Console;
with MicroBit.MotorDriver; 
with DFR0548; 
with MicroBit.IOsForTasking;

--Important: use Microbit.IOsForTasking for controlling pins as the timer used there is implemented as an protected object
--With MicroBit.IOsForTasking; use MicroBit.IOsForTasking;

package body TaskAct is

   task body act is
      myClock : Time;   
      StartTime : Time;
      EndTime : Time;
      ElapsedTime: Time_Span;
      Distance1 : Integer:= 20;
      Distance2 : Integer := 10;   
   begin
      
       -- we do Setup once at the start of the task;
      
      loop
         myClock := Clock;
     
         --Drive(Forward);
         --MicroBit.MotorDriver.Drive(MicroBit.MotorDriver.Forward,(4095,4095,4095,4095));
         StartTime := Clock;
         case MotorDriver.GetDirection is
            when Forward =>
               MicroBit.MotorDriver.Drive(MicroBit.MotorDriver.Forward,(2000,2000,2000,2000));
            when Stop =>
               MicroBit.MotorDriver.Drive(MicroBit.MotorDriver.Stop,(0,0,0,0));
            when Left =>
               MicroBit.MotorDriver.Drive(MicroBit.MotorDriver.Rotating_Left,(2000,2000,2000, 2000));
            when Right =>
               MicroBit.MotorDriver.Drive(MicroBit.MotorDriver.Rotating_Right,(2000,2000,2000,2000));
            when Backward =>
               MicroBit.MotorDriver.Drive(MicroBit.MotorDriver.Backward,(2000,2000,2000,2000));
         end case;

         --test

         EndTime := Clock;
         ElapsedTime := EndTime - StartTime;
         
         Put_Line("Elapsed time Act(ms):" &Duration'Image (To_Duration (ElapsedTime) * 1_000.0));
       
         delay until myClock + Milliseconds(50);  --random period, but faster than 20 ms is no use because Set_Analog_Period_Us(20000) !
                                                  --faster is better but note the weakest link: if decisions in the thinking task come at 100ms and acting come at 20ms 
                                                  --then no change is set in the acting task for at least 5x (and is wasting power to wake up and execute task!)
      end loop;
   end act;
   
   
   
end TaskAct;