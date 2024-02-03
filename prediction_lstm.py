from tensorflow.keras.models import load_model
from numpy import load, save
from sys import argv

lstm_model = load_model('updated_sequential_model.h5')
input_values = load(argv[1], delimiter=",")
predictions = lstm_model.predict(input_values)
save(argv[2], predictions, fmt="%.8f", delimiter=",")
