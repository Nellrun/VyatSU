from PIL import Image

# img = Image.open("img.png")
img = Image.open("sound_sized.png")

# img.save("simped.png")

width, height = img.size

res = []
out = ""
for y in range(0, height):
	for x in range(0, width):
		# print(img.getpixel((x, y)))
		r, g, b, a = img.getpixel((x, y))

		if (g > 200) and ((r < 200) or (b < 200)):
			out = "01" + out
		elif (r > 200) and ((g < 200) or (b < 200)):
			out = "10" + out
		elif (r > 250) and (g > 250) and (b > 250):
			out = "11" + out
		else:
			out = "00" + out

		# if (g > 200) and ((r < 200) or (b < 200)):
		# 	out += "01"
		# elif (r > 200) and ((g < 200) or (b < 200)):
		# 	out += "10"
		# elif (r > 250) and (g > 250) and (b > 250):
		# 	out += "11"
		# else:
		# 	out += "00"

		# if (r > g) and (r > b):
		# 	out = "10" + out
		# elif (g > r) and (g > b):
		# 	out = "01" + out
		# elif (r == 255) and (g == 255) and (b == 255):
		# 	out = "11" + out
		# else:
		# 	out = "00" + out

		# if img.getpixel((x, y)) == 255:
		# 	out += "11"
		# else:
		# 	out += "00"

		if x % 4 == 3:
			res.append(str(int(out, 2)))
			out = ""

		# xs = x * 4

		# out = ""
		# for i in range(0, 4):
		# 	if img.getpixel((xs + i, y)) == 255:
		# 		out += "00"
		# 	else:
		# 		out += "11"
		# res.append(str(int(out, 2)))

for i in res:
	print("db {}".format(i))
# print(",".join(res))