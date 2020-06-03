pragma Ada_2012;

private with Interfaces.C;
private with Ada.Finalization;

package UUID is

   type VARIANT_Type is (NCS, DCE, MICROSOFT, OTHER);

   type TYPE_DCE is (TIME, RANDOM);

   type Uuid_Type is tagged private;

   procedure Clear (Uu : out Uuid_Type);


   function "="
     (L : Uuid_Type;
      R : Uuid_Type) return Boolean;
   function ">"
     (L : Uuid_Type;
      R : Uuid_Type) return Boolean;


   procedure Generate (Uu : out Uuid_Type);
   function Generate return Uuid_Type;


   procedure Generate_Random (Uu : out Uuid_Type);
   function Generate_Random return Uuid_Type;


   procedure Generate_Time (Uu : out Uuid_Type);
   function Generate_Time return Uuid_Type;

   function Generate_Time_Safe (Uu : out Uuid_Type) return Boolean;

   function Is_Null (Uu : out Uuid_Type) return Boolean;

   function Parse (S : String) return Uuid_Type;
   function Parse (Uu : out Uuid_Type; S : String) return Boolean;
   procedure Parse (Uu : out Uuid_Type; S : String);

   type Image_Type is (Default, Upper_Case, Lower_Case);


   function Image (Uu : Uuid_Type; Mode : Image_Type := Default) return String;
   function Value (S : String) return Uuid_Type renames Parse;

   function Gettype (Uu : Uuid_Type) return TYPE_DCE;

   function Variant (Uu : Uuid_Type) return VARIANT_Type;

private

   use Interfaces.C;

   type Uuid_T is array (0 .. 15) of aliased Unsigned_Char;  -- /usr/include/uuid/uuid.h:44
   type Uuid_Type is new Ada.Finalization.Controlled with record
      Data : aliased Uuid_T;
   end record;
   procedure Initialize (Self : in out Uuid_Type);

   pragma Linker_Options ("-luuid");
end UUID;
