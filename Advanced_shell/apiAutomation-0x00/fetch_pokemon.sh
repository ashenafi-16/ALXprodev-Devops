#!/bin/bash
# Automates fetching Pikachu data from the Pokémon API
# Saves response to data.json or logs error to errors.txt

# Enable strict error handling
set -euo pipefail

# Variables
POKEMON="pikachu"
API_URL="https://pokeapi.co/api/v2/pokemon/${POKEMON}"
OUTPUT_FILE="data.json"
ERROR_FILE="errors.txt"

# Make API request
# -s = silent
# -w "%{http_code}" = output only HTTP status code
# -o $OUTPUT_FILE = save body to file
HTTP_CODE=$(curl -s -w "%{http_code}" "$API_URL" -o "$OUTPUT_FILE")

# Check if request succeeded
if [ "$HTTP_CODE" -ne 200 ]; then
    echo "Error: Failed to fetch data for $POKEMON (status $HTTP_CODE)" >> "$ERROR_FILE"
    exit 1
fi

echo "Successfully saved $POKEMON data to $OUTPUT_FILE"
