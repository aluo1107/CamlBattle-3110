
# Installation Instructions 

- opam install ANSITerminal graphics 

- MAC Users
  - Download XQuartz (X servers for displaying graphics)
  - Open XQuarts
  - Run make build
  - Run make play to run the game itself

- Windows Users
  - Download Xming X Server (https://sourceforge.net/projects/xming/)
  - Open Xming X Server
  - Run make build
  - Run make play to run the game itself
    - If you receive the "Fatal error: exception Graphics.Graphic_failure("Cannot open display ")"
      - Copy export DISPLAY=$(ip route|awk '/^default/{print $3}'):0.0 into terminal

- Run make test to run tests

