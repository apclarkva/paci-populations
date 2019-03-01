%===============================================================================
% CellML file:   C:\Users\pax\Downloads\Ventricular_SI_working_withSTIM.cellml
% CellML model:  paci_severi_atrial_original_parameters
% Date and time: 26/05/2013 at 17:29:35
%-------------------------------------------------------------------------------
% Conversion from CellML 1.0 to MATLAB (init) was done using COR (0.9.31.1371)
%    Copyright 2002-2013 Dr Alan Garny
%    http://cor.physiol.ox.ac.uk/ - cor@physiol.ox.ac.uk
%-------------------------------------------------------------------------------
% http://www.cellml.org/
%===============================================================================

function [dY dati] = Ventricular_SI_working_withSTIM(time, Y, test_params)

%-------------------------------------------------------------------------------
% Initial conditions
%-------------------------------------------------------------------------------

%Y = [-0.0608443305677611, 0.112965312614939, 2.03476685230653e-5, 1.0, 0.000603742193300477, 0.998265535424663, 0.999344505829326, 0.998795773148552, 0.000653795648693262, 0.369142924099062, 0.0646255500426227, 0.486042493171428, 0.320263696896905, 0.219683858857575, 0.115357897266967, 0.688979719223289, 0.000927855750956294, 10.3857618241907];
% Y=[
%     -0.070
%     0.3
%     0.0002
%     1
%     0
%     1
%     1
%     1
%     0
%     1
%     0
%     0.75
%     0.75
%     0
%     0.1
%     1
%     0
%     10
%     ];

% YNames = {'Vm', 'Ca_SR', 'Cai', 'g', 'd', 'f1', 'f2', 'fCa', 'Xr1', 'Xr2', 'Xs', 'h', 'j', 'm', 'Xf', 'q', 'r', 'Nai'};
% YUnits = {'volt', 'millimolar', 'millimolar', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'millimolar'};
% YComponents = {'Membrane', 'calcium_dynamics', 'calcium_dynamics', 'calcium_dynamics', 'i_CaL_d_gate', 'i_CaL_f1_gate', 'i_CaL_f2_gate', 'i_CaL_fCa_gate', 'i_Kr_Xr1_gate', 'i_Kr_Xr2_gate', 'i_Ks_Xs_gate', 'i_Na_h_gate', 'i_Na_j_gate', 'i_Na_m_gate', 'i_f_Xf_gate', 'i_to_q_gate', 'i_to_r_gate', 'sodium_dynamics'};

%-------------------------------------------------------------------------------
% State variables
%-------------------------------------------------------------------------------

% 1: Vm (volt) (in Membrane)
% 2: Ca_SR (millimolar) (in calcium_dynamics)
% 3: Cai (millimolar) (in calcium_dynamics)
% 4: g (dimensionless) (in calcium_dynamics)
% 5: d (dimensionless) (in i_CaL_d_gate)
% 6: f1 (dimensionless) (in i_CaL_f1_gate)
% 7: f2 (dimensionless) (in i_CaL_f2_gate)
% 8: fCa (dimensionless) (in i_CaL_fCa_gate)
% 9: Xr1 (dimensionless) (in i_Kr_Xr1_gate)
% 10: Xr2 (dimensionless) (in i_Kr_Xr2_gate)
% 11: Xs (dimensionless) (in i_Ks_Xs_gate)
% 12: h (dimensionless) (in i_Na_h_gate)
% 13: j (dimensionless) (in i_Na_j_gate)
% 14: m (dimensionless) (in i_Na_m_gate)
% 15: Xf (dimensionless) (in i_f_Xf_gate)
% 16: q (dimensionless) (in i_to_q_gate)
% 17: r (dimensionless) (in i_to_r_gate)
% 18: Nai (millimolar) (in sodium_dynamics)

%-------------------------------------------------------------------------------
% Constants
%-------------------------------------------------------------------------------

% load("lhs_variables_20.mat");
% 
try
    g_CaL = test_params(1);
    g_K1 = test_params(2);
    g_Kr = test_params(3);
    g_Ks = test_params(4);
    g_Na = test_params(5);
    g_PCa = test_params(6);
    g_b_Ca = test_params(7);
    g_b_Na = test_params(8);
catch
    keyboard
end

% g_CaL = 8.635702e-5;   % metre_cube_per_F_per_s (in i_CaL)
% g_K1 = 28.1492;   % S_per_F (in i_K1)
% g_Kr = 29.8667;   % S_per_F (in i_Kr)
% g_Ks = 2.041;   % S_per_F (in i_Ks)
% g_Na = 3671.2302;   % S_per_F (in i_Na)
% g_PCa = 0.4125;   % A_per_F (in i_PCa)
% g_b_Ca = 0.69264;   % S_per_F (in i_b_Ca)
% g_b_Na = 0.9;   % S_


Buf_C = 0.25;   % millimolar (in calcium_dynamics)
Buf_SR = 10.0;   % millimolar (in calcium_dynamics)
Kbuf_C = 0.001;   % millimolar (in calcium_dynamics)
Kbuf_SR = 0.3;   % millimolar (in calcium_dynamics)
Kup = 0.00025;   % millimolar (in calcium_dynamics)
V_leak = 0.00044444;   % per_second (in calcium_dynamics)
VmaxUp = 0.56064;   % millimolar_per_second (in calcium_dynamics)
a_rel = 16.464;   % millimolar_per_second (in calcium_dynamics)
b_rel = 0.25;   % millimolar (in calcium_dynamics)
c_rel = 8.232;   % millimolar_per_second (in calcium_dynamics)
tau_g = 0.002;   % second (in calcium_dynamics)
Chromanol_iKs30 = 0.0;   % dimensionless (in current_blockers)
Chromanol_iKs50 = 0.0;   % dimensionless (in current_blockers)
Chromanol_iKs70 = 0.0;   % dimensionless (in current_blockers)
Chromanol_iKs90 = 0.0;   % dimensionless (in current_blockers)
E4031_100nM = 0.0;   % dimensionless (in current_blockers)
E4031_30nM = 0.0;   % dimensionless (in current_blockers)
TTX_10uM = 0.0;   % dimensionless (in current_blockers)
TTX_30uM = 0.0;   % dimensionless (in current_blockers)
TTX_3uM = 0.0;   % dimensionless (in current_blockers)
nifed_100nM = 0.0;   % dimensionless (in current_blockers)
nifed_10nM = 0.0;   % dimensionless (in current_blockers)
nifed_30nM = 0.0;   % dimensionless (in current_blockers)
nifed_3nM = 0.0;   % dimensionless (in current_blockers)
PkNa = 0.03;   % dimensionless (in electric_potentials)
tau_fCa = 0.002;   % second (in i_CaL_fCa_gate)
% g_CaL = 8.635702e-5;   % metre_cube_per_F_per_s (in i_CaL)
% g_K1 = 28.1492;   % S_per_F (in i_K1)
L0 = 0.025;   % dimensionless (in i_Kr_Xr1_gate)
Q = 2.3;   % dimensionless (in i_Kr_Xr1_gate)
% g_Kr = 29.8667;   % S_per_F (in i_Kr)
% g_Ks = 2.041;   % S_per_F (in i_Ks)
KmCa = 1.38;   % millimolar (in i_NaCa)
KmNai = 87.5;   % millimolar (in i_NaCa)
Ksat = 0.1;   % dimensionless (in i_NaCa)
alpha = 2.8571432;   % dimensionless (in i_NaCa)
gamma = 0.35;   % dimensionless (in i_NaCa)
kNaCa = 4900.0;   % A_per_F (in i_NaCa)
Km_K = 1.0;   % millimolar (in i_NaK)
Km_Na = 40.0;   % millimolar (in i_NaK)
PNaK = 1.841424;   % A_per_F (in i_NaK)
% g_Na = 3671.2302;   % S_per_F (in i_Na)
KPCa = 0.0005;   % millimolar (in i_PCa)
% g_PCa = 0.4125;   % A_per_F (in i_PCa)
% g_b_Ca = 0.69264;   % S_per_F (in i_b_Ca)
% g_b_Na = 0.9;   % S_per_F (in i_b_Na)
E_f = -0.017;   % volt (in i_f)
g_f = 30.10312;   % S_per_F (in i_f)
g_to = 29.9038;   % S_per_F (in i_to)
Cao = 1.8;   % millimolar (in model_parameters)
Cm = 9.87109e-11;   % farad (in model_parameters)
F = 96485.3415;   % coulomb_per_mole (in model_parameters)
Ki = 150.0;   % millimolar (in model_parameters)
Ko = 5.4;   % millimolar (in model_parameters)
Nao = 151.0;   % millimolar (in model_parameters)
R = 8.314472;   % joule_per_mole_kelvin (in model_parameters)
T = 310.0;   % kelvin (in model_parameters)
V_SR = 583.73;   % micrometre_cube (in model_parameters)
Vc = 8800.0;   % micrometre_cube (in model_parameters)
i_stim_Amplitude = 1.5e-9; %5.5e-9;   % ampere (in stim_mode) %%%%%%%%%%%%%%%%%%
i_stim_End = 1010.0;   % second (in stim_mode)
i_stim_PulseDuration = 0.005;   % second (in stim_mode)
i_stim_Start = 1.0;   % second (in stim_mode)
i_stim_frequency = 60.0; %60.0;   % per_second (in stim_mode)
stim_flag = 0.0; %0.0;   % dimensionless (in stim_mode) %%%%%%%%%%%%%%%%

%-------------------------------------------------------------------------------
% Computed variables
%-------------------------------------------------------------------------------

% Ca_SR_bufSR (dimensionless) (in calcium_dynamics)
% Cai_bufc (dimensionless) (in calcium_dynamics)
% const2 (dimensionless) (in calcium_dynamics)
% g_inf (dimensionless) (in calcium_dynamics)
% i_leak (millimolar_per_second) (in calcium_dynamics)
% i_rel (millimolar_per_second) (in calcium_dynamics)
% i_up (millimolar_per_second) (in calcium_dynamics)
% E_Ca (volt) (in electric_potentials)
% E_K (volt) (in electric_potentials)
% E_Ks (volt) (in electric_potentials)
% E_Na (volt) (in electric_potentials)
% alpha_d (dimensionless) (in i_CaL_d_gate)
% beta_d (dimensionless) (in i_CaL_d_gate)
% d_infinity (dimensionless) (in i_CaL_d_gate)
% gamma_d (dimensionless) (in i_CaL_d_gate)
% tau_d (second) (in i_CaL_d_gate)
% constf1 (dimensionless) (in i_CaL_f1_gate)
% f1_inf (dimensionless) (in i_CaL_f1_gate)
% tau_f1 (second) (in i_CaL_f1_gate)
% constf2 (dimensionless) (in i_CaL_f2_gate)
% f2_inf (dimensionless) (in i_CaL_f2_gate)
% tau_f2 (second) (in i_CaL_f2_gate)
% alpha_fCa (dimensionless) (in i_CaL_fCa_gate)
% beta_fCa (dimensionless) (in i_CaL_fCa_gate)
% constfCa (dimensionless) (in i_CaL_fCa_gate)
% fCa_inf (dimensionless) (in i_CaL_fCa_gate)
% gamma_fCa (dimensionless) (in i_CaL_fCa_gate)
% i_CaL (A_per_F) (in i_CaL)
% nifed_coeff (dimensionless) (in i_CaL)
% XK1_inf (dimensionless) (in i_K1)
% alpha_K1 (dimensionless) (in i_K1)
% beta_K1 (dimensionless) (in i_K1)
% i_K1 (A_per_F) (in i_K1)
% E4031_coeff (dimensionless) (in i_Kr)
% V_half (millivolt) (in i_Kr_Xr1_gate)
% Xr1_inf (dimensionless) (in i_Kr_Xr1_gate)
% alpha_Xr1 (dimensionless) (in i_Kr_Xr1_gate)
% beta_Xr1 (dimensionless) (in i_Kr_Xr1_gate)
% tau_Xr1 (second) (in i_Kr_Xr1_gate)
% Xr2_infinity (dimensionless) (in i_Kr_Xr2_gate)
% alpha_Xr2 (dimensionless) (in i_Kr_Xr2_gate)
% beta_Xr2 (dimensionless) (in i_Kr_Xr2_gate)
% tau_Xr2 (second) (in i_Kr_Xr2_gate)
% i_Kr (A_per_F) (in i_Kr)
% Chromanol_coeff (dimensionless) (in i_Ks)
% Xs_infinity (dimensionless) (in i_Ks_Xs_gate)
% alpha_Xs (dimensionless) (in i_Ks_Xs_gate)
% beta_Xs (dimensionless) (in i_Ks_Xs_gate)
% tau_Xs (second) (in i_Ks_Xs_gate)
% i_Ks (A_per_F) (in i_Ks)
% i_NaCa (A_per_F) (in i_NaCa)
% i_NaK (A_per_F) (in i_NaK)
% TTX_coeff (dimensionless) (in i_Na)
% alpha_h (dimensionless) (in i_Na_h_gate)
% beta_h (dimensionless) (in i_Na_h_gate)
% h_inf (dimensionless) (in i_Na_h_gate)
% tau_h (second) (in i_Na_h_gate)
% alpha_j (dimensionless) (in i_Na_j_gate)
% beta_j (dimensionless) (in i_Na_j_gate)
% j_inf (dimensionless) (in i_Na_j_gate)
% tau_j (second) (in i_Na_j_gate)
% alpha_m (dimensionless) (in i_Na_m_gate)
% beta_m (dimensionless) (in i_Na_m_gate)
% m_inf (dimensionless) (in i_Na_m_gate)
% tau_m (second) (in i_Na_m_gate)
% i_Na (A_per_F) (in i_Na)
% i_PCa (A_per_F) (in i_PCa)
% i_b_Ca (A_per_F) (in i_b_Ca)
% i_b_Na (A_per_F) (in i_b_Na)
% Xf_infinity (dimensionless) (in i_f_Xf_gate)
% tau_Xf (second) (in i_f_Xf_gate)
% i_f (A_per_F) (in i_f)
% q_inf (dimensionless) (in i_to_q_gate)
% tau_q (second) (in i_to_q_gate)
% r_inf (dimensionless) (in i_to_r_gate)
% tau_r (second) (in i_to_r_gate)
% i_to (A_per_F) (in i_to)
% i_stim (A_per_F) (in stim_mode)
% i_stim_Period (second) (in stim_mode)

%-------------------------------------------------------------------------------
% Computation
%-------------------------------------------------------------------------------

% time (second)

E_K = R*T/F*log(Ko/Ki);
alpha_K1 = 3.91/(1.0+exp(0.5942*(Y(1)*1000.0-E_K*1000.0-200.0)));
beta_K1 = (-1.509*exp(0.0002*(Y(1)*1000.0-E_K*1000.0+100.0))+exp(0.5886*(Y(1)*1000.0-E_K*1000.0-10.0)))/(1.0+exp(0.4547*(Y(1)*1000.0-E_K*1000.0)));
XK1_inf = alpha_K1/(alpha_K1+beta_K1);
i_K1 = g_K1*XK1_inf*(Y(1)-E_K)*sqrt(Ko/5.4);
i_to = g_to*(Y(1)-E_K)*Y(16)*Y(17);

if (E4031_30nM == 1.0)
   E4031_coeff = 0.77;
elseif (E4031_100nM == 1.0)
   E4031_coeff = 0.5;
else
   E4031_coeff = 1.0;
end;

i_Kr = E4031_coeff*g_Kr*(Y(1)-E_K)*Y(9)*Y(10)*sqrt(Ko/5.4);

if (Chromanol_iKs30 == 1.0)
   Chromanol_coeff = 0.7;
elseif (Chromanol_iKs50 == 1.0)
   Chromanol_coeff = 0.5;
elseif (Chromanol_iKs70 == 1.0)
   Chromanol_coeff = 0.3;
elseif (Chromanol_iKs90 == 1.0)
   Chromanol_coeff = 0.1;
else
   Chromanol_coeff = 1.0;
end;

E_Ks = R*T/F*log((Ko+PkNa*Nao)/(Ki+PkNa*Y(18)));
i_Ks = Chromanol_coeff*g_Ks*(Y(1)-E_Ks)*Y(11)^2.0*(1.0+0.6/(1.0+(3.8*0.00001/Y(3))^1.4));

if (nifed_3nM == 1.0)
   nifed_coeff = 0.93;
elseif (nifed_10nM == 1.0)
   nifed_coeff = 0.79;
elseif (nifed_30nM == 1.0)
   nifed_coeff = 0.56;
elseif (nifed_100nM == 1.0)
   nifed_coeff = 0.28;
else
   nifed_coeff = 1.0;
end;

i_CaL = nifed_coeff*g_CaL*4.0*Y(1)*F^2.0/(R*T)*(Y(3)*exp(2.0*Y(1)*F/(R*T))-0.341*Cao)/(exp(2.0*Y(1)*F/(R*T))-1.0)*Y(5)*Y(6)*Y(7)*Y(8);
i_NaK = PNaK*Ko/(Ko+Km_K)*Y(18)/(Y(18)+Km_Na)/(1.0+0.1245*exp(-0.1*Y(1)*F/(R*T))+0.0353*exp(-Y(1)*F/(R*T)));

if (TTX_3uM == 1.0)
   TTX_coeff = 0.18;
elseif (TTX_10uM == 1.0)
   TTX_coeff = 0.06;
elseif (TTX_30uM == 1.0)
   TTX_coeff = 0.02;
else
   TTX_coeff = 1.0;
end;

E_Na = R*T/F*log(Nao/Y(18));
i_Na = TTX_coeff*g_Na*Y(14)^3.0*Y(12)*Y(13)*(Y(1)-E_Na);
i_NaCa = kNaCa*(exp(gamma*Y(1)*F/(R*T))*Y(18)^3.0*Cao-exp((gamma-1.0)*Y(1)*F/(R*T))*Nao^3.0*Y(3)*alpha)/((KmNai^3.0+Nao^3.0)*(KmCa+Cao)*(1.0+Ksat*exp((gamma-1.0)*Y(1)*F/(R*T))));
i_PCa = g_PCa*Y(3)/(Y(3)+KPCa);
i_f = g_f*Y(15)*(Y(1)-E_f);
i_b_Na = g_b_Na*(Y(1)-E_Na);
E_Ca = 0.5*R*T/F*log(Cao/Y(3));
i_b_Ca = g_b_Ca*(Y(1)-E_Ca);
i_stim_Period = 60.0/i_stim_frequency;

if ((time >= i_stim_Start) && (time <= i_stim_End) && (time-i_stim_Start-floor((time-i_stim_Start)/i_stim_Period)*i_stim_Period <= i_stim_PulseDuration))
   i_stim = stim_flag*i_stim_Amplitude/Cm;
else
   i_stim = 0.0;
end;

dY(1, 1) = -(i_K1+i_to+i_Kr+i_Ks+i_CaL+i_NaK+i_Na+i_NaCa+i_PCa+i_f+i_b_Na+i_b_Ca-i_stim);
i_rel = (c_rel+a_rel*Y(2)^2.0/(b_rel^2.0+Y(2)^2.0))*Y(5)*Y(4)*0.0411;
i_up = VmaxUp/(1.0+Kup^2.0/Y(3)^2.0);
i_leak = (Y(2)-Y(3))*V_leak;

g_inf= (Y(3)<=0.00035)*(1/(1+(Y(3)/0.00035)^6))+(Y(3)>0.00035)*(1/(1+(Y(3)/0.00035)^16));
% if (Y(3) <= 0.00035)
%    g_inf = 1.0/(1.0+(Y(3)/0.00035)^6.0);
% else
%    g_inf = 1.0/(1.0+(Y(3)/0.00035)^16.0);
% end;

const2=(1-(g_inf > Y(4))*(Y(1)>-0.06));
% if ((g_inf > Y(4)) && (Y(1) > -0.06))
%    const2 = 0.0;
% else
%    const2 = 1.0;
% end;

dY(4, 1) = const2*(g_inf-Y(4))/tau_g;
Cai_bufc = 1.0/(1.0+Buf_C*Kbuf_C/(Y(3)+Kbuf_C)^2.0);
Ca_SR_bufSR = 1.0/(1.0+Buf_SR*Kbuf_SR/(Y(2)+Kbuf_SR)^2.0);
dY(3, 1) = Cai_bufc*(i_leak-i_up+i_rel-(i_CaL+i_b_Ca+i_PCa-2.0*i_NaCa)*Cm/(2.0*Vc*F*1.0e-18));
dY(2, 1) = Ca_SR_bufSR*Vc/V_SR*(i_up-(i_rel+i_leak));


d_infinity = 1.0/(1.0+exp(-(Y(1)*1000.0+9.1)/7.0));
alpha_d = 0.25+1.4/(1.0+exp((-Y(1)*1000.0-35.0)/13.0));
beta_d = 1.4/(1.0+exp((Y(1)*1000.0+5.0)/5.0));
gamma_d = 1.0/(1.0+exp((-Y(1)*1000.0+50.0)/20.0));
tau_d = (alpha_d*beta_d+gamma_d)*1.0/1000.0;
dY(5, 1) = (d_infinity-Y(5))/tau_d;
f1_inf = 1.0/(1.0+exp((Y(1)*1000.0+26.0)/3.0));

if (f1_inf-Y(6) > 0.0)
   constf1 = 1.0+1433.0*(Y(3)-50.0*1.0e-6);
else
   constf1 = 1.0;
end;

tau_f1 = (20.0+1102.5*exp(-((Y(1)*1000.0+27.0)^2.0/15.0)^2.0)+200.0/(1.0+exp((13.0-Y(1)*1000.0)/10.0))+180.0/(1.0+exp((30.0+Y(1)*1000.0)/10.0)))*constf1/1000.0;
dY(6, 1) = (f1_inf-Y(6))/tau_f1;
f2_inf = 0.33+0.67/(1.0+exp((Y(1)*1000.0+35.0)/4.0));
constf2 = 1.0;
tau_f2 = (600.0*exp(-(Y(1)*1000.0+25.0)^2.0/170.0)+31.0/(1.0+exp((25.0-Y(1)*1000.0)/10.0))+16.0/(1.0+exp((30.0+Y(1)*1000.0)/10.0)))*constf2/1000.0;
dY(7, 1) = (f2_inf-Y(7))/tau_f2;
alpha_fCa = 1.0/(1.0+(Y(3)/0.0006)^8.0);
beta_fCa = 0.1/(1.0+exp((Y(3)-0.0009)/0.0001));
gamma_fCa = 0.3/(1.0+exp((Y(3)-0.00075)/0.0008));
fCa_inf = (alpha_fCa+beta_fCa+gamma_fCa)/1.3156;

if ((Y(1) > -0.06) && (fCa_inf > Y(8)))
   constfCa = 0.0;
else
   constfCa = 1.0;
end;

dY(8, 1) = constfCa*(fCa_inf-Y(8))/tau_fCa;
V_half = 1000.0*(-R*T/(F*Q)*log((1.0+Cao/2.6)^4.0/(L0*(1.0+Cao/0.58)^4.0))-0.019);
Xr1_inf = 1.0/(1.0+exp((V_half-Y(1)*1000.0)/4.9));
alpha_Xr1 = 450.0/(1.0+exp((-45.0-Y(1)*1000.0)/10.0));
beta_Xr1 = 6.0/(1.0+exp((30.0+Y(1)*1000.0)/11.5));
tau_Xr1 = 1.0*alpha_Xr1*beta_Xr1/1000.0;
dY(9, 1) = (Xr1_inf-Y(9))/tau_Xr1;
Xr2_infinity = 1.0/(1.0+exp((Y(1)*1000.0+88.0)/50.0));
alpha_Xr2 = 3.0/(1.0+exp((-60.0-Y(1)*1000.0)/20.0));
beta_Xr2 = 1.12/(1.0+exp((-60.0+Y(1)*1000.0)/20.0));
tau_Xr2 = 1.0*alpha_Xr2*beta_Xr2/1000.0;
dY(10, 1) = (Xr2_infinity-Y(10))/tau_Xr2;
Xs_infinity = 1.0/(1.0+exp((-Y(1)*1000.0-20.0)/16.0));
alpha_Xs = 1100.0/sqrt(1.0+exp((-10.0-Y(1)*1000.0)/6.0));
beta_Xs = 1.0/(1.0+exp((-60.0+Y(1)*1000.0)/20.0));
tau_Xs = 1.0*alpha_Xs*beta_Xs/1000.0;
dY(11, 1) = (Xs_infinity-Y(11))/tau_Xs;
h_inf = 1.0/sqrt(1.0+exp((Y(1)*1000.0+72.1)/5.7));

if (Y(1) < -0.04)
   alpha_h = 0.057*exp(-(Y(1)*1000.0+80.0)/6.8);
else
   alpha_h = 0.0;
end;

if (Y(1) < -0.04)
   beta_h = 2.7*exp(0.079*Y(1)*1000.0)+3.1*10.0^5.0*exp(0.3485*Y(1)*1000.0);
else
   beta_h = 0.77/(0.13*(1.0+exp((Y(1)*1000.0+10.66)/-11.1)));
end;

if (Y(1) < -0.04)
   tau_h = 1.5/((alpha_h+beta_h)*1000.0);
else
   tau_h = 2.542/1000.0;
end;

dY(12, 1) = (h_inf-Y(12))/tau_h;
j_inf = 1.0/sqrt(1.0+exp((Y(1)*1000.0+72.1)/5.7));

if (Y(1) < -0.04)
   alpha_j = (-25428.0*exp(0.2444*Y(1)*1000.0)-6.948*10.0^-6.0*exp(-0.04391*Y(1)*1000.0))*(Y(1)*1000.0+37.78)/(1.0+exp(0.311*(Y(1)*1000.0+79.23)));
else
   alpha_j = 0.0;
end;

if (Y(1) < -0.04)
   beta_j = 0.02424*exp(-0.01052*Y(1)*1000.0)/(1.0+exp(-0.1378*(Y(1)*1000.0+40.14)));
else
   beta_j = 0.6*exp(0.057*Y(1)*1000.0)/(1.0+exp(-0.1*(Y(1)*1000.0+32.0)));
end;

tau_j = 7.0/((alpha_j+beta_j)*1000.0);
dY(13, 1) = (j_inf-Y(13))/tau_j;
m_inf = 1.0/(1.0+exp((-Y(1)*1000.0-34.1)/5.9))^(1.0/3.0);
alpha_m = 1.0/(1.0+exp((-Y(1)*1000.0-60.0)/5.0));
beta_m = 0.1/(1.0+exp((Y(1)*1000.0+35.0)/5.0))+0.1/(1.0+exp((Y(1)*1000.0-50.0)/200.0));
tau_m = 1.0*alpha_m*beta_m/1000.0;
dY(14, 1) = (m_inf-Y(14))/tau_m;
Xf_infinity = 1.0/(1.0+exp((Y(1)*1000.0+77.85)/5.0));
tau_Xf = 1900.0/(1.0+exp((Y(1)*1000.0+15.0)/10.0))/1000.0;
dY(15, 1) = (Xf_infinity-Y(15))/tau_Xf;
q_inf = 1.0/(1.0+exp((Y(1)*1000.0+53.0)/13.0));
tau_q = (6.06+39.102/(0.57*exp(-0.08*(Y(1)*1000.0+44.0))+0.065*exp(0.1*(Y(1)*1000.0+45.93))))/1000.0;
dY(16, 1) = (q_inf-Y(16))/tau_q;
r_inf = 1.0/(1.0+exp(-(Y(1)*1000.0-22.3)/18.75));
tau_r = (2.75352+14.40516/(1.037*exp(0.09*(Y(1)*1000.0+30.61))+0.369*exp(-0.12*(Y(1)*1000.0+23.84))))/1000.0;
dY(17, 1) = (r_inf-Y(17))/tau_r;
dY(18, 1) = -Cm*(i_Na+i_b_Na+3.0*i_NaK+3.0*i_NaCa)/(F*Vc*1.0e-18);

Ik1 = i_K1;
Ito = i_to;
Ikr = i_Kr;
Iks = i_Ks;
ica = i_CaL;
INaK = i_NaK;
INa = i_Na;
inaca = i_NaCa;
IpCa = i_PCa;
If = i_f;
IbNa = i_b_Na;
IbCa = i_b_Ca;
Irel = i_rel;
Iup = i_up;
Ileak = i_leak;
Istim = i_stim;

dati = [Ik1, Ito, Ikr, Iks, ica, INaK, INa, inaca, IpCa, If, IbNa, IbCa, Irel, Iup, Ileak, Istim, E_K, E_Na];
%===============================================================================
% End of file
%===============================================================================
