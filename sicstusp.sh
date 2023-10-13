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

	# Check if the terminal is not in full-screen mode
	if [ "$TERMINAL_WIDTH" -lt 80 ] || [ "$TERMINAL_HEIGHT" -lt 24 ]; then
		# Set the text color to red
		tput setaf 1
		echo "Warning: Your terminal is not in full-screen mode."
		echo "Please maximize your terminal window and run this script again for a better experience."
		# Reset text color
		tput sgr0
		exit 1
	else
		# Set the text color to green
		tput setaf 2
		echo "The screen is in full-screen mode. Good to go!"
		# Reset text color
		tput sgr0
	fi

	# Set the environment variable
	export TERMINAL_WIDTH
	export TERMINAL_HEIGHT

	# Run SICStus Prolog
	"$SICSTUS_PATH"

	# Your SICStus Prolog commands go here
else
	echo "SICStus Prolog not found. Please install it or adjust the path."
fi
