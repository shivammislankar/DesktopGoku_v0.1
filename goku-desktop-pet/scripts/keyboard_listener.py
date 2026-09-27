import socket
from pynput import keyboard

HOST = "127.0.0.1"
PORT = 5000

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect((HOST, PORT))

print("Connected to Godot")

def on_press(key):
    try:

        if hasattr(key, "char"):
            if key.char is not None:
                client.send(b"KEY\n")
                return

        if key in [
            keyboard.Key.space,
            keyboard.Key.enter,
            keyboard.Key.backspace
        ]:
            client.send(b"KEY\n")

        if key in [
            keyboard.Key.alt_l,
            keyboard.Key.alt_gr
        ]:
            client.send(b"ALT\n")

    except Exception as e:
        print(e)

listener = keyboard.Listener(on_press=on_press)
listener.start()

print("Listening...")
listener.join()
