#pragma once
#include "Matrix.h"

using namespace matrix;

typedef double lFunc(int inter);

double sigmoid(double a) {
	return 1.0 / (1.0 + exp(-a));
}

double lin(double a) {
	return a > 0 ? 1 : 0;
}

double th(double a) {
	return (tanh(a) + 1) / 2;
}

double a1(int i) {
	return 1.0 / i;
}

class LogisticRegression
{

private:
	Matrix* W;
	Matrix* b;
	mapFunc* activate;
	lFunc* learnCoeff;

public:
	LogisticRegression(int features, int classes, mapFunc* activ, lFunc* learnCoeff) {
		this->W = randoms(features, classes);
		this->b = randoms(1, classes);
		this->activate = activ;
		this->learnCoeff = learnCoeff;
	}
	~LogisticRegression();


	Matrix* predict(Matrix* X) {
		return map(sum(matmul(X, W, false), b, false), *this->activate);
	}

	void fit(Matrix* X, Matrix* Y, int epoch=10) {
		for (int e = 0; e < epoch; e++) {
			for (int i = 0; i < X->lines; i++) {
				Matrix* x = getLine(X, i);
				Matrix* y = getLine(Y, i);
				Matrix* d = sub(this->predict(x), y, 0);
				Matrix* t_x = transpose(x, 0);
				this->W = sub(this->W, mul(matmul(t_x, d, 1), 1 / (e + 1)));
				this->b = sub(this->b, mul(matmul(ones(1, x->lines), d), learnCoeff(e + 1)));
				//clear(t_x);
				clear(x);
				clear(y);
			}
		}
		//less(X, y);
	}

	void less(Matrix* X, Matrix* y) {
		Matrix* h = predict(X);
		Matrix* one = ones(y->lines, y->cols);

		Matrix* l = matmul(transpose(mul(y, -1)), map(h, log));
		Matrix* r = matmul(transpose(sub(one, y)), sub(one, map(h, log)));
		Matrix* res = mul(sub(l, r), 1 / y->lines);

		print(res);
	}
};
