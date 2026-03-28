#!/bin/bash
read -p "Enter alias name: " name
read -p "Enter command to run: " cmd

# Check if .bash_aliases exists, create if not
touch ~/.bash_aliases

# Append the alias
echo "alias $name='$cmd'" >> ~/.bash_aliases
echo "Alias '$name' added to ~/.bash_aliases."
