atom_length2(Atom, Length) :-
    atom_chars(Atom, Chars),  % Convert the atom to a list of characters
    length(Chars, Length).
print_n(0,_).
print_n(N,Ch):-
  N1 is N-1,
  print_n(N1,Ch),
  write(Ch).

write_center(Text):- 
  get_terminal_width(W),
  atom_length2(Text,L),
  N is (W-L)//2,
  print_n(N,' '),
  write(Text),
  print_n(N,' ').


/* waldmeister_logo/0 is a predicate that is responsible for showing the waldmeister logo in ASCII ART */
waldmeister_logo:-
write_center(' ##      ##    ##    ##    ##    ###       ##     ##   ####   #   ###   #####  ####   ###   '),
nl,
write_center('  ##   ## ##  ##   ##  ##  ##    #  #    ####   ####   # __   |    #  #   #    # __   #  #  '),
nl,
write_center('   ## ##  ## ##    ######  ##    #   #  ##  ## ##  ##  #      |  # ##     #    #      # ##  '),
nl,
write_center('    ##      ##     ##  ##  ##### ####  #    ##     #   ####   |  ###      #    ####   ##  # '),
nl.

clear:-
   write('\e[H\e[2J\n\n').

% Define a predicate to print all options.
print_options :-
    write_center('1. Human/Human'),
    nl,
    write_center('2. Human/PC'),
    nl,
    write_center('3. PC/PC'),
    nl,
    write_center('4. Instructions'),
    nl,
    write_center('5. Credits'),
    nl,
    write_center('6. Quit').

handle_option(1) :-
    view_main_menu.

handle_option(2) :-
    view_main_menu.

handle_option(3) :-
    view_main_menu.

handle_option(4) :-
    instructions,view_main_menu.

handle_option(5) :-
    credits,view_main_menu.

handle_option(6) :-
    quit.

handle_option(_Other):-
    nl,
    write_center('ERROR: that option does not exist.'),
    nl,
    nl,
    write_center('Insert option from 1-6: '),
    nl,
    get_option(Option),
    handle_option(Option).
char_to_number(Input,Option):-
 char_code(Input,Code),
 Option is Code - 48.
get_option(Option):-
    get_char(Input),
    get_char(_),
    char_to_number(Input,Option).
view_main_menu :-
    clear,
    waldmeister_logo,
    nl,
    write_center('Available Options'),
    nl,
    print_options, % Use option_main_menu to print options
    write_center('Insert option from 1-6: '),
    nl,
    get_option(Option),
    handle_option(Option).

