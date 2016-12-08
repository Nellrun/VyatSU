#!/usr/bin/python3

import tkinter as tk
from tkinter import filedialog
from tkinter import messagebox
import json

def getClientConfig(root):

    key = b'\xf4r:\xe3\xaf\xca\x1d\xcc%\xe1\xe4).#=\xe1\x1eF\x9d\x94\x83\xd24\xa7\xa0\xc6\x15\xfb\xc0$\xe6H'
    iv = b'u\xba\xea\x8d\x969x5;\x0e\x17be\xaf\x9c\x16'

    return {
        "clientIP": tk.StringVar(root, "127.0.0.1"),
        "clientPort": tk.StringVar(root, "8080"),
        "serverIP": tk.StringVar(root, "127.0.0.1"),
        "serverPort": tk.StringVar(root, "8081"),
        "key": tk.StringVar(root, "".join(map(lambda x: str(hex(x))[2:].zfill(3), bytearray(key)))),
        "iv": tk.StringVar(root, "".join(map(lambda x: str(hex(x))[2:].zfill(3), bytearray(iv))))
    }

    return clientConf

class ClientConfigurator(tk.Tk):
    """docstring for ClientConfigurator."""
    def __init__(self):
        super(ClientConfigurator, self).__init__()
        self.title('Конфигуратор')
        self.geometry("350x475")

        menu = tk.Menu(self)
        menu.add_command(label = "Открыть", command = self.onOpenMenu)
        menu.add_command(label = "Сохранить", command = lambda: self.onSaveButClick(None))

        self.config(menu = menu)

        self.clientConf = getClientConfig(self)

        clientAddressFrame = tk.Frame(self)
        clientAddressFrame.pack(side = "top")

        tk.Label(clientAddressFrame, text = "Адрес клиента").pack(pady = 10, fill = "both")
        tk.Label(clientAddressFrame, text = "IP:").pack(side = "left", padx = 10)
        self.clientIPEntry = tk.Entry(clientAddressFrame, width = 15, textvariable = self.clientConf["clientIP"])
        self.clientIPEntry.pack(side = "left")

        tk.Label(clientAddressFrame, text = "Port:").pack(side = "left", padx = 10)
        self.clientPortEntry = tk.Entry(clientAddressFrame, width = 5, textvariable = self.clientConf["clientPort"])
        self.clientPortEntry.pack(side = "left")


        serverAddressFrame = tk.Frame(self)
        serverAddressFrame.pack(side = "top")

        tk.Label(serverAddressFrame, text = "Адрес сервера").pack(pady = 10, fill = "both")
        tk.Label(serverAddressFrame, text = "IP:").pack(side = "left", padx = 10)
        self.serverIPEntry = tk.Entry(serverAddressFrame, width = 15, textvariable = self.clientConf["serverIP"])
        self.serverIPEntry.pack(side = "left")

        tk.Label(serverAddressFrame, text = "Port:").pack(side = "left", padx = 10)
        self.serverPortEntry = tk.Entry(serverAddressFrame, width = 5, textvariable = self.clientConf["serverPort"])
        self.serverPortEntry.pack(side = "left")

        cryptoFrame = tk.Frame(self)
        cryptoFrame.pack(side = "top", pady = 20)

        cryptoKeyFrame = tk.Frame(cryptoFrame)
        cryptoKeyFrame.pack(side = "top")

        tk.Label(cryptoKeyFrame, text = "Криптография").pack(fill = "both", pady = 10)
        tk.Label(cryptoKeyFrame, text = "Ключ:", width = 7).pack(side = "left", padx = 5)
        self.keyEntry = tk.Entry(cryptoKeyFrame, width = 32, textvariable = self.clientConf["key"])
        self.keyEntry.pack(side = "left")

        cryptoIVFrame = tk.Frame(cryptoFrame)
        cryptoIVFrame.pack(side = "top")

        tk.Label(cryptoIVFrame, text = "Вектор:", width = 7).pack(side = "left", padx = 5)
        self.ivEntry = tk.Entry(cryptoIVFrame, width = 32, textvariable = self.clientConf["iv"])
        self.ivEntry.pack(side = "left")


        whitelistFrame = tk.Frame(self)
        whitelistFrame.pack(side = "top", pady = 20)
        #
        tk.Label(whitelistFrame, text = "Белый список").pack(fill = "both")
        self.whitelistText = tk.Text(whitelistFrame, height = 10)
        self.whitelistText.pack(side = "top", padx = 10)

        self.saveBut = tk.Button(self, text = "Сохранить")
        self.saveBut.bind("<Button-1>", self.onSaveButClick)
        self.saveBut.pack(side = "top")

    def onSaveButClick(self, e):
        r = {}

        for key in self.clientConf:
            r[key] = self.clientConf[key].get()

        r["whitelist"] = list(filter(lambda x: x != "", self.whitelistText.get("1.0", tk.END).split("\n")))

        f = filedialog.asksaveasfile(mode='w')

        if f:
            json.dump(r, f, sort_keys=True, indent=4)

    def onOpenMenu(self):
        f = filedialog.askopenfile()

        if f:
            try:
                r = json.load(f)
            except:
                messagebox.showerror("Ошибка", "Выбран ошибочный файл")
                return

            for key in r:
                try:
                    self.clientConf[key].set(r[key])
                except:
                    continue

            self.whitelistText.delete("1.0", tk.END)
            try:
                self.whitelistText.insert(tk.END, "\n".join(r["whitelist"]))
            except:
                pass


m = ClientConfigurator()
m.mainloop()
