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

figure(1);
plot(initial_molar_dist(:,1), initial_molar_dist(:,chem_lookup('CO2','offset').offset))

figure(2);
psd = getPSDwithZindex(soot_psd,50);
loglog(psd(:,1),psd(:,2))




