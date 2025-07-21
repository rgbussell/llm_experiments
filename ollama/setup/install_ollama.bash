# setup script for ollama
#!/bin/bash
# Install Ollama on Linux
set -e

# set up a virtual environment for the llm experiments
python3 -m venv llm_experiments
source llm_experiments/bin/activate
pip install --upgrade pip
pip install requests

# install ollama
if ! command -v ollama &> /dev/null; then
    echo "Installing Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
else
    echo "Ollama is already installed."
    exit 0
fi

