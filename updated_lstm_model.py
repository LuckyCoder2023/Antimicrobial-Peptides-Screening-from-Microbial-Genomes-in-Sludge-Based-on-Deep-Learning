import tensorflow as tf
from tensorflow.keras.models import load_model
loaded_model = load_model("updated_lstm_model.h5")
loaded_model.summary()
