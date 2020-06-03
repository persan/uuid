with System;
-- Get the uuid Value stored in source
-- Use with extreme care since there are no safety nets.
function UUID.get (Source : System.Address)  return Uuid_Type;
