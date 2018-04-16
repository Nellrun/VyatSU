from PIL import Image

img = Image.open("lab4.png")

width, height = img.size

res = []
out = ""
for d in range(0, 4):
	for x in range(0, width):
		out = ""

		for y in range(0 + 8*d, 8 + 8*d):
			r, g, b = img.getpixel((x, y))

			if (r > 250) and (g > 250) and (b > 250):
				out += "0"
			else:
				out += "1"

		res.append(str(int(out, 2)))

	print("db 1bh, 2ah, 0, 32, 0")
	print("db " + ", ".join(res))
	print("db 0Ah, 0Dh")
	res = []

# for i in res:
# 	print("db {}".format(i))
# print(",".join(res))