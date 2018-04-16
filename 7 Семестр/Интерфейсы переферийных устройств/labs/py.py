for i in range(1, 31):
	with open("{:04d}".format(i) + ".task", "r") as f:
		f.seek(0x26)
		print(f.read(5))