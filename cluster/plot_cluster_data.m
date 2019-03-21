
num_rows = size(Yc);

t_end = num_rows(1);

t_range = 30000;

t_start = t_end - t_range;

% t_start = 400000;
% 
% t_end = t_start + 100000;

% plotTitle = "Nine Identical Cells";
% Yc = Yc_no_alter;

% plotTitle = "Random Sodium Conductance, No Gap";
% Yc = Yc_no_gap;

% plotTitle = "Random Sodium Conductance, With Gap";
% Yc = Yc_gap;

plotTitle = "Paced at 1 Hz";
% Yc = Yc_k1_changed;

% for i = 1:length(Yc(1,:))/18
%     figure(1);
%    plot(t(t_start:t_end), Yc(t_start:t_end, (18*(i-1)+1)));
%    hold on;
% end


% level_1 = 1;
% level_2 = [2, 6, 7];
% level_3 = [3,8,11,12,13];
% level_4 = [4,9,14,16,17,18,19];
% level_5 = [5,10,15,20,21,22,23,24,25];

level_1 = 5;
level_2 = [1,2,3,4,6,7,8,9];

for i = 1:(length(Yc(1,:)) / 18)
   figure(1);
   
   if ismember(i, level_1)
       plot(t(t_start:t_end)-t(t_start), Yc(t_start:t_end, (18*(i-1)+1)), 'Color', [0 .8 0], "LineWidth", 2);
   end
   
   if ismember(i, level_2)
       plot(t(t_start:t_end)-t(t_start), Yc(t_start:t_end, (18*(i-1)+1)), 'Color', [.15 .15 .15], "LineWidth", 2);
   end
   
   if ismember(i, level_3)
       plot(t(t_start:t_end)-t(t_start), Yc(t_start:t_end, (18*(i-1)+1)), 'Color', [.4 .4 .4]);
   end
   
   if ismember(i, level_4)
       plot(t(t_start:t_end)-t(t_start), Yc(t_start:t_end, (18*(i-1)+1)), 'Color', [.6 .6 .6]);
   end
   
   if ismember(i, level_5)
       plot(t(t_start:t_end)-t(t_start), Yc(t_start:t_end, (18*(i-1)+1)), 'Color', [.8 .8 .8]);
   end
   
   if i >25
       plot(t(t_start:t_end), Yc(t_start:t_end, (18*(i-1)+1)), 'Color', [.9 .9 .9]);
   end
   
   hold on;
end

% plot(t(1:t_range), Yc(1:t_range,1),... 
%      t(1:t_range), Yc(1:t_range,19),...
%      t(1:t_range), Yc(1:t_range,37),...
%      t(1:t_range), Yc(1:t_range,55),...
%      t(1:t_range), Yc(1:t_range,73),...
%      t(1:t_range), Yc(1:t_range,91),...
%      t(1:t_range), Yc(1:t_range,109),...
%      t(1:t_range), Yc(1:t_range,127),...
%      t(1:t_range), Yc(1:t_range,145));

% Get number of maxima

 
 
title(plotTitle);
xlabel("Time (s)");
ylabel("Voltage (V)");

ax = gca;
ax.FontSize = 20; 
ax.TitleFontSizeMultiplier = 2;

% legend({"1", "2", "3", "4", "5", "6", "7", "8", "9"},"FontSize", 18)
 

 