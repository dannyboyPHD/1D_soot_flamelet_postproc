%% Jan 20, 2023
% 'Be a Man'
%
% Live output for 1D flame, for debugging purposes
%% directories

% data_dir = '../sooting_flamlet2/projects/combustion/flamelet/';
data_dir = './Jan31_2PBEDiff/';

%%
f = 'z_space.out';
g = 'conc_molf.out';

live_update = true;


while live_update
   z_data = dlmread(strcat(data_dir,f));
   all_data = dlmread(strcat(data_dir,g));
   
   z = z_data(1:2:199,1);
   N0 = z_data(1:2:199,2);
   M1 = z_data(1:2:199,3);
   AS = z_data(2:2:200,1);
   
   T = all_data(:,150);
   
   figure(1)
   plot(z,T,'k-');
   
   figure(2)
   plot(z,AS,'r-');
   
   pause(0.5); 
end
