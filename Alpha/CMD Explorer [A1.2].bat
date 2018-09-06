@echo off
mode con: cols=120 lines=30
title CMDE
set tempdir=%cd%
set szloc=C:\Program Files\7-Zip\7z.exe
set rarloc=C:\Program Files\WinRAR\Rar.exe
set unrarloc=C:\Program Files\WinRAR\UnRAR.exe
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do (if %%i==Version (set v=%%j.%%k) else (set v=%%i.%%j))
if exist "%tempdir%\override.cmd" goto :override

:Introductory
color 07
cls
title CMDE Intro
echo ________________________________________________________________________________________________________________________
echo [CMDE Version A1.2]
echo Welcome to CMDE, User!
echo.
echo About:
echo CMD Explorer is a batch file that is like File Explorer created by TheonTutorials. CMD Explorer is the perfect way to
echo browse your files in a console program.
echo.
echo Latest Patch Notes:
echo Enhanced the built-in calculator.
echo.
echo WARNING:
echo If you have purchased this program somewhere, DEMAND YOUR MONEY BACK IMMEDIATELY! CMDE is a free software and should be downloaded from TheonTutorial's GitHub.
echo ________________________________________________________________________________________________________________________
pause
goto :Start

:override
call "%tempdir%\override.cmd"
set szloc=%SzipCustomFolder%7z.exe
set rarloc=%WinRARCustomFolder%Rar.exe
set unrarloc=%WinRARCustomFolder%UnRAR.exe
goto :Introductory

:Start
title CMDE Drive Selection
cls
if "%v%"=="6.1" echo WARNING Compression (.zip only) doesn't work with Windows 7 machines!
echo Choose A Drive:
echo.
for /f "skip=1 delims=" %%x in ('wmic logicaldisk get caption') do @echo.%%x
echo.
echo Or type '/eject' to eject the disc tray.
echo ________________________________________________________________________________________________________________________
set /p ds=Drive Selection: 
if %ds%==/eject goto ejecttray
if %ds%==/debug goto debugmenu
%ds%
cd %ds%\
goto :SelDir

:debugmenu
title CMDE Debug Menu
color 0c
echo [v] = debug variables
echo [go] = generate overrides
echo [c] = cancel
set /p debugchoice=Choice: 
if %debugchoice%==c goto :Introductory
if %debugchoice%==v goto :debugvars
if %debugchoice%==go goto :debuggenerateoverride

:debuggenerateoverride
echo generating...
echo REM make sure you put backslashes at the end of the path!>"%tempdir%\override.cmd"
echo REM Szip is really 7-Zip, you just can't use numbers in variables.>>"%tempdir%\override.cmd"
echo set SzipCustomFolder=C:\Program Files\7-Zip\>>"%tempdir%\override.cmd"
echo set WinRARCustomFolder=C:\Program Files\WinRAR\>>"%tempdir%\override.cmd"
echo generated successfully!
pause
goto :debugmenu

:debugvars
echo [1] = szloc
echo [2] = winrarloc
echo [c] = cancel
set /p debugvarchoice=Choice: 
if %debugvarchoice%==1 echo %szloc%
if %debugvarchoice%==2 echo %rarloc% & echo %unrarloc%
if %debugvarchoice%==c goto :debugmenu
goto :debugvars

:ejecttray
title CMDE CD Tray Ejecting
echo Set oWMP = CreateObject("WMPlayer.OCX.7") >> "%tempdir%\temp.vbs"
echo Set colCDROMs = oWMP.cdromCollection >> "%tempdir%\temp.vbs"
echo For i = 0 to colCDROMs.Count-1 >> "%tempdir%\temp.vbs"
echo colCDROMs.Item(i).Eject >> "%tempdir%\temp.vbs"
echo next >> "%tempdir%\temp.vbs"
echo oWMP.close >> "%tempdir%\temp.vbs"
Start "" "%tempdir%\temp.vbs"
timeout /t 1
del "%tempdir%\temp.vbs"
goto :Start

:SelDir
SET currentdir=%cd%
title CMDE %currentdir%
cls
dir
echo ________________________________________________________________________________________________________________________
echo Choose: [CD] = Change Diretory, [CHD] = Change Hard Drive, [E] = Exit, [O] = Open..., [R] = Rename, [REF] = Refresh,
echo         [D] = Delete, [DF] = Delete Folder, [CP] = Copy/Paste, [M] = Move..., [N] = New..., [ZM] = Zip Management
echo         [A] = Accessories...
echo.
set /P ch=Choice: 
if %ch%==E goto exitprog
if %ch%==e goto exitprog
if %ch%==CD goto :cd
if %ch%==cd goto :cd
if %ch%==CHD goto :Start
if %ch%==chd goto :Start
if %ch%==D goto :Delete
if %ch%==d goto :Delete
if %ch%==DF goto :DeleteFolder
if %ch%==df goto :DeleteFolder
if %ch%==CP goto :CopyPaste
if %ch%==cp goto :CopyPaste
if %ch%==M goto :MoveMode
if %ch%==m goto :MoveMode
if %ch%==N goto :NewFile
if %ch%==n goto :NewFile
if %ch%==O goto :OpenFile
if %ch%==o goto :OpenFile
if %ch%==R goto :RenameFile
if %ch%==r goto :RenameFile
if %ch%==ZM goto :ZipManagement
if %ch%==zm goto :ZipManagement
if %ch%==REF goto :SelDir
if %ch%==ref goto :SelDir
if %ch%==A goto :Accessories
if %ch%==a goto :Accessories
goto :SelDir

:exitprog
set /p ays=Are you sure you want to quit? [Y/N] 
if %ays%==Y exit
if %ays%==y exit
if %ays%==N goto :SelDir
if %ays%==n goto :SelDir
goto :exitprog

:cd
title CMDE Change Directory
echo Type .. to go up a folder
set /P chdir=Directory: 
cd %chdir%
goto :SelDir

:Delete
title CMDE Delete File
set /p delfil=File To Delete: 
if exist "%delfil%" goto :DelExist
echo The file '%delfil%' does not exist!
pause
goto :SelDir

:DelExist
del "%delfil%"
echo The file '%delfil%' was deleted. If you selected a folder, it only deleted the files inside. To delete folders, use [DF]
pause
goto :SelDir

:DeleteFolder
title CMDE Delete Folder
set /p delfol=Folder To Delete: 
rmdir "%delfol%" /S
echo If there are no error messages above, the folder was deleted successfully!
pause
goto :SelDir

:CopyPaste
echo [CO] = Copy
echo [PA] = Paste
echo [C]  = Cancel
set /p cpch=Choice: 
if %cpch%==CO goto :CopyMode
if %cpch%==co goto :CopyMode
if %cpch%==PA goto :PasteMode
if %cpch%==pa goto :PasteMode
if %cpch%==C goto :SelDir
if %cpch%==c goto :SelDir
goto :SelDir

:CopyMode
title CMDE Copy File
set /p CopyFil=File to Copy: 
set clipboard=%cd%\%CopyFil%
goto :SelDir

:PasteMode
title CMDE Paste File
if exist "%clipboard%" goto :PasteModeContinued
echo The file you tried to copy either doesn't exist or there is nothing copied.
pause
goto :SelDir

:PasteModeContinued
copy "%clipboard%" "%cd%"
pause
goto :SelDir

:MoveMode
Title CMDE Move File
echo [CU] = Cut
echo [PA] = Paste
echo [C]  = Cancel
set /p cpch2=Choice: 
if %cpch2%==CU goto :CutMode
if %cpch2%==cu goto :CutMode
if %cpch2%==PA goto :PasteCutMode
if %cpch2%==pa goto :PasteCutMode
if %cpch2%==C goto :SelDir
if %cpch2%==c goto :SelDir
goto :SelDir

:CutMode
title CMDE Copy File
set /p CopyFil2=File to Copy: 
set clipboard2=%cd%\%CopyFil2%
goto :SelDir

:PasteCutMode
title CMDE Paste File
if exist "%clipboard2%" goto :PasteCutModeContinued
echo The file you tried to copy either doesn't exist or there is nothing copied.
pause
goto :SelDir

:PasteCutModeContinued
move "%clipboard2%" "%cd%"
pause
goto :SelDir

:NewFile
title CMDE New
echo [FOL] = New Folder
echo [FIL] = New Blank File
echo [C]   = Cancel
set /p nch=Choice: 
if %nch%==FOL goto :NewFileFolder
if %nch%==fol goto :NewFileFolder
if %nch%==FIL goto :NewFileFile
if %nch%==fil goto :NewFileFile
if %nch%==C goto :SelDir
if %nch%==c goto :SelDir
goto :NewFile

:NewFileFolder
title CMDE New Folder
set /p folname=Folder Name: 
mkdir "%folname%"
echo If there are no errors above, the folder was created successfully!
pause
goto :SelDir

:NewFileFile
title CMDE New Blank File
echo Don't forget to add an extension to the end such as:
echo .txt or .bat (Don't forget that you don't need to include these specifically)
set /p filname=File Name: 
fsutil file createnew "%filname%" 0
echo If there are no errors above, the file was created successfully!
pause
goto :SelDir

:OpenFile
title CMDE Open File
set /p opnfil=File To Launch: 
start "" "%opnfil%"
goto :SelDir

:RenameFile
title CMDE Rename File
set /p ren1=File you want to rename: 
set /p ren2=New name: 
ren "%ren1%" "%ren2%"
echo If there are no errors above, the file was renamed successfully!
pause
goto :SelDir

:ZipManagement
title CMDE Zip Management
echo [CO]  = Compress   (.zip)
echo [DC]  = Decompress (.zip)
echo [7z]  = 7-Zip      (requires 7zip to be installed)
echo [RAR] = WinRar     (requires WinRar to be installed)
echo [C]   = Cancel
set /p zipch=Choice: 
if %zipch%==CO goto :Compress
if %zipch%==co goto :Compress
if %zipch%==DC goto :Decompress
if %zipch%==dc goto :Decompress
if %zipch%==7Z goto :7zipMode
if %zipch%==7z goto :7zipMode
if %zipch%==RAR goto :WinRarMode
if %zipch%==rar goto :WinRarMode
if %zipch%==C goto :SelDir
if %zipch%==c goto :SelDir
goto :ZipManagement

:Compress
title CMDE Compress a Zip
set /p conm=File/Folder to compress: 
if exist "%conm%" goto :CompressContinuation
echo The file/folder does not exist!
pause
goto :SelDir

:CompressContinuation
powershell -Command "& {cd '%cd%'; Compress-Archive -Path '%conm%' -DestinationPath '%conm%.zip'}"
echo The process has been executed. To check if this has worked, check if there is a zip file that has the same name as the file/folder.
pause
Goto :SelDir

:Decompress
title CMDE Decompress a Zip
set /p dcnm=File to decompress: 
if exist "%dcnm%" goto :DecompressContinuation
echo The file does not exist!
pause
goto :SelDir

:DecompressContinuation
if exist "%tempdir%\decompress.vbs" del "%tempdir%\decompress.vbs"
echo Option Explicit > "%tempdir%\decompress.vbs"
echo Dim objFSO : Set objFSO = CreateObject("Scripting.FileSystemObject") >> "%tempdir%\decompress.vbs"
echo Dim objAPP : Set objAPP = CreateObject("Shell.Application") >> "%tempdir%\decompress.vbs"
echo Dim COMP : COMP = "%cd%\%dcnm%" >> "%tempdir%\decompress.vbs"
echo Dim EXTR : EXTR = Left(COMP, InStrRev(COMP,".") - 1) >> "%tempdir%\decompress.vbs"
echo If Not objFSO.FolderExists(EXTR) then >> "%tempdir%\decompress.vbs"
echo objFSO.CreateFolder EXTR >> "%tempdir%\decompress.vbs"
echo End If >> "%tempdir%\decompress.vbs"
echo objAPP.NameSpace(EXTR).CopyHere(objAPP.NameSpace(COMP).Items) >> "%tempdir%\decompress.vbs"
Start "" "%tempdir%\decompress.vbs"
timeout /t 3 /nobreak
del /f /q "%tempdir%\decompress.vbs"
echo The process has been executed. To check if this has worked, check if there is a folder named the same as the file.
pause
goto :SelDir

:7zipMode
echo Scanning for 7-Zip...
if exist "%szloc%" goto 7zipChoice
echo Scan failed. If you have 7-Zip installed in a custom location,
echo type CON to continue and then enter the folder that contains 7-zip.
echo [CON] = Continue
echo [C]   = Cancel
set /p szfc=Choice: 
if %szfc%==CON goto :7zCustom
if %szfc%==con goto :7zCustom
if %szfc%==C goto :ZipManagement
if %szfc%==c goto :ZipManagement
goto :7zipMode

:7zCustom
echo (Be sure to have a backslash at the end)
set /p szfolder=7-Zip Folder: 
set szloc=%szfolder%7z.exe
goto :7zipMode

:7zipChoice
echo Scan complete. 7-Zip found.
echo [CO] = Compress   (.7z)
echo [DC] = Decompress (.7z)
echo [C]  = Cancel
set /p szch=Choice: 
if %szch%==CO goto :7zCompress
if %szch%==co goto :7zCompress
if %szch%==DC goto :7zDecompress
if %szch%==dc goto :7zDecompress
if %szch%==C goto :ZipManagement
if %szch%==c goto :ZipManagement
goto :7zipChoice

:7zCompress
set /p szftc=File/Folder to compress: 
"%szloc%" a "%szftc%.7z" "%szftc%"
echo The process has been executed. Check above to see if there are any errors.
pause
goto :SelDir

:7zDecompress
set /p szftd=File to decompress: 
"%szloc%" e "%szftd%"
echo The process has been executed. Check above to see if there are any errors.
pause
goto :SelDir

:WinRarMode
echo Scanning for WinRar...
if exist "%rarloc%" if exist "%unrarloc%" goto WinRarChoice
echo Scan failed. If you have WinRar installed in a custom location,
echo type CON to continue and then enter the folder that contains WinRar.
echo [CON] = Continue
echo [C]   = Cancel
set /p wrfc=Choice: 
if %wrfc%==CON goto :WinRarCustom
if %wrfc%==con goto :WinRarCustom
if %wrfc%==C goto :ZipManagement
if %wrfc%==c goto :ZipManagement
goto :WinRarMode

:WinRarCustom
echo (Be sure to have a backslash at the end)
set /p winrarfolder=WinRar Folder: 
set rarloc=%winrarfolder%Rar.exe
set unrarloc=%winrarfolder%UnRAR.exe
goto :WinRarMode

:WinRarChoice
echo Scan complete. WinRar found.
echo [CO] = Compress   (.rar)
echo [DC] = Decompress (.rar)
echo [C]  = Cancel
set /p wrch=Choice: 
if %wrch%==CO goto :WinRarCompress
if %wrch%==co goto :WinRarCompress
if %wrch%==DC goto :WinRarDecompress
if %wrch%==dc goto :WinRarDecompress
if %wrch%==C goto :ZipManagement
if %wrch%==c goto :ZipManagement
goto :7zipChoice

:WinRarCompress
set /p wrftc=File/Folder to compress: 
"%rarloc%" a "%wrftc%.rar" "%wrftc%"
echo The process has been executed. Check above to see if there are any errors.
pause
goto :SelDir

:WinRarDecompress
set /p wrftd=File to decompress: 
"%unrarloc%" e "%wrftd%"
echo The process has been executed. Check above to see if there are any errors.
pause
goto :SelDir

:Accessories
echo [CAL] = Built-in Calculator
echo [C]   = Cancel
set /p ach=Choice: 
if %ach%==CAL goto :BuiltinCalculatorSetup
if %ach%==cal goto :BuiltinCalculatorSetup
if %ach%==C goto :SelDir
if %ach%==c goto :SelDir
goto :Accessories

:BuiltinCalculatorSetup
cls
title CMDE Calculator
echo Type '/exit' to exit the calculator.
echo ________________________________________________________________________________________________________________________ 
goto :BuiltinCalculator

:BuiltinCalculator
set /p eq=Equation: 
if %eq%==/exit goto :Accessories 
set /a eqa=%eq%
echo Result: %eqa%
goto :BuiltinCalculator