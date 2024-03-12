@echo off

rem Set up virtual environment
python -m venv venv

rem Activate virtual environment
call venv\Scripts\activate

rem Upgrade pip
python -m pip install --upgrade pip

rem Install packages
pip install pyinstaller pyinstaller-versionfile icoextract

rem Move folders and files to venv folder
move "Bypass_AV" venv
move "command" venv
move "resource_hacker" venv
move "main.bat" venv

echo Setup completed successfully!

pause

rem Delete the batch file
del %0