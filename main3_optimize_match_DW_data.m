% plot model trajectory on top with DW-NOMINATE data
% running 2 party max vote model 
% code written in MATLAB 2016a

clear all; clc; 
optimize = 0; # whether to run optimization for parameters or not. If 0, then run model with initial parameters, knob0

para = struct();

% parameters to be optimized. knob = [sigma0, b, k]
knob0 = [   0.9325    3.7333    2.5471];

% scaling of parameters for optimization routine. Real parameters = knob*scaling
para.scaling = [1, 1, 1]; 

% numerical parameters
para.timeGap = 2; % years between every sigma update
para.tres = 10; % number of time steps between each update

%% Load data
load('dataHouseSenate_final2.mat')
data = struct();
data.Dmu = Ddata(:,1);
data.Rmu = Rdata(:,1);
data.Dsig = Ddata(:,2);
data.Rsig = Rdata(:,2);
data.year = year; 

% a list year variables for plotting data
yr_list = linspace(min(data.year), max(data.year), length(data.year)*para.tres);

%% optimize parameters 
if optimize == 1
    disp('running optimization ...')
    [ knob, errVal, exitflag ] = fminsearch(@(knob)find_2_party_fit_err( knob, para, data), knob0, optimset('Display', 'iter-detailed','TolFun', 0.001 ,'TolX', 0.005));
    if exitflag~= 1
        disp('optimizaion did not converge')
    else
        disp('optimizaion converged')
    end
    
else 
    disp('skip optimization, knob = knob0')
    knob = knob0; 
end

% run the 2 party model with data
[err, mu_full] = find_2_party_fit_err(knob, para, data); 



%% save data 
theory = struct(); 
theory.para = knob;
theory.mu = mu_full;
theory.year = yr_list; 
theory.tres = para.tres; 
save('theory.mat', 'theory')



%% Plot with DW data
plot_DW_data_with_theory( data, mu_full, yr_list )


%%  Plot distance to party 
meanSig = (data.Dsig + data.Rsig)./2;
dmuData = abs(data.Dmu - data.Rmu);
dmuTheo = abs(mu_full(1:para.tres:end,1) - mu_full(1:para.tres:end,2));


f1 = polyfit(meanSig,dmuData, 1); 
f2 = polyfit(meanSig,dmuTheo, 1); 

xplt = linspace(0.08, 0.2, 50);


figure()
plot(meanSig, dmuData, 'ko')
hold on

plot(xplt, xplt*f1(1)+f1(2), 'k-') 
plot(meanSig, dmuTheo, 'r^')
plot(xplt, xplt*f2(1)+f2(2), 'r--')


xlabel('mean party heterogeneity')
ylabel('distance between parties')
legend('data','data fit', 'theory' , 'theory fit')

