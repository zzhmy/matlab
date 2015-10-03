%%
%功能：把ITRF2008框架下历元2000.0的坐标，转换为ITRF97，历元2000.0
%调用外部函数itrf2008_to_itrf97
%输入文件格式：站名  X Y Z 十进制年
%输出文件格式：站名  X Y Z 十进制年
%by zzh_my@163.com
%create at 2015-9-24
%language matlab
clear all
disp('this is local ');
%%
%读取数据，调用函数计算itrf97历元2000.0的坐标
[openFileName,openPathName]=uigetfile('my.XYZ','打开计算ITRF97框架的文件');
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
%输出指定历元下的坐标
%格式：点名  X Y Z 历元
name_out=cell2mat(name);
year_out=cell2mat(year);

fileName_out=strrep(lower(openFileName),'xyz',strcat('To','97'));
fileName_out=strcat(fileName_out,'.xyz');
fileID=fopen(fileName_out,'w+');

[m, n] = size(get_coor);
 for i = 1 : m
    fprintf(fileID, '%s ', name_out(i, :));
    for j = 1 : n % 逐行打印出来
        fprintf(fileID, '%f ', get_coor(i, j)); % 注意%f后面有一个空格
    end
     fprintf(fileID, '%s ', year_out(i, :));
     fprintf(fileID, '\r\n');
 end
fclose(fileID);
disp('计算站点ITRF97框架完毕');

