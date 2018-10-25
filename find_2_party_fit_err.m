function [err, mu_full] = find_2_party_fit_err(knob, para, data)
% run the 2 party system while updating the parameters according to DW
% nominate. 

t = linspace(0, para.timeGap, para.tres);

str = sprintf('knobs = [%0.2f, %0.2f, %0.1f]', knob(1), knob(2), knob(3));
disp(str)

%para.sigma0 = 1; % after nondimensionalization. 

para.sigma0 = knob(1)*para.scaling(1); 
para.b = knob(2)*para.scaling(2); 
para.k = knob(3)*para.scaling(3);


mu0 = [data.Dmu(1), data.Rmu(1)];
mu_full = zeros(length(data.year)*para.tres, 2);
mu_short = zeros(length(data.year), 2); 

for idx = 1:length(data.year)
    para.sigma = [data.Dsig(idx), data.Rsig(idx)]*para.b;
    
    [T, mu_new] = run_2_party( mu0, para, t);
    mu0 = mu_new(end,:); % update the initial condition
    mu_short(idx,:) = mu0; % save only 2 year intervals

    
    mu_full((idx-1)*para.tres+1:idx*para.tres,:) = mu_new ; 
    % append mu_new to the matrix storing big mu
end

% decide which xi corresponds to which data. 
if mu_short(1,1)<0 
    err1= abs(mu_short(:,1) - data.Dmu);
    err2 = abs(mu_short(:,2) - data.Rmu);
else
    err1= abs(mu_short(:,2) - data.Dmu);
    err2 = abs(mu_short(:,1) - data.Rmu);
end
err = sum(err1+err2)/(2*length(data.year)); 
str2 = sprintf('err = %0.2f', err);
disp(str2)


end

