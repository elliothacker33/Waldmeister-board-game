:-consult('quit.pl').
:-consult('menus.pl').
:-consult('display.pl').
:-consult('generate_table.pl').
:-consult('axil_of_the_board.pl').
:-consult('logic.pl').
:-consult('play.pl').
:-use_module(library(system)).
:-use_module(library(lists)).
play:-view_main_menu.  % play/0 is a predicate that redirects the player for the main menu.
