# 1 "lib/regex_lexer.mll"
 
open Regex_parser
open Lexing

exception SyntaxError of string

# 9 "lib/regex_lexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base =
   "\000\000\213\255\214\255\215\255\216\255\217\255\218\255\219\255\
    \220\255\221\255\222\255\223\255\224\255\225\255\226\255\227\255\
    \228\255\229\255\230\255\231\255\232\255\233\255\234\255\235\255\
    \236\255\237\255\238\255\239\255\240\255\241\255\242\255\243\255\
    \244\255\245\255\246\255\247\255\248\255\249\255\250\255\251\255\
    \252\255\253\255\254\255\255\255";
  Lexing.lex_backtrk =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255";
  Lexing.lex_default =
   "\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000";
  Lexing.lex_trans =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\023\000\000\000\000\000\031\000\000\000\000\000\000\000\
    \042\000\041\000\035\000\034\000\036\000\024\000\029\000\000\000\
    \004\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\028\000\000\000\027\000\025\000\026\000\033\000\
    \000\000\000\000\021\000\000\000\019\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \005\000\000\000\000\000\017\000\000\000\000\000\000\000\015\000\
    \000\000\000\000\000\000\040\000\030\000\039\000\032\000\000\000\
    \000\000\000\000\022\000\000\000\020\000\000\000\014\000\000\000\
    \000\000\000\000\000\000\009\000\000\000\000\000\013\000\000\000\
    \006\000\000\000\012\000\018\000\011\000\007\000\010\000\016\000\
    \008\000\000\000\000\000\038\000\043\000\037\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \001\000";
  Lexing.lex_check =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\255\255\255\255\000\000\255\255\255\255\255\255\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\255\255\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\255\255\000\000\000\000\000\000\000\000\
    \255\255\255\255\000\000\255\255\000\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\000\000\255\255\255\255\255\255\000\000\
    \255\255\255\255\255\255\000\000\000\000\000\000\000\000\255\255\
    \255\255\255\255\000\000\255\255\000\000\255\255\000\000\255\255\
    \255\255\255\255\255\255\000\000\255\255\255\255\000\000\255\255\
    \000\000\255\255\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\255\255\255\255\000\000\000\000\000\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000";
  Lexing.lex_base_code =
   "";
  Lexing.lex_backtrk_code =
   "";
  Lexing.lex_default_code =
   "";
  Lexing.lex_trans_code =
   "";
  Lexing.lex_check_code =
   "";
  Lexing.lex_code =
   "";
}

let rec token lexbuf =
   __ocaml_lex_token_rec lexbuf 0
and __ocaml_lex_token_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 13 "lib/regex_lexer.mll"
      ( ALT )
# 121 "lib/regex_lexer.ml"

  | 1 ->
# 14 "lib/regex_lexer.mll"
      ( LPAR )
# 126 "lib/regex_lexer.ml"

  | 2 ->
# 15 "lib/regex_lexer.mll"
      ( RPAR )
# 131 "lib/regex_lexer.ml"

  | 3 ->
# 16 "lib/regex_lexer.mll"
      ( LBRACK )
# 136 "lib/regex_lexer.ml"

  | 4 ->
# 17 "lib/regex_lexer.mll"
      ( RBRACK )
# 141 "lib/regex_lexer.ml"

  | 5 ->
# 18 "lib/regex_lexer.mll"
      ( LBRAC )
# 146 "lib/regex_lexer.ml"

  | 6 ->
# 19 "lib/regex_lexer.mll"
      ( RBRAC )
# 151 "lib/regex_lexer.ml"

  | 7 ->
# 20 "lib/regex_lexer.mll"
      ( COMMA )
# 156 "lib/regex_lexer.ml"

  | 8 ->
# 21 "lib/regex_lexer.mll"
      ( STAR )
# 161 "lib/regex_lexer.ml"

  | 9 ->
# 22 "lib/regex_lexer.mll"
      ( PLUS )
# 166 "lib/regex_lexer.ml"

  | 10 ->
# 23 "lib/regex_lexer.mll"
      ( QMARK )
# 171 "lib/regex_lexer.ml"

  | 11 ->
# 24 "lib/regex_lexer.mll"
      ( HAT )
# 176 "lib/regex_lexer.ml"

  | 12 ->
# 25 "lib/regex_lexer.mll"
      ( DOLLAR )
# 181 "lib/regex_lexer.ml"

  | 13 ->
# 26 "lib/regex_lexer.mll"
       ( BACKSL )
# 186 "lib/regex_lexer.ml"

  | 14 ->
# 27 "lib/regex_lexer.mll"
      ( DOT )
# 191 "lib/regex_lexer.ml"

  | 15 ->
# 28 "lib/regex_lexer.mll"
      ( COLONS )
# 196 "lib/regex_lexer.ml"

  | 16 ->
# 29 "lib/regex_lexer.mll"
      ( LESS )
# 201 "lib/regex_lexer.ml"

  | 17 ->
# 30 "lib/regex_lexer.mll"
      ( MORE )
# 206 "lib/regex_lexer.ml"

  | 18 ->
# 31 "lib/regex_lexer.mll"
      ( EQUAL )
# 211 "lib/regex_lexer.ml"

  | 19 ->
# 32 "lib/regex_lexer.mll"
      ( MINUS )
# 216 "lib/regex_lexer.ml"

  | 20 ->
# 33 "lib/regex_lexer.mll"
      ( EXCL )
# 221 "lib/regex_lexer.ml"

  | 21 ->
# 34 "lib/regex_lexer.mll"
      ( LOWB )
# 226 "lib/regex_lexer.ml"

  | 22 ->
# 35 "lib/regex_lexer.mll"
      ( UPB )
# 231 "lib/regex_lexer.ml"

  | 23 ->
# 36 "lib/regex_lexer.mll"
       ( LOWD )
# 236 "lib/regex_lexer.ml"

  | 24 ->
# 37 "lib/regex_lexer.mll"
       ( UPD )
# 241 "lib/regex_lexer.ml"

  | 25 ->
# 38 "lib/regex_lexer.mll"
      ( LOWS )
# 246 "lib/regex_lexer.ml"

  | 26 ->
# 39 "lib/regex_lexer.mll"
      ( UPS )
# 251 "lib/regex_lexer.ml"

  | 27 ->
# 40 "lib/regex_lexer.mll"
      ( LOWW )
# 256 "lib/regex_lexer.ml"

  | 28 ->
# 41 "lib/regex_lexer.mll"
      ( UPW )
# 261 "lib/regex_lexer.ml"

  | 29 ->
# 42 "lib/regex_lexer.mll"
      ( LOWF )
# 266 "lib/regex_lexer.ml"

  | 30 ->
# 43 "lib/regex_lexer.mll"
      ( LOWN )
# 271 "lib/regex_lexer.ml"

  | 31 ->
# 44 "lib/regex_lexer.mll"
      ( LOWR )
# 276 "lib/regex_lexer.ml"

  | 32 ->
# 45 "lib/regex_lexer.mll"
      ( LOWT )
# 281 "lib/regex_lexer.ml"

  | 33 ->
# 46 "lib/regex_lexer.mll"
      ( LOWV )
# 286 "lib/regex_lexer.ml"

  | 34 ->
# 47 "lib/regex_lexer.mll"
      ( LOWK )
# 291 "lib/regex_lexer.ml"

  | 35 ->
# 48 "lib/regex_lexer.mll"
      ( LOWX )
# 296 "lib/regex_lexer.ml"

  | 36 ->
# 49 "lib/regex_lexer.mll"
      ( LOWU )
# 301 "lib/regex_lexer.ml"

  | 37 ->
# 50 "lib/regex_lexer.mll"
      ( LOWP )
# 306 "lib/regex_lexer.ml"

  | 38 ->
# 51 "lib/regex_lexer.mll"
      ( UPP )
# 311 "lib/regex_lexer.ml"

  | 39 ->
# 52 "lib/regex_lexer.mll"
      ( ZERO )
# 316 "lib/regex_lexer.ml"

  | 40 ->
let
# 53 "lib/regex_lexer.mll"
           d
# 322 "lib/regex_lexer.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 53 "lib/regex_lexer.mll"
             ( NZDIGIT d )
# 326 "lib/regex_lexer.ml"

  | 41 ->
let
# 54 "lib/regex_lexer.mll"
                      c
# 332 "lib/regex_lexer.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 54 "lib/regex_lexer.mll"
                        ( CHAR c )
# 336 "lib/regex_lexer.ml"

  | 42 ->
# 55 "lib/regex_lexer.mll"
      ( EOF )
# 341 "lib/regex_lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_token_rec lexbuf __ocaml_lex_state

;;
