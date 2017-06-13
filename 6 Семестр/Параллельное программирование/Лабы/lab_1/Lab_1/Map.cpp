#include "Map.h"
#include <iostream>

Map::Map(int lines, int cols)
{
	this->map = new int[lines*cols];
	this->lines = lines;
	this->cols = cols;
}

Map::Map(int lines, int cols, int * map)
{
	this->lines = lines;
	this->cols = cols;
	this->map = new int[lines*cols];
	for (int i = 0; i < lines * cols; i++) {
		this->map[i] = map[i];
	}
}

Map::~Map()
{
	delete[] map;
}

int Map::getLines()
{
	return this->lines;
}

int Map::getCols()
{
	return this->cols;
}

int Map::find(int n)
{
	for (int i = 0; i < lines * cols; ++i) {
		if (map[i] == n) return i;
	}
	return  -1;
}

Map * Map::shift(int angle, int * zero)
{
	if ((angle < 0) || (angle > 3)) return this;

	int len = lines * cols;
	Map* mapc = new Map(lines, cols);

	int ind = 0;

	for (int i = 0; i < len; ++i) {
		mapc->map[i] = map[i];
		if (map[i] == 0) ind = i;
	}

	if ((angle == 0) && (ind / cols == 0)) return this;
	if ((angle == 1) && (ind % cols == cols - 1)) return this;
	if ((angle == 2) && (ind / cols == lines - 1)) return this;
	if ((angle == 3) && (ind % cols == 0)) return this;

	switch (angle) {
	case 0: {
		mapc->map[ind] = mapc->map[ind - cols];
		mapc->map[ind - cols] = 0;
		ind = ind - cols;
		break;
	}
	case 1: {
		mapc->map[ind] = mapc->map[ind + 1];
		mapc->map[ind + 1] = 0;
		ind = ind + 1;
		break;
	}
	case 2: {
		mapc->map[ind] = mapc->map[ind + cols];
		mapc->map[ind + cols] = 0;
		ind = ind + cols;
		break;
	}
	case 3: {
		mapc->map[ind] = mapc->map[ind - 1];
		mapc->map[ind - 1] = 0;
		ind = ind - 1;
		break;
	}
	}

	if (zero != 0) *zero = ind;

	return mapc;
}

void printMap(Map * map)
{
		std::cout << std::endl;
		for (int i = 0; i < map->lines; ++i) {
			for (int j = 0; j < map->cols; ++j) {
				std::cout << map->map[i*map->cols + j] << '\t';
			}
			std::cout << std::endl;
		}
}

Map * ones(int lines, int cols)
{
	Map* m = new Map(lines, cols);

	for (int i = 0; i < lines; i++) {
		for (int j = 0; j < cols; j++) {
			if ((i == lines - 1) && (j == cols - 1)) {
				m->map[i * cols + j] = 0;
			}
			else {
				m->map[i * cols + j] = i * cols + j + 1;
			}
		}
	}

	return m;
}
