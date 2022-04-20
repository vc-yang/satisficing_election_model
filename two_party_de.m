
function dmu = two_party_de( mu, para)
% function for the sigma diff. eq. 
% dxi/dt = k dz/dxi 

dmu = zeros(2, 1);

% finds the two derivatives
dmu(1) = para.k*find_rhs_2(mu, para, [1, 2]);
dmu(2) = para.k*find_rhs_2(mu, para, [2, 1]);
end


% import the analytic derivatives
function [rhs] = find_rhs_2(mu, para, idxOrder)
% convert parameters to notation used in maple
i = idxOrder(1);
j = idxOrder(2); 

sigma0 = para.sigma0;
sigma =  para.sigma;

dVdmu_line; % maple computed analytic derivatives

rhs = dVdmu; 

end