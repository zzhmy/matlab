%%
%���ܣ�����gps��ռ�ֱ�����꼰���ٶȼ���ŷ��ʸ��
%�����ļ���ʽ��վ��  X Y Z VX  VY VZ ʮ������
%by zzh_my@163.com
%create at 2015-9-24
%language matlab
% clear all
% disp('this is local ');
%%
%���ļ���ȫ����ȡ������contentAll��ȥ
% [openFileName,openPathName]=uigetfile('my.vel','�򿪼���ŷ��ʸ�����ļ�');
% if(openFileName==0)
%     error('open file failed!')
% end
% openFnamePname=strcat(openPathName,openFileName);
% [name, X, Y, Z,VX,VY,VZ,year]=textread(openFnamePname,'%s%s%s%s%s%s%s%s');
function[eulerVector]=gps_getEulerVector(X, Y, Z,VX,VY,VZ)
%%
% ��װAX=B��xΪ����ŷ��ʸ��,AΪ�������BΪ���ʾ���
%����Ҫ����װA,B,����ѭ��
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
%��������
eulerVector=A\B;
cc=A*eulerVector-B;%����ŷ��ʸ���в�
disp('ŷ��ʸ��(����/��)��')
disp(eulerVector);

%%
