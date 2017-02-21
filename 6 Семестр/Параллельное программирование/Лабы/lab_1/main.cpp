#include <iostream>
#include <cstdlib>

int** generateMap(int w, int h) {
	int** map = new int*[h];
	for (int i = 0; i < h; ++i) {
		map[i] = new int[w];
		for (int j = 0; j < w; ++j) {
			if ( (i != h - 1) || (j != w - 1) ) {
				map[i][j] = i * w + j + 1;
			}
			else {
				map[i][j] = 0;
			}
		}
	}

	for (int i = 0; i < h; ++i) {
		for (int j = 0; j < w; ++j) {
			int l = rand() % h;
			int c = rand() % w;
			int m = map[l][c];
			map[l][c] = map[i][j];
			map[i][j] = m;
		}
	}

	return map;
}

void printMap(int** map, int w, int h) {
	for (int i = 0; i < h; ++i) {
		for (int j = 0; j < w; ++j) {
			std::cout << map[i][j] << '\t';
		}
		std::cout << std::endl;
	}
}


int main(int argc, char const *argv[]) {
	int lines, columns;
	int** map;

	std::cout << "Write matrix's dimensions: ";
	std::cin >> lines >> columns;

	map = generateMap(lines, columns);
	printMap(map, lines, columns);

	return 0;
}