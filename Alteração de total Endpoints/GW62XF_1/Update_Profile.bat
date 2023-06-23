echo off
cls

echo ********************************************************************************
echo               GW 6.2.X FW - 2010 Profile Update Script for IPv4 v1

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%cd%\profile_update.ps1'" 
pause