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

del hw.exe
icl test\hw.cpp -o hw.exe

FOR /F "tokens=* USEBACKQ" %%F IN (`hw.exe`) DO (
  SET output=%%F
)

if /I "hello world" EQU "%output%" (
  echo icl compile succeeded
) else (
  echo "icl unexpected output: %output%"
  exit /b 1
)

del hw.exe
icx test\hw.cpp -o hw.exe

FOR /F "tokens=* USEBACKQ" %%F IN (`hw.exe`) DO (
  SET output=%%F
)

if /I "hello world" EQU "%output%" (
  echo icx compile succeeded
) else (
  echo "icx unexpected output: %output%"
  exit /b 1
)