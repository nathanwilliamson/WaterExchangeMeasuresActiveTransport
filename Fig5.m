%%% creates figure 5 in  Williamson, et al., PNAS nexus (2023)

%% bar graphs
clear all
close all
%% load data
load('Data_AXR_OGD.mat')
SxOGD=Sx; clear Sx ; 
load('Data_D_oabain.mat');
load('Data_AXR_oabain.mat');
load('Data_25_7_25_35_25_CompareMethods.mat'); %%% add folder Fig_exchange
set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
%%define sample
si=1; indo=5;c=[2,1,2];

%si=2; indo=5;
%si=3; indo=5;
%si=4; indo=12;
%si=4; indo=12;

%si=12; indo=22;
%si=13; indo=15;
%si=14; indo=15;

cii=1;

%% initialize fig

fig                 = figure();
fig.Units           = 'centimeters';
fig.PaperUnits      = 'centimeters';
fig.Position        = [0 0 8 5];
fig.PaperPosition   = fig.Position;

FontName            = 'helvetica';
FontSize            = 7;
FontWeight          = 'normal';

COLORSpatch = 1/255 * [255 255 100  ; ...
    100 255 100  ; ...
    150 255 255];
COLORSpatchlive = 1/255 * [93  187 70]; ...
COLORSpatchfixed = 1/255 *[241 156 31];
COLORSpatchao = 1/255 *  [80 120 240];
COLORSpatcha70OGD = 1/255 *  [255 50 50 ]; 
COLORSpatchr70OGD = 1/255 *  [237 28  36]; 
COLORSpatchr38OGD = 1/255 * [20  170 120]; 

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


%% exchange rate bar  chart
h                   = axes();
%h.Units             = 'centimeters';
%h.Position          = [1.25 1.25 6.5 4.25];
h.FontSize=FontSize;
h.FontName=FontName;
ht.FontWeight='normal';
hold on
h.YLabel.String     = '$k$ [$\mathrm{s^{-1}}$]';
h.XLabel.String='';
h.XTick=[1 2 3 4];
h.XTickLabel={'fixed' 'live' 'ouabain' '70 min OGD' };
%h.XTickLabel={'fixed' 'live' 'ouabain' '70 min OGD' '38 min OGD recovery' '70 min OGD recovery'};
h.XLim=[0.5 4.5];
% h.Position(3)=h.Position(3)-.05
% h.Position(1)=h.Position(1)+.05
%ht=title({'n=3',' '}) ; 
%xtickangle(30);
yarraybo=[];
ci=1;

for si=1:3
    yarraybo=vertcat(yarraybo,Sx(si).T.AXR_I3_subbi(Sx(si).scanMat(ci,1):Sx(si).scanMat(ci,2))*1000);
    yarrayboAvgs(si)=mean(Sx(si).T.AXR_I3_subbi(Sx(si).scanMat(ci,1):Sx(si).scanMat(ci,2)))*1000;
end
yarrayao=[];
for si=1:3
    yarrayao=vertcat(yarrayao,Sx(si).T.AXR_I3_subbi(Sx(si).ao(1):Sx(si).ao(2))*1000);
    yarrayaoAvgs(si)=mean(Sx(si).T.AXR_I3_subbi(Sx(si).ao(1):Sx(si).ao(2)))*1000;
end

yarrayLive=[];
for si=1:7
    yarrayLive=vertcat(yarrayLive,S(si).T(1).AXR_I3_subbi*1000);
    yarrayLiveAvgs(si)=mean(S(si).T(1).AXR_I3_subbi)*1000;
end
count=0
yarrayFixed=[];
for si=8:13
    count=count+1
    yarrayFixed=vertcat(yarrayFixed,S(si).T(1).AXR_I3_subbi*1000);
    yarrayFixedAvgs(count)=mean(S(si).T(1).AXR_I3_subbi)*1000;
end

yarraybOGD=[];
for si=1:17 %% omitting final sample as an outlier (k=96 before perturbation)
    ci=1
    yarraybOGD=vertcat(yarraybOGD,SxOGD(si).T.AXR_I3_subbi(SxOGD(si).scanMat(ci,1):SxOGD(si).scanMat(ci,2))*1000);
    yarraybOGDAvgs(si)=mean(SxOGD(si).T.AXR_I3_subbi(SxOGD(si).scanMat(ci,1):SxOGD(si).scanMat(ci,2)))*1000;
end
yarrayaOGD=[];
for si=1:9 %% only using the 70 min OGD data
    ci=2
    yarrayaOGD=vertcat(yarrayaOGD,SxOGD(si).T.AXR_I3_subbi(SxOGD(si).scanMat(ci,2))*1000);
    yarrayaOGDAvgs(si)=mean(SxOGD(si).T.AXR_I3_subbi(SxOGD(si).scanMat(ci,2)))*1000;
end


yarrayLive=[yarrayLive; yarraybo; yarraybOGD];
yarrayLiveAvgs=[yarrayLiveAvgs yarrayboAvgs yarraybOGDAvgs];

%%% t tests

[Ah,Ap,Aci,Astats]=ttest2(yarraybo,yarrayao);
[Bh,Bp,Bci,Bstats]=ttest2(yarrayLive,yarrayFixed);
[Ch,Cp,Cci,Cstats]=ttest2(yarrayLive,yarrayao);
[Dh,Dp,Dci,Dstats]=ttest2(yarrayao,yarrayFixed);
[Eh,Ep,Eci,Estats]=ttest2(yarrayao,yarrayaOGD);


x=[1 2 3 4];
%y=[mean(yarrayFixed),mean(yarrayLive),mean(yarrayao),mean(yarrayaOGD), mean(yarrayrOGD70), mean(yarrayrOGD38)];
y=[mean(yarrayFixed),mean(yarrayLive),mean(yarrayao),mean(yarrayaOGD)];

N = length(yarrayFixed);                                      % Number of ‘Experiments’ In Data Set
yMean = mean(yarrayFixed);                                    % Mean Of All Experiments At Each Value Of ‘x’
ySEM = std(yarrayFixed)/sqrt(N);                              % Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
CI95 = tinv([0.025 0.975], N-1);                    % Calculate 95% Probability Intervals Of t-Distribution
yCI95Fixed = bsxfun(@times, ySEM, CI95(:));              % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of ‘x’


N = length(yarrayLive);                                      % Number of ‘Experiments’ In Data Set
yMean = mean(yarrayLive);                                    % Mean Of All Experiments At Each Value Of ‘x’
ySEM = std(yarrayLive)/sqrt(N);                              % Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
CI95 = tinv([0.025 0.975], N-1);                    % Calculate 95% Probability Intervals Of t-Distribution
yCI95Live = bsxfun(@times, ySEM, CI95(:));              % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of ‘x’

N = length(yarrayao);                                      % Number of ‘Experiments’ In Data Set
yMean = mean(yarrayao);                                    % Mean Of All Experiments At Each Value Of ‘x’
ySEM = std(yarrayao)/sqrt(N);                              % Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
CI95 = tinv([0.025 0.975], N-1);                    % Calculate 95% Probability Intervals Of t-Distribution
yCI95ao = bsxfun(@times, ySEM, CI95(:));              % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of ‘x’

N = length(yarrayaOGD);                                      % Number of ‘Experiments’ In Data Set
yMean = mean(yarrayaOGD);                                    % Mean Of All Experiments At Each Value Of ‘x’
ySEM = std(yarrayaOGD)/sqrt(N);                              % Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
CI95 = tinv([0.025 0.975], N-1);                    % Calculate 95% Probability Intervals Of t-Distribution
yCI95aOGD = bsxfun(@times, ySEM, CI95(:));              % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of ‘x’

CI95=[yCI95Fixed(2),yCI95Live(2),yCI95ao(2),yCI95aOGD(2)];
%CI95=[yCI95Fixed(2),yCI95Live(2),yCI95ao(2),yCI95aOGD(2),yCI95rOGD38(2),yCI95rOGD70(2)];
hb=bar(x,y);
hb.FaceColor = 'flat';
hb.FaceAlpha = .6;
hb.CData(1,:) = COLORSpatchfixed(1,:);
hb.CData(2,:) = COLORSpatchlive(1,:);
hb.CData(3,:) = COLORSpatchao(1,:);
 hb.CData(4,:) = COLORSpatcha70OGD(1,:);
% hb.CData(5,:) = COLORSpatchr38OGD(1,:);
% hb.CData(6,:) = COLORSpatchr70OGD(1,:);

hold on

x_=linspace(.65,1.35,length(yarrayFixedAvgs));
hl=plot(x_,yarrayFixedAvgs,'o');
hl.Color=[0.3 0.3 0.3];

x_=linspace(.6,1.4,length(yarrayLiveAvgs))+1;
hl=plot(x_,yarrayLiveAvgs,'o');
hl.Color=[0.3 0.3 0.3];

x_=[0.8 1 1.2]+2;
hl=plot(x_,yarrayaoAvgs,'o');
hl.Color=[0.3 0.3 0.3];

x_=linspace(.65,1.35,length(yarrayaOGDAvgs))+3;
hl=plot(x_,yarrayaOGDAvgs,'o');
hl.Color=[0.3 0.3 0.3];

er = errorbar(x,y,CI95);    
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 
