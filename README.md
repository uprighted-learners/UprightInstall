# Upright Education SoftwareDev Installer (macOS)
 
✅ Intel ( Tested on macOS Monterey v.12 )

⚠️ Apple Silicon (Testing, will be available soon)

The Upright Installer is a convenient tool for setting up your development environment on macOS. It will install the following software:

- **Git (will also generate SSH key for GitHub, which will be copied to the clipboard)**
- **MongoDB (mongosh + MongoDB Compass)**
- **Nodejs**
- **Visual Studio Code**
- **Postman**

## Installation Instructions

### Step 1: Clone the Repository

First, clone the repository into your `Downloads` folder. Open your terminal and run:

```bash
cd ~/Downloads
git clone https://github.com/uprighted-learners/UprightInstall.git
```

### Step 2: Run the Installer

You have two options to run the installer:

#### Option 1: Double-Click the Installation File

1. Navigate to the cloned directory found within your `Downloads` folder
2. Find the `UprightInstaller` file and double-click it to run.

#### Option 2: Run the Script via Terminal

Alternatively, you can run the installer script directly in the terminal:

1. Open your terminal.
2. Navigate to the cloned directory:
   ```bash
   cd ~/Downloads/UprightInstall
   ```
3. Run the installer script:
   ```bash
   ./upright_install_mac.sh
   ```

🔑 You will be prompted for your password to grant sudo privileges for 📦 package installations. Please input it to continue.

### Step 3: Complete 
   - Will avoid re-installing packages after initial execution
   - Version numbers will display at the end on every execution and for successful installations 
   
<div style="text-align: center;">
    <img src="https://i.ibb.co/fF2NTgn/nocut.png" alt="Image of result" style="width: 20%; min-width:300px; height:100%"/>
</div>
