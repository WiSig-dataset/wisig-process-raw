warning('off','MATLAB:MKDIR:DirectoryExists')
rx_nodes = dir('data');

for i = 3 : length(rx_nodes)
   fldr_name = [rx_nodes(i).name,'/'];
   disp(['Started Processing, ' num2str(i) ' : ' fldr_name])
   t1 = tic;
   split_signal_fun(fldr_name)
   disp(toc(t1))
end