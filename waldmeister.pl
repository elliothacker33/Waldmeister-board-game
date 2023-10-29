:-consult('quit.pl').
:-consult('menus.pl').
:-consult('display.pl').
:-consult('screen.pl').
:-consult('logic.pl').
:-consult('play.pl').
:-use_module(library(system)).
play:-view_main_menu.  % play/0 is a predicate that redirects the player for the main menu.
