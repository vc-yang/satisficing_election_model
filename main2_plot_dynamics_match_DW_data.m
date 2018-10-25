% plot trajectory with DW-NOMINATE data
% running 2 party max vote model 

clear all; clc; 
%optimize = 0;

para = struct();

% knob = [1.5, 1, 2];
% sigma0, b, k

para.sigma0 = 1.5; 
para.k = 2;
para.b = 1; %sigma_model = sigma_data*b; 

% numeric variables
para.timeGap = 2; % years between every sigma update
para.tres = 10; % number of time steps between each update

%% Load data
load('../../Data/DWnominate/House and Senate Joint/dataHouseSenate_final2.mat')
data = struct();
data.Dmu = Ddata(:,1);
data.Rmu = Rdata(:,1);
data.Dsig = Ddata(:,2);
data.Rsig = Rdata(:,2);
data.year = year; 

% a list year variable for plotting data
yr_list = linspace(min(data.year), max(data.year), length(data.year)*para.tres);

% run the 2 party model with data
mu_full = run_2_party_with_DW_para(para, data);


%% figure()
plot_DW_data_with_theory( data, mu_full, yr_list )
%plot(yr_list, mu_full)