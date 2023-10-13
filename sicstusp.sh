#!/bin/bash
# Find the path to SICStus Prolog

# Use the 'which' command to locate SICStus Prolog
SICSTUS_PATH=$(which sicstus)

# Check if SICStus Prolog is installed
if [ -x "$SICSTUS_PATH" ]; then
	echo "SICStus Prolog found at $SICSTUS_PATH"
	# Get the terminal width and store it in a variable
	TERMINAL_WIDTH=$(tput cols)
	TERMINAL_HEIGHT=$(tput lines)

	# Set the environment variable
	export TERMINAL_WIDTH
	export TERMINAL_HEIGHT
	# Run SICStus Prolog
	"$SICSTUS_PATH"

	# Your SICStus Prolog commands go here
else
	echo "SICStus Prolog not found. Please install it or adjust the path."
fi
