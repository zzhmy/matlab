%%
%��ȡXYZ�ļ�����ʽ��ʮ������  ��  �����  X  Y  Z
%����XYZ��������ʡ�
%������֮���������������������������Ҫ��Ӵ�����knowTerms�����С�
%
clear all
disp('this is local ');
%%
%���ļ���ȫ����ȡ������contentAll��ȥ
[openFileName,openPathName]=uigetfile('my.xyz','���ļ�');
if(openFileName==0)
    error('open file failed!')
end
openFnamePname=strcat(openPathName,openFileName);
contentAll=load(openFnamePname);
%%
% ���Ȱ�ԭ������ͼ��������֮���ڸ�ͼ�ϰ��������ģ��Ҳ����������>�鿴���Ч��(���ִ��뿽����neushow)
%%
%������һ���µĻ���
hraw=figure;

%%
%�����������ж������ʾ�����>=4�У��򻭳�3�������ͼ
figure(hraw)
[row col]=size(contentAll);

if(col>=4)
    year=contentAll(:,1);
    %
    year1=year(1,1);
    yearstr=num2str(year1);
    s=strtok(yearstr,'.');%���꣬�ִ�
    yearfirst=str2num(s);
    %
    yearlast=year(length(year),1);
    % 
    direction1=contentAll(:,4);
    direction2=contentAll(:,5);
    direction3=contentAll(:,6);
    subplot(3,1,1);
    plot(year,direction1,'o'); 
    ylabel('X-residual(m)');
%   
   title(strcat('Station:',strrep(upper(openFileName),'.XYZ','')));
   grid on;
set(gca,'xtick',yearfirst:0.5:2014);
    subplot(3,1,2);
    plot(year,direction2,'o'); 
    ylabel('Y-residual(m)');
%        
          grid on;
set(gca,'xtick',yearfirst:0.5:2014);
    subplot(3,1,3);
    plot(year,direction3,'o'); 
    xlabel('time(years)');
    ylabel('Z-residual(m)');
%     
        grid on;
set(gca,'xtick',yearfirst:0.5:2014);
end
%%
%hresidual=figure;%�в����л��ڸû�����
%��contentAll����ϸ�ֵ���������year,X,Y,Z,
if(col>=4)
year=contentAll(:,1);
X=contentAll(:,4);
Y=contentAll(:,5);
Z=contentAll(:,6);

%%
% ������������
% knowTermsN=[ones(size(year)),  year,  sin(2*pi*year), cos(2*pi*year),  sin(4*pi*year) ,cos(4*pi*year) , ...
%    myStep(year,TstepN), myStep(year,TstepN).*year, exp(-(year-TstepN).*year/tao).*myStep(year,TstepN)];
knowTermsX=[ones(size(year)), year];
knowTermsY=[ones(size(year)) ,year] ;
knowTermsZ=[ones(size(year)) ,year] ;
%%
%��ȡX����в�
Xterm=knowTermsX\X;%���������
Xmodle=knowTermsX*Xterm;%����ģ��
%%%%%%
figure(hraw);%����ԭͼ�ϻ����ģ������
subplot(3,1,1);
hold on;
plot(year,Xmodle,'red');
hh=axis;
text((yearlast+yearfirst)/2,hh(4),strcat('X-vel=  ', num2str(Xterm(2,1)*100,'%10.2f'),' cm/yr'),'Color',[1 0 0],'VerticalAlignment','top','FontSize',10); %����
%%
%��ȡY����β�
Yterm=knowTermsY\Y;
Ymodle=knowTermsY*Yterm;
%%%%%%
figure(hraw);%����ԭͼ�ϻ����ģ������
subplot(3,1,2);
hold on;
plot(year,Ymodle,'red');
hh=axis;
text((yearlast+yearfirst)/2,hh(4),strcat('Y-vel=  ', num2str(Yterm(2,1)*100,'%10.2f'),' cm/yr'),'Color',[1 0 0],'VerticalAlignment','top','FontSize',10); %����

%%
Zterm=knowTermsZ\Z;
Zmodle=knowTermsZ*Zterm;
figure(hraw);%����ԭͼ�ϻ����ģ������
subplot(3,1,3);
hold on;
plot(year,Zmodle,'red');
hh=axis;
text((yearlast+yearfirst)/2,hh(4),strcat('Z-vel=  ', num2str(Zterm(2,1)*100,'%10.2f'),' cm/yr'),'Color',[1 0 0],'VerticalAlignment','top','FontSize',10); %����
%%
filenamePicraw=strrep(lower(openFileName),'xyz','XYZ');
filenamePicraw=strcat(filenamePicraw,'.ps');
%print(gcf,'-dps','-cmyk',filenamePic);
print(gcf,'-depsc',filenamePicraw);
filenamePicraw=strrep(lower(openFileName),'.xyz','.XYZ');
filenamePicraw=strcat(filenamePicraw,'.png');
print(gcf,'-dpng',filenamePicraw);
%%

end
disp(openFileName)
disp('X���� �� Y�ٶȣ�Z�ٶ� ');
temp=[Xterm(2,1);
Yterm(2,1);
Zterm(2,1)];
temp