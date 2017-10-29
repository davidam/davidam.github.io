;; Copyright (C) 2015  David Arroyo Menéndez

;; Author: David Arroyo Menéndez <davidam@gnu.org>
;; Maintainer: David Arroyo Menéndez <davidam@gnu.org>

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, 
;; Boston, MA 02110-1301 USA,

;; To install php-ext.el:
;; You can add (load "path/php-ext/php-ext.el") to your .emacs

;; Description:
;; Php ext is some skeleton templates for extend php-mode


;; Math functions

(define-skeleton php-abs
  "Insert an abs statement"
  ""
  > "abs(" (skeleton-read "Number to round? ") ");" \n
)

(define-skeleton php-acos
  "Insert an acos statement"
  ""
  > "acos(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-acosh
  "Insert an acosh statement"
  ""
  > "acosh(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-asin
  "Insert an asin statement"
  ""
  > "asin(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-asinh
  "Insert an asinh statement"
  ""
  > "asinh(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-atanh
  "Insert an asinh statement"
  ""
  > "atanh(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-atan
  "Insert an atan statement"
  ""
  > "atan(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-atan2
  "Insert an atan2 statement"
  ""
  > "atan2(" (skeleton-read "Number? ") ", " (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-atanh
  "Insert an atan statement"
  ""
  > "atanh(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-base_convert
  "Insert a base_convert statement"
  ""
  > "base_convert(" (skeleton-read "Number? ") ", " (skeleton-read "Base number? ") ", " (skeleton-read "Base number? ") ");" \n
)

(define-skeleton php-bcadd
  "Insert a bcadd statement"
  ""
  > "bcadd(" (skeleton-read "Number? ") ", " (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-gmp_add
  "Insert a bcadd statement"
  ""
  > "gmp_add(" (skeleton-read "Number? ") ", " (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-bindec
  "Insert a bindec statement"
  ""
  > "bindec(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-ceil
  "Insert a ceil statement"
  ""
  > "ceil(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-cos
  "Insert a cos statement"
  ""
  > "cos(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-cosh
  "Insert a cosh statement"
  ""
  > "cosh(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-decbin
  "Insert a decbin statement"
  ""
  > "decbin(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-dechex
  "Insert a dechex statement"
  ""
  > "dechex(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-decoct
  "Insert a dechex statement"
  ""
  > "decoct(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-deg2rad
  "Insert a dechex statement"
  ""
  > "deg2rad(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-exp
  "Insert an exp statement"
  ""
  > "exp(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-expm1
  "Insert an expm1 statement"
  ""
  > "expm1(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-floor
  "Insert a floor statement"
  ""
  > "floor(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-fmod
  "Insert a fmod statement"
  ""
  > "fmod(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-getrandmax
  "Insert an getrandmax statement"
  ""
  > "getrandmax(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-mt_rand
  "Insert an mt_rand statement"
  ""
  > "mt_rand(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-mt_srand
  "Insert an mt_rand statement"
  ""
  > "mt_srand(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-hexdec
  "Insert a hexdec statement"
  ""
  > "hexdec(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-hypot
  "Insert a hypot statement"
  ""
  > "hypot(" (skeleton-read "Number? ") ", " (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-is_finite
  "Insert a is_finite statement"
  ""
  > "is_finite(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-is_infinite
  "Insert a is_infinite statement"
  ""
  > "is_infinite(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-is_nan
  "Insert a is_nan statement"
  ""
  > "is_nan(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-lcg_value
  "Insert a lcg_value statement"
  ""
  > "lcg_value(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-log10
  "Insert a log10 statement"
  ""
  > "log10(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-log1p
  "Insert a log1p statement"
  ""
  > "log1p(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-log
  "Insert a log statement"
  ""
  > "log(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-max
  "Insert a max statement"
  ""
  > "max(" (skeleton-read "Number? ") ", " (skeleton-read "Number? ") \n
   ( "Another number %s: "
   > ", " str)
  > ");" \n
)

(define-skeleton php-min
  "Insert a min statement"
  ""
  > "min(" (skeleton-read "Number? ") ", " (skeleton-read "Number? ") \n
   ( "Another number %s: "
   > ", " str)
  > ");" \n
)

(define-skeleton php-mt_getrandmax
  "Insert a mt_getrandmax statement"
  ""
  > "mt_getrandmax(); " \n
)

(define-skeleton php-number_format
  "Insert a number_format statement"
  ""
  '(setq number (skeleton-read "Number? "))
  > "number_format(" number ", " 
  ( "Another argument %s: "
   > ", " str)
)

(define-skeleton php-pi
  "Insert a pi statement"
  ""
  > "pi();" \n
)

(define-skeleton php-pow
  "Insert a pow statement"
  ""
  '(setq base (skeleton-read "Base? "))
  '(setq exp (skeleton-read "Exponent? "))
  > "pow(" base ", " exp ");" \n
)

(define-skeleton php-rad2deg
  "Insert a pow statement"
  ""
  '(setq base (skeleton-read "Radians? "))
  '(setq exp (skeleton-read "Degrees? "))
  > "rad2deg(" base  ");" \n
)

(define-skeleton php-rand_weighted
  "Insert an rand_weighted statement"
  ""
  > "rand_weighted(" (skeleton-read "Number? ") ");" \n
)

(define-skeleton php-round
  "Insert a round statement"
  ""
  '(setq number (skeleton-read "Number to round? "))
  > "round(" number ");" \n
)

(define-skeleton php-sin
  "Insert a sin statement"
  ""
  '(setq number (skeleton-read "Number? "))
  > "sin(" number ");" \n
)

(define-skeleton php-sinh
  "Insert a sin statement"
  ""
  '(setq number (skeleton-read "Number? "))
  > "sinh(" number ");" \n
)

(define-skeleton php-sqrt
  "Insert a sqrt statement"
  ""
  '(setq number (skeleton-read "Number? "))
  > "sqrt(" number ");" \n
)

(define-skeleton php-srand
  "Insert a sqrt statement"
  ""
  '(setq number (skeleton-read "Number? "))
  > "srand(" number ");" \n
)

(define-skeleton php-tan
  "Insert a tan statement"
  ""
  '(setq number (skeleton-read "Number? "))
  > "tan(" number ");" \n
)

(define-skeleton php-tanh
  "Insert a tan statement"
  ""
  '(setq number (skeleton-read "Number? "))
  > "tanh(" number ");" \n
)

;; Control Structures

(define-skeleton php-if
  "Insert a if statement"
  ""
  '(setq condition (skeleton-read "Condition? ")) \n
   > "if( " condition " ) {" \n
   > _ \n
   ( "other condition, %s: "
   > "}" \n  
   > "else if( " str " ) {" \n
   > _ \n)
   > "}" \n
   > "else {" \n
   > _ \n
   resume:
   > "}" \n)

(define-skeleton php-foreach
  "Insert a foreach statement."
  ""
  '(setq index (skeleton-read "Index variable? ")) \n
  '(setq array (skeleton-read "Array? ")) \n
  > "foreach (" index " as " array ") {" \n
  > _ \n
  > "}" \n)

(define-skeleton php-for
  "Insert a for statement."
  ""
  '(setq index (skeleton-read "Index variable? ")) \n
  '(setq condition (skeleton-read "Condition? ")) \n
  > "for (" condition "; " index "++) {" \n
  > _ \n
  > "}" \n)

(define-skeleton php-include
  "Insert a include statement."
  ""
  '(setq file (skeleton-read "File? ")) \n
  > "include_once '" file "';")

(define-skeleton php-include_once
  "Insert a include_once statement."
  ""
  '(setq file (skeleton-read "File? ")) \n
  > "include_once '" file "';")

(define-skeleton php-require
  "Insert a require statement."
  ""
  '(setq file (skeleton-read "File? ")) \n
  > "require '" file "';")

(define-skeleton php-require_once
  "Insert a require statement."
  ""
  '(setq file (skeleton-read "File? ")) \n
  > "require_once '" file "';")

;; Functions

(define-skeleton php-function
  "Insert a function statement."
  ""
  '(setq function (skeleton-read "Function name? ")) \n
  '(setq argument (skeleton-read "Argument? ")) \n
  > "function " function "(" argument 
  ( "Another argument? %s: "
    > ", " str )
  > ") {" \n
  _ \n
  > "}"
)

(define-skeleton php-class
  "Insert a class statement."
  ""
  '(setq class (skeleton-read "Class name? ")) \n
  > "class " class \n
  > "{" \n
  _ \n
  > "}" \n
)

;; Handling strings

(define-skeleton php-addcslashes 
  "Insert an addcslashes statement"
  ""
  '(setq str (skeleton-read "String? "))
  '(setq charlist (skeleton-read "Charlist? "))
  > "addclslashes(" str ", " charlist ");" \n)

(define-skeleton php-addslashes 
  "Insert an addcslashes statement"
  ""
  '(setq str (skeleton-read "String? "))
  > "addclslashes(" str ");" \n)

(define-skeleton php-bin2hex
  "Insert a bin2hex statement"
  ""
  '(setq str (skeleton-read "String? "))
  > "bin2hex(" str ");" \n)

(define-skeleton php-convert_uudecode
  "Insert a bin2hex statement"
  ""
  '(setq str (skeleton-read "String? "))
  > "convert_uudecode(" str ");" \n)

(define-skeleton php-convert_uuencode
  "Insert a bin2hex statement"
  ""
  '(setq str (skeleton-read "String? "))
  > "convert_uuencode(" str ");" \n)

(define-skeleton php-explode
  "Insert an explode statement"
  ""
  '(setq separator (skeleton-read "Explode separator? "))
  '(setq var (skeleton-read "Explode variable? "))
  > "explode('" separator "', " var ");" \n)

(define-skeleton php-implode
  "Insert an implode statement"
  ""
  '(setq separator (skeleton-read "Implode separator? "))
  '(setq var (skeleton-read "Implode variable? "))
  > "implode('" separator "', " var 
  (skeleton-read 
   > ", " str )
  > ");"
  )

(define-skeleton php-rtrim
  "Insert a bin2hex statement"
  ""
  '(setq str (skeleton-read "String? "))
  > "rtrim(" str ");" \n)

(define-skeleton php-strlen
  "Insert a strlen statement"
  ""
  '(setq str (skeleton-read "String? "))
  > "strlen(" str ");" \n)

(define-skeleton php-strtolower
  "Insert a strlower statement"
  ""
  '(setq str (skeleton-read "String? "))
  > "strtolower(" str ");" \n)

(define-skeleton php-strtotime
  "Insert a strtotime
 statement"
  ""
  '(setq str (skeleton-read "String? "))
  > "strtotime(" str ");" \n)

(define-skeleton php-strtoupper
  "Insert a strtoupper statement"
  ""
  '(setq str (skeleton-read "String? "))
  > "strtoupper(" str ");" \n)

(define-skeleton php-strrev
  "Insert a strrev statement"
  ""
  '(setq str (skeleton-read "String? "))
  > "strrev('" str "');" \n)

(define-skeleton php-ucfirst
  "Insert a ucfirst statement"
  ""
  '(setq str (skeleton-read "String? "))
  > "ucfirst('" str "');" \n)

(define-skeleton php-ucwords
  "Insert a ucfirst statement"
  ""
  '(setq str (skeleton-read "String? "))
  > "ucwords('" str "');" \n)

;; Regular expression

(define-skeleton php-ereg
  "Insert an ereg statement"
  ""
  '(setq regexp (skeleton-read "Regexp? "))
  '(setq string (skeleton-read "String? "))
  > "ereg(" regexp ", " string ");"
)

(define-skeleton php-ereg_replace
  "Insert an eregi_replace statement"
  ""
  '(setq pattern (skeleton-read "Pattern? "))
  '(setq replacement (skeleton-read "Replacement? "))
  '(setq string (skeleton-read "String? "))
  > "ereg_replace(" pattern ", " replacement ", " string ");"
)

(define-skeleton php-eregi
  "Insert an eregi statement"
  ""
  '(setq regexp (skeleton-read "Regexp? "))
  '(setq string (skeleton-read "String? "))
  > "ereg(" regexp ", " string ");"
)

(define-skeleton php-eregi_replace
  "Insert an eregi_replace statement"
  ""
  '(setq pattern (skeleton-read "Pattern? "))
  '(setq replacement (skeleton-read "Replacement? "))
  '(setq string (skeleton-read "String? "))
  > "eregi_replace(" pattern ", " replacement ", " string ");"
)

;; Handling Variables

(define-skeleton php-define
  "Insert a define statement"
  ""
  '(setq variable (skeleton-read "Variable? "))
  '(setq value (skeleton-read "Value? "))
  "define(\"" variable "\",\"" value "\");")
 
(define-skeleton php-boolval
  "Insert a boolval statement"
  ""
  '(setq variable (skeleton-read "Variable? "))
  "boolval(" variable ");"
)

(define-skeleton php-chr
  "Insert a chr statement"
  ""
  '(setq chr (skeleton-read "Char? "))
  "chr(" chr ");"
)
 
(define-skeleton php-empty
  "Insert an empty statement"
  ""
  '(setq variable (skeleton-read "Variable? "))
  "empty(" variable ");"
)

(define-skeleton php-var_dump
  "Insert a var_dump statement"
  ""
  '(setq variable (skeleton-read "Variable? "))
  > "var_dump(" variable 
  ( "Other variable? %s: "
   > ", " str )
  > ");"
)

;; Exceptions

(define-skeleton php-try-catch
  "Insert a try catch statement"
  ""
  > "try {" \n
  _ \n
  > "} catch (" (skeleton-read "Exception? ") ") {" \n
  _ \n
  > "}" \n
)

(define-skeleton php-try-catch-finally
  "Insert a try catch statement"
  ""
  > "try {" \n
  _ \n
  > "} catch (" (skeleton-read "Exception? ") ") {" \n
  _ \n
  > "} finally {" \n
  _ \n
  > "}" \n
)

;; XML
;; See /usr/share/doc/php-doc/html/function.xml-parse-into-struct.html

(define-skeleton php-utf8_decode
  "Insert a utf8_decode statement"
  ""
  > "utf8_decode(" (skeleton-read "An utf-8 string ") ");" \n
)

(define-skeleton php-utf8_encode
  "Insert a utf8_encode statement"
  ""
  > "utf8_encode(" (skeleton-read "An iso-8859-1 string ") ");" \n
)

(define-skeleton php-xml_error_string
  "Insert a xml_error_string statement"
  ""
  > "xml_error_string(" (skeleton-read "Code? ") ");" \n
)

(define-skeleton php-xml_get_current_byte_index
  "Insert a xml_get_current_byte_index"
  ""
  > "xml_get_current_byte_index(" (skeleton-read "Parser? ") ");" \n
)

(define-skeleton php-xml-get_current_column_number
  "Insert a xml_get_current_column_number"
  ""
  > "xml_get_current_column_number(" (skeleton-read "Parser? ") ");" \n
)

(define-skeleton php-xml-get_current_line_number
  "Insert a xml_get_current_line_number"
  ""
  > "xml_get_current_line_number(" (skeleton-read "Parser? ") ");" \n
)

(define-skeleton php-xml-get_error_code
  "Insert a xml_get_error_code"
  ""
  > "xml_get_error_code(" (skeleton-read "Parser? ") ");" \n
)


