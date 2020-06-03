pragma Ada_2012;
procedure UUID.Assign (Src : Uuid_Type; Target : System.Address) is
   L_Target : Uuid_T with
     Import => True,
     Address => Target;
begin
   L_Target := Src.Data;
end UUID.Assign;
