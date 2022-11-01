%% Oct 27, 2022  
% 'keep the fire burning'
clear all

data_path = '/home/danny/Desktop/cpmod/projects/soot-flamelet/flamelet';
chem_mech_path = '/home/danny/Desktop/cpmod/projects/soot-flamelet/mechanisms';
psd_path = '/home/danny/Desktop/cpmod/projects/soot-flamelet/pbe';

mech = 'USCMechII';

sim_name = 'Sun_soot_HACA_1D';
folder_name = strcat(sim_name,'_results');
mkdir(folder_name); 

copyfile(strcat(data_path,'/*'),folder_name);
copyfile(strcat(chem_mech_path,'/USCMechII/chem.out'),folder_name);
copyfile(strcat(psd_path,'/FLAMELET_PSD.out'),folder_name)

%% Read and clean chemkin file chem.out
chem_lookup = readtable(strcat(folder_name,'/chem.out'),'FileType','text','Delimiter','\n');
chem_lookup = clean_lookup(chem_lookup);

% add rho and T
scalar_lookup = chem_lookup;
rho = table(0, 0, 0, 0, 0,length(chem_lookup.offset)+1,'VariableNames', {'phase','charge','MR','T_Lo','T_Hi','offset'},'RowNames',string("rho"));
T = table(0, 0, 0, 0, 0,length(chem_lookup.offset)+2,'VariableNames', {'phase','charge','MR','T_Lo','T_Hi','offset'},'RowNames',string("T"));
scalar_lookup = [scalar_lookup;rho;T];

%% Read in flamelet-species output files
initial_mass_dist = dlmread(strcat(folder_name,'/conc_massf_init.out'));
mass_dist = dlmread(strcat(folder_name,'/conc_massf.out'));

initial_molar_dist = dlmread(strcat(folder_name,'/conc_molf_init.out'),' ',1,1);
molar_dist =  dlmread(strcat(folder_name,'/conc_molf.out'));
%% Read in flamelet Soot
soot_moments = dlmread(strcat(folder_name,'/final_distribution.out'));
soot_psd = dlmread(strcat(folder_name,'/FLAMELET_PSD.out'));
soot_psd = clean_psd(soot_psd,soot_moments(:,3)); % soot psd, z

%%

f = uifigure;
ax = uiaxes(f);

dd = uidropdown(f,'Items',scalar_lookup.Properties.RowNames,'ValueChangedFcn',@(dd,event) selection(dd,ax,molar_dist));
dd.ItemsData = scalar_lookup.offset;

%%


figure(2);
psd = getPSDwithZindex(soot_psd,50);
loglog(psd(:,1),psd(:,2))

% callbacks

function selection(dd,ax,molar_dist)

plot(ax,molar_dist(:,1), molar_dist(:,dd.Value));% the order matters


end




