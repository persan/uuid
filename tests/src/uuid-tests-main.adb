with Ada.Text_IO;
procedure UUID.Tests.Main is
   U  : Uuid_Type;
   U1 : Uuid_Type;

begin
   Ada.Text_IO.Put_Line (Boolean'Image (U = U1));
   Ada.Text_IO.Put_Line (U.Is_Null'Img);
   Ada.Text_IO.Put_Line (U.Variant'Img);

   U.Generate;
   Ada.Text_IO.Put_Line (U.Variant'Img);
   Ada.Text_IO.Put_Line (U.Gettype'Img);

   Ada.Text_IO.Put_Line (Boolean'Image(U = U1));
   Ada.Text_IO.Put_Line (U.Is_Null'Img);

   Ada.Text_IO.Put_Line (U.Image);
   Ada.Text_IO.Put_Line (U.Image (Upper_Case));
   Ada.Text_IO.Put_Line (U.Image (Lower_Case));
   Ada.Text_IO.New_Line;
   for I in 1 .. 10 loop
      U.Generate_Time;
      Ada.Text_IO.Put_Line (U.Image);
   end loop;
   Ada.Text_IO.New_Line;
   U.Generate_Random;

   for I in 1 .. 10 loop
      U.Generate_Time_Safe;
      Ada.Text_IO.Put_Line (U.Image & " " &
                              Parse (U.Image).Image & " " & U.Variant'Img &  (if U.Variant = DCE then "/" & U.Gettype'Img else ""));
   end loop;
   Ada.Text_IO.New_Line;

end UUID.Tests.Main;
