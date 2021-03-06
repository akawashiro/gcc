------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                  S Y S T E M . A R I T H _ D O U B L E                   --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--          Copyright (C) 1992-2021, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

--  This package provides software routines for doing arithmetic on "double"
--  signed integer values in cases where either overflow checking is required,
--  or intermediate results are longer than the result type.

generic

   type Double_Int is range <>;

   type Double_Uns is mod <>;

   type Single_Uns is mod <>;

   with function Shift_Left (A : Double_Uns; B : Natural) return Double_Uns
     is <>;

   with function Shift_Right (A : Double_Uns; B : Natural) return Double_Uns
     is <>;

   with function Shift_Left (A : Single_Uns; B : Natural) return Single_Uns
     is <>;

package System.Arith_Double is
   pragma Pure;

   function Add_With_Ovflo_Check (X, Y : Double_Int) return Double_Int;
   --  Raises Constraint_Error if sum of operands overflows Double_Int,
   --  otherwise returns the signed integer sum.

   function Subtract_With_Ovflo_Check (X, Y : Double_Int) return Double_Int;
   --  Raises Constraint_Error if difference of operands overflows Double_Int,
   --  otherwise returns the signed integer difference.

   function Multiply_With_Ovflo_Check (X, Y : Double_Int) return Double_Int;
   pragma Convention (C, Multiply_With_Ovflo_Check);
   --  Raises Constraint_Error if product of operands overflows Double_Int,
   --  otherwise returns the signed integer product. Gigi may also call this
   --  routine directly.

   procedure Scaled_Divide
     (X, Y, Z : Double_Int;
      Q, R    : out Double_Int;
      Round   : Boolean);
   --  Performs the division of (X * Y) / Z, storing the quotient in Q
   --  and the remainder in R. Constraint_Error is raised if Z is zero,
   --  or if the quotient does not fit in Double_Int. Round indicates if
   --  the result should be rounded. If Round is False, then Q, R are
   --  the normal quotient and remainder from a truncating division.
   --  If Round is True, then Q is the rounded quotient. The remainder
   --  R is not affected by the setting of the Round flag.

   procedure Double_Divide
     (X, Y, Z : Double_Int;
      Q, R    : out Double_Int;
      Round   : Boolean);
   --  Performs the division X / (Y * Z), storing the quotient in Q and
   --  the remainder in R. Constraint_Error is raised if Y or Z is zero,
   --  or if the quotient does not fit in Double_Int. Round indicates if the
   --  result should be rounded. If Round is False, then Q, R are the normal
   --  quotient and remainder from a truncating division. If Round is True,
   --  then Q is the rounded quotient. The remainder R is not affected by the
   --  setting of the Round flag.

end System.Arith_Double;
