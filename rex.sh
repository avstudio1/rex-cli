#!/bin/bash

# Set script to exit on any error
set -e

# Define colors for better output
GREEN="\033[0;32m"
RED="\033[0;31m"
AMBER="\033[38;2;255;191;0m"
NC="\033[0m" # No color

# Define functions for each stage of the pipeline
build() {
  echo -e "${AMBER}==> Building the project...${NC}"
  # Example build commands
  go build -o output/rex .
  echo -e "${GREEN}Build completed successfully.${NC}"
}

test() {
  echo -e "${AMBER}==> Running tests...${NC}"
  # Example test commands
  go test ./...
  echo -e "${GREEN}All tests passed successfully.${NC}"
}

deploy() {
  echo -e "${AMBER}==> Deploying the project...${NC}"
  # Example deployment commands (local directory deployment)
  sudo cp output/rex /usr/local/bin
  echo -e "${GREEN}Deployment completed successfully.${NC}"
}

# Show help message
show_help() {
  echo "Usage: $0 [build|test|deploy|all]"
  echo "  build   - Build the project"
  echo "  test    - Run tests"
  echo "  deploy  - Deploy the project locally"
  echo "  all     - Run build, test, and deploy stages"
}

# Main pipeline logic
if [ "$#" -eq 0 ]; then
  show_help
  exit 1
fi

for stage in "$@"; do
  case "$stage" in
    build)
      build
      ;;
    test)
      test
      ;;
    deploy)
      deploy
      ;;
    all)
      build
      test
      deploy
      ;;
    *)
      echo -e "${RED}Unknown command: $stage${NC}"
      show_help
      exit 1
      ;;
  esac
done
