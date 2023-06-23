echo off
cls

echo ********************************************************************************
echo               GW/Gap 2010 Profile Update IPv6 v3

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%cd%\profile_update'"
pause