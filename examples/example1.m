p = 100;
q = 200;

M = clique_matrix({1:5, 4:10, 10:15, 15:25, 20:30, 31:100}, q);

% initialise the ct_control structure
%  - maximum clique size
ct_control.max_clique_size = 10;
%  - minimum clique size
ct_control.min_clique_size = 2;
%  - only edges with score above threshold will appear in the final result
ct_control.threshold = 0.1;
%  - use any separator only once (suggest no)
ct_control.drop_sep = false;

% this gain function, easy and quick for testing, returns the sum of the
% square of the links between the new node and the separator
gain_function = @gf_sumsquares_gen;

% the MFCF algo
[cliques, separators, peo, tree] = MFCF(M, ct_control, gain_function);

J = LOGO(M, cliques, separators, true);


subplot (2,2,1) ; imagesc(M);
subplot (2,2,2) ; imagesc(inv(M));
subplot (2,2,3) ; imagesc(inv(J));
subplot (2,2,4) ; imagesc(J);