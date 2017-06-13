#pragma once
#include <iostream>
#include <stdlib.h>
#include <intrin.h>
#include <malloc.h>
#include <omp.h>

namespace matrix {

	struct Matrix
	{
		float** value;
		int lines;
		int cols;
	};

	typedef float mapFunc(float arg);

	Matrix* zeros(int lines, int cols, float);
	Matrix* ones(int lines, int cols, float);
	Matrix* randoms(int lines, int cols, float min, float max, int seed);

	template <typename t>
	Matrix* mul(Matrix* a, t b, int clr);

	template <typename t>
	Matrix* sse_mul(Matrix* a, t b, int clr);

	Matrix* sse_sum(Matrix* a, Matrix* b, int clear);
	Matrix* sse_sub(Matrix* a, Matrix* b, int clear);
	Matrix* sse_matmul(Matrix* a, Matrix* b, int clear);

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


	Matrix* sse_sum(Matrix* a, Matrix* b, int clr=3) {
		Matrix* m;

		if (clr & 1) m = a;
		else if (clr & 2) m = b;
		else m = zeros(a->lines, a->cols, 0);

//#pragma omp parallel for
		for (int i = 0; i < a->lines; i++) {
			int len = round(a->cols / 4);
			__m128* ptr_a = (__m128*) a->value[i];
			__m128* ptr_b = (__m128*) b->value[i];
			float* m_ptr = m->value[i];
			for (int i = 0; i < len; i++, ptr_a++, ptr_b++, m_ptr += 4) {
				_mm_store_ps(m_ptr, _mm_add_ps(*ptr_a, *ptr_b));
			}
		}

		if ((clr & 1) && (clr & 2)) {
			clear(b);
		}

		return m;
	}
	
	Matrix* sse_sub(Matrix* a, Matrix* b, int clr=3) {
		Matrix* m;

		if (clr & 1) m = a;
		else if (clr & 2) m = b;
		else m = zeros(a->lines, a->cols, 0);
//#pragma omp parallel for
		for (int i = 0; i < a->lines; i++) {
			int len = a->cols / 4;
			//if (a->cols % 4 > 0) len++;
			__m128* ptr_a = (__m128*) a->value[i];
			__m128* ptr_b = (__m128*) b->value[i % b->lines];
			float* m_ptr = m->value[i];
			for (int j = 0; j < len; j++, ++ptr_a, ++ptr_b, m_ptr += 4) {
				_mm_store_ps(m_ptr, _mm_sub_ps(*ptr_a, *ptr_b));
			}

			for (int j = a->cols - (a->cols % 4); j < a->cols; j++) {
				m->value[i][j] = a->value[i][j] - b->value[i % b->lines][j];
			}

		}

		if ((clr & 1) && (clr & 2)) {
			clear(b);
		}

		return m;
	}


	template <typename t>
	Matrix* sse_mul(Matrix* a, t b, int clr=3) {
		Matrix* m;

		float* vec = (float*) _aligned_malloc(4 * sizeof(float), 16);
		vec[0] = b;
		vec[1] = b;
		vec[2] = b;
		vec[3] = b;

		__m128* ptr_b = (__m128*) vec;

		if (clr & 1) m = a;
		else m = zeros(a->lines, a->cols, 0);
//#pragma omp parallel for
		for (int i = 0; i < a->lines; i++) {
			int len = a->cols / 4;
			__m128* ptr_a = (__m128*) a->value[i];
			float* m_ptr = m->value[i];
			for (int j = 0; j < len; j++, ptr_a++, m_ptr += 4) {
				_mm_store_ps(m_ptr, _mm_mul_ps(*ptr_a, *ptr_b));
			}

			for (int j = a->cols - (a->cols % 4); j < a->cols; j++) {
				m->value[i][j] = a->value[i][j] * b;
			}
		}

		_aligned_free(vec);

		return m;
	}


	Matrix* sse_matmul(Matrix* a, Matrix* b, int clr=3) {
		if (a->cols != b->lines) {
			return NULL;
		}

		Matrix* m = zeros(a->lines, b->cols, 0);

		for (int i = 0; i < a->lines; i++) {
			for (int j = 0; j < a->cols; j++) {
				float* vec = (float*)_aligned_malloc(4 * sizeof(float), 16);
				float value = a->value[i][j];
				vec[0] = value;
				vec[1] = value;
				vec[2] = value;
				vec[3] = value;

				__m128* a_ptr = (__m128*) vec;
				__m128* b_ptr = (__m128*) b->value[j];
				__m128* m_ptrv = (__m128*) m->value[i];
				float* m_ptr = m->value[i];

				int len = b->cols / 4;
				for (int k = 0; k < len + 1; k++, b_ptr++, m_ptrv++, m_ptr += 4) {
					_mm_store_ps(m_ptr, _mm_add_ps(*m_ptrv, _mm_mul_ps(*a_ptr, *b_ptr)));
				}
				_aligned_free(vec);
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

	bool cmp(Matrix* a, Matrix* b) {
		for (int i = 0; i < a->lines; i++) {
			for (int j = 0; j < a->cols; j++) {
				if (a->value[i][j] != b->value[i][j]) return false;
			}
		}

		return true;
	}


	Matrix* zeros(int lines, int cols, float num=0) {
		Matrix* m = new Matrix();
		m->lines = lines;
		m->cols = cols;

		m->value = new float*[lines];
		for (int i = 0; i < lines; i++) {
			//m->value[i] = new float[cols]
			m->value[i] = (float*) _aligned_malloc(cols * sizeof(float), 16);
			//aligned_allk
			//align_alloc((void**)&m->value[i], 16, cols * sizeof(float));
			for (int j = 0; j < cols; j++) {
				m->value[i][j] = num;
			}
		}

		return m;
	}

	Matrix* ones(int lines, int cols, float num=1) {
		return zeros(lines, cols, num);
	}

	Matrix* randoms(int lines, int cols, float min=-1, float max=1, int seed=0) {
		Matrix* m = new Matrix();
		m->lines = lines;
		m->cols = cols;

		srand(seed);

		m->value = new float*[lines];
		for (int i = 0; i < lines; i++) {
			m->value[i] = (float*)_aligned_malloc(cols * sizeof(float), 16);
			for (int j = 0; j < cols; j++) {
				m->value[i][j] = ((float) rand() / RAND_MAX) * (abs(max) + abs(min)) + min;
			}
		}

		return m;
	}

	template <typename t>
	Matrix* mul(Matrix* a, t b, int clr=3) {
		Matrix* m = zeros(a->lines, a->cols);

//#pragma omp parallel for
		for (int i = 0; i < a->lines; i++) {
//#pragma omp parallel for
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

		Matrix* m;

		if (clr & 1) m = a;
		else if (clr & 2) m = b;
		else m = zeros(a->lines, a->cols);

//#pragma omp parallel for
		for (int i = 0; i < a->lines; i++) {
//#pragma omp parallel for
			for (int j = 0; j < a->cols; j++) {
				m->value[i][j] = a->value[i][j] + b->value[i % b->lines][j];
			}
		}

		if ((clr & 1) && (clr & 2)) {
			clear(b);
		}

		return m;
	}

	Matrix* sub(Matrix* a, Matrix* b, int clr=3) {
		if (a->cols != b->cols) {
			return NULL;
		}

		//Matrix* m = zeros(a->lines, a->cols);
		Matrix* m;
		if (clr & 1) m = a;
		else if (clr & 2) m = b;
		else m = zeros(a->lines, a->cols);

//#pragma omp parallel for
		for (int i = 0; i < a->lines; i++) {
//#pragma omp parallel for
			for (int j = 0; j < a->cols; j++) {
				m->value[i][j] = a->value[i][j] - b->value[i % b->lines][j];
			}
		}

		//if (clr & 1) {
		//	clear(a);
		//}

		//if (clr & 2) {
		//	clear(b);
		//}

		if ((clr & 1) && (clr & 2)) {
			clear(b);
		}

		return m;
	}

	Matrix* mul(Matrix* a, Matrix* b, int clr=3) {
		if (a->cols != b->cols) {
			return NULL;
		}

		//Matrix* m = zeros(a->lines, a->cols);

		Matrix* m;
		if (clr & 1) m = a;
		else if (clr & 2) m = b;
		else m = zeros(a->lines, a->cols);

//#pragma omp parallel for
		for (int i = 0; i < a->lines; i++) {
//#pragma omp parallel for
			for (int j = 0; j < a->cols; j++) {
				m->value[i][j] = a->value[i][j] * b->value[i % b->lines][j];
			}
		}

		//if (clr & 1) {
		//	clear(a);
		//}

		//if (clr & 2) {
		//	clear(b);
		//}

		if ((clr & 1) && (clr & 2)) {
			clear(b);
		}

		return m;
	}

	Matrix* matmul(Matrix* a, Matrix* b, int clr=3) {
		if (a->cols != b->lines) {
			return NULL;
		}

		Matrix* m = zeros(a->lines, b->cols);

//#pragma omp parallel for
		for (int k = 0; k < b->cols; k++) {
//#pragma omp parallel for
			for (int i = 0; i < a->lines; i++) {
//#pragma omp parallel for
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
			//delete[] a->value[i];
			_aligned_free(a->value[i]);
		}
		delete[] a->value;
		delete a;
	}
}