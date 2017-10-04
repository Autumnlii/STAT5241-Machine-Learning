# -*- coding: utf-8 -*-
"""
Spyder Editor

Qiuying Li
ql2280

This is a temporary script file.
"""
"""1)Plot the stock value you choose vs a benchmark (e.g. S&P 500). 
You can use the first difference to adjust your data. 
We provide some basic data like S&P500, Nasdaq, PBR, BUD,
 Verizon but we highly recommend you to find some stock data you’re interested 
 in and suitable for this question. 
"""

import numpy as np
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import Dropout
from keras.layers import Flatten
from keras.layers.convolutional import Conv2D
from keras.layers.convolutional import MaxPooling2D
from keras import backend as K


# importing data set 
test = np.loadtxt('/Users/qiuying/Desktop//2017 spring/GR 5241/HW/hw5/zip.test')
train = np.loadtxt('/Users/qiuying/Desktop//2017 spring/GR 5241/HW/hw5/zip.train')
# X variable
training_x = train[:,1:]
test_x = test[:,1:]
training_x = training_x.reshape(training_x.shape[0], 1, 16, 16).astype('float32')
#Y variable
training_y = train[:,0]
test_y = test[:,0]
test_x = test_x.reshape(test_x.shape[0], 1, 16, 16).astype('float32')
classes_num = test_y.shape[1]

# Random number
K.set_image_dim_ordering('th')
seed = 7
np.random.seed(seed)

#Define the model
def p3_model():
    model = Sequential()
    model.add(Conv2D(30, (5, 5), input_shape=(1, 16, 16), activation='relu'))
    model.add(Conv2D(15, (3, 3), activation='relu'))
    model.add(MaxPooling2D(pool_size=(2, 2)))
    model.add(Flatten())
    model.add(Dropout(0.2))
    model.add(Dense(50, activation='relu'))
    model.add(Dense(128, activation='relu'))
    model.add(Dense(classes_num, activation='softmax'))
    model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])
    return model


# Call the model
model = p3_model()
model.fit(training_x, training_y, validation_data=(test_x, test_y), epochs=50, batch_size=200)
scores = model.evaluate(test_x, test_y, verbose=0)
print("Error Rate: %.2f%%" % (100-scores[1]*100))