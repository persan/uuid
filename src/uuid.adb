with Interfaces.C.Strings;
package body UUID is

   package Uuid_Uuid_H is


      UUID_VARIANT_NCS       : constant int := 0;  --  /usr/include/uuid/uuid.h:47
      UUID_VARIANT_DCE       : constant int := 1;  --  /usr/include/uuid/uuid.h:48
      UUID_VARIANT_MICROSOFT : constant int := 2;  --  /usr/include/uuid/uuid.h:49
      UUID_VARIANT_OTHER     : constant int := 3;  --  /usr/include/uuid/uuid.h:50

      UUID_TYPE_DCE_TIME     : constant int := 1;  --  /usr/include/uuid/uuid.h:53
      UUID_TYPE_DCE_RANDOM   : constant int := 4;  --  /usr/include/uuid/uuid.h:54
      --  arg-macro: procedure UUID_DEFINE (name, u0, u1, ustatic const uuid_t name __attribute__ ((unused)) := {u0,u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,u11,u12,u13,u14,u15}
      --    static const uuid_t name __attribute__ ((unused)) := {u0,u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,u11,u12,u13,u14,u15}


      procedure Uuid_Clear (Uu : access unsigned_char);  -- /usr/include/uuid/uuid.h:70
      pragma Import (C, Uuid_Clear, "uuid_clear");

      function Uuid_Compare (Uu1 : access unsigned_char; Uu2 : access unsigned_char) return int;  -- /usr/include/uuid/uuid.h:73
      pragma Import (C, Uuid_Compare, "uuid_compare");

      --        procedure Uuid_Copy (Dst : access unsigned_char; Src : access unsigned_char);  -- /usr/include/uuid/uuid.h:76
      --        pragma Import (C, Uuid_Copy, "uuid_copy");

      procedure Uuid_Generate (C_Out : access unsigned_char);  -- /usr/include/uuid/uuid.h:79
      pragma Import (C, Uuid_Generate, "uuid_generate");

      procedure Uuid_Generate_Random (C_Out : access unsigned_char);  -- /usr/include/uuid/uuid.h:80
      pragma Import (C, Uuid_Generate_Random, "uuid_generate_random");

      procedure Uuid_Generate_Time (C_Out : access unsigned_char);  -- /usr/include/uuid/uuid.h:81
      pragma Import (C, Uuid_Generate_Time, "uuid_generate_time");

      function Uuid_Generate_Time_Safe (C_Out : access unsigned_char) return int;  -- /usr/include/uuid/uuid.h:82
      pragma Import (C, Uuid_Generate_Time_Safe, "uuid_generate_time_safe");

      function Uuid_Is_Null (Uu : access unsigned_char) return int;  -- /usr/include/uuid/uuid.h:85
      pragma Import (C, Uuid_Is_Null, "uuid_is_null");

      function Uuid_Parse (C_In : Interfaces.C.Strings.chars_ptr; Uu : access unsigned_char) return int;  -- /usr/include/uuid/uuid.h:88
      pragma Import (C, Uuid_Parse, "uuid_parse");

      procedure Uuid_Unparse (Uu : access constant unsigned_char; C_Out : Interfaces.C.Strings.chars_ptr);  -- /usr/include/uuid/uuid.h:91
      pragma Import (C, Uuid_Unparse, "uuid_unparse");

      procedure Uuid_Unparse_Lower (Uu : access constant unsigned_char; C_Out : Interfaces.C.Strings.chars_ptr);  -- /usr/include/uuid/uuid.h:92
      pragma Import (C, Uuid_Unparse_Lower, "uuid_unparse_lower");

      procedure Uuid_Unparse_Upper (Uu : access constant unsigned_char; C_Out : Interfaces.C.Strings.chars_ptr);  -- /usr/include/uuid/uuid.h:93
      pragma Import (C, Uuid_Unparse_Upper, "uuid_unparse_upper");

      --        function Uuid_Time (Uu : access unsigned_char; Ret_Tv : access Bits_Time_H.Timeval) return Time_H.Time_T;  -- /usr/include/uuid/uuid.h:96
      --        pragma Import (C, Uuid_Time, "uuid_time");

      function Uuid_Type (Uu : access unsigned_char) return int;  -- /usr/include/uuid/uuid.h:97
      pragma Import (C, Uuid_Type, "uuid_type");

      function Uuid_Variant (Uu : access unsigned_char) return int;  -- /usr/include/uuid/uuid.h:98
      pragma Import (C, Uuid_Variant, "uuid_variant");

   end Uuid_Uuid_H;

   use Uuid_Uuid_H;
   -----------
   -- clear --
   -----------
   procedure Clear (Uu : out Uuid_Type) is
   begin
      Uuid_Clear (Uu.Data (Uu.Data'First)'Access);
   end Clear;

   ---------
   -- "=" --
   ---------

   function "="
     (L : Uuid_Type;
      R : Uuid_Type) return Boolean
   is
   begin
      return Uuid_Compare (L.Data (L.Data'First)'Unrestricted_Access, R.Data (R.Data'First)'Unrestricted_Access) = 0;
   end "=";

   ---------
   -- ">" --
   ---------

   function ">"
     (L : Uuid_Type;
      R : Uuid_Type) return Boolean
   is
   begin
      return Uuid_Compare (L.Data (L.Data'First)'Unrestricted_Access, R.Data (R.Data'First)'Unrestricted_Access) > 0;
   end ">";

   --------------
   -- generate --
   --------------

   procedure Generate (Uu : out Uuid_Type) is
   begin
      Uuid_Generate (Uu.Data (Uu.Data'First)'Access);
   end Generate;

   ---------------------
   -- generate_random --
   ---------------------

   procedure Generate_Random (Uu : out Uuid_Type) is
   begin
      Uuid_Generate_Random (Uu.Data (Uu.Data'First)'Access);
   end Generate_Random;

   -------------------
   -- generate_time --
   -------------------

   procedure Generate_Time (Uu : out Uuid_Type) is
   begin
      Uuid_Generate_Time (Uu.Data (Uu.Data'First)'Access);
   end Generate_Time;



   function Generate_Time_Safe (Uu : out Uuid_Type) return Boolean is
   begin
      return Uuid_Generate_Time_Safe (Uu.Data (Uu.Data'First)'Access) = 0;
   end Generate_Time_Safe;
   -------------
   -- is_null --
   -------------

   function Is_Null (Uu : out Uuid_Type) return Boolean is
   begin
      return Uuid_Is_Null (Uu.Data (Uu.Data'First)'Access) /= 0;
   end Is_Null;

   -----------
   -- Parse --
   -----------
   function Parse (Uu : out Uuid_Type; S : String) return Boolean is
      Temp : aliased constant Char_Array := To_C (S);
   begin
      return Uuid_Parse (Strings.To_Chars_Ptr (Temp'Unrestricted_Access), Uu.Data (Uu.Data'First)'Access) = 0;
   end;

   function Parse (S : String) return Uuid_Type is
   begin
      return  Ret : Uuid_Type do
         if not ret.Parse (S) then
            raise Constraint_Error with "Unable to parse " & S;
         end if;
      end return;
   end;

   procedure Parse
     (Uu   : out Uuid_Type;
      s : String)
   is
   begin
      Uu := Parse (S);
   end Parse;

   -------------
   -- unparse --
   -------------

   -- gettype --
   -------------

   function Gettype (Uu : Uuid_Type) return
     TYPE_DCE is
      Temp : constant int := Uuid_Uuid_H.Uuid_Type (Uu.Data (Uu.Data'First)'Unrestricted_Access);
   begin
      case  Temp is
      when UUID_TYPE_DCE_TIME =>  return TIME;
      when UUID_TYPE_DCE_RANDOM => return RANDOM;
      when others => raise Constraint_Error with "Unkonwn type:" & Temp'Img;
      end case;
   end Gettype;

   -------------
   -- variant --
   -------------

   Variant_Map : constant array (UUID_VARIANT_NCS .. UUID_VARIANT_OTHER) of VARIANT_Type :=
                   (UUID_VARIANT_NCS => NCS,
                    UUID_VARIANT_DCE => DCE,
                    UUID_VARIANT_MICROSOFT => MICROSOFT,
                    UUID_VARIANT_OTHER => OTHER);
   function Variant (Uu : Uuid_Type) return VARIANT_Type is
   begin
      return Variant_Map (Uuid_Uuid_H.Uuid_Variant (Uu.Data (Uu.Data'First)'Unrestricted_Access));
   end Variant;

   function Image (Uu : Uuid_Type; Mode : Image_Type := Default) return String is
      R   : aliased Char_Array (1 .. 128) := (others => Interfaces.C.Char'Val (0));
      Ret : constant Interfaces.C.Strings.chars_ptr := Interfaces.C.Strings.To_Chars_Ptr (R'Unrestricted_Access);
   begin
      case Mode is
         when Default =>
            Uuid_Unparse (Uu.Data (Uu.Data'First)'Access, Ret);
         when Upper_Case =>
            Uuid_Unparse_Upper (Uu.Data (Uu.Data'First)'Access, Ret);
         when Lower_Case =>
            Uuid_Unparse_Lower (Uu.Data (Uu.Data'First)'Access, Ret);
      end case;
      return Interfaces.C.Strings.Value (Ret);
   end;

   procedure Initialize (Self : in out Uuid_Type) is
   begin
      Self.Clear;
   end;

   function Generate return Uuid_Type is
   begin
      return Ret : Uuid_Type do
         Generate (Ret);
      end return;
   end;

   function Generate_Random return Uuid_Type is
   begin
      return Ret : Uuid_Type do
         Generate_Random (Ret);
      end return;
   end;

   function Generate_Time return Uuid_Type is
   begin
      return Ret : Uuid_Type do
         Generate_Time (Ret);
      end return;
   end;


end UUID;
