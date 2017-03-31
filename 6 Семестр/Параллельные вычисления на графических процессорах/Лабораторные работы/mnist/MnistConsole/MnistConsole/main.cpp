#include "MnistReader.h"
#include "Matrix.h"
#include "LogisticRegression.h"

#define TRAIN 5000
#define TEST 1000

using namespace matrix;

float f(float a) {
	return a*a;
}

int main() {
	MnistReader* mr = new MnistReader("./trainBase/images.idx3-ubyte", "./trainBase/labels.idx1-ubyte");
	
	Matrix* X = zeros(TRAIN, 28 * 28);
	Matrix* Y = zeros(TRAIN, 10);
	for (int i = 0; i < TRAIN; i++) {
		X->value[i] = mr->getMatrix();
		Y->value[i][mr->label] = 1;
		mr->next();
	}
	
	LogisticRegression* lg = new LogisticRegression(28 * 28, 10, sigmoid, a1);
	//LogisticRegression* lg = new LogisticRegression(28 * 28, 10, lin, a1);
	//LogisticRegression* lg = new LogisticRegression(28 * 28, 10, th, a1);
	
	lg->fit(X, Y, 1);

	//Matrix* pred = getMax(lg->predict(X));
	//Matrix* ans = getMax(Y);

	clear(X);
	clear(Y);

	//delete mr;

	//int k = 0;
	//for (int i = 0; i < pred->lines; i++) {
	//	if (pred->value[i][0] == ans->value[i][0]) k++;
	//}


	//mr = new MnistReader("./trainBase/test-images", "./trainBase/test-labels");
	X = zeros(TEST, 28 * 28);
	Y = zeros(TEST, 10);
	for (int i = 0; i < TEST; i++) {
		X->value[i] = mr->getMatrix();
		Y->value[i][mr->label] = 1;
		mr->next();
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