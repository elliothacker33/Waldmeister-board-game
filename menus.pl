waldmeister_logo:-
write(' ##      ##    ##    ##    ##    ###       ##     ##   ####   #   ###   #####  ####   ###       \n'),
write('  ##   ## ##  ##   ##  ##  ##    #  #    ####   ####   # __   |    #  #   #    # __   #  #      \n'),
write('   ## ##  ## ##    ######  ##    #   #  ##  ## ##  ##  #      |  # ##     #    #      # ##       \n '),
write('    ##      ##     ##  ##  ##### ####  #    ##     #   ####   |  ###      #    ####   ##  #  \n').

clear:- write('\33\[2J'). /* This predicate clears the terminal view for better UX. */

start_main_menu:-clear,	waldmeister_logo,view_main_menu. % add repeat

option_main_menu('1',"Human/Human"):- .
option_main_menu('2',"Human/PC"):- .
option_main_menu('3',"PC/PC"):-.
option_main_menu('4',"Instructions"):-.
option_main_menu('5',"Credits"):-.
option_main_menu('6',"Quit"):-.

view_main_menu:-clear,
	waldmeister_logo,
	write("1. Human/Human\n"),
	write("2. Human/PC\n"),
	write("3. PC/PC\n"),
	write("4. Instructions\n"),
	write("5. Credits\n"),
	write("6. Quit\n"),
	get_option(Option),
	handle_option(Option).

get_option(Option):-get_char(Option).
handle_option(_):-view_main_menu.

handle_option('1'):-.
handle_option('2'):-.
handle_option('3'):-.
handle_option('4'):-.
handle_option('5'):-.
handle_option('6'):-.

	
