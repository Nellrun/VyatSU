@echo off
echo.
echo ======================================================
echo Uninstall Visual Studio 2010 Code Snippets for the lab
echo ======================================================
echo.

DEL "%USERPROFILE%\Documents\Visual Studio 2010\Code Snippets\Visual C#\My Code Snippets\IntroductiontoWindowsAzureEx*.snippet"
DEL "%USERPROFILE%\Documents\Visual Studio 2010\Code Snippets\Visual Basic\My Code Snippets\IntroductiontoWindowsAzureEx*.snippet"
DEL "%USERPROFILE%\Documents\Visual Studio 2010\Code Snippets\XML\My Xml Snippets\IntroductiontoWindowsAzureEx*.snippet"

echo Lab Code Snippets have been removed!