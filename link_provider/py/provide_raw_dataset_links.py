#!/usr/bin/env python
# coding: utf-8

# In[2]:


get_ipython().run_line_magic('load_ext', 'autoreload')

get_ipython().run_line_magic('autoreload', '2')
import matplotlib.pyplot as plt
import numpy as np
import pickle
import os
import scipy.optimize


# In[3]:


import os
GPU = ""
os.environ["CUDA_DEVICE_ORDER"]="PCI_BUS_ID"   
os.environ["CUDA_VISIBLE_DEVICES"]=GPU


# In[9]:


with open('raw_info_dct.pkl','rb') as f:
    dct = pickle.load(f)


# In[7]:



print('https://drive.google.com/u/0/uc?export=download&id={}'.format('1bQbswsPLZy5lSe5Lu_IpRoaV4wtlcLBH')) 


# In[17]:


def provide_links(day_list=['2021_03_01','2021_03_08','2021_03_15','2021_03_23'],rx_list=None,tx_groups=range(10)):
    total_size = 0
    with open('raw_info_dct.pkl','rb') as f:
        dct = pickle.load(f)
    for day in day_list:
        print('Day {} links'.format(day))
        print('----------------------')
        
        if rx_list is None:
            rx_list=dct[day].keys()
        for rx in rx_list:
            print('Rx {} links'.format(rx))
            if rx in dct[day].keys():
                for tx_g in tx_groups:
                    if tx_g in dct[day][rx].keys():
                        lnk = dct[day][rx][tx_g][1]
                        total_size= total_size + dct[day][rx][tx_g][2]
                        print('https://drive.google.com/u/0/uc?export=download&id={}'.format(lnk)) 
            print('')
        print('')
        print('')
        print('Total download size is {} GB'.format(total_size/1e9))


# In[22]:


provide_links()


# In[ ]:




