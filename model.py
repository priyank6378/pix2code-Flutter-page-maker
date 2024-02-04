import tensorflow as tf
from tensorflow.keras import layers

from model_constant import *

def make_model():
    # Vision model
    image_input = layers.Input(shape=(IMG_SIZE[0], IMG_SIZE[1], 3), name='img')
    x = layers.Conv2D(32, 3, strides=1)(image_input)
    x = layers.MaxPool2D(2)(x)
    x = layers.Conv2D(64, 3, strides=1)(x)
    x = layers.MaxPool2D(2)(x)
    x = layers.Conv2D(128, 3, strides=1)(x)
    x = layers.MaxPool2D(2)(x)
    x = layers.Flatten()(x)
    x = layers.Dense(1024, activation='relu')(x)
    p = layers.Dense(1024, activation='relu')(x)
    # print(p.shape)

    # Language model
    # First LSTM model
    code_input = layers.Input(shape=(TOKEN_LEN, 1))
    # x = layers.Embedding(VOCAB_SIZE, 256, mask_zero=True)(code_input)
    x = layers.Masking(mask_value=0)(code_input)
    x = layers.LSTM(128, return_sequences=True)(x)
    qt = layers.LSTM(128)(x)
    # print(qt.shape)

    # Second LSTM model
    rt = layers.Concatenate()([p, qt])
    rt = tf.expand_dims(rt, axis=1)
    x = layers.LSTM(512)(rt)
    xt = layers.Dense(VOCAB_SIZE+2, activation='softmax')(x)
    # xt = layers.Dense(1)(x)
    # print(xt.shape)

    # Model
    pix2code = tf.keras.Model(inputs=[image_input, code_input], outputs=xt)
    model_path = 'outputs/pix2code.keras'
    pix2code.load_weights(model_path)

    return pix2code