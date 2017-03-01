%%
%matlab 
%�Ƚ�HLJCORS�͹㲥CORS�Ķ�λ����
%���ù�������1�����ߣ�2������վ���ֱ����2��CORSϵͳ��
%��ȡHLJCOR��λ����ļ�����ʽ��x  y  H
%��ȡradio��λ����ļ�����ʽ��x  y  H
%by zzh_my@163.com��
%create at 2017-2-28
clear all
disp('this is local ');
%%
%���ļ�����ȡHLJCORS��λ���
[openFileName,openPathName]=uigetfile('HLJCORS.xyH','��HLJCORS�ļ�');
if(openFileName==0)
    error('open file failed!')
end
openFnamePname=strcat(openPathName,openFileName);
hljcorsAll=load(openFnamePname);
hljcorsX=hljcorsAll(:,1);
hljcorsY=hljcorsAll(:,2);
hljcorsH=hljcorsAll(:,3);

%���ļ�����ȡradio��λ���
[openFileName,openPathName]=uigetfile('radio.xyH','��radio�ļ�');
if(openFileName==0)
    error('open file failed!')
end
openFnamePname=strcat(openPathName,openFileName);
radioAll=load(openFnamePname);
radioX=radioAll(:,1);
radioY=radioAll(:,2);
radioH=radioAll(:,3);
%%
%X����
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
%Y����
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
%H����
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
%����1m��ֵ���޸�ΪNAN
 chazhiX(abs(chazhiX)>1)=NaN;
 chazhiY(abs(chazhiY)>1)=NaN;
 chazhiH(abs(chazhiH)>2)=NaN;
 %%
 %��ͼ
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
