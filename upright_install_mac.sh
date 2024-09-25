#!/bin/bash
HOMEBREW_NO_ENV_HINTS=1

# Function to install Homebrew
install_homebrew() {
    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew is already installed."
    fi
}

# Function to install Node.js
install_node() {
    if ! command -v node &>/dev/null; then

        # URL of the directory to fetch
        url="https://nodejs.org/dist/latest/"

        # Step 1: Fetch the directory listing using curl
        echo "Fetching directory listing from $url"
        content=$(curl -s "$url")

        # Step 2: Use grep to find the .pkg file and awk to extract the filename
        pkg_filename=$(echo "$content" | grep -oE 'node-v[0-9]+\.[0-9]+\.[0-9]+\.pkg')

        # Step 3: Verify the filename
        if [ -n "$pkg_filename" ]; then
            echo "Found .pkg file: $pkg_filename"
            download_url="${url}${pkg_filename}"
            curl -o ./Downloads/node-current.pkg $download_url
            echo "Downloaded Node Installer"
            sudo installer -pkg ./Downloads/node-current.pkg -target /
        else

            echo "No .pkg file found."
            exit 1
        fi

        echo "Installing Node..."
    else
        echo "Node is already installed."
    fi
}

# Function to install Git
install_git() {
    if ! command -v git &>/dev/null; then
        echo "Installing Git..."
        brew install git >/dev/null
    else
        echo "Git is already installed."
    fi
}

# Function to install Visual Studio Code
install_vscode() {
    if ! command -v code &>/dev/null; then
        echo "Installing Visual Studio Code..."
        brew install --cask visual-studio-code >/dev/null
    else
        echo "VSCode is already installed."
    fi
}
# Function to Mongodb & compass
install_mongodb_compass() {
    if ! command -v mongosh &>/dev/null; then
        echo "Installing MongoDB + Compass ..."
        brew tap mongodb/brew >/dev/null
        brew install --ignore-dependencies mongodb/brew/mongosh
        brew install --ignore-dependencies mongodb/brew/mongodb-community
        brew install --cask mongodb-compass
        echo "Starting mongodb server"
        brew services start mongodb/brew/mongodb-community
        sudo mkdir -p /usr/local/opt/node/bin
        sudo ln -s $(which node) /usr/local/opt/node/bin/node
    else
        echo "MongoDB is already installed."
    fi
}

# Function to install Postman
install_postman() {
    if [ -d "/Applications/Postman.app" ]; then
        echo "Postman is already installed."
    else
        echo "Installing Postman..."
        brew install --cask postman >/dev/null
    fi
}

check_postman_version() {
    if [ -d "/Applications/Postman.app" ]; then
        version=$(/usr/bin/defaults read /Applications/Postman.app/Contents/Info.plist CFBundleShortVersionString)
        echo "Postman: $version"
    else
        echo "Postman is not installed."
    fi
}

check_compass_version() {
    if [ -d "/Applications/MongoDB Compass.app" ]; then
        version=$(/usr/bin/defaults read "/Applications/MongoDB Compass.app/Contents/Info.plist" CFBundleShortVersionString)
        echo "MongoDB Compass: $version"
    else
        echo "MongoDB Compass is not installed."
    fi
}

# Function to set up Git SSH key
setup_git_ssh() {

    # Path to the known_hosts file
    known_hosts_file="$HOME/.ssh/known_hosts"

    # Check if the file contains 'github.com'
    if grep -q "github.com" "$known_hosts_file"; then
        echo "Github found in known hosts"
    else
        echo "The known_hosts file does NOT contain an entry for github.com."
        echo "Creating SSH key..."
        ssh-keygen -t rsa -b 4096 -C
        eval "$(ssh-agent -s)"
        ssh-add -K ~/.ssh/id_rsa

        echo "Add this SSH key to your GitHub account:"
        pbcopy <~/.ssh/id_rsa.pub
        echo "SSH key copied to clipboard. Please add it to your GitHub account."
    fi
}

# Function to log installed versions
log_versions() {
    echo "----------------------"
    echo "Current Installed Versions:"
    echo "----------------------"
    echo "VSCODE: $(code --version | head -n 1)"
    echo "GIT: $(git --version | head -n 1)"
    echo "NODE: $(node --version)"
    echo "NPM: $(npm --version)"
    check_postman_version
    echo "MongoSH: $(mongosh --version)"
    check_compass_version
}

echo "----------------------"
echo "Running Installer..."
echo "----------------------"
install_homebrew
install_git
install_node
install_vscode
install_postman
install_mongodb_compass
setup_git_ssh
log_versions

echo "----------------------"
echo "Installation complete!"
echo "----------------------"