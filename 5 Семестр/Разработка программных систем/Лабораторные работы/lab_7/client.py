import socket
from Crypto.Cipher import AES
import xmlrpc.client
import re
import json
import sys
import urllib.request

def sendData(d, host):
    # d = aes.decrypt(data.data).decode("UTF-8")

    # print(d)

    url = d.split("\r\n")[0]

    print(d)

    if ("http://" in url):
        req = urllib.request.Request(url.split(" ")[1])
        print(url.split(" ")[1])
    else:
        req = urllib.request.Request("http://" + host + url.split(" ")[1])
        print("http://" + host + url.split(" ")[1])

    for line in d.split("\r\n")[1:]:
        if (":" in line) and (not "Accept-Encoding:" in line):
            h = line.split(":")

            # print(h[0], h[1:])
            req.add_header(h[0], "".join(h[1:]))


    data = urllib.request.urlopen(req).read()

    return data

def printError(errorText):
    print(errorText)
    exit(0)

def readConfig(path):
    cfg = {}

    keyWords = ["key", "iv", "serverIP", "serverPort", "clientIP", "clientPort", "whitelist"]

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

if len(sys.argv) > 1:
    cfg = readConfig(sys.argv[1])
else:
    printError("client.py <config file>")

KEY = hexToBinStr(cfg["key"])
IV = hexToBinStr(cfg["iv"])

DESTIP = cfg["serverIP"]
DESTPORT = cfg["serverPort"]
WHITELIST = cfg["whitelist"]
# KEY = b'\xf4r:\xe3\xaf\xca\x1d\xcc%\xe1\xe4).#=\xe1\x1eF\x9d\x94\x83\xd24\xa7\xa0\xc6\x15\xfb\xc0$\xe6H'
# IV = b'u\xba\xea\x8d\x969x5;\x0e\x17be\xaf\x9c\x16'

targetServer = xmlrpc.client.ServerProxy("http://" + DESTIP + ":" + str(DESTPORT))

aes = AES.new(KEY, AES.MODE_CFB, IV)

s = socket.socket()
try:
    s.bind((cfg["clientIP"], int(cfg["clientPort"])))
except:
    printError("Не удалось запустить сервер. Возможно неверно заданы поля `clientIP` и `clientPort`")

s.listen(1)

print("Программа успешно запущена")
print("IP:", "0.0.0.0" if cfg["clientIP"] == "" else cfg["clientIP"])
print("Port:", cfg["clientPort"])
while True:
    conn, addr = s.accept()
    print("Пришли данные от", addr)

    req = b''
    data = conn.recv(1024)
    conn.settimeout(0.1)
    while data:
        req += data
        try:
            data = conn.recv(1024)
        except socket.error:
            break

    try:
        host = re.search("(?<=Host: )(\w|\.)*", data.decode("UTF-8")).group(0)
    except:
        continue

    if host in WHITELIST:
        ans = sendData(data.decode("UTF-8"), host)
    else:
        try:
            msgEncrypt = aes.encrypt(data)
            ans = aes.decrypt(targetServer.sendData(msgEncrypt, host).data)
        except:
            print("ERROR: Сервер не доступен")
            continue

    conn.send(ans)
