#pragma once
#include <cstdlib>
#include <iostream>

namespace matrix {

	struct Matrix
	{
		double** value;
		int lines;
		int cols;
	};

	typedef double mapFunc(double arg);

	Matrix* zeros(int lines, int cols, double);
	Matrix* ones(int lines, int cols, double);
	Matrix* randoms(int lines, int cols, double min, double max, int seed);

	template <typename t>
	Matrix* mul(Matrix* a, t b, int clear);

	Matrix* sum(Matrix* a, Matrix* b, int clear);
	Matrix* sub(Matrix* a, Matrix* b, int clear);
	Matrix* mul(Matrix* a, Matrix* b, int clear);
	Matrix* matmul(Matrix* a, Matrix* b, int clear);

	Matrix* transpose(Matrix* a, int clear);

	Matrix* map(Matrix* a, mapFunc f, int clear);
	Matrix* getLine(Matrix* a, int line);
	Matrix* getMax(Matrix* a);

	Matrix* print(Matrix* a);
	void clear(Matrix* a);


	Matrix* zeros(int lines, int cols, double num=0) {
		Matrix* m = new Matrix();
		m->lines = lines;
		m->cols = cols;

		m->value = new double*[lines];
		for (int i = 0; i < lines; i++) {
			m->value[i] = new double[cols];
			for (int j = 0; j < cols; j++) {
				m->value[i][j] = num;
			}
		}

		return m;
	}

	Matrix* ones(int lines, int cols, double num=1) {
		return zeros(lines, cols, num);
	}

	Matrix* randoms(int lines, int cols, double min=-1, double max=1, int seed=0) {
		Matrix* m = new Matrix();
		m->lines = lines;
		m->cols = cols;

		srand(seed);

		m->value = new double*[lines];
		for (int i = 0; i < lines; i++) {
			m->value[i] = new double[cols];
			for (int j = 0; j < cols; j++) {
				m->value[i][j] = ((double) rand() / RAND_MAX) * (abs(max) + abs(min)) + min;
			}
		}

		return m;
	}

	template <typename t>
	Matrix* mul(Matrix* a, t b, int clr=3) {
		Matrix* m = zeros(a->lines, a->cols);

		for (int i = 0; i < a->lines; i++) {
			for (int j = 0; j < a->cols; j++) {
				m->value[i][j] = a->value[i][j] * b;
			}
		}

		if (clr & 1 == 1) {
			clear(a);
		}

		return m;
	}

	Matrix* sum(Matrix* a, Matrix* b, int clr=3) {
		if (a->cols != b->cols) {
			return NULL;
		}

		Matrix* m = zeros(a->lines, a->cols);

		for (int i = 0; i < a->lines; i++) {
			for (int j = 0; j < a->cols; j++) {
				m->value[i][j] = a->value[i][j] + b->value[i % b->lines][j];
			}
		}

		if (clr & 1 == 1) {
			clear(a);
		}

		if (clr & 2 == 1) {
			clear(b);
		}

		return m;
	}

	Matrix* sub(Matrix* a, Matrix* b, int clr=3) {
		if (a->cols != b->cols) {
			return NULL;
		}

		Matrix* m = zeros(a->lines, a->cols);

		for (int i = 0; i < a->lines; i++) {
			for (int j = 0; j < a->cols; j++) {
				m->value[i][j] = a->value[i][j] - b->value[i % b->lines][j];
			}
		}

		if (clr & 1) {
			clear(a);
		}

		if (clr & 2) {
			clear(b);
		}

		return m;
	}

	Matrix* mul(Matrix* a, Matrix* b, int clr=3) {
		if (a->cols != b->cols) {
			return NULL;
		}

		Matrix* m = zeros(a->lines, a->cols);

		for (int i = 0; i < a->lines; i++) {
			for (int j = 0; j < a->cols; j++) {
				m->value[i][j] = a->value[i][j] * b->value[i % b->lines][j];
			}
		}

		if (clr & 1) {
			clear(a);
		}

		if (clr & 2) {
			clear(b);
		}

		return m;
	}

	Matrix* matmul(Matrix* a, Matrix* b, int clr=3) {
		if (a->cols != b->lines) {
			return NULL;
		}

		Matrix* m = zeros(a->lines, b->cols);

		for (int k = 0; k < b->cols; k++) {
			for (int i = 0; i < a->lines; i++) {
				for (int j = 0; j < a->cols; j++) {
					m->value[i][k] += a->value[i][j] * b->value[j][k];
				}
			}
		}

		if (clr & 1) {
			clear(a);
		}

		if (clr & 2) {
			clear(b);
		}

		return m;
	}

	Matrix* transpose(Matrix* a, int clr=3) {
		Matrix* m = zeros(a->cols, a->lines);

		for (int i = 0; i < a->lines; i++) {
			for (int j = 0; j < a->cols; j++) {
				m->value[j][i] = a->value[i][j];
			}
		}

		if (clr & 1) {
			clear(a);
		}

		return m;
	}

	Matrix* map(Matrix* a, mapFunc f, int clr=3) {
		Matrix* m = zeros(a->lines, a->cols);

		for (int i = 0; i < a->lines; i++) {
			for (int j = 0; j < a->cols; j++) {
				m->value[i][j] = f(a->value[i][j]);
			}
		}

		if (clr & 1) {
			clear(a);
		}

		return m;
	}

	Matrix* getLine(Matrix* a, int line) {
		Matrix* m = zeros(1, a->cols);

		for (int i = 0; i < a->cols; i++) {
			m->value[0][i] = a->value[line][i];
		}

		return m;
	}

	Matrix* getMax(Matrix* a) {
		Matrix* m = zeros(a->lines, 1);

		for (int i = 0; i < a->lines; i++){
			int k = 0;
			for (int j = 1; j < a->cols; j++) {
				if (a->value[i][k] < a->value[i][j]) k = j;
			}
			m->value[i][0] = k;
		}

		return m;
	}

	Matrix* print(Matrix* a) {
		for (int i = 0; i < a->lines; i++) {
			for (int j = 0; j < a->cols; j++) {
				std::cout << a->value[i][j] << "\t";
			}
			std::cout << std::endl;
		}
		std::cout << std::endl;

		return a;
	}

	void clear(Matrix* a) {
		for (int i = 0; i < a->lines; i++) {
			delete a->value[i];
		}
		delete a->value;
		delete a;
	}
}