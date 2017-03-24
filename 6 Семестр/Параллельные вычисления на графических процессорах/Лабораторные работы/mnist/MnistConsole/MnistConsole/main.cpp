#include "MnistReader.h"
#include "Matrix.h"
#include "LogisticRegression.h"

using namespace matrix;

float f(float a) {
	return a*a;
}

int main() {
	MnistReader* mr = new MnistReader("./trainBase/images.idx3-ubyte", "./trainBase/labels.idx1-ubyte");
	
	Matrix* X = zeros(100, 28 * 28);
	Matrix* Y = zeros(100, 10);
	for (int i = 0; i < 100; i++) {
		X->value[i] = mr->getMatrix();
		Y->value[i][mr->label] = 1;
		mr->next();
	}

	Matrix* x = getLine(X, 0);
	Matrix* y = getLine(Y, 0);
	
	LogisticRegression* lg = new LogisticRegression(28 * 28, 10, sigmoid, a1);
	for (int i = 0; i < 100; i++)
	{
		lg->fit(X, Y);
	}

	Matrix* pred = getMax(lg->predict(X));
	Matrix* ans = getMax(Y);

	int k = 0;
	for (int i = 0; i < pred->lines; i++) {
		if (pred->value[i][0] == ans->value[i][0]) k++;
	}

	std::cout << k << "/" << pred->lines << " -> " << (double) k / pred->lines * 100 << "%" << std::endl;

	system("pause");

	return 0;
}