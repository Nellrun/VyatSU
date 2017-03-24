#pragma once

class Map
{
public:
	int* map;
	int lines;
	int cols;
public:
	Map(int lines, int cols) {
		this->map = new int[lines*cols];
		this->lines = lines;
		this->cols = cols;
	}

	int getLines() {
		return this->lines;
	}

	int getCols() {
		return this->cols;
	}

	int find(int n) {
		for (int i = 0; i < lines * cols; ++i) {
			if (map[i] == n) return i;
		}
		return  -1;
	}

	Map* shift(int angle) {
		if ((angle < 0) || (angle > 3)) return this;

		int len = lines * cols;
		Map* mapc = new Map(lines, cols);

		int ind = 0;

		for (int i = 0; i < len; ++i) {
			mapc->map[i] = map[i];
			if (map[i] == 0) ind = i;
		}

		switch (angle) {
		case 0: {
			mapc->map[ind] = mapc->map[ind - cols];
			mapc->map[ind - cols] = 0;
			break;
		}
		case 1: {
			mapc->map[ind] = mapc->map[ind + 1];
			mapc->map[ind + 1] = 0;
			break;
		}
		case 2: {
			mapc->map[ind] = mapc->map[ind + cols];
			mapc->map[ind + cols] = 0;
			break;
		}
		case 3: {
			mapc->map[ind] = mapc->map[ind - 1];
			mapc->map[ind - 1] = 0;
			break;
		}
		}
		return mapc;
	}
};