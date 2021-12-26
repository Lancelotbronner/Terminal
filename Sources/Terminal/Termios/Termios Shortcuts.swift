//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2021-12-26.
//

import Darwin



/*
 Special Control Characters
 The special control characters values are defined by the array c_cc.  This table lists the array index, the corresponding special character, and the system default value.  For an accurate list of the system
 defaults, consult the header file ⟨ttydefaults.h⟩.
 
 Index Name    Special Character    Default Value
 VEOF          EOF                  ^D
 VEOL          EOL                  _POSIX_VDISABLE
 VEOL2         EOL2                 _POSIX_VDISABLE
 VERASE        ERASE                ^? ‘\177’
 VWERASE       WERASE               ^W
 VKILL         KILL                 ^U
 VREPRINT      REPRINT              ^R
 VINTR         INTR                 ^C
 VQUIT         QUIT                 ^\\ ‘\34’
 VSUSP         SUSP                 ^Z
 VDSUSP        DSUSP                ^Y
 VSTART        START                ^Q
 VSTOP         STOP                 ^S
 VLNEXT        LNEXT                ^V
 VDISCARD      DISCARD              ^O
 VMIN          ---                  1
 VTIME         ---                  0
 VSTATUS       STATUS               ^T
 
 If the value of one of the changeable special control characters (see Special Characters) is {_POSIX_VDISABLE}, that function is disabled; that is, no input data is recognized as the disabled special character.  If
 ICANON is not set, the value of {_POSIX_VDISABLE} has no special meaning for the VMIN and VTIME entries of the c_cc array.
 
 The initial values of the flags and control characters after open() is set according to the values in the header ⟨sys/ttydefaults.h⟩.
 */
