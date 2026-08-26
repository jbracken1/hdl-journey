# sends one test sample (0x7FFF) to the board over uart and prints back what the fir filter returns
import serial
import time

with serial.Serial('COM12', baudrate=9600, bytesize=serial.EIGHTBITS, parity=serial.PARITY_NONE, timeout=5) as ser:
    ser.reset_input_buffer()
    ser.write(bytes([0x7F, 0xFF]))  # Send 0x7FFF
    # time.sleep(0.01)
    high = ser.read(1)
    low = ser.read(1)
    if len(high) > 0 and len(low) > 0:
        print(f"Got: {high[0]:02x} {low[0]:02x}")
    else:
        print("No response")