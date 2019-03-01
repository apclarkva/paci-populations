function [random_bin_selections] = generate_lhs_selection(number_of_models, number_of_parameters)
param_unshuffled = repmat(1:number_of_models, number_of_parameters, 1);
params_shuffled = param_unshuffled;
for i=1:number_of_parameters 
    idx = randperm(number_of_models) ; 
    params_shuffled(i,idx) = param_unshuffled(1,:); 
end

random_bin_selections = params_shuffled;
end