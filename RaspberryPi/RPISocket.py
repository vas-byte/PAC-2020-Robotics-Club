#!/usr/bin/env python

import asyncio
import serial

import websockets

ser = serial.Serial('/dev/ttyACM0', 9600)

intensity = "1"

async def hello(websocket, path):
    global intensity
    data = await websocket.recv()


    if data == "rf": #reach forward
        print(data)
        toWrite = intensity + 'u\n'
        ser.write(toWrite.encode(encoding = 'UTF-8'))
    elif data == "rb": #reach back
        print(data)
        toWrite = intensity + 'd\n'
        ser.write(toWrite.encode(encoding = 'UTF-8'))
    elif data == "bl": #base left
        print(data)
        toWrite = intensity + 'l\n'
        ser.write(toWrite.encode(encoding = 'UTF-8'))
    elif data == "br": #base right
        print(data)
        toWrite = intensity + 'r\n'
        ser.write(toWrite.encode(encoding = 'UTF-8'))
    elif data == "ef":  # shoulder forwards
        print(data)
        toWrite = intensity + 'f\n'
        ser.write(toWrite.encode(encoding='UTF-8'))
    elif data == "eb":  # shoulder back
        print(data)
        toWrite = intensity + 'b\n'
        ser.write(toWrite.encode(encoding='UTF-8'))
    elif data == "rl":  # rotate wrist left
        print(data)
        toWrite = intensity + 'i\n'
        ser.write(toWrite.encode(encoding='UTF-8'))
    elif data == "rr":  # rotate wrist right
        print(data)
        toWrite = intensity + 'j\n'
        ser.write(toWrite.encode(encoding='UTF-8'))

    elif data == "wf":  # wrist forward
        print(data)
        toWrite = intensity + 'q\n'
        ser.write(toWrite.encode(encoding='UTF-8'))
    elif data == "wb":  # wrist back
        print(data)
        toWrite = intensity + 'w\n'
        ser.write(toWrite.encode(encoding='UTF-8'))
    elif data == "co":  # claw open
        print(data)
        toWrite = intensity + 'y\n'
        ser.write(toWrite.encode(encoding='UTF-8'))
    elif data == "cc":  # claw closed
        print(data)
        toWrite = intensity + 'z\n'
        ser.write(toWrite.encode(encoding='UTF-8'))
    else:
        intensity = data
        print(intensity)
        #ser.write(b'{}'.__format__(f'{intensity}'))





start_server = websockets.serve(hello, '192.168.2.128', 1234)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
