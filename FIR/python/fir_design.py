import numpy as np
import scipy.signal as signal
import matplotlib.pyplot as plt

N = 1024                                            # number of samples
fs = 10000                                          # sample frequency
t = np.arange(0, (N - 1) / fs, 1 / fs)              # time samples where we increase by dt = 1 / fs and get N samples

amplitude_1 = 1.0                                   # amplitude of our signal. needs to be -1 <--> 0.999... 
amplitude_2 = 0.5                                   # amplitude of signal 2 
signal_frequency_1 = 97.65625  
signal_frequency_2 = 1464.84375

# test signal
x = amplitude_1 * np.sin(2 * np.pi * signal_frequency_1 * t) + amplitude_2 * np.sin(2 * np.pi * signal_frequency_2 * t)
x = x / np.max(np.abs(x))                           # Normalize to -1 to +1

# time domain plot
plt.figure()
plt.plot(t, x)
plt.savefig("../docs/input_time_domain.png")

# frequency domain plot
f = np.arange(-N/2, N/2 - 1) * fs/N                 # frequency range
x_fdomain = np.fft.fft(x)
x_fdomain = np.fft.fftshift(x_fdomain)
x_fdomain = np.absolute(x_fdomain)

plt.figure()
plt.plot(f, x_fdomain)
plt.savefig("../docs/input_frequency_domain.png")

# writes the signal values in hex to input_signal.hex
with open("../hex/input_signal.hex", "w") as file:
    for i in x:
        val = int(np.round(i * 2**15))
        if val < 0:
            val = val + 2**16                       # Convert to two's complement 16-bit
        file.write(f"{val:04x}\n")


# write the FIR tap coefficients intot he coefficients.hex file
taps = signal.firwin(32, 500, fs=10000)                         # lowpass filter with a cutoff at 500Hz
# taps = signal.firwin(32, [0, 200], pass_zero=False, fs=fs)

with open("../hex/coefficients.hex", "w") as file:
    for j in taps:
        val = int(np.round(j * 2**15))
        if val < 0:
            val = val + 2**16  # Convert to two's complement 16-bit
        file.write(f"{val:04x}\n")

y = []
with open("../hex/output_signal.hex", "r") as file:
    for hex in file:
        val = int(hex, 16)
        if val >= 2**15:
            val -= 2**16
        val /= 2**15
        y.append(val)

plt.figure()
plt.plot(t, y)
plt.savefig("../docs/output_time_domain.png")

f = np.array(f)
y = np.array(y)

y_fdomain = np.fft.fft(y)
y_fdomain = np.fft.fftshift(y_fdomain)
y_fdomain = np.absolute(y_fdomain)

plt.figure()
plt.plot(f, y_fdomain)
plt.savefig("../docs/output_frequency_domain.png")

plt.show()








