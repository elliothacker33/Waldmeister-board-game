:-consult('quit.pl').
:-consult('menus.pl').
:-consult('display.pl').
<<<<<<< HEAD
=======
:-consult('screen.pl').
:-consult('generate_table.pl').
>>>>>>> 73898be40465c76729e4deca484476971991de41
:-consult('logic.pl').
:-consult('play.pl').
:-consult('generate_table.pl').
:-consult('axil_of_the_board.pl').
:-use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(aggregate)).
:- use_module(library(random)).
play:-view_main_menu.  % play/0 is a predicate that redirects the player for the main menu.
