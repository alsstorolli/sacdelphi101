cd\sac\programa
rem pkzip -u fontoke *.pas *.dfm *.ddp *.bat *.txt *.dpr
rem arj u fontoke *.pas *.dfm *.ddp *.bat *.txt
rar u fontoke *.pas *.dfm *.ddp *.bat *.txt
cd\sac\frota
rem arj u fonfrota *.pas *.dfm *.ddp *.bat *.txt
rar u fonfrota *.pas *.dfm *.ddp *.bat *.txt

cd\sac\programa
rem copy fontoke.arj e:\toke
copy fontoke.rar d:\toke
copy fontoke.rar m:\reges
copy fonfrota.rar d:\toke
copy fonfrota.rar m:\reges

cd\sac\instalador
rem pkzip -u foninst *.pas *.dfm *.ddp *.bat *.txt *.dpr
rem arj u foninst *.pas *.dfm *.ddp *.bat *.txt
rar u foninst *.pas *.dfm *.ddp *.bat *.txt
copy foninst.rar e:\toke
copy foninst.rar d:\toke
cd\sac\importacao
rem arj u fonconv c*.pas c*.dfm c*.ddp *.bat *.dpr
rar u fonconv c*.pas c*.dfm c*.ddp *.bat *.dpr
copy fonconv.rar e:\toke
copy fonconv.rar d:\toke
copy fonconv.rar m:\reges
dir d:\toke\*.rar
pause
