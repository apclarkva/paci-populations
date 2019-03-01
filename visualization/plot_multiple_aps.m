paci = all_action_potential_readings{1};
[m_single_t m_single_v] = ap_amplitude3x(paci(:,1),paci(:,2));
plot(m_single_t - min(m_single_t), m_single_v)
xlim([0 4]);
hold on

for i = 1:20
    m = all_action_potential_readings{i};
    try
        [m_single_t m_single_v] = ap_amplitude3x(m(:,1),m(:,2));
    catch
        disp(i);
    end
    plot(m_single_t - min(m_single_t), m_single_v)
    hold on
end