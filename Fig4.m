%%% creates figure 4 in  Williamson, et al., PNAS nexus (2023)

%% timecourse figure
clear all
close all

%% load data
load('Data_D_OGD.mat');
load('Data_AXR_OGD.mat');
load('Data_R1_OGD.mat');
load('correlation.mat');
set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
%% define mean exchange rate after ouabain
kouabain=35.9196; % after 100 micromolar
%kouabain=33.3633; %after smaller doses
knrml=140; %% value averaged over all normal states
%% initialize fig

fig                 = figure();
fig.Units           = 'centimeters';
fig.PaperUnits      = 'centimeters';
fig.Position        = [0 0 18 22];

fig.PaperPosition   = fig.Position;

FontName            = 'helvetica';
FontSize            = 7;
FontWeight          = 'normal';

COLORSpatch = 1/255 * [255 255 100  ; ...
    100 255 100  ; ...
    150 255 255 ; ...
    100 150 255 ; ...
    255 0 100 ; ...
    255 0 0 ];
COLORSpatchlive = 1/255 * [93  187 70] ; 
COLORSpatchfixed = 1/255 *[241 156 31];
COLORSpatchao = 1/255 *  [80 120 240];
COLORSpatcha70OGD = 1/255 *  [255 50 50]; 
COLORSpatchr70OGD = 1/255 *  [255, 150, 130]; 
COLORSpatchr38OGD = 1/255 * [255, 120, 200]; 
COLORS = 1/255 * [  95  120  202 ; ...
    93  187 70  ; ...
    241 156 31  ; ...
    237 28  36  ; ...
    129 41  134 ; ...
    75 186 233  ];

%%%%%%%%%%%%%%%%%%%%%%%% 38 min OGD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% define sample
si=1; indo=5;c=[2,5,2];
%samples=[1:9];
samples=[10:17];
ttotal=250;
del_=12; %delay to shift the repreentative sample so it lines up with the others.
ncond=3; %%% number of conditions of interest. useful when there is additional conditions for some samples 

cii=1
%% plot representative sample  

h=subplot(5,2,7);
h.Units             = 'centimeters';
hold on
h.FontName=FontName;
h.FontSize=FontSize;
ylimhold=[0 200];
h.YLim=ylimhold;

   si=13;
    tMinutes0= (Sx(si).T(cii).tseconds-Sx(si).T(cii).tseconds(1))/60+2+del_; %% need to play around with this time...
    tMinutes0x= (Sx(si).T(cii).tseconds-Sx(si).T(cii).tseconds(1))/60+5+del_; %% need to play around with this time...
    tMinutes0R1= (Sx(si).T(cii).tseconds-Sx(si).T(cii).tseconds(1))/60+9+del_;%% need to play around with this time...

scanMat=Sx(si).scanMat;

hold on

h.YLabel.String='$k$ [$\mathrm{s^{-1}}$]';
h.XLabel.String='time [min]';
h.XLim=[0 ttotal]; 
h.Position(4)          = h.Position(4)+0.5;

%%% annotation
ha=annotation('textbox');
ha.Interpreter='latex';
ha.String='g';
ha.FontSize=11;
ha.Units='centimeters';
ha.Position(1)=h.Position(1)-1;
ha.Position(2)=h.Position(2)+3;%4.15;
ha.Position(3)=0.5;
ha.Position(4)=0.5;
ha.Color=[0 0 0];
ha.BackgroundColor=[.95 .95 .95];
ha.EdgeColor= [.8 0 0];

ht=title({'representative sample'}) ; 

ncond=3;

for i=1:ncond

if i==ncond
   X=[tMinutes0(scanMat(i,1)),ttotal,ttotal,tMinutes0(scanMat(i,1))];
elseif i==1
   X=[0,tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i+1,1)),0];
else
   X=[tMinutes0(scanMat(i,1)),tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i,1))];
end
    Y=[h.YLim(2),h.YLim(2),h.YLim(1),h.YLim(1)];

hf = patch('XData',X,'YData',Y,'FaceColor', COLORSpatch(c(i),:),'LineStyle','none' );
    hf.FaceAlpha = .2;
end

for i=2:ncond
hl= plot([1,1]*tMinutes0(SD(si).scanMat(i,1)),h.YLim,'--');
hl.Color=[98 122 157]/255;
end

%%% pick sample index

As=Sx(si).T(cii).AXR_I3_subbi(1:Sx(si).scanMat(ncond,2))*1000;
hl=plot(tMinutes0x(1:length(As)),As);
hl.LineStyle = 'none';
hl.Marker = 'o';
hl.MarkerFaceColor = COLORS(1,:);
 hl.MarkerEdgeColor = [0 0 0];
 
hl= plot([0 ttotal], [1,1]*knrml,'-'); 
hl.Color=[0.9290    0.6940    0.1250];
hl= plot([0 ttotal], [1,1]*kouabain,'-'); 
hl.Color=[1 0 0] ;

As=SD(si).T(cii).D_init(1:Sx(si).scanMat(ncond,2));
As=(As/nanmean(As(1:scanMat(1,2)))-1)*100; % percent change

yyaxis right
hl=plot(tMinutes0(1:length(As)),As);
hl.LineStyle = 'none';
hl.Marker = '^';
%hl.MarkerEdgeColor = COLORS(4,:);
hl.MarkerFaceColor = COLORS(4,:);
 hl.MarkerEdgeColor = [0 0 0];

hold on

 if si>1

As=SR1(si).T(cii).R1(1:Sx(si).scanMat(ncond,2));
As=(As/nanmean(As(1:scanMat(1,2)))-1)*100; % percent change
hl=plot(tMinutes0R1(1:length(As)),As);
hl.LineStyle = 'none';
hl.Marker = 's';
 hl.MarkerFaceColor = COLORS(6,:);
 hl.MarkerEdgeColor = [0 0 0];

end

%hl.MarkerFaceColor = COLORS(2,:);
sf=0.1571; %%% scaling factor between diffusion R_1 and exchange
h.YLim=(ylimhold-140)*sf;
h.YLabel.String= '    $\Delta R_1 \ \ \ \Delta \mathrm{ADC}_y$ [$\%$]';
h.XLim=[0 ttotal]; 
h.YColor=[.4 .4 .4];  %COLORS(4,:);



% ht = text(0.5*xlim(1)+0.5*xlim(2),0.6*ylim(1)+0.4*ylim(2),'My text');
% set(ht,'Rotation',45)
% set(ht,'FontSize',18
% if p(si)>0.05
%     text(3,8,'no correlation','FontSize',7) 
% elseif p(si)<0.05
%     cc_=num2str(cc(si));
%     cc_=cc_(1:4);
%     text(3,8,horzcat('correlation coefficient=',cc_),'FontSize',7)
% end
%     text(3,-16,horzcat('p',num2str(Sx(si).postnatal)),'FontSize',7);


%% the effect of low glucose oxygen averaged over all samples
%%% found mean(meantdiff(1:8))=10.6
sets=42; %35;%;
meantdiff_=10.6;
  tMinutes0= [0:sets-1]*meantdiff_+2;
  tMinutes0x=[0:sets-1]*meantdiff_+5; % adjusting for the time for each exchange experiment, 0.5 min for wobb and tune and match, 3 min for diffusion, 6 min for exchange, but assuming that each measurement is averaged over the duration of the measurement (so adding 0.5+1.5 for diff and 0.5+1.5+3 for exchange)
%%% making an arbitrary scanMat to fit with shifting sets and total sets;
 % scanMat=[1,5; 6,12 ; 13, sets]; % for 70 min
  scanMat=[1,5; 6,9; 10, sets]; % for 38min
  
perturb=6;     %%% shifting data so that the first perturbation always occurs during
               %%% set 6
%% exchange
hold on
h=subplot(5,2,5);
h.Units             = 'centimeters';
h.Position(2)          = h.Position(2)+0.2;%-0.2;
h.Position(4)          = h.Position(4)+0.5;
h.FontName=FontName;
h.FontSize=FontSize;
%ht=title({'normal$ \qquad $  0 glucose, $1\%\ \mathrm{pO_2}$       $ \qquad $ normal  $ \quad \qquad \qquad $     '}) ; 
%ht=title({'n=8'}) ; 

hold on
%%% annotation
ha=annotation('textbox');
ha.Interpreter='latex';
ha.String='e';
ha.FontSize=11;
ha.Units='centimeters';
ha.Position(1)=h.Position(1)-1;
ha.Position(2)=h.Position(2)+2.75;
ha.Position(3)=0.5;
ha.Position(4)=0.5;
ha.Color=[0 0 0];
ha.BackgroundColor=[.95 .95 .95];
ha.EdgeColor= [.8 0 0];

h.YLim=[0 200];
h.YLabel.String='$k$ [$\mathrm{s^{-1}}$]';
%h.XLabel.String='time [min]';
h.XLim=[0 ttotal]; 

for i=1:ncond

if i==ncond
   X=[tMinutes0(scanMat(i,1)),tMinutes0(end),tMinutes0(end),tMinutes0(scanMat(i,1))];
elseif i==1
   X=[0,tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i+1,1)),0];
else
   X=[tMinutes0(scanMat(i,1)),tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i,1))];
end
    Y=[h.YLim(2),h.YLim(2),h.YLim(1),h.YLim(1)];

hf = patch('XData',X,'YData',Y,'FaceColor', COLORSpatch(c(i),:),'LineStyle','none' );
hf.FaceAlpha = .2;
end
for i=2:ncond
hl= plot([1,1]*tMinutes0(scanMat(i,1)),h.YLim,'--');
hl.Color=[98 122 157]/255;
end

% A=Sx.T.AXR_I3_N24*1000;
% hl=plot(tMinutes0(Sx(si).scanMat(1):Sx(si).scanMat(end)),A,'.');
%  M = movmedian(A,k);
% hl= plot(tMinutes0(Sx(si).scanMat(1):Sx(si).scanMat(end)),M);
A_=NaN(length(samples),sets);

for i=1:length(samples)
    si=samples(i);
    firstNaN(i)=1+perturb-Sx(si).scanMat(2,1);
    lastNaN(i)= Sx(si).scanMat(ncond,2) + perturb -Sx(si).scanMat(2,1);
    %%% shifting data so that the first perturbation always occurs during
    %%% set 6
    %%% also using experiments only up to the number of conditions of interest. 
    A_(i,firstNaN(i):lastNaN(i)) = Sx(si).T(cii).AXR_I3_subbi(1:Sx(si).scanMat(ncond,2))*1000;
end
A_x=A_; % holding
A=nanmean(A_,1);
hl= plot([0 ttotal], [1,1]*knrml,'-'); 
hl.Color=[0.9290    0.6940    0.1250];
hl= plot([0 ttotal], [1,1]*kouabain,'-'); 
hl.Color=[1 0 0] ;
Astd=nanstd(A_,1);
%hl=plot(tMinutes0x(Sx(si).scanMat(1):Sx(si).scanMat(end)),A(Sx(si).scanMat(1):Sx(si).scanMat(end)));
hl=plot(tMinutes0x,A(1:length(tMinutes0x)));
hl.LineStyle = 'none';
  hl.Marker = 'o';
 hl.MarkerFaceColor = COLORS(1,:);
% M = movmedian(A,k);
%hl= plot(tMinutes0x(Sx(si).scanMat(1):Sx(si).scanMat(end)),M);
hl=errorbar(tMinutes0x,A(1:length(tMinutes0x)),Astd(1:length(tMinutes0x)));
 hl.LineStyle = 'none';
  hl.Marker = 'o';
 hl.Color = [0 0 0];
 
 %% diffusion
h=subplot(5,2,3);
h.Units             = 'centimeters';
h.FontName=FontName;
h.FontSize=FontSize;
h.Position(4)          = h.Position(4)+0.5;

hold on
%%% annotation
ha=annotation('textbox');
ha.Interpreter='latex';
ha.String='c';
ha.FontSize=11;
ha.Units='centimeters';
ha.Position(1)=h.Position(1)-1;
ha.Position(2)=h.Position(2)+2.75;
ha.Position(3)=0.5;
ha.Position(4)=0.5;
ha.Color=[0 0 0];
ha.BackgroundColor=[.95 .95 .95];
ha.EdgeColor= [.8 0 0];


h.YLim=(ylimhold-140)*sf;
%h.YLim=[-22 3];
%h.YTick=[-15 -10 -5 0 5];
h.YLabel.String= '$\Delta \mathrm{ADC}_y$ [$\%$]';
%h.XLabel.String='time [min]';
h.XLim=[0 ttotal]; 

for i=1:ncond

if i==ncond
   X=[tMinutes0(scanMat(i,1)),tMinutes0(end),tMinutes0(end),tMinutes0(scanMat(i,1))];
elseif i==1
   X=[0,tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i+1,1)),0];
else
   X=[tMinutes0(scanMat(i,1)),tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i,1))];
end
    Y=[h.YLim(2),h.YLim(2),h.YLim(1),h.YLim(1)];

hf = patch('XData',X,'YData',Y,'FaceColor', COLORSpatch(c(i),:),'LineStyle','none' );
hf.FaceAlpha = .2;
end
for i=2:ncond
hl= plot([1,1]*tMinutes0(scanMat(i,1)),h.YLim,'--');
hl.Color=[98 122 157]/255;
end
% A=Sx.T.AXR_I3_N24*1000;
% hl=plot(tMinutes0(Sx(si).scanMat(1):Sx(si).scanMat(end)),A,'.');
%  M = movmedian(A,k);
% hl= plot(tMinutes0(Sx(si).scanMat(1):Sx(si).scanMat(end)),M);
A_=NaN(length(samples),sets);
for i=1:length(samples)
    si=samples(i);
    A_(i,firstNaN(i):lastNaN(i)) = SD(si).T(cii).D_init(1:Sx(si).scanMat(ncond,2));
    A_(i,:)=(A_(i,:)/nanmean(A_(i,1:perturb-1))-1)*100; % percent change
    %A_(i,:)=(A_(i,:)/nanmean(A_(i,1:perturb-1)));      % normalized change
end
A_D=A_;
A=nanmean(A_,1);
hl= plot([0 ttotal], [1,1]*mean(A(1:perturb-1)),'-'); 
hl.Color=[0.9290    0.6940    0.1250] 
Astd=nanstd(A_,1);
hl=plot(tMinutes0,A(1:length(tMinutes0)));
hl.LineStyle = 'none';
hl.Marker = '^';
hl.MarkerFaceColor = COLORS(4,:);
% M = movmedian(A,k);
%hl= plot(tMinutes0x(Sx(si).scanMat(1):Sx(si).scanMat(end)),M);
hl=errorbar(tMinutes0,A(1:length(tMinutes0)),Astd(1:length(tMinutes0)));
hl.LineStyle = 'none';
hl.Marker = '^';
hl.Color = [0 0 0];

%% R_1
hold on
h=subplot(5,2,1);
h.Units             = 'centimeters';
h.Position(2)          = h.Position(2)-0.2;
h.Position(4)          = h.Position(4)+0.5;
h.FontName=FontName;
h.FontSize=FontSize;
%ht=title({'normal$ \qquad $  0 glucose, $1\%\ \mathrm{pO_2}$       $ \qquad $ normal  $ \quad \qquad \qquad $     '}) ; 
ht=title({'normal$ \quad $  40 min OGD       $ \quad $ normal  $ \qquad \qquad \qquad \quad $     '}) ; 

hold on
%%% annotation
ha=annotation('textbox');
ha.Interpreter='latex';
ha.String='a';
ha.FontSize=11;
ha.Units='centimeters';
ha.Position(1)=h.Position(1)-1;
ha.Position(2)=h.Position(2)+3;
ha.Position(3)=0.5;
ha.Position(4)=0.5;
ha.Color=[0 0 0];
ha.BackgroundColor=[.95 .95 .95];
ha.EdgeColor= [.8 0 0];

%h.YLim=[0.65 0.9];
%h.YLabel.String='$R_1$ [$\mathrm{s^{-1}}$]';
h.YLim=(ylimhold-140)*sf;
%h.YLim=[-22 3];
%h.YTick=[-20 -15 -10 -5 0 5];
h.YLabel.String= '$\Delta R_1$ [$\%$]';
h.XLim=[0 ttotal]; 

for i=1:ncond

if i==ncond
   X=[tMinutes0(scanMat(i,1)),tMinutes0(end),tMinutes0(end),tMinutes0(scanMat(i,1))];
elseif i==1
   X=[0,tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i+1,1)),0];
else
   X=[tMinutes0(scanMat(i,1)),tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i,1))];
end
    Y=[h.YLim(2),h.YLim(2),h.YLim(1),h.YLim(1)];

hf = patch('XData',X,'YData',Y,'FaceColor', COLORSpatch(c(i),:),'LineStyle','none' );
hf.FaceAlpha = .2;
end
for i=2:ncond
hl= plot([1,1]*tMinutes0(scanMat(i,1)),h.YLim,'--');
hl.Color=[98 122 157]/255;
end

% A=Sx.T.AXR_I3_N24*1000;
% hl=plot(tMinutes0(Sx(si).scanMat(1):Sx(si).scanMat(end)),A,'.');
%  M = movmedian(A,k);
% hl= plot(tMinutes0(Sx(si).scanMat(1):Sx(si).scanMat(end)),M);
A_=NaN(length(samples),sets);

for i=1:length(samples) %no R1 for first experiment at 70minOGD
    si=samples(i);
    firstNaN(i)=1+perturb-Sx(si).scanMat(2,1);
    lastNaN(i)= Sx(si).scanMat(ncond,2) + perturb -Sx(si).scanMat(2,1);
    %%% shifting data so that the first perturbation always occurs during
    %%% set 6
    %%% also using experiments only up to the number of conditions of interest. 
    A_(i,firstNaN(i):lastNaN(i)) = SR1(si).T(cii).R1(1:Sx(si).scanMat(ncond,2));
    A_(i,:)=(A_(i,:)/nanmean(A_(i,1:perturb-1))-1)*100; % percent change
end
A_(8,8)=NaN; %outlier
A=nanmean(A_,1);
hl= plot([0 ttotal], [1,1]*mean(A(1:perturb-1)),'-'); 
hl.Color=[0.9290    0.6940    0.1250] 
% hl= plot([0 ttotal], [1,1]*knrml,'-'); 
% hl.Color=[0.9290    0.6940    0.1250];
% hl= plot([0 ttotal], [1,1]*kouabain,'-'); 
% hl.Color=[1 0 0] ;
Astd=nanstd(A_,1);
%hl=plot(tMinutes0x(Sx(si).scanMat(1):Sx(si).scanMat(end)),A(Sx(si).scanMat(1):Sx(si).scanMat(end)));
hl=plot(tMinutes0x,A(1:length(tMinutes0x)));
hl.LineStyle = 'none';
  hl.Marker = 's';
 hl.MarkerFaceColor = COLORS(6,:);
% M = movmedian(A,k);
%hl= plot(tMinutes0x(Sx(si).scanMat(1):Sx(si).scanMat(end)),M);
hl=errorbar(tMinutes0x,A(1:length(tMinutes0x)),Astd(1:length(tMinutes0x)));
 hl.LineStyle = 'none';
  hl.Marker = 's';
 hl.Color = [0 0 0];

%%%%%%%%%%%%%%%%%%%%%%%% 70 min OGD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% define sample
si=1; indo=5;c=[2,6,2];
samples=[1:9];
%samples=[10:18];
ttotal=250;
del_=0; %delay to shift the repreentative sample so it lines up with the others.
ncond=3; %%% number of conditions of interest. useful when there is additional conditions for some samples 

%% plot representative sample  

h=subplot(5,2,8);
h.Units             = 'centimeters';
hold on
h.FontName=FontName;
h.FontSize=FontSize;
ylimhold=[0 200];
h.YLim=ylimhold;
   si=5;
    tMinutes0= (Sx(si).T(cii).tseconds-Sx(si).T(cii).tseconds(1))/60+2+del_; %% need to play around with this time...
    tMinutes0x= (Sx(si).T(cii).tseconds-Sx(si).T(cii).tseconds(1))/60+5+del_; %% need to play around with this time...
    tMinutes0R1= (Sx(si).T(cii).tseconds-Sx(si).T(cii).tseconds(1))/60+9+del_;%% need to play around with this time...

scanMat=Sx(si).scanMat;

hold on
%%% annotation
ha=annotation('textbox');
ha.Interpreter='latex';
ha.String='h';
ha.FontSize=11;
ha.Units='centimeters';
ha.Position(1)=h.Position(1)-1;
ha.Position(2)=h.Position(2)+3;
ha.Position(3)=0.5;
ha.Position(4)=0.5;
ha.Color=[0 0 0];
ha.BackgroundColor=[.95 .95 .95];
ha.EdgeColor= [.8 0 0];

h.YLabel.String='$k$ [$\mathrm{s^{-1}}$]';
h.XLabel.String='time [min]';
h.XLim=[0 ttotal]; 
h.Position(4)          = h.Position(4)+0.5;

ht=title({'representative sample'}) ; 

ncond=3;

for i=1:ncond

if i==ncond
   X=[tMinutes0(scanMat(i,1)),ttotal,ttotal,tMinutes0(scanMat(i,1))];
elseif i==1
   X=[0,tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i+1,1)),0];
else
   X=[tMinutes0(scanMat(i,1)),tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i,1))];
end
    Y=[h.YLim(2),h.YLim(2),h.YLim(1),h.YLim(1)];

hf = patch('XData',X,'YData',Y,'FaceColor', COLORSpatch(c(i),:),'LineStyle','none' );
    hf.FaceAlpha = .2;
end

for i=2:ncond
hl= plot([1,1]*tMinutes0(SD(si).scanMat(i,1)),h.YLim,'--');
hl.Color=[98 122 157]/255;
end

%%% pick sample index

As=Sx(si).T(cii).AXR_I3_subbi(1:Sx(si).scanMat(ncond,2))*1000;
hl=plot(tMinutes0x(1:length(As)),As);
hl.LineStyle = 'none';
hl.Marker = 'o';
hl.MarkerFaceColor = COLORS(1,:);
hl.MarkerEdgeColor = [0 0 0];

 
hl= plot([0 ttotal], [1,1]*knrml,'-'); 
hl.Color=[0.9290    0.6940    0.1250];
hl= plot([0 ttotal], [1,1]*kouabain,'-'); 
hl.Color=[1 0 0] ;

As=SD(si).T(cii).D_init(1:Sx(si).scanMat(ncond,2));
As=(As/nanmean(As(1:scanMat(1,2)))-1)*100; % percent change

yyaxis right
hl=plot(tMinutes0(1:length(As)),As);
hl.LineStyle = 'none';
hl.Marker = '^';
hl.MarkerFaceColor = COLORS(4,:);
 hl.MarkerEdgeColor = [0 0 0];

hold on

if si>1

As=SR1(si).T(cii).R1(1:Sx(si).scanMat(ncond,2));
As=(As/nanmean(As(1:scanMat(1,2)))-1)*100; % percent change
hl=plot(tMinutes0R1(1:length(As)),As);
hl.LineStyle = 'none';
hl.Marker = 's';
 hl.MarkerFaceColor = COLORS(6,:);
 hl.MarkerEdgeColor = [0 0 0];

end

%hl.MarkerFaceColor = COLORS(2,:);
h.YLim=(ylimhold-140)*sf;
h.YLabel.String= '    $\Delta R_1 \ \ \ \Delta \mathrm{ADC}_y$ [$\%$]';
h.XLim=[0 ttotal]; 
h.YColor=[.4 .4 .4];  %COLORS(4,:);
% h.YLabel.String= '$\Delta \mathrm{ADC}_y$ [$\%$]';
% h.XLim=[0 ttotal]; 
% h.YColor=COLORS(4,:);

% if p(si)>0.05
%     text(3,8,'no correlation','FontSize',7) 
% elseif p(si)<0.05
%     cc_=num2str(cc(si));
%     cc_=cc_(1:4);
%     text(3,8,horzcat('correlation coefficient=',cc_),'FontSize',7)
% end
%     text(3,-16,horzcat('p',num2str(Sx(si).postnatal)),'FontSize',7);


%% the effect of low glucose oxygen averaged over all samples
%%% found mean(meantdiff(1:8))=10.6
sets=35;%;
meantdiff_=10.6;
  tMinutes0= [0:sets-1]*meantdiff_+2;
  tMinutes0x=[0:sets-1]*meantdiff_+5; % adjusting for the time for each exchange experiment, 0.5 min for wobb and tune and match, 3 min for diffusion, 6 min for exchange, but assuming that each measurement is averaged over the duration of the measurement (so adding 0.5+1.5 for diff and 0.5+1.5+3 for exchange)
%%% making an arbitrary scanMat to fit with shifting sets and total sets;
  scanMat=[1,5; 6,12 ; 13, sets]; % for 70 min
 % scanMat=[1,5; 6,9; 10, sets]; % for 38min
  
perturb=6;     %%% shifting data so that the first perturbation always occurs during
                %%% set 6
%% exchange
hold on
h=subplot(5,2,6);
h.Units             = 'centimeters';
h.Position(2)          = h.Position(2)+0.2;%-0.2;
h.Position(4)          = h.Position(4)+0.5;
h.FontName=FontName;
h.FontSize=FontSize;
%ht=title({'normal$ \qquad $  0 glucose, $1\%\ \mathrm{pO_2}$       $ \qquad $ normal  $ \quad \qquad \qquad $     '}) ; 
%ht=title({'n=9'}) ; 

hold on
%%% annotation
ha=annotation('textbox');
ha.Interpreter='latex';
ha.String='f';
ha.FontSize=11;
ha.Units='centimeters';
ha.Position(1)=h.Position(1)-1;
ha.Position(2)=h.Position(2)+2.75; %3.8;
ha.Position(3)=0.5;
ha.Position(4)=0.5;
ha.Color=[0 0 0];
ha.BackgroundColor=[.95 .95 .95];
ha.EdgeColor= [.8 0 0];

h.YLim=[0 200];
h.YLabel.String='$k$ [$\mathrm{s^{-1}}$]';
%h.XLabel.String='time [min]';
h.XLim=[0 ttotal]; 

for i=1:ncond

if i==ncond
   X=[tMinutes0(scanMat(i,1)),tMinutes0(end),tMinutes0(end),tMinutes0(scanMat(i,1))];
elseif i==1
   X=[0,tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i+1,1)),0];
else
   X=[tMinutes0(scanMat(i,1)),tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i,1))];
end
    Y=[h.YLim(2),h.YLim(2),h.YLim(1),h.YLim(1)];

hf = patch('XData',X,'YData',Y,'FaceColor', COLORSpatch(c(i),:),'LineStyle','none' );
hf.FaceAlpha = .2;
end
for i=2:ncond
hl= plot([1,1]*tMinutes0(scanMat(i,1)),h.YLim,'--');
hl.Color=[98 122 157]/255;
end

% A=Sx.T.AXR_I3_N24*1000;
% hl=plot(tMinutes0(Sx(si).scanMat(1):Sx(si).scanMat(end)),A,'.');
%  M = movmedian(A,k);
% hl= plot(tMinutes0(Sx(si).scanMat(1):Sx(si).scanMat(end)),M);
A_=NaN(length(samples),sets);

for i=1:length(samples)
    si=samples(i);
    firstNaN(i)=1+perturb-Sx(si).scanMat(2,1);
    lastNaN(i)= Sx(si).scanMat(ncond,2) + perturb -Sx(si).scanMat(2,1);
    %%% shifting data so that the first perturbation always occurs during
    %%% set 6
    %%% also using experiments only up to the number of conditions of interest. 
    A_(i,firstNaN(i):lastNaN(i)) = Sx(si).T(cii).AXR_I3_subbi(1:Sx(si).scanMat(ncond,2))*1000;

end
A_x=A_; % holding
A=nanmean(A_,1);
hl= plot([0 ttotal], [1,1]*knrml,'-'); 
hl.Color=[0.9290    0.6940    0.1250];
hl= plot([0 ttotal], [1,1]*kouabain,'-'); 
hl.Color=[1 0 0] ;
Astd=nanstd(A_,1);
%hl=plot(tMinutes0x(Sx(si).scanMat(1):Sx(si).scanMat(end)),A(Sx(si).scanMat(1):Sx(si).scanMat(end)));
hl=plot(tMinutes0x,A(1:length(tMinutes0x)));
hl.LineStyle = 'none';
  hl.Marker = 'o';
 hl.MarkerFaceColor = COLORS(1,:);
% M = movmedian(A,k);
%hl= plot(tMinutes0x(Sx(si).scanMat(1):Sx(si).scanMat(end)),M);
hl=errorbar(tMinutes0x,A(1:length(tMinutes0x)),Astd(1:length(tMinutes0x)));
 hl.LineStyle = 'none';
  hl.Marker = 'o';
 hl.Color = [0 0 0];
 
 %% diffusion
h=subplot(5,2,4);
h.Units             = 'centimeters';
h.FontName=FontName;
h.FontSize=FontSize;
h.Position(4)          = h.Position(4)+0.5;

hold on
%%% annotation
ha=annotation('textbox');
ha.Interpreter='latex';
ha.String='d';
ha.FontSize=11;
ha.Units='centimeters';
ha.Position(1)=h.Position(1)-1;
ha.Position(2)=h.Position(2)+2.75; %3.65;
ha.Position(3)=0.5;
ha.Position(4)=0.5;
ha.Color=[0 0 0];
ha.BackgroundColor=[.95 .95 .95];
ha.EdgeColor= [.8 0 0];

h.YLim=(ylimhold-140)*sf;
%h.YLim=[-22 3];
%h.YTick=[-20 -15 -10 -5 0];
h.YLabel.String= '$\Delta \mathrm{ADC}_y$ [$\%$]';
%h.XLabel.String='time [min]';
h.XLim=[0 ttotal]; 

for i=1:ncond

if i==ncond
   X=[tMinutes0(scanMat(i,1)),tMinutes0(end),tMinutes0(end),tMinutes0(scanMat(i,1))];
elseif i==1
   X=[0,tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i+1,1)),0];
else
   X=[tMinutes0(scanMat(i,1)),tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i,1))];
end
    Y=[h.YLim(2),h.YLim(2),h.YLim(1),h.YLim(1)];

hf = patch('XData',X,'YData',Y,'FaceColor', COLORSpatch(c(i),:),'LineStyle','none' );
hf.FaceAlpha = .2;
end
for i=2:ncond
hl= plot([1,1]*tMinutes0(scanMat(i,1)),h.YLim,'--');
hl.Color=[98 122 157]/255;
end
% A=Sx.T.AXR_I3_N24*1000;
% hl=plot(tMinutes0(Sx(si).scanMat(1):Sx(si).scanMat(end)),A,'.');
%  M = movmedian(A,k);
% hl= plot(tMinutes0(Sx(si).scanMat(1):Sx(si).scanMat(end)),M);
A_=NaN(length(samples),sets);
for i=1:length(samples)
    si=samples(i);
    A_(i,firstNaN(i):lastNaN(i)) = SD(si).T(cii).D_init(1:Sx(si).scanMat(ncond,2));
    A_(i,:)=(A_(i,:)/nanmean(A_(i,1:perturb-1))-1)*100; % percent change
    %A_(i,:)=(A_(i,:)/nanmean(A_(i,1:perturb-1)));      % normalized change
end
A_D=A_;
A=nanmean(A_,1);
hl= plot([0 ttotal], [1,1]*mean(A(1:perturb-1)),'-'); 
hl.Color=[0.9290    0.6940    0.1250] 
Astd=nanstd(A_,1);
hl=plot(tMinutes0,A(1:length(tMinutes0)));
hl.LineStyle = 'none';
hl.Marker = '^';
hl.MarkerFaceColor = COLORS(4,:);
% M = movmedian(A,k);
%hl= plot(tMinutes0x(Sx(si).scanMat(1):Sx(si).scanMat(end)),M);
hl=errorbar(tMinutes0,A(1:length(tMinutes0)),Astd(1:length(tMinutes0)));
hl.LineStyle = 'none';
hl.Marker = '^';
hl.Color = [0 0 0];
%% R_1
hold on
h=subplot(5,2,2);
h.Units             = 'centimeters';
h.Position(2)          = h.Position(2)-0.2;
h.Position(4)          = h.Position(4)+0.5;
h.FontName=FontName;
h.FontSize=FontSize;
%ht=title({'normal$ \qquad $  0 glucose, $1\%\ \mathrm{pO_2}$       $ \qquad $ normal  $ \quad \qquad \qquad $     '}) ; 
ht=title({;'normal$ \qquad $  70 min OGD       $ \qquad $ normal  $ \qquad \qquad \quad  $     '}) ; 

hold on
%%% annotation
ha=annotation('textbox');
ha.Interpreter='latex';
ha.String='b';
ha.FontSize=11;
ha.Units='centimeters';
ha.Position(1)=h.Position(1)-1;
ha.Position(2)=h.Position(2)+3;
ha.Position(3)=0.5;
ha.Position(4)=0.5;
ha.Color=[0 0 0];
ha.BackgroundColor=[.95 .95 .95];
ha.EdgeColor= [.8 0 0];

%h.YLim=[0.65 0.9];
%h.YLabel.String='$R_1$ [$\mathrm{s^{-1}}$]';
h.YLim=(ylimhold-140)*sf;
%h.YLim=[-22 3];
%h.YTick=[-20 -15 -10 -5 0 5];
h.YLabel.String= '$\Delta R_1$ [$\%$]';
h.XLim=[0 ttotal]; 

for i=1:ncond

if i==ncond
   X=[tMinutes0(scanMat(i,1)),tMinutes0(end),tMinutes0(end),tMinutes0(scanMat(i,1))];
elseif i==1
   X=[0,tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i+1,1)),0];
else
   X=[tMinutes0(scanMat(i,1)),tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i+1,1)),tMinutes0(scanMat(i,1))];
end
    Y=[h.YLim(2),h.YLim(2),h.YLim(1),h.YLim(1)];

hf = patch('XData',X,'YData',Y,'FaceColor', COLORSpatch(c(i),:),'LineStyle','none' );
hf.FaceAlpha = .2;
end
for i=2:ncond
hl= plot([1,1]*tMinutes0(scanMat(i,1)),h.YLim,'--');
hl.Color=[98 122 157]/255;
end

% A=Sx.T.AXR_I3_N24*1000;
% hl=plot(tMinutes0(Sx(si).scanMat(1):Sx(si).scanMat(end)),A,'.');
%  M = movmedian(A,k);
% hl= plot(tMinutes0(Sx(si).scanMat(1):Sx(si).scanMat(end)),M);
A_=NaN(length(samples),sets);

for i=2:length(samples) %no R1 for first experiment at 70minOGD
    si=samples(i);
    firstNaN(i)=1+perturb-Sx(si).scanMat(2,1);
    lastNaN(i)= Sx(si).scanMat(ncond,2) + perturb -Sx(si).scanMat(2,1);
    %%% shifting data so that the first perturbation always occurs during
    %%% set 6
    %%% also using experiments only up to the number of conditions of interest. 
    A_(i,firstNaN(i):lastNaN(i)) = SR1(si).T(cii).R1(1:Sx(si).scanMat(ncond,2));
    A_(i,:)=(A_(i,:)/nanmean(A_(i,1:perturb-1))-1)*100; % percent change
end
A=nanmean(A_,1);
hl= plot([0 ttotal], [1,1]*mean(A(1:perturb-1)),'-'); 
hl.Color=[0.9290    0.6940    0.1250] 
% hl= plot([0 ttotal], [1,1]*knrml,'-'); 
% hl.Color=[0.9290    0.6940    0.1250];
% hl= plot([0 ttotal], [1,1]*kouabain,'-'); 
% hl.Color=[1 0 0] ;
Astd=nanstd(A_,1);
%hl=plot(tMinutes0x(Sx(si).scanMat(1):Sx(si).scanMat(end)),A(Sx(si).scanMat(1):Sx(si).scanMat(end)));
hl=plot(tMinutes0x,A(1:length(tMinutes0x)));
hl.LineStyle = 'none';
  hl.Marker = 's';
 hl.MarkerFaceColor = COLORS(6,:);
% M = movmedian(A,k);
%hl= plot(tMinutes0x(Sx(si).scanMat(1):Sx(si).scanMat(end)),M);
hl=errorbar(tMinutes0x,A(1:length(tMinutes0x)),Astd(1:length(tMinutes0x)));
 hl.LineStyle = 'none';
  hl.Marker = 's';
 hl.Color = [0 0 0];

%% creating arrays
%%% exchange %%%%
yarrayrOGD38=[];
for si=10:17%% only using the 70 min OGD data
    i=si-9;
    ci=3
    yarrayrOGD38=vertcat(yarrayrOGD38,Sx(si).T.AXR_I3_subbi(Sx(si).scanMat(ci,1)+8:Sx(si).scanMat(ci,1)+12)*1000);
    yarrayrOGD38Avgs(i)=mean(Sx(si).T.AXR_I3_subbi(Sx(si).scanMat(ci,1)+8:Sx(si).scanMat(ci,1)+12))*1000;
end
yarrayrOGD70=[];
for si=1:9 %% only using the 70 min OGD data
    ci=3
    if Sx(si).scanMat(ci,2)>=Sx(si).scanMat(ci,1)+12
        yarrayrOGD70=vertcat(yarrayrOGD70,Sx(si).T.AXR_I3_subbi(Sx(si).scanMat(ci,1)+8:Sx(si).scanMat(ci,1)+12)*1000);
        yarrayrOGD70Avgs(si)=mean(Sx(si).T.AXR_I3_subbi(Sx(si).scanMat(ci,1)+8:Sx(si).scanMat(ci,1)+12))*1000;
    else
        yarrayrOGD70=vertcat(yarrayrOGD70,Sx(si).T.AXR_I3_subbi(Sx(si).scanMat(ci,1)+8:Sx(si).scanMat(ci,2))*1000);
        yarrayrOGD70Avgs(si)=mean(Sx(si).T.AXR_I3_subbi(Sx(si).scanMat(ci,1)+8:Sx(si).scanMat(ci,2)))*1000;
    end
end
yarrayrOGD=NaN(41,2)
yarrayrOGD(1:40,1)=yarrayrOGD38 ;
yarrayrOGD(1:41,2)=yarrayrOGD70;

%%% diffusion %%%%
yarrayrOGD38D=[];
for si=10:17%% only using the 70 min OGD data
    i=si-9;
    ci=3
    yarrayrOGD38D=vertcat(yarrayrOGD38D,SD(si).T.D_init(Sx(si).scanMat(ci,1)+8:Sx(si).scanMat(ci,1)+12) / mean(SD(si).T.D_init(Sx(si).scanMat(1,1):Sx(si).scanMat(1,2))));
    yarrayrOGD38AvgsD(i)=mean(SD(si).T.D_init(Sx(si).scanMat(ci,1)+8:Sx(si).scanMat(ci,1)+12)/ mean(SD(si).T.D_init(Sx(si).scanMat(1,1):Sx(si).scanMat(1,2))));
end
yarrayrOGD70D=[];
for si=1:9 %% only using the 70 min OGD data
    ci=3
    if Sx(si).scanMat(ci,2)>=Sx(si).scanMat(ci,1)+12
            A_(i,:)=(A_(i,:)/nanmean(A_(i,1:perturb-1))-1)*100; % percent change
        yarrayrOGD70D=vertcat(yarrayrOGD70D,SD(si).T.D_init(Sx(si).scanMat(ci,1)+8:Sx(si).scanMat(ci,1)+12) / mean(SD(si).T.D_init(Sx(si).scanMat(1,1):Sx(si).scanMat(1,2))));
        yarrayrOGD70AvgsD(si)=mean(SD(si).T.D_init(Sx(si).scanMat(ci,1)+8:Sx(si).scanMat(ci,1)+12)/ mean(SD(si).T.D_init(Sx(si).scanMat(1,1):Sx(si).scanMat(1,2))));
    else
        yarrayrOGD70D=vertcat(yarrayrOGD70D,SD(si).T.D_init(Sx(si).scanMat(ci,1)+8:Sx(si).scanMat(ci,2))/ mean(SD(si).T.D_init(Sx(si).scanMat(1,1):Sx(si).scanMat(1,2))));
        yarrayrOGD70AvgsD(si)=mean(SD(si).T.D_init(Sx(si).scanMat(ci,1)+8:Sx(si).scanMat(ci,2))/ mean(SD(si).T.D_init(Sx(si).scanMat(1,1):Sx(si).scanMat(1,2))));
    end
end
yarrayrOGDD=NaN(41,2);
yarrayrOGDD(1:40,1)=yarrayrOGD38D;
yarrayrOGDD(1:41,2)=yarrayrOGD70D;

%% Plot exchange rate boxplot

h = subplot(5,2,10);
h.Units             = 'centimeters';
ht=title('exchange rate recovery')
h.Units             = 'centimeters';
h.FontName          = FontName;
h.FontSize          = FontSize;
h.FontWeight        = FontWeight;
%h.Position          = [1.25+3.75 1.25 2.75 3.25]; 
%h.YTick             = [.001 .01 .1 1];
h.XTick             = [1 2];
h.YLim(2)=200;
h.XTickLabel             = {'40 min OGD', '70 min OGD'};
%                                               h.XLabel.String     = '$ T$ [$^{\circ}C$] ';
%h.YLabel.String     = '$\Delta \langle D \rangle / \langle D \rangle _0$ [$\%$]';
h.YLabel.String     = '$k$ [$s^{-1}$]';
%h.YScale            = 'log';
 h.XLim           = [0.4 2.6];
% h.YLim(1)           = 1e-3;
% h.YLim(2)           = 350;

h.YLabel.Units      = 'centimeters';
h.YLabel.Position(1) = -0.8;
h.YGrid = 'on';
h.YLabel.Position(1)=h.YLabel.Position(1)+.3;

%%% annotation
ha=annotation('textbox');
ha.Interpreter='latex';
ha.String='j';
ha.FontSize=11;
ha.Units='centimeters';
ha.Position(1)=h.Position(1)-1;
ha.Position(2)=h.Position(2)+2.45; %3.35;
ha.Position(3)=0.5;
ha.Position(4)=0.5;
ha.Color=[0 0 0];
ha.BackgroundColor=[.95 .95 .95];
ha.EdgeColor= [.8 0 0];

hold on
x2=[1,2]
h=violin(yarrayrOGD,'x2',x2,'facecolor',[COLORSpatchr38OGD;COLORSpatchr70OGD],'FaceAlpha',0.9);
h=boxplot2(yarrayrOGD,x2,'barwidth',0.5,'notch','on');

 h = findobj(gca,'Tag','Box');
j=1;   
    hf=patch(get(h(j),'XData'),get(h(j),'YData'),'w');
    hf.LineStyle = 'none';
    hf.FaceColor = [1 1 1];
    hf.FaceAlpha = .5;
j=2;   
    hf=patch(get(h(j),'XData'),get(h(j),'YData'),'w');
    hf.LineStyle = 'none';
    hf.FaceColor = [1 1 1];
    hf.FaceAlpha = .5;      

h=boxplot2(yarrayrOGD,x2,'barwidth',0.5,'notch','on');

for j=1:length(yarrayrOGD38Avgs)
    
    hl=plot([1],yarrayrOGD38Avgs(j),'.');
        hl.MarkerSize=10

   %hl.Color=[0 0 0];
end
for j=1:length(yarrayrOGD70Avgs(:))
    hl=plot([2],yarrayrOGD70Avgs(j),'.');
        hl.MarkerSize=10

   %hl.Color=[0 0 0];
end

%% t tests that AXR is different between recoveries

[Ah,Ap,Aci,Astats]=ttest2(yarrayrOGD(:,2),yarrayrOGD(:,1));
mean(yarrayrOGD(:,2));
std(yarrayrOGD(:,2));
mean(yarrayrOGD(:,1));
std(yarrayrOGD(:,1));

%% histogram of max correlation from cross correlation analysis
h=subplot(5,2,9);
h.Units             = 'centimeters';
h.FontName=FontName;
h.FontSize=FontSize;
ht=title('cross-correlation')
hold on
%%% annotation
ha=annotation('textbox');
ha.Interpreter='latex';
ha.String='i';
ha.FontSize=11;
ha.Units='centimeters';
ha.Position(1)=h.Position(1)-.9;
ha.Position(2)=h.Position(2)+2.45;
ha.Position(3)=0.5;
ha.Position(4)=0.5;
ha.Color=[0 0 0];
ha.BackgroundColor=[.95 .95 .95];
ha.EdgeColor= [.8 0 0];

h.XLabel.String=' time lag [min]';
h.YLabel.String='samples';
hl=histogram(lagMaxr*10.6+2.4);
h.XLim(1)=0;

