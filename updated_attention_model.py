from tensorflow.keras.models import load_model
from numpy import load, save
from FocusMechanism import FocusMechanism as AttentionMechanism
from sys import argv

custom_model = load_model('updated_attention_model.h5', custom_objects={'AttentionMechanism': AttentionMechanism})
input_data = load(argv[1], delimiter=",")
model_prediction = custom_model.predict(input_data)
save(argv[2], model_prediction, fmt="%.8f", delimiter=",")
