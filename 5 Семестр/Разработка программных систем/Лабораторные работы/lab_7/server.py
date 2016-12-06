#!/usr/bin/python3

from Crypto.Cipher import AES
from xmlrpc.server import SimpleXMLRPCServer
from xmlrpc.server import SimpleXMLRPCRequestHandler
import socket
import sys
import json
import urllib.request

def printError(errorText):
    print(errorText)
    exit(0)

def readConfig(path):
    cfg = {}

    keyWords = ["key", "iv", "serverIP", "serverPort"]

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
    d = aes.decrypt(data.data).decode("UTF-8")

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

    # print(req)

    # print(d)
    #
    # url = d.split("\n")[0]
    #
    # if ("http://" in url):
    #     req = urllib.request.Request(url.split(" ")[1])
    #     print(url.split(" ")[1])
    # else:
    #     req = urllib.request.Request("http://" + host + url.split(" ")[1])
    #     print("http://" + host + url.split(" ")[1])
    #
    # for line in d.split("\r\n")[1:]:
    #     if (":" in line) and (not "Accept-Encoding:" in line):
    #         h = line.split(":")
    #
    #         # print(h[0], h[1:])
    #         req.add_header(h[0], "".join(h[1:]))

    # data = urllib.request.urlopen(req).read()

    # print(data)

    # return aes.encrypt(data.encode("UTF-8"))


# DESTIP = ""
# DESTPORT = 8081
# KEY = b'\xf4r:\xe3\xaf\xca\x1d\xcc%\xe1\xe4).#=\xe1\x1eF\x9d\x94\x83\xd24\xa7\xa0\xc6\x15\xfb\xc0$\xe6H'
# IV = b'u\xba\xea\x8d\x969x5;\x0e\x17be\xaf\x9c\x16'

if len(sys.argv) > 1:
    cfg = readConfig(sys.argv[1])
else:
    printError("server.py <config file>")

KEY = hexToBinStr(cfg["key"])
IV = hexToBinStr(cfg["iv"])

aes = AES.new(KEY, AES.MODE_CFB, IV)

try:
    server = SimpleXMLRPCServer((cfg["serverIP"], int(cfg["serverPort"])),
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
