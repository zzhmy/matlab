function [XS,YS,ZS]=itrf2008_to_itrf97(X,Y,Z)
format long g;
%%itrf2008参考框架转换为itrf97
% by zzh_my@163.com
%%指定参数，ransformation parameters at epoch 2000.0 and their rates from
%%ITRF2008 to ITRF97
%http://itrf.ensg.ign.fr/ITRF_solutions/2008/tp_08-05.php
%转换参数来自“大地测量控制点坐标转换技术规程”
Tx=4.8;Ty=2.6;Tz=-33.2;D=2.92;Rx=0.000;Ry=0.000;Rz=	0.06;
TxV=0.1;TyV=-0.5;TzV=-3.2;DV=0.09;RxV=0.000;RyV=0.000;RzV=0.02;

%%(1)转单位
Tx=Tx*10^(-3);%mm变为单位m
Ty=Ty*10^(-3);
Tz=Tz*10^(-3);
D=D*10^(-9);
Rz=Rz*10^(-3)/3600*(pi/180);%毫角秒 化为 弧度
%%(2)做矩阵
T=[Tx;Ty;Tz];
MA=[D,-Rz,Ry;Rz,D,-Rx;-Ry,Rx,D];
%%(3)计算
TransBefore=[X;Y;Z];
Trans=TransBefore+T+MA*TransBefore;
XS=Trans(1);
YS=Trans(2);
ZS=Trans(3);




