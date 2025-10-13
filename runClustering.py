#!/usr/bin/python
# -*- coding: utf-8 -*-
# python runClustering.py /mnt/raid/wuye4567/NCPR/streamline.h5 /mnt/raid/wuye4567/NCPR 
import argparse
import h5py
import os

import numpy as np
from scipy.io import savemat
from sklearn.cluster import MiniBatchKMeans

parser = argparse.ArgumentParser(
    description="Fiber clustering in cosine space via MinBatchKMeans, Birch, DBSCAN, or GaussianMixture",
    epilog="Written by Ye Wu (amri.wuye@gmail.com)")
parser.add_argument("-v","--version",
    action="version", default=argparse.SUPPRESS,
    version='1.0',
    help="Show program's version number and exit")
parser.add_argument(
    'inputfilename',
    help='Input a HDF5 file that contain streamline cosine coefficient')
args = parser.parse_args()

inputfilename = args.inputfilename

with h5py.File(inputfilename, 'r') as f:
    data = list(f['cosine'])
    #data = f['cosine']

data = np.array(data)

clubernumber = np.ceil(np.power(np.shape(data)[0],1/5)).astype(int)
batchsize = np.ceil(np.power(np.shape(data)[0],1/4)).astype(int)

print (clubernumber)

cluster = MiniBatchKMeans(n_clusters=clubernumber, init='k-means++',
                max_iter=10000,compute_labels=True,
                init_size=None, batch_size=batchsize, verbose=False)
label = cluster.fit_predict(data)
label_more = np.ones_like(label) * clubernumber

for i in np.arange(clubernumber):
	ind = np.where(label==i)
	data_ind = data[ind]
	
	clubernumber_ind = np.ceil(np.power(np.shape(data_ind)[0],1/6)).astype(int)
	batchsize_ind = np.ceil(np.power(np.shape(data_ind)[0],1/4)).astype(int)

	cluster_ind = MiniBatchKMeans(n_clusters=clubernumber_ind, init='k-means++',
                    max_iter=10000,compute_labels=True,
                    init_size=None, batch_size=batchsize_ind, verbose=False)
	label_more[ind] = cluster_ind.fit_predict(data_ind)

with h5py.File(inputfilename[:-3] + '_label_1.h5', 'w') as f:
    f.create_dataset('train_data', data=label)
    
with h5py.File(inputfilename[:-3] + '_label_2.h5', 'w') as f:
    f.create_dataset('train_data', data=label_more)
