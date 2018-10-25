function [mu_full] = run_2_party_with_DW_para(para, data)
% run the 2 party system while updating the parameters according to DW
% nominate. 

t = linspace(0, para.timeGap, para.tres);

mu0 = [data.Dmu(1), data.Rmu(1)];
mu_full = zeros(length(data.year)*para.tres, 2);


for idx = 1:length(data.year)
    para.sigma = [data.Dsig(idx), data.Rsig(idx)]*para.b;
    
    [T, mu_new] = run_2_party( mu0, para, t);
    mu0 = mu_new(end,:); % update the initial condition
    
    mu_full((idx-1)*para.tres+1:idx*para.tres,:) = mu_new ; 
    % append mu_new to the matrix storing big mu
end



end

