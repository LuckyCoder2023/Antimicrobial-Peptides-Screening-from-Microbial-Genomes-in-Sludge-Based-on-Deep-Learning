from tensorflow.keras import backend as K_backend
from tensorflow.keras.layers import Layer
from tensorflow.keras import initializers as init, regularizers as regs, constraints as consts

class FocusMechanism(Layer):
    def __init__(self,
                 kernel_regularizer=None, bias_regularizer=None,
                 kernel_constraint=None, bias_constraint=None,
                 use_bias=True, **kwargs):
        self.mask_support = True
        self.weight_initializer = init.get('glorot_uniform')
        self.kernel_regularizer = regs.get(kernel_regularizer)
        self.bias_regularizer = regs.get(bias_regularizer)
        self.kernel_constraint = consts.get(kernel_constraint)
        self.bias_constraint = consts.get(bias_constraint)
        self.use_bias = use_bias
        super(FocusMechanism, self).__init__(**kwargs)

    def build(self, input_shape):
        assert len(input_shape) == 3
        self.kernel = self.add_weight(shape=(input_shape[-1], input_shape[-1]),
                                      initializer=self.weight_initializer,
                                      name='{}_kernel'.format(self.name),
                                      regularizer=self.kernel_regularizer,
                                      constraint=self.kernel_constraint)
        if self.use_bias:
            self.bias = self.add_weight(shape=(input_shape[-1],),
                                        initializer='zeros',
                                        name='{}_bias'.format(self.name),
                                        regularizer=self.bias_regularizer,
                                        constraint=self.bias_constraint)
        super(FocusMechanism, self).build(input_shape)

    def compute_mask(self, inputs, input_mask=None):
        return None

    def call(self, inputs, mask=None):
        uit = K_backend.dot(inputs, self.kernel)
        if self.use_bias:
            uit += self.bias
        uit = K_backend.tanh(uit)
        a = K_backend.exp(uit)
        if mask is not None:
            a *= K_backend.cast(mask, K_backend.floatx())
        a /= K_backend.cast(K_backend.sum(a, axis=1, keepdims=True) + K_backend.epsilon(), K_backend.floatx())
        weighted_input = inputs * a
        return K_backend.sum(weighted_input, axis=1)

    def compute_output_shape(self, input_shape):
        return input_shape[0], input_shape[-1]
