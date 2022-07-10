Set-ExecutionPolicy Bypass -Scope Process -Force

choco install -y python2
choco install -y nodejs
choco install -y git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'"

choco install -y consul

choco install -y microsoft-visual-cpp-build-tools
choco install -y vscode
# choco install -y visualstudio2013professional
choco install -y cygwin
choco install -y 7zip.install
choco install -y sysinternals
