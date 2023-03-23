%%% plots figure 2 in Williamson, et al., PNAS nexus (2023)

%% Initialization.
close all
clear all
set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');

%% load data.
load('diffData_25_7_25_35_25_Dpts2to4.mat');
load('DiffusionDataStruct_aCSF.mat');
DarrayLive=NaN(30,5);
DarrayFixed=NaN(30,5);


D_0_25=2.15E-9; %\mu m^2/ms
D_0_7=1.34E-9; %\mu m^2/ms
D_0_35=3E-9; %\mu m^2/ms
D_0=[D_0_25,D_0_7,D_0_25,D_0_35,D_0_25];
R=8.3145E-3; %kJ/mol K

for i=1:5
DarrayLive(1:length(Tlive(i).D_init),i)=Tlive(i).D_init;                 
DarrayFixed(1:length(Tfixed(i).D_init),i)=Tfixed(i).D_init;                   

DarrayLive_means(:,i)=Tlive(i).D_init_means; 
DarrayFixed_means(:,i)=Tfixed(i).D_init_means;
end
x=[1:5];

for i=1:3
    Darrayacsf_means(i)=Sacsf.T(i).D_init_mean;
    Darrayacsf_std(i)=Sacsf.T(i).D_init_spread*Sacsf.T(i).D_init_mean;
end
    
AXRaxis=1./([25 7 25 35 25]+273);
AXRaxisacsf=1./([25 35 7]+273);

arrheniusy=NaN(7,2);
arrheniusy(1:length(arrhenius.EaFixed_init),1)=arrhenius.EaFixed_init;
arrheniusy(1:length(arrhenius.EaLive_init),2)=arrhenius.EaLive_init;

%% Initialize figure.
ColOrderf=get(0,'FactoryAxesColorOrder')
ColOrderf(3,:)=[0    0.8940    0.1250];
ColOrderl=get(0,'FactoryAxesColorOrder')
ColOrderl(5,:)=[0.3660    0    0.1];
ColOrderl(2,:)=[0.9500    0.3250    0.1980];

COLORS = 1/255 * [  55  80  162 ; ...
    93  187 70  ; ...
    241 156 31  ; ...
    237 28  36  ; ...
    129 41  134 ];
COLORSpatchlive = 1/255 * [93  187 70]; ...
COLORSpatchfixed = 1/255 *[241 156 31];
COLORSacsf=	1/255 * [50,50,255];
col=get(groot,'DefaultAxesColorOrder');
fig                 = figure();
fig.Units           = 'centimeters';
fig.PaperUnits      = 'centimeters';
fig.Position        = [0 0 8 13];
fig.PaperPosition   = fig.Position;

FontName            = 'helvetica';
FontSize            = 7;
FontWeight          = 'normal';


%% Plot fixed

h                   = axes();
h.Units             = 'centimeters';
h.FontName          = FontName;
h.FontSize          = FontSize;
h.FontWeight        = FontWeight;
h.Position          = [1.25 1.25+4.25+4 6.5 3.25];
%h.YTick             = [.001 .01 .1 1];
h.XTick             = [1 2 3 4 5];
h.XTickLabel             = [25 7 25 35 25];
%h.XLabel.String     = '$ b\ \mathrm{ (\times 10^{3}\ s/mm^2)  } $';
%h.XLabel.String     = '$ b\ \mathrm{ (\times 10^{3}\ s/mm^2)  } $';
h.XLabel.String     = '$ T$ [$^{\circ}\mathrm{C}$] ';
h.YLabel.String     = 'ADC$_y$ [$\mathrm{\mu m^2/ms}$]';
%h.YScale            = 'log';
 h.XLim(2)           = 6;
 h.YLim(1)           = 0.4;
 h.YLim(2)           = 1.5;

h.YLabel.Units      = 'centimeters';
h.YLabel.Position(1) = -0.8;
h.YGrid = 'on';

%%% annotation
ha=annotation('textbox');
ha.Interpreter='latex';
ha.String='a';
ha.FontSize=11;
ha.Units='centimeters';
ha.Position(1)=h.Position(1)-1.2;
ha.Position(2)=h.Position(2)+2.75;
ha.Position(3)=0.5;
ha.Position(4)=0.5;
ha.Color=[0 0 0];
ha.BackgroundColor=[.95 .95 .95];
ha.EdgeColor= [.8 0 0];

hold on

h=violin(DarrayFixed*1E9,'x',x,'facecolor',[COLORSpatchfixed;COLORSpatchfixed;COLORSpatchfixed;COLORSpatchfixed;COLORSpatchfixed]);
h=boxplot2(DarrayFixed*1E9,x,'barwidth',0.5,'notch','on');


 h = findobj(gca,'Tag','Box');
 for j=1:length(h)
    
    hf=patch(get(h(j),'XData'),get(h(j),'YData'),'w');
    hf.LineStyle = 'none';
    hf.FaceColor = COLORSpatchfixed(1,:);
    %hf.FaceAlpha = 0.5;

 end
h=boxplot2(DarrayFixed*1E9,x,'barwidth',0.5,'notch','on');

for j=1:length(DarrayFixed_means(:,1))
    hl=plot([1:5],DarrayFixed_means(j,:)*1E9,'.','LineStyle','-');
    hl.Color=ColOrderf(j,:);
end
%% Plot live

h                   = axes();
h.Units             = 'centimeters';
h.FontName          = FontName;
h.FontSize          = FontSize;
h.FontWeight        = FontWeight;
h.Position          = [1.25 1.25+4.25 6.5 3.25];
%h.YTick             = [.001 .01 .1 1];
h.XTick             = [1 2 3 4 5];
h.XTickLabel             = [25 7 25 35 25];
%h.XLabel.String     = '$ b\ \mathrm{ (\times 10^{3}\ s/mm^2)  } $';
%h.XLabel.String     = '$ b\ \mathrm{ (\times 10^{3}\ s/mm^2)  } $';
h.XLabel.String     = '$ T$ [$^{\circ}\mathrm{C}$] ';
h.YLabel.String     = 'ADC$_y$ [$\mathrm{\mu m^2/ms}$]';
%h.YScale            = 'log';
 h.XLim(2)           = 6;
 h.YLim(1)           = 0.4;
 h.YLim(2)           = 1.5;

h.YLabel.Units      = 'centimeters';
h.YLabel.Position(1) = -0.8;
h.YGrid = 'on';

%%% annotation
ha=annotation('textbox');
ha.Interpreter='latex';
ha.String='b';
ha.FontSize=11;
ha.Units='centimeters';
ha.Position(1)=h.Position(1)-1.2;
ha.Position(2)=h.Position(2)+2.75;
ha.Position(3)=0.5;
ha.Position(4)=0.5;
ha.Color=[0 0 0];
ha.BackgroundColor=[.95 .95 .95];
ha.EdgeColor= [.8 0 0];

hold on

h=violin(DarrayLive*1E9,'x',x,'facecolor',[COLORSpatchlive;COLORSpatchlive;COLORSpatchlive;COLORSpatchlive;COLORSpatchlive]);
h=boxplot2(DarrayLive*1E9,x,'barwidth',0.5,'notch','on');


 h = findobj(gca,'Tag','Box');
 for j=1:length(h)
    
    hf=patch(get(h(j),'XData'),get(h(j),'YData'),'w');
    hf.LineStyle = 'none';
    hf.FaceColor = COLORSpatchlive(1,:);
    %hf.FaceAlpha = .6;
   

 end
h=boxplot2(DarrayLive*1E9,x,'barwidth',0.5,'notch','on');

for j=1:length(DarrayLive_means(:,1))
    hl=plot([1:5],DarrayLive_means(j,:)*1E9,'.','LineStyle','-');
    hl.Color=ColOrderl(j,:);

end

%% Plot Arrhenius

h                   = axes();
h.Units             = 'centimeters';
h.FontName          = FontName;
h.FontSize          = FontSize;
h.FontWeight        = FontWeight;
h.Position          = [1.25 1.25 2.75 3.25];
%h.YTick             = [.001 .01 .1 1];
%h.XTick             = [1 2 3 4 5];
%h.XTickLabel             = [25 7 25 35 25];
h.XLabel.String     = '$ T^{-1}$ [$\mathrm{K^{-1}}$] ';
h.YLabel.String     = 'ADC$_y$ [$\mathrm{\mu m^2/ms}$]';
%LinkTopAxisData(1000./(300:-50:100),300:-50:100,'T / K')
h.YScale            = 'log';
% h.XLim(2)           = 6;
% h.YLim(1)           = 1e-3;
% h.YLim(2)           = 350;

h.YLabel.Units      = 'centimeters';
h.YLabel.Position(1) = -0.8;

%%% annotation
ha=annotation('textbox');
ha.Interpreter='latex';
ha.String='c';
ha.FontSize=11;
ha.Units='centimeters';
ha.Position(1)=h.Position(1)-1.2;
ha.Position(2)=h.Position(2)+2.75;
ha.Position(3)=0.5;
ha.Position(4)=0.5;
ha.Color=[0 0 0];
ha.BackgroundColor=[.95 .95 .95];
ha.EdgeColor= [.8 0 0];

hold on

hl=errorbar(AXRaxis,nanmean(DarrayFixed*1E9,1),nanstd(DarrayFixed*1E9,0,1));
 hl.Marker = 'o';
hl.MarkerFaceColor=COLORS(3,:);
   hl.LineStyle = 'none';
 hl.MarkerSize = 3;
 hl.Color = COLORS(3,:)*.5;
 
TheoryT= 1./(linspace(7,35)+273);
theory=arrhenius.AFixed_init'.*exp(-arrhenius.EaFixed_init'.*TheoryT)*1E9;
hl=line(TheoryT,mean(theory,1));
hl.LineWidth=1;
hl.Color=COLORS(3,:)*.8; hl.LineStyle = '-';
clear theory

hl=errorbar(AXRaxis,nanmean(DarrayLive*1E9,1),nanstd(DarrayLive*1E9,0,1));
 hl.Marker = 's';
hl.MarkerFaceColor=COLORS(2,:);
   hl.LineStyle = 'none';
 hl.MarkerSize = 3;
 hl.Color=[0 0 0];

theory=arrhenius.ALive_init'.*exp(-arrhenius.EaLive_init'.*TheoryT)*1E9;
hl=line(TheoryT,mean(theory,1));
hl.LineWidth=1;
hl.Color=COLORS(2,:)*.5; 
clear theory

hl=errorbar(AXRaxisacsf,Darrayacsf_means*1E9,Darrayacsf_std*1E9);
 hl.Marker = 's';
hl.MarkerFaceColor=COLORSacsf;
   hl.LineStyle = 'none';
 hl.MarkerSize = 3;
 hl.Color=[0 0 0];

theory=Sacsf.arrhenius_D_init_A.*exp(-Sacsf.arrhenius_D_init_Ea.*TheoryT)*1E9;
hl=line(TheoryT,theory);
hl.LineWidth=1;
hl.Color=COLORSacsf; 

% Create textbox
a=annotation(fig,'textbox',...
    [0.35 0.3 0.0916041666666664 0.018970189701897],...
    'String','aCSF',...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',7,...
    'FitBoxToText','off');
a.Color=COLORSacsf;

% Create textbox
annotation(fig,'textbox',...
    [0.433148341899168 0.165 0.0916041666666664 0.018970189701897],...
    'String','$7^{\circ}$C',...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',7,...
    'FitBoxToText','off');

% Create textbox
annotation(fig,'textbox',...
    [0.247944444444445 0.111111111111111 0.0916041666666667 0.021680216802168],...
    'String','$25^{\circ}$C',...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',7,...
    'FitBoxToText','off');

% Create textbox
annotation(fig,'textbox',...
    [0.15975 0.113821138211382 0.0916041666666665 0.018970189701897],...
    'String','$35^{\circ}$C',...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',7,...
    'FitBoxToText','off');

%% Plot Ea boxplot

h                   = axes();
h.Units             = 'centimeters';
h.FontName          = FontName;
h.FontSize          = FontSize;
h.FontWeight        = FontWeight;
h.Position          = [1.25+3.75 1.25 2.75 3.25]; 
%h.YTick             = [.001 .01 .1 1];
h.XTick             = [1 2];
h.XTickLabel             = {'fixed','live'};
%                                               h.XLabel.String     = '$ T$ [$^{\circ}C$] ';
h.YLabel.String     = '$E_a$ [$\mathrm{kJ/mol}$]';
%h.YScale            = 'log';
 h.XLim(2)           = 3;
% h.YLim(1)           = 1e-3;
% h.YLim(2)           = 350;

h.YLabel.Units      = 'centimeters';
h.YLabel.Position(1) = -0.8;
%h.YGrid = 'on';
h.YLabel.Position(1)=h.YLabel.Position(1)+.3;

%%% annotation
ha=annotation('textbox');
ha.Interpreter='latex';
ha.String='d';
ha.FontSize=11;
ha.Units='centimeters';
ha.Position(1)=h.Position(1)-0.9;
ha.Position(2)=h.Position(2)+2.75;
ha.Position(3)=.5;
ha.Position(4)=.5;
ha.Color=[0 0 0];
ha.BackgroundColor=[.95 .95 .95];
ha.EdgeColor= [.8 0 0];

hold on
x2=[1,2];
h=violin(arrheniusy*R,'x2',x2,'facecolor',[COLORSpatchfixed;COLORSpatchlive]);
h=boxplot2(arrheniusy*R,x2,'barwidth',0.5,'notch','on');


 h = findobj(gca,'Tag','Box');
j=1;   
    hf=patch(get(h(j),'XData'),get(h(j),'YData'),'w');
    hf.LineStyle = 'none';
    hf.FaceColor = COLORSpatchlive;
    %hf.FaceAlpha = .6;  
j=2;   
    hf=patch(get(h(j),'XData'),get(h(j),'YData'),'w');
    hf.LineStyle = 'none';
    hf.FaceColor = COLORSpatchfixed;
    %hf.FaceAlpha = .6;      

h=boxplot2(arrheniusy*R,x2,'barwidth',0.5,'notch','on');

for j=1:length(arrheniusy(:,1))
    hl=plot([1],arrheniusy(j,1)*R,'.');
    hl.Color=ColOrderf(j,:);
end
for j=1:length(arrheniusy(:,2))
    hl=plot([2],arrheniusy(j,2)*R,'.');
    hl.Color=ColOrderl(j,:);
end

hl=plot([0 3],[1 1]*Sacsf.arrhenius_D_init_Ea*R);
hl.LineWidth=1;
hl.Color=COLORSacsf; 
%% t tests of activation energy

[Ah,Ap,Aci,Astats]=ttest2(arrheniusy(:,2)*R,arrheniusy(1:6,1)*R);
mean(arrheniusy(:,2))*R
std(arrheniusy(:,2))*R
mean(arrheniusy(1:6,1))*R
std(arrheniusy(1:6,1))*R
