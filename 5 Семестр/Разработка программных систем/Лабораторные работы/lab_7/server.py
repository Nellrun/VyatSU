#!/usr/bin/python3

from Crypto.Cipher import AES
from xmlrpc.server import SimpleXMLRPCServer
from xmlrpc.server import SimpleXMLRPCRequestHandler
import xmlrpc.client
import socket
import sys
import json
import urllib.request

def printError(errorText):
    print(errorText)
    exit(0)

def readConfig(path):
    cfg = {}

    keyWords = ["key", "iv", "clientIP", "clientPort", "serverIP", "serverPort"]

    try:
        with open(path, "r") as f:
            cfg = json.load(f)
    except:
        printError("Ошибочный файл")

    f.close()

    for key in keyWords:
        if not(key in cfg):
            printError("В файле конфиругации не определенно поле `%(keyName)s`"%{"keyName": key})

    return cfg

def hexToBinStr(h):
    try:
        return bytes([int(i, 16) for i in h[::3]])
    except:
        printError("Не удалось получить данные из файла, возможно они поврежденны")

class RequestHandler(SimpleXMLRPCRequestHandler):
    rpc_paths = ('/RPC2',)

def sendData(data, host):
    d = aes.decrypt(data.data)

    if SERVER_PORT and SERVER_IP:
        try:
            targetServer = xmlrpc.client.ServerProxy("http://" + SERVER_IP+ ":" + str(SERVER_PORT))
        except:
            printError("Неверно задана конфигурация serverIP и serverPort")
	
	return	aes.encrypt(targetServer.sendData(d, host))

    d = d.decode("UTF-8")

    req = ""

    for line in d.split("\r\n"):
        if not "Accept-Encoding:" in line:
            req += line + "\r\n"

    print(req)

    s = socket.socket()
    s.connect((host, 80))

    s.send(req.encode("UTF-8"))

    req = b''
    data = s.recv(1024)
    s.settimeout(1)
    while data:
        req += data
        try:
            data = s.recv(1024)
        except socket.error:
            break

    return aes.encrypt(req)


if len(sys.argv) > 1:
    cfg = readConfig(sys.argv[1])
else:
    printError("server.py <config file>")

KEY = hexToBinStr(cfg["key"])
IV = hexToBinStr(cfg["iv"])
SERVER_IP = cfg["serverIP"]
SERVER_PORT = cfg["serverPort"]

aes = AES.new(KEY, AES.MODE_CFB, IV)

try:
    server = SimpleXMLRPCServer((cfg["clientIP"], int(cfg["clientPort"])),
                                requestHandler=RequestHandler,
                                allow_none=True)
except:
    printError("Неверно заданые поля `ServerIP` и `ServerPort`")

server.register_introspection_functions()
server.register_function(sendData)

print("Сервер успешно запущен")
print("IP:", "0.0.0.0" if cfg["serverIP"] == "" else cfg["serverIP"])
print("Port:", cfg["serverPort"])
server.serve_forever()
