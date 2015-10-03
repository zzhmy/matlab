%%
%���ܣ���ITRF2008�������Ԫ2000.0�����꣬ת��ΪITRF97����Ԫ2000.0
%�����ⲿ����itrf2008_to_itrf97
%�����ļ���ʽ��վ��  X Y Z ʮ������
%����ļ���ʽ��վ��  X Y Z ʮ������
%by zzh_my@163.com
%create at 2015-9-24
%language matlab
clear all
disp('this is local ');
%%
%��ȡ���ݣ����ú�������itrf97��Ԫ2000.0������
[openFileName,openPathName]=uigetfile('my.XYZ','�򿪼���ITRF97��ܵ��ļ�');
if(openFileName==0)
    error('open file failed!')
end
openFnamePname=strcat(openPathName,openFileName);
[name, X, Y, Z,year]=textread(openFnamePname,'%s%s%s%s%s');
get_coor=ones(length(name),3);
for i=1:length(name);
    [x_itrf97,y_itrf97,z_itrf97]=itrf2008_to_itrf97(str2num(X{i}), str2num(Y{i}), str2num(Z{i}));
    get_coor(i,1)=x_itrf97;
    get_coor(i,2)=y_itrf97;
    get_coor(i,3)=z_itrf97;
end

%%
%���ָ����Ԫ�µ�����
%��ʽ������  X Y Z ��Ԫ
name_out=cell2mat(name);
year_out=cell2mat(year);

fileName_out=strrep(lower(openFileName),'xyz',strcat('To','97'));
fileName_out=strcat(fileName_out,'.xyz');
fileID=fopen(fileName_out,'w+');

[m, n] = size(get_coor);
 for i = 1 : m
    fprintf(fileID, '%s ', name_out(i, :));
    for j = 1 : n % ���д�ӡ����
        fprintf(fileID, '%f ', get_coor(i, j)); % ע��%f������һ���ո�
    end
     fprintf(fileID, '%s ', year_out(i, :));
     fprintf(fileID, '\r\n');
 end
fclose(fileID);
disp('����վ��ITRF97������');

