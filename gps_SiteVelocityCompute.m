%%
%功能：根据gps点空间直接坐标及其速度计算欧拉矢量，然后利用欧拉矢量计算站点速率
%计算欧拉矢量输入文件格式：站名  X Y Z VX  VY VZ 十进制年，调用外部函数gps_getEulerVector
% 计算待求点速率输入文件格式：站名  X Y Z 十进制年
%by zzh_my@163.com
%create at 2015-9-24
%language matlab
clear all
disp('this is local ');
%%
%计算欧拉矢量
[openFileName,openPathName]=uigetfile('my.vel','打开计算欧拉矢量的文件');
if(openFileName==0)
    error('open file failed!')
end
openFnamePname=strcat(openPathName,openFileName);
[name, X, Y, Z,VX,VY,VZ,year]=textread(openFnamePname,'%s%s%s%s%s%s%s%s');
eulerVector=gps_getEulerVector(X, Y, Z,VX,VY,VZ);
%%
%利用欧拉矢量计算待求站点速率
[openFileName,openPathName]=uigetfile('my.XYZ','打开计算站速度的文件');
if(openFileName==0)
    error('open file failed!')
end
openFnamePname=strcat(openPathName,openFileName);
[name, X, Y, Z,year]=textread(openFnamePname,'%s%s%s%s%s');
% 组装B=AX，B为待求站点速率,A为坐标矩阵，X为欧拉矢量矩阵
%按照要求组装A,B,规律循环
%      VX1
%      VY1        0  Z  -Y
%      VZ1   A=  -Z  0   X
% B=   VX2        Y -X   0
%      VY2
%      VZ2
A=ones(length(name)*3,3);
count=1;
for i=1:length(name)
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
B=A*eulerVector;
reShapeB=reshape(B,3,length(name));
reShapeB=reShapeB';%新求解的站速率

%%
%利用求解的站速率，计算指定历元的站坐标
get_time=2000.0;

X_getTime=str2num(cell2mat(X))+reShapeB(:,1).*(get_time-str2num(cell2mat(year)));
Y_getTime=str2num(cell2mat(Y))+reShapeB(:,2).*(get_time-str2num(cell2mat(year)));
Z_getTime=str2num(cell2mat(Z))+reShapeB(:,3).*(get_time-str2num(cell2mat(year)));

%%
%输出指定历元下的坐标
%格式：点名  X Y Z 历元
get_time=ones(length(X_getTime),1).*get_time;
outFile=[X_getTime,Y_getTime,Z_getTime,get_time];
name_out=cell2mat(name);

fileName_out=strrep(lower(openFileName),'xyz',strcat('To',num2str(get_time(1,1))));
fileName_out=strcat(fileName_out,'.xyz');
fileID=fopen(fileName_out,'w+');

[m, n] = size(outFile);
 for i = 1 : m
    fprintf(fileID, '%s ', name_out(i, :));
    for j = 1 : n % 逐行打印出来
        fprintf(fileID, '%f ', outFile(i, j)); % 注意%f后面有一个空格
     end
     fprintf(fileID, '\r\n');
 end
fclose(fileID);
disp('计算站点速率完毕');
