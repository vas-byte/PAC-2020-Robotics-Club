#!/usr/bin/env python

import asyncio
import serial

import websockets

#ser = serial.Serial('/dev/ttyUSB0', 9600)

async def hello(websocket, path):
    data = await websocket.recv()


    if data == "up":
        print(data)
        #ser.write(b'u')
    elif data == "down":
        print(data)
        # ser.write(b'd')
    elif data == "left":
        print(data)
        # ser.write(b'l')
    elif data == "right":
        print(data)
        # ser.write(b'r')
    else:
        intensity = int(data)
        print(intensity)
        #ser.write(b'{}'.__format__(f'{intensity}'))





start_server = websockets.serve(hello, 'localhost', 1234)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()