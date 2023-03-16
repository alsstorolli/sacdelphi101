cd\sac\programa
rem pkzip -u fontoke *.pas *.dfm *.ddp *.bat *.txt
arj u fontoke *.pas *.dfm *.ddp *.bat *.txt
copy fontoke.arj a:
cd\sac\instalador
rem pkzip -u foninst *.pas *.dfm *.ddp *.bat *.txt
arj u foninst *.pas *.dfm *.ddp *.bat *.txt
copy foninst.arj a:
dir a:
pause
