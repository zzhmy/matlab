%%
%matlab 
%比较HLJCORS和广播CORS的定位精度
%采用功分器，1个天线，2个流动站，分别接入2个CORS系统。
%读取HLJCOR定位结果文件，格式：x  y  H
%读取radio定位结果文件，格式：x  y  H
%by zzh_my@163.com。
%create at 2017-2-28
clear all
disp('this is local ');
%%
%打开文件，读取HLJCORS定位结果
[openFileName,openPathName]=uigetfile('HLJCORS.xyH','打开HLJCORS文件');
if(openFileName==0)
    error('open file failed!')
end
openFnamePname=strcat(openPathName,openFileName);
hljcorsAll=load(openFnamePname);
hljcorsX=hljcorsAll(:,1);
hljcorsY=hljcorsAll(:,2);
hljcorsH=hljcorsAll(:,3);

%打开文件，读取radio定位结果
[openFileName,openPathName]=uigetfile('radio.xyH','打开radio文件');
if(openFileName==0)
    error('open file failed!')
end
openFnamePname=strcat(openPathName,openFileName);
radioAll=load(openFnamePname);
radioX=radioAll(:,1);
radioY=radioAll(:,2);
radioH=radioAll(:,3);
%%
%X方向
for i=1:length(radioX)
    chazhiX(i)=radioX(i)-hljcorsX(1);
    for j=1:length(hljcorsX)
        tempX=radioX(i)-hljcorsX(j);
        if(abs(tempX)<abs(chazhiX(i)))
            chazhiX(i)=tempX;
        end
    end
end
%%
%Y方向
for i=1:length(radioY)
    chazhiY(i)=radioY(i)-hljcorsY(1);
    for j=1:length(hljcorsY)
        tempX=radioY(i)-hljcorsY(j);
        if(abs(tempX)<abs(chazhiY(i)))
            chazhiY(i)=tempX;
        end
    end
end
%%
%H方向
for i=1:length(radioH)
    chazhiH(i)=radioH(i)-hljcorsH(1);
    for j=1:length(hljcorsH)
        tempX=radioH(i)-hljcorsH(j);
        if(abs(tempX)<abs(chazhiH(i)))
            chazhiH(i)=tempX;
        end
    end
end
%%
%大于1m的值，修改为NAN
 chazhiX(abs(chazhiX)>1)=NaN;
 chazhiY(abs(chazhiY)>1)=NaN;
 chazhiH(abs(chazhiH)>2)=NaN;
 %%
 %绘图
hraw=figure;
figure(hraw);
subplot(3,1,1);
hold on;
plot(chazhiX,'red.');
%
figure(hraw);
subplot(3,1,2);
hold on;
plot(chazhiY,'red.');
%
figure(hraw);
subplot(3,1,3);
hold on;
plot(chazhiH,'red.');
