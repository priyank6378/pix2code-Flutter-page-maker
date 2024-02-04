from model import *

import pickle
import numpy as np
import os
import sys
import cv2

IMG_SIZE = (256, 256)
SEQUENCE_LENGTH = 75
VOCAB_SIZE = 20
TOKEN_LEN = 48

model_path = 'outputs/pix2code.keras'

pix2code = make_model()

import pickle

code_to_index_path = 'outputs/code_to_index.pickle'
index_to_code_path = 'outputs/index_to_code.pickle'

with open(code_to_index_path, 'rb') as f:
    code_to_index = pickle.load(f)

with open(index_to_code_path, 'rb') as f:
    index_to_code = pickle.load(f)


def pad_sequences(x, max_len=TOKEN_LEN):
    padded = np.zeros((max_len), dtype=np.int64)
    if len(x) > max_len: padded[:] = x[-max_len:]
    else: padded[:len(x)] = x
    padded = tf.expand_dims(padded, axis=1)
    return padded

def generate_code(img, max_length):
    img = np.array([img], dtype=np.float32)
    final_code = '<START>'
    code = [code_to_index['<START>']]
    tmp = code
    code = pad_sequences(code, max_len=TOKEN_LEN)
    for i in range(max_length):
        prediction = pix2code([img, np.array([code])], training=False)
#         print(prediction)
        prediction = tf.argmax(prediction , axis=-1)
        final_code = final_code + ' ' + index_to_code[int(prediction[0])]
        tmp.append(int(prediction[0]))
        if (len(tmp) > TOKEN_LEN):
            tmp = tmp[1:]
        code = pad_sequences(tmp, max_len=TOKEN_LEN)
        if int(prediction[0]) == code_to_index['<END>']:
            break
    return final_code

def generate_code_from_path(img_path, max_length = 80):
    img = cv2.imread(img_path)
    img = cv2.resize(img, IMG_SIZE)
    img = img / 255.0
    code = generate_code(img, max_length)
    code = code[len('<START> ') : len(code) - len(' <END>')]
    return code


############################### MAIN FUNCTION ###############################

if __name__ == '__main__' : 
    img_path = sys.argv[1]
    output_folder = 'generated_page_output'
    if (len(sys.argv) > 2) :
        output_folder = sys.argv[2]
    code = generate_code_from_path(img_path)
    print(code)
    cli_cmd = f"dart flutterPageMaker/parser.dart \"{code}\" {output_folder}"
    os.system(cli_cmd)