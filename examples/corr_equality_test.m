% 
% Guido Previde Massara - 25-Apr-2021
% example Octave / Matlab implementation of the test mentioned in par 7.1 of:
%
%   Rencher, Alvin C. Methods of multivariate analysis. Vol. 492. 
%   John Wiley & Sons, 2003.
%
% H0: S = S0

% However, note that in the MFCF algorithm we test for NESTED models, and 
% therefore the number of degrees of freedom is given by the number of 
% elements that are in S and not in S0. Also, since we deal with correlation, and
% not covariance, matrices, we should not count the elements on the diagonal in
% the degrees of freedom.


clc;

n      = 300;   % lenght of time series
nu     = n - 1; % for un-pooled observations the degrees of freedom is (n-1)
p      = 10;    % matrix dimension
noise  = 0.1;   % noise to perturb X0 to get X1
pvalue = 0.95;  % confidence interval


fprintf('----------------------------------------------------\n');
fprintf('    Test for equality of correlation matrices       \n');
fprintf('----------------------------------------------------\n');
fprintf('\nS0 and S are the two matrices.\n');
fprintf('H0 is S0 = S\n');
fprintf('p-value: %1.2f\n', pvalue);

df =0.5 * p * (p+1);
u_crit = chi2inv(pvalue, df);

fprintf('Test degrees of freedom: %d\n', df);
fprintf('Chisquared critical value: %f\n\n', u_crit); 

fprintf('\n------ Case (1): Similar matrices.\n');
fprintf('Length of time series: %d.\n', n);
fprintf('Noise: %f\n', noise);

% build two 'similar' correlation matrices 
X0 = randn(n, p);
S0 = corrcoef(X0);
% X1 is a slightly noisy version of X0
X = X0 + noise .* randn(n, p);
S = corrcoef(X);
 
%subplot(1,2,1); imagesc(S0);
%subplot(1,2,2); imagesc(S1);

% Rencher, Eq. (7.1) 
u = nu * (log(det(S0)) - log(det(S)) + sum(diag(S / S0)) - p )

if u > u_crit 
  fprintf('H0 is REJECTED at the %1.2f confidence level.\n', pvalue);
else
  fprintf('H0 is ACCEPTED at the %1.2f confidence level.\n', pvalue);
end

fprintf('Indicative p-value: %1.2f\n\n', chi2cdf(u, df));

fprintf('\n----- Case (2): Different matrices.\n');
fprintf('Length of time series %d.\n', n);

% build two different correlation matrices 
X0 = randn(n, p);
S0 = corrcoef(X0);
% X1 is a slightly noisy version of X0
X = randn(n, p);
S = corrcoef(X);
 
%subplot(1,2,1); imagesc(S0);
%subplot(1,2,2); imagesc(S1);

% Rencher, Eq. (7.1) 
u = nu * (log(det(S0)) - log(det(S)) + sum(diag(S / S0)) - p )
df = 0.5 * p * (p+1);

if u > u_crit 
  fprintf('H0 is REJECTED at the %1.2f confidence level.\n', pvalue);
else
  fprintf('H0 is ACCEPTED at the %1.2f confidence level.\n', pvalue);
end

fprintf('Indicative p-value: %1.2f\n\n', chi2cdf(u, df));

