# Save the current location and switch to this script's directory.
# Note: This shouldn't fail; if it did, it would indicate a
#       serious system-wide problem.
$prevPwd = $PWD; Set-Location -ErrorAction Stop -LiteralPath $PSScriptRoot

try
{
  #First remove the exe and kill the process
  kall screen*
  kall AutoHotkey*
  rm "./screenShotShortcut.exe"
  echo "Previous instance killed, removed exe"
  # The location of this command is located in the ~/.config/powershell/user_profile.ps1
  ahk2exe /in "./screenShotShortcut.ahk" /out "./screenShotShortcut.exe" /silent
  echo "Compiled new instance"
  sudo "C:\Users\gersi\Desktop\scripts\screenShotShortcut.exe"
  echo "New instance running!" 
} finally
{
  # Restore the previous location.
  $prevPwd | Set-Location
}
