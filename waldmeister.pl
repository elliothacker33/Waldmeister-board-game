/*
 Game files.
*/

:-consult('board.pl').
:-consult('bot.pl').
:-consult('credits.pl').
:-consult('display.pl').
:-consult('instructions.pl').
:-consult('logic.pl').
:-consult('menus.pl').
:-consult('play.pl').
:-consult('value.pl').

/*
 Prolog modules and libraries.
*/

:-use_module(library(aggregate)).
:-use_module(library(between)).
:-use_module(library(lists)).
:-use_module(library(random)).

/*
 Play predicate is responsible to start the game invoking main menu.
*/
% play/0 

play:-display_main_menu.
