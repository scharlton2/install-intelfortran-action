@echo off
ifort test\hw.f90 -o hw.exe

FOR /F "tokens=* USEBACKQ" %%F IN (`hw.exe`) DO (
  SET output=%%F
)

if /I "hello world" EQU "%output%" (
  echo fortran compile succeeded
) else (
  echo "unexpected output: %output%"
  exit /b 1
)
