#include "MnistReader.h"
#include "Matrix.h"
#include "LogisticRegression.h"
#include <ctime>
#include <omp.h>

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
		_aligned_free(X->value[i]);
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
	

#pragma omp parallel sections private(t)
	{
#pragma omp section
			{
				t = clock();
				lgSigm->sse_fit(X, Y, EPOCHES);
				float time = (float)(clock() - t);
				std::cout << "LogReg with Sigmoid." << " fit time = " << time / CLOCKS_PER_SEC << " sec" << std::endl;
			}
#pragma omp section 
			{
				t = clock();
				lgLin->sse_fit(X, Y, EPOCHES);
				float time = (float)(clock() - t);
				std::cout << "LogReg with Linear." << " fit time = " << time / CLOCKS_PER_SEC << " sec" << std::endl;
			}

#pragma omp section 
			{
				t = clock();
				lgTh->sse_fit(X, Y, EPOCHES);
				float time = (float)(clock() - t);
				std::cout << "LogReg with Th." << " fit time = " << time / CLOCKS_PER_SEC << " sec" << std::endl;
			}
#pragma omp section 
			{
				t = clock();
				lgSigmA1->sse_fit(X, Y, EPOCHES);
				float time = (float)(clock() - t);
				std::cout << "LogReg with Sigmoid and learn rate a1." << " fit time = " << time / CLOCKS_PER_SEC << " sec" << std::endl;
			}

#pragma omp section 
			{
				t = clock();
				lgLinA1->sse_fit(X, Y, EPOCHES);
				float time = (float)(clock() - t);
				std::cout << "LogReg with Linear and learn rate a1." << " fit time = " << time / CLOCKS_PER_SEC << " sec" << std::endl;
			}

#pragma omp section 
			{
				t = clock();
				lgThA1->sse_fit(X, Y, EPOCHES);
				float time = (float)(clock() - t);
				std::cout << "LogReg with Th and learn rate a1." << " fit time = " << time / CLOCKS_PER_SEC << " sec" << std::endl;
			}
		}
	//}
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
//	Matrix* a = ones(128, 128);
//	Matrix* b = ones(128, 128);
//
//	time_t t = std::clock();
//	for (int i = 0; i < 1000; i++) {
//		a = matmul(a, b, 1);
//	}
//
//	Matrix* a_0 = a;
//	std::cout << "MUL: " << (double)(std::clock() - t) / 1000 << std::endl;
//
//	a = ones(128, 128);
//	t = std::clock();
//	for (int i = 0; i < 1000; i++) {
//		a = sse_matmul(a, b, 1);
//	}
//	std::cout << "SSE MUL: " << (double)(std::clock() - t) / 1000 << std::endl;
//
//	std::cout << cmp(a, a_0) << std::endl;
//
//	system("pause");
//
//	return 0;
//}