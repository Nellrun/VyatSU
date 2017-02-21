@echo off
SET msbuild=%WINDIR%\Microsoft.NET\Framework\v3.5\msbuild.exe

%msbuild% "%~dp0..\..\Assets\VHDUpload\Source\VHDUpload.sln" 

REM pause
:end