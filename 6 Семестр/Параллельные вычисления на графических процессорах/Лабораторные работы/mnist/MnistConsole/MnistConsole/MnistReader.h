#pragma once
#include <iostream>
#include <fstream>

using namespace std;

template <typename t>
void getData(ifstream &f, t &data) {

	data = 0;
	for (int i = sizeof(data) - 1; i >= 0; i--) {
		data |= f.get() << (8 * i);
	}
}

class MnistReader
{
public:

	ifstream file;
	ifstream labelFile;
	int count;
	unsigned char image[28][28];
	unsigned char label;


	MnistReader(char* filename, char* labelFilename) {
		file.open(filename, ios::binary | ios::in);
		file.seekg(4);
		getData(file, count);
		file.seekg(16);

		labelFile.open(labelFilename, ios::binary | ios::in);
		labelFile.seekg(8);

		next();
	}

	~MnistReader() {
		file.close();
		labelFile.close();
	};

	void next() {
		if (count <= 1) reset();

		for (int y = 0; y < 28; y++) {
			for (int x = 0; x < 28; x++) {
				image[x][y] = file.get();// +((float)rand() / RAND_MAX) * 1.5;
			}
		}

		label = labelFile.get();
		count--;
	}

	void reset() {
		file.seekg(4);
		getData(file, count);
		file.seekg(16);
		labelFile.seekg(8);

	}

	unsigned char* getImage() {
		unsigned char* arr = new unsigned char[28 * 28];

		for (int i = 0; i < 28 * 28; i++)
		{
			arr[i] = image[i / 28][i % 28];
		}

		return arr;
	}

	float* getMatrix() {
		float* arr = new float[28 * 28];

		for (int i = 0; i < 28 * 28; i++)
		{
			arr[i] = (float) image[i / 28][i % 28] / 255;
		}

		return arr;
	}

private:

};