# Variables
PROJECT_DIR = Carhub-API
TUIST = tuist
NPM = npm
SERVER_PORT = 3000  # Change if your server runs on a different port

# Default target
.PHONY: all run clean check_server start_server

all: run

# Check if the server is already running
check_server:
	@nc -z localhost $(SERVER_PORT) && echo "Server is already running on port $(SERVER_PORT)" || make start_server

# Start the server in a new macOS Terminal window
start_server:
	@echo "Starting CarHub API in a new terminal..."
	@osascript -e 'tell application "Terminal" to do script "cd $(PWD)/$(PROJECT_DIR) && $(NPM) start"'

# Generate project and run server if needed
run:
	@echo "Generating project using Tuist..."
	@$(TUIST) generate
	@make check_server

# Clean the project
clean:
	@echo "Cleaning project with Tuist..."
	@$(TUIST) clean
