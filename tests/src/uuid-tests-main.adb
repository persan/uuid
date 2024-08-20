with Ada.Text_IO;
with UUID.Assign;
with UUID.Get;
with GNAT.Traceback.Symbolic;
with GNAT.Exception_Traces;


procedure UUID.Tests.Main is
   U  : Uuid_Type;
   U1 : Uuid_Type;

begin
   GNAT.Exception_Traces.Trace_On (GNAT.Exception_Traces.Every_Raise);
   GNAT.Exception_Traces.Set_Trace_Decorator (GNAT.Traceback.Symbolic.Symbolic_Traceback_No_Hex'Access);

   Ada.Text_IO.Put_Line (Boolean'Image (U = U1));
   Ada.Text_IO.Put_Line (U.Is_Null'Img);
   Ada.Text_IO.Put_Line (U.Variant'Img);

   U.Generate;
   Ada.Text_IO.Put_Line (U.Variant'Img);
   Ada.Text_IO.Put_Line (U.Gettype'Img);

   Ada.Text_IO.Put_Line (Boolean'Image (U = U1));
   Ada.Text_IO.Put_Line (U.Is_Null'Img);

   Ada.Text_IO.Put_Line (NULL_UUID.Image);
   Ada.Text_IO.Put_Line (U.Image);
   Ada.Text_IO.Put_Line (U.Image (Upper_Case));
   Ada.Text_IO.Put_Line (U.Image (Lower_Case));
   Ada.Text_IO.New_Line;

   for I in 1 .. 3 loop
      U.Generate_Time;
      Ada.Text_IO.Put_Line (U.Image);
   end loop;

   Ada.Text_IO.New_Line;
   for I in 1 .. 3 loop
      U.Generate_Random;
      Ada.Text_IO.Put_Line (U.Image);
   end loop;
   Ada.Text_IO.New_Line;

   for I in 1 .. 3 loop
      U.Generate_Time;
      Ada.Text_IO.Put_Line (U.Image & " " &
                              Parse (U.Image).Image & " " & U.Variant'Img &  (if U.Variant = DCE then "/" & U.Gettype'Img else ""));
   end loop;
   Ada.Text_IO.New_Line;

   declare
      Buffer : String (1 .. 32) := (others => ASCII.NUL);
   begin
      U.Generate_Time;
      Assign (U, Buffer'Address);
      U1 := Get (Buffer'Address);
      if U1 /= U then
         raise Program_Error with "Invalid data" & Image (U) & "/=" &  Image (U1);
      end if;

   end;

end UUID.Tests.Main;
