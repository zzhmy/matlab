%%
%功能：根据gps点空间直接坐标及其速度计算欧拉矢量
%输入文件格式：站名  X Y Z VX  VY VZ 十进制年
%by zzh_my@163.com
%create at 2015-9-24
%language matlab
% clear all
% disp('this is local ');
%%
%打开文件，全部读取到变量contentAll中去
% [openFileName,openPathName]=uigetfile('my.vel','打开计算欧拉矢量的文件');
% if(openFileName==0)
%     error('open file failed!')
% end
% openFnamePname=strcat(openPathName,openFileName);
% [name, X, Y, Z,VX,VY,VZ,year]=textread(openFnamePname,'%s%s%s%s%s%s%s%s');
function[eulerVector]=gps_getEulerVector(X, Y, Z,VX,VY,VZ)
%%
% 组装AX=B，x为待求欧拉矢量,A为坐标矩阵，B为速率矩阵
%按照要求组装A,B,规律循环
%      VX1
%      VY1        0  Z  -Y
%      VZ1   A=  -Z  0   X
% B=   VX2        Y -X   0
%      VY2
%      VZ2
B=ones(length(X)*3,1);
count=1;
for i=1:length(X)
    B(count)=str2num(VX{i});
    B(count+1)=str2num(VY{i});
    B(count+2)=str2num(VZ{i});
    count=count+3;
end
A=ones(length(X)*3,3);
count=1;
for i=1:length(X)
    A(count,1)=0;
    A(count,2)=str2num(Z{i});
    A(count,3)=-str2num(Y{i});
    
    A(count+1,1)=-str2num(Z{i});
    A(count+1,2)=0;
    A(count+1,3)=str2num(X{i});
    
    A(count+2,1)=str2num(Y{i});
    A(count+2,2)=-str2num(X{i});
    A(count+2,3)=0;
    
    count=count+3;
end
%%
%矩阵运算
eulerVector=A\B;
cc=A*eulerVector-B;%计算欧拉矢量残差
disp('欧拉矢量(弧度/年)：')
disp(eulerVector);

%%
