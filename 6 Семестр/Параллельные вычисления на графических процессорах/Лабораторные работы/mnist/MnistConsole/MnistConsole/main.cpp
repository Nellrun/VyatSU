#include "MnistReader.h"
#include "Matrix.h"
#include "LogisticRegression.h"
#include <ctime>

#define TRAIN 10000
#define TEST 1000
#define EPOCHES 4

using namespace matrix;


int metric(Matrix* Y, Matrix* pred) {
	//Matrix* pred = getMax(lg->predict(X));
	Matrix* ans = getMax(Y);
	Matrix* predMax = getMax(pred);

	int k = 0;
	for (int i = 0; i < pred->lines; i++) {
		if (predMax->value[i][0] == ans->value[i][0]) k++;
	}

	clear(ans);
	clear(predMax);

	return k;
}

float f(float a) {
	return a*a;
}

int main() {
	MnistReader* mr = new MnistReader("./trainBase/images.idx3-ubyte", "./trainBase/labels.idx1-ubyte");
	clock_t t;

	Matrix* X = zeros(TRAIN, 28 * 28);
	Matrix* Y = zeros(TRAIN, 10);
	for (int i = 0; i < TRAIN; i++) {
		X->value[i] = mr->getMatrix();
		Y->value[i][mr->label] = 1;
		mr->next();
	}
	
	LogisticRegression* lgSigm = new LogisticRegression(28 * 28, 10, sigmoid, a0);
	LogisticRegression* lgLin = new LogisticRegression(28 * 28, 10, lin, a0);
	LogisticRegression* lgTh = new LogisticRegression(28 * 28, 10, th, a0);
	LogisticRegression* lgSigmA1 = new LogisticRegression(28 * 28, 10, sigmoid, a1);
	LogisticRegression* lgLinA1 = new LogisticRegression(28 * 28, 10, lin, a1);
	LogisticRegression* lgThA1 = new LogisticRegression(28 * 28, 10, th, a1);
	
	t = clock();
	lgSigm->fit(X, Y, EPOCHES);
	std::cout << "LogReg with Sigmoid." << " fit time = " << (float) (clock() - t) / CLOCKS_PER_SEC << " sec" << std::endl;

	t = clock();
	lgLin->fit(X, Y, EPOCHES);
	std::cout << "LogReg with Linear." << " fit time = " << (float)(clock() - t) / CLOCKS_PER_SEC << " sec" << std::endl;

	t = clock();
	lgTh->fit(X, Y, EPOCHES);
	std::cout << "LogReg with Th." << " fit time = " << (float)(clock() - t) / CLOCKS_PER_SEC << " sec" << std::endl;

	t = clock();
	lgSigmA1->fit(X, Y, EPOCHES);
	std::cout << "LogReg with Sigmoid and learn rate a1." << " fit time = " << (float)(clock() - t) / CLOCKS_PER_SEC << " sec" << std::endl;

	t = clock();
	lgLinA1->fit(X, Y, EPOCHES);
	std::cout << "LogReg with Linear and learn rate a1." << " fit time = " << (float)(clock() - t) / CLOCKS_PER_SEC << " sec" << std::endl;

	t = clock();
	lgThA1->fit(X, Y, EPOCHES);
	std::cout << "LogReg with Th and learn rate a1." << " fit time = " << (float)(clock() - t) / CLOCKS_PER_SEC << " sec" << std::endl;
	

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

	std::cout << "LogReg with Sigmoid." << " Accuracy =  " << (float)metric(Y, lgSigm->predict(X)) / X->lines * 100 << "%" << std::endl;
	std::cout << "LogReg with Linear." << " Accuracy = " << (float)metric(Y, lgLin->predict(X)) / X->lines * 100 << "%" << std::endl;
	std::cout << "LogReg with Th." << " Accuracy = " << (float)metric(Y, lgTh->predict(X)) / X->lines * 100 << "%" << std::endl;
	std::cout << "LogReg with Sigmoid and learn rate a1." << " Accuracy = " << (float)metric(Y, lgSigmA1->predict(X)) / X->lines * 100 << "%" << std::endl;
	std::cout << "LogReg with Linear and learn rate a1." << " Accuracy = " << (float)metric(Y, lgLinA1->predict(X)) / X->lines * 100 << "%" << std::endl;
	std::cout << "LogReg with Th and learn rate a1." << " Accuracy = " << (float)metric(Y, lgThA1->predict(X)) / X->lines * 100 << "%" << std::endl;

	//std::cout << k << "/" << pred->lines << " -> " << (float) k / pred->lines * 100 << "%" << std::endl;

	system("pause");

	return 0;
}

//int main() {
//	Matrix* a = ones(28*28, 10);
//	Matrix* b = ones(28*28, 10);
//
//	time_t t = std::clock();
//	for (int i = 0; i < 5000; i++) {
//		a = sub(a, b, 1);
//	}
//
//	Matrix* a_0 = a;
//	std::cout << "SUM: " << (double)(std::clock() - t) / 1000 << std::endl;
//
//	a = ones(28*28, 10);
//	t = std::clock();
//	for (int i = 0; i < 5000; i++) {
//		a = sse_sub(a, b, 1);
//	}
//	std::cout << "SSE: " << (double)(std::clock() - t) / 1000 << std::endl;
//
//	std::cout << cmp(a, a_0) << std::endl;
//
//	system("pause");
//
//	return 0;
//}