%% plot ouabain result, including fig. 3  in Williamson, et al., PNAS nexus (2023)

%% timecourse figure
clear all
close all
%% load data
load('Data_D_oabain.mat');
load('Data_AXR_oabain.mat');
set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
%%define sample
si=1; indo=5;c=[2,4,2];



cii=1;
%% define mean exchange rate after ouabain
kouabain=35.9196; % after 100 micromolar
knrml=140; %% value averaged over all normal states
%% initialize fig


fig                 = figure();
fig.Units           = 'centimeters';
fig.PaperUnits      = 'centimeters';
fig.Position        = [0 0 8 12];
fig.PaperPosition   = fig.Position;

FontName            = 'helvetica';
FontSize            = 7;
FontWeight          = 'normal';

COLORSpatch = 1/255 * [255 255 100  ; ...
    100 255 100  ; ...
    150 255 255 ; ...
    100 150 255];
COLORSpatchlive = 1/255 * [93  187 70]; ...
COLORSpatchfixed = 1/255 *[241 156 31];
COLORSpatchao = 1/255 *  [80 120 240];
COLORS = 1/255 * [  95  120  202 ; ...
    93  187 70  ; ...
    241 156 31  ; ...
    237 28  36  ; ...
    129 41  134 ];
%% plot
% %%% exchange
% k=3
 tMinutes0= (Sx(si).T(cii).tseconds-Sx(si).T(cii).tseconds(1))/60+2;
 tMinutes0x= (Sx(si).T(cii).tseconds-Sx(si).T(cii).tseconds(1))/60+5; % adjusting for the time for each exchange experiment, 0.5 min for wobb and tune and match, 3 min for diffusion, 6 min for exchange, but assuming that each measurement is averaged over the duration of the measurement (so adding 0.5+1.5 for diff and 0.5+1.5+3 for exchange)

%% the effect of 100 muM ouabain averaged over all samples

%%% exchange
hold on
h=subplot(2,1,1);
h.FontName=FontName;
h.FontSize=FontSize;

ht=title({'normal$\qquad \qquad \qquad \qquad \qquad$    100$\mu$M ouabain       $\qquad$       '}) ; 
ht.FontSize=FontSize;
ht.FontName=FontName;
ht.FontWeight='normal';
hold on
h.Units             = 'centimeters';
h.Position(2)          = h.Position(2)-0.5;
h.Position(4)          = h.Position(4)+0.5;
h.YLim=[0 200];
h.YLabel.String='$k$ [$\mathrm{s^{-1}}$]';
%h.XLabel.String='time [min]';
h.XLim=[0 tMinutes0x(SD(si).scanMat(2,2))];

%%% annotation
ha=annotation('textbox');
ha.Interpreter='latex';
ha.String='a';
ha.FontSize=11;
ha.Units='centimeters';
ha.Position(1)=h.Position(1)-1;
ha.Position(2)=h.Position(2)+4.4;
ha.Position(3)=0.5;
ha.Position(4)=0.5;
ha.Color=[0 0 0];
ha.BackgroundColor=[.95 .95 .95];
ha.EdgeColor= [.8 0 0];

for i=1:length(SD(si).condition)
%q = (1:N-1)';
%faces = [q, q+1, q+N+1, q+N];
if i==length(SD(si).condition)
   X=[tMinutes0x(Sx(si).scanMat(i,1)),tMinutes0x(end),tMinutes0x(end),tMinutes0x(Sx(si).scanMat(i,1))];
elseif i==1
   X=[0,tMinutes0x(Sx(si).scanMat(i+1,1)),tMinutes0x(Sx(si).scanMat(i+1,1)),0];
else
   X=[tMinutes0x(Sx(si).scanMat(i,1)),tMinutes0x(Sx(si).scanMat(i+1,1)),tMinutes0x(Sx(si).scanMat(i+1,1)),tMinutes0x(Sx(si).scanMat(i,1))];
end
    Y=[h.YLim(2),h.YLim(2),h.YLim(1),h.YLim(1)];

hf = patch('XData',X,'YData',Y,'FaceColor', COLORSpatch(c(i),:),'LineStyle','none' );
hf.FaceAlpha = .2;
end
for i=2:length(SD(si).condition)
hl= plot([1,1]*tMinutes0x(SD(si).scanMat(i,1)),h.YLim,'--');
hl.Color=[98 122 157]/255;
end

% A=Sx.T.AXR_I3_N24*1000;
% hl=plot(tMinutes0(Sx(si).scanMat(1):Sx(si).scanMat(end)),A,'.');
%  M = movmedian(A,k);
% hl= plot(tMinutes0(Sx(si).scanMat(1):Sx(si).scanMat(end)),M);
for si=1:3
A_(si,1:9)=Sx(si).T(cii).AXR_I3_subbi(1:9)*1000;
end
hl= plot([0 90], [1,1]*knrml,'-'); 
hl.Color=[0.9290    0.6940    0.1250];
hl= plot([0 90], [1,1]*kouabain,'-'); 
hl.Color=[1 0 0] ;
A=mean(A_,1);
Astd=std(A_,1);
hl=plot(tMinutes0x(Sx(si).scanMat(1):Sx(si).scanMat(end)),A);
 hl.LineStyle = 'none';
  hl.Marker = 'o';
 hl.MarkerFaceColor = COLORS(1,:);
% M = movmedian(A,k);
%hl= plot(tMinutes0x(Sx(si).scanMat(1):Sx(si).scanMat(end)),M);
hl=errorbar(tMinutes0x(Sx(si).scanMat(1):Sx(si).scanMat(end)),A,Astd);
 hl.LineStyle = 'none';
  hl.Marker = 'o';
 hl.Color = [0 0 0];
 
 %% diffusion
h=subplot(2,1,2);
h.FontName=FontName;
h.FontSize=FontSize;

hold on
h.Units             = 'centimeters';
h.Position(4)          = h.Position(4)+0.5;
sf=0.1571; %%% scaling factor between diffusion R_1 and exchange
h.YLim=([0 200]-140)*sf;
%h.YTick=[-15 -10 -5 0 5];
%h.YLabel.String='$\Delta \langle D \rangle / \langle D \rangle _0$ [$\%$]';
%h.YLabel.String='$\Delta \mathrm{ADC_y} / \mathrm{ADC}_{y0}$ [$\%$]';
h.YLabel.String='$\Delta \mathrm{ADC}_y$ [$\%$]';
h.XLabel.String='time [min]';
h.XLim=[0 tMinutes0x(SD(si).scanMat(2,2))];

%%% annotation
ha=annotation('textbox');
ha.Interpreter='latex';
ha.String='b';
ha.FontSize=11;
ha.Units='centimeters';
ha.Position(1)=h.Position(1)-1;
ha.Position(2)=h.Position(2)+4.15;
ha.Position(3)=0.5;
ha.Position(4)=0.5;
ha.Color=[0 0 0];
ha.BackgroundColor=[.95 .95 .95];
ha.EdgeColor= [.8 0 0];

for i=1:length(SD(si).condition)
%q = (1:N-1)';
%faces = [q, q+1, q+N+1, q+N];
if i==length(SD(si).condition)
   X=[tMinutes0x(Sx(si).scanMat(i,1)),tMinutes0x(end),tMinutes0x(end),tMinutes0x(Sx(si).scanMat(i,1))];
elseif i==1
   X=[0,tMinutes0x(Sx(si).scanMat(i+1,1)),tMinutes0x(Sx(si).scanMat(i+1,1)),0];
else
   X=[tMinutes0x(Sx(si).scanMat(i,1)),tMinutes0x(Sx(si).scanMat(i+1,1)),tMinutes0x(Sx(si).scanMat(i+1,1)),tMinutes0x(Sx(si).scanMat(i,1))];
end
    Y=[h.YLim(2),h.YLim(2),h.YLim(1),h.YLim(1)];

hf = patch('XData',X,'YData',Y,'FaceColor', COLORSpatch(c(i),:),'LineStyle','none' );
hf.FaceAlpha = .2;
end
for i=2:length(SD(si).condition)
hl= plot([1,1]*tMinutes0x(SD(si).scanMat(i,1)),h.YLim,'--');
hl.Color=[98 122 157]/255;
end

for si=1:3
A_(si,1:9)=SD(si).T(cii).D_init(1:9);
A_(si,1:9)=(A_(si,1:9)/mean(A_(si,1:4))-1)*100;
end
A=mean(A_,1);
hl= plot([0 90], [1,1]*mean(A(1:4)),'-');
hl.Color=[0.9290    0.6940    0.1250];
Astd=std(A_,1);
hl=plot(tMinutes0(Sx(si).scanMat(1):Sx(si).scanMat(end)),A);
hl.LineStyle = 'none';
hl.Marker = '^';
hl.MarkerFaceColor = COLORS(4,:);
% M = movmedian(A,k);
%hl= plot(tMinutes0x(Sx(si).scanMat(1):Sx(si).scanMat(end)),M);
hl=errorbar(tMinutes0(Sx(si).scanMat(1):Sx(si).scanMat(end)),A,Astd);
hl.LineStyle = 'none';
hl.Marker = '^';
hl.Color = [0 0 0];
