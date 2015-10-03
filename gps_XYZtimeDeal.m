%%
%读取XYZ文件，格式：十进制年  年  年积日  X  Y  Z
%计算XYZ方向的速率。
%趋势项之包含了年速率项，如果加如其他项，需要添加代码在knowTerms变量中。
%
clear all
disp('this is local ');
%%
%打开文件，全部读取到变量contentAll中去
[openFileName,openPathName]=uigetfile('my.xyz','打开文件');
if(openFileName==0)
    error('open file failed!')
end
openFnamePname=strcat(openPathName,openFileName);
contentAll=load(openFnamePname);
%%
% 首先把原数据用图画出来，之后在该图上把数据拟合模型也华出来——>查看拟合效果(部分代码拷贝于neushow)
%%
%先生成一个新的画板
hraw=figure;

%%
%根据列数来判断如何显示：如果>=4列，则画出3个方向的图
figure(hraw)
[row col]=size(contentAll);

if(col>=4)
    year=contentAll(:,1);
    %
    year1=year(1,1);
    yearstr=num2str(year1);
    s=strtok(yearstr,'.');%整年，字串
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
%hresidual=figure;%残差序列画在该画板上
%把contentAll变量细分到各变量：year,X,Y,Z,
if(col>=4)
year=contentAll(:,1);
X=contentAll(:,4);
Y=contentAll(:,5);
Z=contentAll(:,6);

%%
% 仅含有趋势项
% knowTermsN=[ones(size(year)),  year,  sin(2*pi*year), cos(2*pi*year),  sin(4*pi*year) ,cos(4*pi*year) , ...
%    myStep(year,TstepN), myStep(year,TstepN).*year, exp(-(year-TstepN).*year/tao).*myStep(year,TstepN)];
knowTermsX=[ones(size(year)), year];
knowTermsY=[ones(size(year)) ,year] ;
knowTermsZ=[ones(size(year)) ,year] ;
%%
%获取X方向残差
Xterm=knowTermsX\X;%趋势项参数
Xmodle=knowTermsX*Xterm;%数据模型
%%%%%%
figure(hraw);%先在原图上画拟合模型曲线
subplot(3,1,1);
hold on;
plot(year,Xmodle,'red');
hh=axis;
text((yearlast+yearfirst)/2,hh(4),strcat('X-vel=  ', num2str(Xterm(2,1)*100,'%10.2f'),' cm/yr'),'Color',[1 0 0],'VerticalAlignment','top','FontSize',10); %速率
%%
%获取Y方向参差
Yterm=knowTermsY\Y;
Ymodle=knowTermsY*Yterm;
%%%%%%
figure(hraw);%先在原图上画拟合模型曲线
subplot(3,1,2);
hold on;
plot(year,Ymodle,'red');
hh=axis;
text((yearlast+yearfirst)/2,hh(4),strcat('Y-vel=  ', num2str(Yterm(2,1)*100,'%10.2f'),' cm/yr'),'Color',[1 0 0],'VerticalAlignment','top','FontSize',10); %速率

%%
Zterm=knowTermsZ\Z;
Zmodle=knowTermsZ*Zterm;
figure(hraw);%先在原图上画拟合模型曲线
subplot(3,1,3);
hold on;
plot(year,Zmodle,'red');
hh=axis;
text((yearlast+yearfirst)/2,hh(4),strcat('Z-vel=  ', num2str(Zterm(2,1)*100,'%10.2f'),' cm/yr'),'Color',[1 0 0],'VerticalAlignment','top','FontSize',10); %速率
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
disp('X速率 ； Y速度；Z速度 ');
temp=[Xterm(2,1);
Yterm(2,1);
Zterm(2,1)];
temp