With Ada.Real_Time; use Ada.Real_Time;
With MicroBit.Console; use MicroBit.Console;
with MicroBit.MotorDriver; 
with DFR0548; 
with MicroBit.IOsForTasking;

package body TaskAct is

   task body act is
      myClock : Time;   
      Distance1 : Integer:= 20;
      Distance2 : Integer := 10;   
   begin
      
      
      loop
         myClock := Clock;

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

         delay until myClock + Milliseconds(50); 
      end loop;
   end act;
   
   
   
end TaskAct;