pragma Ada_2012;

private with Interfaces.C;
private with Ada.Finalization;

package UUID is

   type UUID_VARIANT is (NCS, DCE, MICROSOFT, OTHER);

   type UUID_TYPE_DCE is (TIME, RANDOM);

   type Uuid_Type is tagged private;

   procedure Clear (Uu : out Uuid_Type);


   function "="
     (L : Uuid_Type;
      R : Uuid_Type) return Boolean;
   function ">"
     (L : Uuid_Type;
      R : Uuid_Type) return Boolean;


   procedure Generate (Uu : out Uuid_Type);


   procedure Generate_Random (Uu : out Uuid_Type);


   procedure Generate_Time (Uu : out Uuid_Type);

   procedure Generate_Time_Safe (Uu : out Uuid_Type);

   function Generate_Time_Safe (Uu : out Uuid_Type) return Boolean;

   function Is_Null (Uu : out Uuid_Type) return Boolean;

   function Parse (S : String) return Uuid_Type;
   function Parse (Uu : out Uuid_Type; S : String) return Boolean;
   procedure Parse (Uu : out Uuid_Type; S : String);

   type Image_Type is (Default, Upper_Case, Lower_Case);


   function Image (Uu : Uuid_Type; Mode : Image_Type := Default) return String;

   -- function time (uu : not null access uuid_type; ret_tv : access bits_time_h.timeval) return time_h.time_t;

   function Gettype (Uu : Uuid_Type) return UUID_TYPE_DCE;

   function Variant (Uu : Uuid_Type) return UUID_VARIANT;

private

   use Interfaces.C;

   type Uuid_T is array (0 .. 15) of aliased Unsigned_Char;  -- /usr/include/uuid/uuid.h:44
   type Uuid_Type is new Ada.Finalization.Controlled with record
      Data : aliased Uuid_T;
   end record;
   procedure Initialize (Self : in out Uuid_Type);

   pragma Linker_Options ("-luuid");
end UUID;
