## macos vscode vim插件连续移动问题

link: https://stackoverflow.com/questions/39972335/how-do-i-press-and-hold-a-key-and-have-it-repeat-in-vscode

在mac的vscode上使用vim插件时，按下移动键时，mac会帮你锁住移动，只能移动一行。
为了取消这个限制需要两个步骤：
  1. 在命令行输入 `defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false` 
  2. 在系统偏好设置->键盘里，将按键重复调到最快，重复前延迟调到最短
