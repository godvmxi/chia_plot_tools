set tmp1=u:\tmp1\
set tmp2=v:\tmp2\
set tmp3=w:\tmp3\
set tmp4=t:\tmp1\
set tmpdir=%tmp4%
set dstdriver=i
set dstdir=%dstdriver%:\chia
set var=0
echo "tmp->"%tmpdir%
echo "dst->"%dstdir%
md %tmpdir%
md %dstdir%
:continue
echo run %var% times
del %tmpdir%*.* /f/s/q/a
chia-plotter-windows-amd64 -action plotting -plotting-fpk 0x8addc65c5cc57e2ea08c460d15a2287143fff3c357b9f554b0a831a7722acea624532aab7fb488c3f0d7a35a71809496 -plotting-ppk 0xa605b02dc7ebd75712a50d650a5aa708cd5e98a05ae0f5a1c9364cd2569a717b3f4c5457d929259649af7335b66c00c9 -plotting-n 1000 -b 3390 -r 2 -p  -d %dstdir%  -t  %tmpdir%
set /a var+=1
if %var% lss 10 goto continue

echo Done
pause