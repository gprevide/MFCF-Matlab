addpath('../src/')

% 16/05/2019 Guido Previde Massara
% Example usage of the MFCF routine
% See:
% Massara, G. P., & Aste, T. (2019). Learning Clique Forests. 
% arXiv preprint arXiv:1905.02266.

% random symmetric matrix
cliques_in = {1:4; 5:9; 10:14; 15:30};
T = 2000;
M = clique_matrix(cliques_in, T);


% initialise the ct_control structure
%  - maximum clique size
ct_control.max_clique_size = 5;
%  - minimum clique size
ct_control.min_clique_size = 2;
%  - only edges with score above threshold will appear in the final result
ct_control.threshold = 0.01;
%  - use any separator only once (suggest no)
ct_control.drop_sep = true;

% this gain function, easy and quick for testing, returns the sum of the
% square of the links between the new node and the separator
gain_function = @gf_sumsquares_gen;

% the MFCF algo
[cliques, separators, peo, tree] = MFCF(M, ct_control, gain_function);

J = LOGO(M, cliques, separators, true);

subplot(2,2,1); imagesc(M)
subplot(2,2,2); imagesc(inv(J))
subplot(2,2,3); imagesc(inv(M))
subplot(2,2,4); imagesc(J)


