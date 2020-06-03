pragma Ada_2012;
function UUID.get (Source : System.Address) return Uuid_Type is
   L_Source : Uuid_T with
     Import => True,
     Address => Source;
begin
   return ret : Uuid_Type do
      ret.Data := L_Source;
   end return;
end UUID.Get;
