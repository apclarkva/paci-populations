
% t_range = 6000;

% plotTitle = "Nine Identical Cells";
% Yc = Yc_no_alter;

% plotTitle = "Random Sodium Conductance, No Gap";
% Yc = Yc_no_gap;

% plotTitle = "Random Sodium Conductance, With Gap";
% Yc = Yc_gap;

plotTitle = "One Spontaneous Cell";
% Yc = Yc_k1_changed;

% t_of_interest = t(t_range(1):t_range(2));
% V_of_interest = Yc(t_range(1):t_range(2));


times = t;
voltages = Vm;
[t_of_interest, V_of_interest] = find_single_ap(times, voltages);
plot(t_of_interest - min(t_of_interest), V_of_interest);
hold on

load("model-1.mat");
times_model = t_vs_v_lhs(:,1);
voltages_model = t_vs_v_lhs(:,2);
[model_t model_v] = find_single_ap(times_model, voltages_model);
plot(model_t - min(model_t), model_v);

% Get number of maxima
title(plotTitle);
xlabel("Time (s)");
ylabel("Voltage (V)");

ax = gca;
ax.FontSize = 14; 
ax.TitleFontSizeMultiplier = 2;
 

 