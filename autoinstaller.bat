@ECHO OFF
TITLE Kat's TF2 autoexec installer
REM Version 1.0
SET il=%~dp0

:HOME
ECHO:
ECHO Do you have your steam games installed on a separate drive?
CHOICE /C YN /N /M ">"
IF ERRORLEVEL 2 GOTO :CDRIVE
IF ERRORLEVEL 1 GOTO :EXTERDRIVE

REM Install to the default location in C:\Program Files (x86)\Steam\steamapps\common\
:CDRIVE
ROBOCOPY "%il%\cfg" "C:\Program Files (x86)\Steam\steamapps\common\Team Fortress 2\tf\cfg" *.cfg*
IF %ERRORLEVEL% LSS 8 (
    GOTO :SUCCESS
) ELSE IF %ERRORLEVEL% EQU 2 (
    GOTO :ROBOCOPYEL2
) ELSE (
    GOTO :ROBOCOPYFAILURE
)

REM Handle moving the files to an external drive.
:EXTERDRIVE
CLS
ECHO:
ECHO Please specifiy the drive letter. Ensure that it is capitalized.
SET /p dl=^>
GOTO :MOVE2ED

:MOVE2ED
ROBOCOPY "%il%\cfg" "%dl%:\SteamLibrary\steamapps\common\Team Fortress 2\tf\cfg" *.cfg*
IF %ERRORLEVEL% LSS 8 (
    GOTO :SUCCESS
) ELSE IF %ERRORLEVEL% EQU 2 (
    GOTO :ROBOCOPYEL2
) ELSE (
    GOTO :ROBOCOPYFAILURE
)

REM ROBOCOPY moved the files successfully.
:SUCCESS
ECHO:
ECHO ROBOCOPY moved the files successfully, you may close this utility now.
PAUSE
EXIT

REM Some extra files or directories were detected, no files were copied.
:ROBOCOPYEL2
ECHO ROBOCOPY encountered an issue, please read the above output log.
PAUSE
EXIT

REM Handle this error
:ROBOCOPYFAILURE
ECHO ROBOCOPY has failed, read the above error!
PAUSE
EXIT