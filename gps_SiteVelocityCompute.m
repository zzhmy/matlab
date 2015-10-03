%%
%���ܣ�����gps��ռ�ֱ�����꼰���ٶȼ���ŷ��ʸ����Ȼ������ŷ��ʸ������վ������
%����ŷ��ʸ�������ļ���ʽ��վ��  X Y Z VX  VY VZ ʮ�����꣬�����ⲿ����gps_getEulerVector
% �����������������ļ���ʽ��վ��  X Y Z ʮ������
%by zzh_my@163.com
%create at 2015-9-24
%language matlab
clear all
disp('this is local ');
%%
%����ŷ��ʸ��
[openFileName,openPathName]=uigetfile('my.vel','�򿪼���ŷ��ʸ�����ļ�');
if(openFileName==0)
    error('open file failed!')
end
openFnamePname=strcat(openPathName,openFileName);
[name, X, Y, Z,VX,VY,VZ,year]=textread(openFnamePname,'%s%s%s%s%s%s%s%s');
eulerVector=gps_getEulerVector(X, Y, Z,VX,VY,VZ);
%%
%����ŷ��ʸ���������վ������
[openFileName,openPathName]=uigetfile('my.XYZ','�򿪼���վ�ٶȵ��ļ�');
if(openFileName==0)
    error('open file failed!')
end
openFnamePname=strcat(openPathName,openFileName);
[name, X, Y, Z,year]=textread(openFnamePname,'%s%s%s%s%s');
% ��װB=AX��BΪ����վ������,AΪ�������XΪŷ��ʸ������
%����Ҫ����װA,B,����ѭ��
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
reShapeB=reShapeB';%������վ����

%%
%��������վ���ʣ�����ָ����Ԫ��վ����
get_time=2000.0;

X_getTime=str2num(cell2mat(X))+reShapeB(:,1).*(get_time-str2num(cell2mat(year)));
Y_getTime=str2num(cell2mat(Y))+reShapeB(:,2).*(get_time-str2num(cell2mat(year)));
Z_getTime=str2num(cell2mat(Z))+reShapeB(:,3).*(get_time-str2num(cell2mat(year)));

%%
%���ָ����Ԫ�µ�����
%��ʽ������  X Y Z ��Ԫ
get_time=ones(length(X_getTime),1).*get_time;
outFile=[X_getTime,Y_getTime,Z_getTime,get_time];
name_out=cell2mat(name);

fileName_out=strrep(lower(openFileName),'xyz',strcat('To',num2str(get_time(1,1))));
fileName_out=strcat(fileName_out,'.xyz');
fileID=fopen(fileName_out,'w+');

[m, n] = size(outFile);
 for i = 1 : m
    fprintf(fileID, '%s ', name_out(i, :));
    for j = 1 : n % ���д�ӡ����
        fprintf(fileID, '%f ', outFile(i, j)); % ע��%f������һ���ո�
     end
     fprintf(fileID, '\r\n');
 end
fclose(fileID);
disp('����վ���������');
