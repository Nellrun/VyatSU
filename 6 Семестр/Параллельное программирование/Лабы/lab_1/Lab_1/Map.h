#pragma once

class Map
{
public:
	int* map;
	int lines;
	int cols;
public:
	Map(int lines, int cols);
	Map(int lines, int cols, int* map);
	~Map();

	int getLines();
	int getCols();
	int find(int n);

	Map* shift(int angle, int* zero = 0);
};

// Вывод головоломки
void printMap(Map* map);
Map* ones(int lines, int cols);