addpath('../src/')

% 16/05/2019 Guido Previde Massara
% Example usage of the MFCF routine
% See:
% Massara, G. P., & Aste, T. (2019). Learning Clique Forests. 
% arXiv preprint arXiv:1905.02266.

% random symmetric matrix
M = rand(200,200); M = .5 * (M +M');

% initialise the ct_control structure
%  - maximum clique size
ct_control.max_clique_size = 4;
%  - minimum clique size
ct_control.min_clique_size = 4;
%  - only edges with score above threshold will appear in the final result
ct_control.threshold = 0.5;
%  - use any separator only once (suggest no)
ct_control.drop_sep = false;

% this gain function, easy and quick for testing, returns the sum of the
% square of the links between the new node and the separator
gain_function = @gf_sum_squares;

% the MFCF algo
[cliques, separators, peo, tree] = MFCF(M, ct_control, gain_function);

J = LOGO(M, cliques, separators, true);
S = LOGO(M, cliques, separators, false);


