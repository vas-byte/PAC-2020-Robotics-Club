#!/usr/bin/env python

import asyncio
import serial

import websockets

ser = serial.Serial('/dev/ttyACM0', 9600)

intensity = "1"

async def hello(websocket, path):
    global intensity
    data = await websocket.recv()


    if data == "up":
        print(data)
        toWrite = intensity + 'u\n'
        ser.write(toWrite.encode(encoding = 'UTF-8'))
    elif data == "down":
        print(data)
        toWrite = intensity + 'd\n'
        ser.write(toWrite.encode(encoding = 'UTF-8'))
    elif data == "left":
        print(data)
        toWrite = intensity + 'l\n'
        ser.write(toWrite.encode(encoding = 'UTF-8'))
    elif data == "right":
        print(data)
        toWrite = intensity + 'r\n'
        ser.write(toWrite.encode(encoding = 'UTF-8'))
    else:
        intensity = data
        print(intensity)
        #ser.write(b'{}'.__format__(f'{intensity}'))





start_server = websockets.serve(hello, '192.168.2.128', 1234)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
