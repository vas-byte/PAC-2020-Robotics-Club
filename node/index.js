const dgram = require("dgram")
const socket = dgram.createSocket({type: 'udp4', reuseAddr: true}); // Create a socket that listens for UDP
const port = 1234 // The port Flutter sends data to
const { SerialPort } = require('serialport')

const serialport = new SerialPort({ path: 'USB SERIAL PORT E.G. /dev/ttyACM0', baudRate: 9600 })

var intensity = "1";

socket.on('message', (msg, info) => { // Upon receiving a message via UDP
    msg = msg.toString()
    switch(msg){
    case "rf":
        var toWrite = intensity + 'u\n'
        serialport.write(toWrite)
        break;
    case "rb":
        var toWrite = intensity + 'd\n'
        serialport.write(toWrite)
        break;
    case "bl":
        var toWrite = intensity + 'l\n'
        serialport.write(toWrite)
        break;
    case "br":
        var toWrite = intensity + 'r\n'
        serialport.write(toWrite)
        break;
    case "ef":
        var toWrite = intensity + 'f\n'
        serialport.write(toWrite)
        break;
    case "eb":
        var toWrite = intensity + 'b\n'
        serialport.write(toWrite)
        break;
    case "rl":
        var toWrite = intensity + 'i\n'
        serialport.write(toWrite)
        break;
    case "rr":
        var toWrite = intensity + 'j\n'
        serialport.write(toWrite)
        break;
    case "wf":
        var toWrite = intensity + 'q\n'
        serialport.write(toWrite)
        break;
    case "wb":
        var toWrite = intensity + 'w\n'
        serialport.write(toWrite)
        break;
    case "co":
        var toWrite = intensity + 'y\n'
        serialport.write(toWrite)
        break;
    case "cc":
        var toWrite = intensity + 'z\n'
        serialport.write(toWrite)
        break;
    default:
        intensity = msg
        break;
   }
   
 });

socket.on('listening', () => { // When the server starts up
    var address = socket.address(); // Listen on the local IPv4 address
    console.log("listening  on :" + address.address + ":" + address.port);
});

socket.bind(port); // Listen on the Flutter reply port (also prohibits other programs from using said port)
