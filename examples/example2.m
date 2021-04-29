% test a triangles only network
M = rand(100, 100);
M = M + transpose(M);

% initialise the ct_control structure
%  - maximum clique size
ct_control.max_clique_size = 3;
%  - minimum clique size
ct_control.min_clique_size = 2;
%  - only edges with score above threshold will appear in the final result
ct_control.threshold = 0.0;
%  - use any separator only once (suggest no)
ct_control.drop_sep = true;

gain_function = @gf_sumsquares_gen;

% the MFCF algo
[cliques, separators, peo, tree] = MFCF(M, ct_control, gain_function);

J = LOGO(M, cliques, separators, false);

M3 = triu(J,1); nnz(M3), sum(M3(:))

ct_control.max_clique_size = 4;
%  - minimum clique size
ct_control.min_clique_size = 4;
%  - only edges with score above threshold will appear in the final result
ct_control.threshold = 0.0;
%  - use any separator only once (suggest no)
ct_control.drop_sep = true;

gain_function = @gf_sumsquares_gen;

% the MFCF algo
[cliques, separators, peo, tree] = MFCF(M, ct_control, gain_function);

J = LOGO(M, cliques, separators, false);

M4 = triu(J,1); nnz(M4), sum(M4(:))