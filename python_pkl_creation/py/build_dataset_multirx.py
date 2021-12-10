#!/usr/bin/env python
# coding: utf-8

# In[1]:


import glob
import re
import numpy as np
import matplotlib.pyplot as plt
import pickle
import scipy.io
import os


# In[2]:


pkt_len = 256
base_src_fldr = 'wifi_2021_03_15/equalized_packets/' 
base_dest_fldr = 'wifi_2021_03_15/pkl_equalized_packets/' 
file_base = 'dataset_2021_03_15_'


# In[3]:


def process_save_rx(src_fldr,dst_file):
    dataset = {}
    file_list = os.listdir(src_fldr)
    print(len(file_list))
    n_nodes = len(file_list)
    data = []
    node_list = [] 
    i = 0
    for fname in file_list:
#         print(os.stat(src_fldr+fname).st_size)
        if os.stat(src_fldr+fname).st_size >file_thresh:
            f = scipy.io.loadmat(src_fldr+fname,verify_compressed_data_integrity=False)
#             print(fname)
            if len(f['packet_log'][0]) > pkt_thresh:
                print(i,fname[8:-4],len(f['packet_log'][0]))
                data_i = np.zeros((f['packet_log'][0].size,pkt_len,2))
                for j,pkt in enumerate(f['packet_log'][0]):
                    data_i[j,:,0] = np.real(pkt[slc,0])
                    data_i[j,:,1] = np.imag(pkt[slc,0])
                data.append(data_i)
                node_list.append(fname[8:-4])
            else:
                print(i,fname[8:-4],'Eliminated')
        i = i+1
        
    dataset = {'data':data,'node_list':node_list}
    op_name = dst_file +'.pkl'
    with open(op_name,'wb') as f:
        pickle.dump(dataset,f)


# In[4]:


slc = slice(0,256)
file_thresh = 0
pkt_thresh = 3



rx_list = os.listdir(base_src_fldr)
i= 0
for i in range(len(rx_list)):
    rx_name = rx_list[i]
    src_fldr = base_src_fldr +  rx_name + '/'
    dst_file = base_dest_fldr + file_base + rx_name 
    print(i,src_fldr)
    process_save_rx(src_fldr,dst_file)


# In[ ]:





# In[5]:


for _ in range(100):
    print("")

