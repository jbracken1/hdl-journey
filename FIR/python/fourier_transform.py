# builds a test signal, runs it through a scipy lowpass as a reference, and plots
# a few other filter types (highpass/bandpass/bandstop) for comparison
import numpy as np
import scipy.signal as signal
import matplotlib.pyplot as plt

N = 1000                                            # number of samples
fs = 10000                                          # sample frequency
t = np.arange(0, (N) / fs, 1 / fs)              # time samples where we increase by dt = 1 / fs and get N samples

amplitude_1 = 1.0                                   # amplitude of our signal. needs to be -1 <--> 0.999... 
amplitude_2 = 0.5                                   # amplitude of signal 2 
signal_frequency_1 =  250  
signal_frequency_2 = 15.84375

# test signal
x = 0
for i in range(1,11):
    x += np.cos(2 * np.pi * signal_frequency_1 * t * i)
x = x / np.max(np.abs(x))                           # Normalize to -1 to +1

# time domain plot
plt.figure()
plt.plot(t, x)

# frequency domain plot
f = np.arange(-N/2, N/2) * fs/N                 # frequency range
print(f)
x_fdomain = np.fft.fft(x)
x_fdomain = np.fft.fftshift(x_fdomain)
x_fdomain = np.absolute(x_fdomain)
x_fdomain /= 500

plt.figure()
plt.plot(f, x_fdomain)

lowpass_taps = signal.firwin(63, 750, fs=fs)

x_filtered = signal.lfilter(lowpass_taps, 1.0, x)

plt.figure()
plt.plot(t, x_filtered)
plt.title("signal filtered time")

xfiltered_fdomain = np.fft.fft(x_filtered)
xfiltered_fdomain = np.fft.fftshift(xfiltered_fdomain)
xfiltered_fdomain = np.absolute(xfiltered_fdomain)
xfiltered_fdomain /= 500

plt.figure()
plt.plot(f, xfiltered_fdomain)
plt.title("signal filtered frequency")

y = 0.1 * (np.cos(2 * np.pi * 250 * t) + np.cos(2 * np.pi * 500 * t) + 0.5 * np.cos(2 * np.pi * 750 * t))
plt.figure()
plt.plot(t, y)
plt.title("ideal signal time")

plt.show()


tap_num = 101
freq_cutoff = 1000

# FIR filter tap coefficients plotted in the time domain
# Lowpass
lp_taps = signal.firwin(tap_num, freq_cutoff, fs=10000, pass_zero=True)
tap_index = range(tap_num)
plt.figure()
plt.plot(tap_index, lp_taps)
plt.title("lowpass taps")

# FIR filter tap coefficients plotted in the frequency domain  
lp_taps_f = np.fft.fft(lp_taps, N-1)
lp_taps_f = np.fft.fftshift(lp_taps_f)
lp_taps_f = np.absolute(lp_taps_f)
plt.figure()
plt.plot(f, lp_taps_f)
plt.title("lowpass freq")

print("lowpass tapp sum: " + str(np.sum(lp_taps)))

# Highpass
hp_taps = signal.firwin(tap_num, freq_cutoff, fs=10000, pass_zero=False)
tap_index = range(tap_num)
plt.figure()
plt.plot(tap_index, hp_taps)
plt.title("highpass taps")

# FIR filter tap coefficients plotted in the frequency domain
hp_taps_f = np.fft.fft(hp_taps, N-1)
hp_taps_f = np.fft.fftshift(hp_taps_f)
hp_taps_f = np.absolute(hp_taps_f)
plt.figure()
plt.plot(f, hp_taps_f)
plt.title("highpass freq")

print("highpass tapp sum: " + str(np.sum(hp_taps)))

# bandpass
band_range = [1000,2000]
bp_taps = signal.firwin(tap_num, band_range, fs=10000, pass_zero=False)
tap_index = range(tap_num)
plt.figure()
plt.plot(tap_index, bp_taps)
plt.title("bandpass taps")

bp_taps_f = np.fft.fft(bp_taps, N-1)
bp_taps_f = np.fft.fftshift(bp_taps_f)
bp_taps_f = np.absolute(bp_taps_f)
plt.figure()
plt.plot(f, bp_taps_f)
plt.title("bandpass freq")

print("bandpass tapp sum: " + str(np.sum(bp_taps)))

# bandstop
bs_taps = signal.firwin(tap_num, band_range, fs=10000, pass_zero=True)
tap_index = range(tap_num)
plt.figure()
plt.plot(tap_index, bs_taps)
plt.title("bandstop taps")

bs_taps_f = np.fft.fft(bs_taps, N-1)
bs_taps_f = np.fft.fftshift(bs_taps_f)
bs_taps_f = np.absolute(bs_taps_f)
plt.figure()
plt.plot(f, bs_taps_f)
plt.title("bandstop freq")

print("bandstop tapp sum: " + str(np.sum(bs_taps)))


# average 
average = 30
average_taps = []
for i in range(average):
    average_taps.append(1/average)

np.array(average_taps)
average_taps_f = np.fft.fft(average_taps, N-1)
average_taps_f = np.fft.fftshift(average_taps_f)
# average_taps_f = np.absolute(average_taps_f)
plt.figure()
plt.plot(f, average_taps_f)
plt.title("average freq")

#average alternating
# constant
average_alt_taps = []
for i in range(average):
    average_taps.append(1/average if (i%2==0) else -1/average)

np.array(average_alt_taps)
average_alt_taps_f = np.fft.fft(average_alt_taps, N-1)
average_alt_taps_f = np.fft.fftshift(average_alt_taps_f)
average_alt_taps_f = np.absolute(average_alt_taps_f)
plt.figure()
plt.plot(f, average_alt_taps_f)
plt.title("average alternating freq")



# fake highpass
amount = 51
fake_high = []
for i in range(amount):
    if (i != amount // 2):
        fake_high.append(-1 / (amount-1))
    else:
        fake_high.append(1)
# print(fake_high)
np.array(fake_high)

fh = np.fft.fft(fake_high, N-1)
fh = np.fft.fftshift(fh)
fh = np.absolute(fh)
plt.figure()
plt.plot(f, fh)
plt.title("jacks highpass")


# impulse
impulse = []
for i in range(50):
    if (i != 50 // 2):
        impulse.append(0)
    else:
        impulse.append(2)
np.array(impulse)

imp = np.fft.fft(impulse, N-1)
imp = np.fft.fftshift(imp)
imp = np.absolute(imp)
plt.figure()
plt.plot(f, imp)
plt.title("impulse(All Pass)")

plt.show()








