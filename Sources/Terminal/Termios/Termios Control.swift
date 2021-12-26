//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2021-12-26.
//

import Darwin

//MARK: - Termios Control

extension Termios {
	public struct Control {
		
		//MARK: Properties
		
		@usableFromInline var underlying: tcflag_t
		
		//MARK: Computed Properties
		
		
		
		//MARK: Initialization
		
		@usableFromInline init(of terminal: termios) {
			underlying = terminal.c_cflag
		}
		
		//MARK: Methods
		
		@usableFromInline func apply(to terminal: inout termios) {
			terminal.c_cflag = underlying
		}
		
		@usableFromInline func retrieve(_ option: Int32) -> Bool {
			Termios.retrieve(option, from: underlying)
		}
		
		@usableFromInline mutating func configure(_ option: Int32, to newValue: Bool) {
			Termios.configure(option, to: newValue, into: &underlying)
		}
		
	}
}

/*
 Values of the c_cflag field describe the basic terminal hardware control, and are composed of the following masks.  Not all values specified are supported by all hardware.
 
 CSIZE       /* character size mask */
 CS5         /* 5 bits (pseudo) */
 CS6         /* 6 bits */
 CS7         /* 7 bits */
 CS8         /* 8 bits */
 CSTOPB      /* send 2 stop bits */
 CREAD       /* enable receiver */
 PARENB      /* parity enable */
 PARODD      /* odd parity, else even */
 HUPCL       /* hang up on last close */
 CLOCAL      /* ignore modem status lines */
 CCTS_OFLOW  /* CTS flow control of output */
 CRTSCTS     /* same as CCTS_OFLOW */
 CRTS_IFLOW  /* RTS flow control of input */
 MDMBUF      /* flow control output via Carrier */
 
 The CSIZE bits specify the byte size in bits for both transmission and reception.  The c_cflag is masked with CSIZE and compared with the values CS5, CS6, CS7, or CS8.  This size does not include the parity bit, if
 any.  If CSTOPB is set, two stop bits are used, otherwise one stop bit.  For example, at 110 baud, two stop bits are normally used.
 
 If CREAD is set, the receiver is enabled.  Otherwise, no character is received.  Not all hardware supports this bit.  In fact, this flag is pretty silly and if it were not part of the termios specification it would
 be omitted.
 
 If PARENB is set, parity generation and detection are enabled and a parity bit is added to each character.  If parity is enabled, PARODD specifies odd parity if set, otherwise even parity is used.
 
 If HUPCL is set, the modem control lines for the port are lowered when the last process with the port open closes the port or the process terminates.  The modem connection is broken.
 
 If CLOCAL is set, a connection does not depend on the state of the modem status lines.  If CLOCAL is clear, the modem status lines are monitored.
 
 Under normal circumstances, a call to the open() function waits for the modem connection to complete.  However, if the O_NONBLOCK flag is set or if CLOCAL has been set, the open() function returns immediately
 without waiting for the connection.
 
 The CCTS_OFLOW (CRTSCTS) flag is currently unused.
 
 If MDMBUF is set then output flow control is controlled by the state of Carrier Detect.
 
 If the object for which the control modes are set is not an asynchronous serial connection, some of the modes may be ignored; for example, if an attempt is made to set the baud rate on a network connection to a
 terminal on another host, the baud rate may or may not be set on the connection between that terminal and the machine it is directly connected to.
 */
