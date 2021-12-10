warning('off','MATLAB:MKDIR:DirectoryExists')

folder='wifi_2021_03_23/';

rx_nodes = dir([folder,'packets/']);


for rx_i = 3 : length(rx_nodes)
    rx_node = rx_nodes(rx_i).name;
    disp(['Started Processing, ' num2str(rx_i) ' : ' rx_node])
    t1 = tic;
    
    fls = dir([folder,'packets/',rx_node]);
   
    
    for fl_i = 3 : length(fls)
        fl = fls(fl_i).name;

        fprintf(sprintf('File %d of %d: %s' , fl_i, length(fls),fl) ); 
        t2=tic;
        load([folder,'packets/',rx_node,'/',fl]);
        packet_log_in = packet_log;
        packet_log_op = {};
        for pkt_i=1:length(packet_log_in)
            pkt = packet_log_in{pkt_i};
            pkt_op = equalize_channel(pkt);
            if ~isempty(pkt_op)
                packet_log_op{end+1}=pkt_op;
            end
        end
        fprintf(sprintf('  %d \n' , toc(t2) ))
        packet_log=packet_log_op;
        if ~isempty(packet_log)
            mkdir([folder,'equalized_packets/'])
            mkdir([folder,'equalized_packets/',rx_node])
            save([folder,'equalized_packets/',rx_node,'/',fl],'packet_log')
        end
    end
    disp(toc(t1))
end
