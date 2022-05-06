//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2022-04-24.
//

//MARK: - Darwin

#if canImport(Darwin)
import Darwin.POSIX.termios

@usableFromInline typealias TermiosFlags = tcflag_t

//MARK: - Glibc

#elseif canImport(Glibc)
import Glibc.POSIX.termios


#else

//MARK: - Unknown

#error("Unsupported platform")
#endif
