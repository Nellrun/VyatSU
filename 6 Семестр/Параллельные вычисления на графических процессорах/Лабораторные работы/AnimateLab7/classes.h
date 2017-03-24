#pragma once
#include <windows.h>
#include <math.h>

ref class CirclBuffer
{
public:
	CirclBuffer() {
		addMut = CreateMutex(NULL, false, NULL);
		data = gcnew array<System::Windows::Forms::PictureBox^>(10);
		in = 0;
		out = 0;
	};
	~CirclBuffer() {};


	bool isFull() {
		return (in + 1) % 10 == out;
	}

	bool isEmpty() {
		return in == out;
	}

	int getPlace() {
		WaitForSingleObject(addMut, INFINITE);
		return in;
	}

	int add(System::Windows::Forms::PictureBox^ pic) {
		data[in] = pic;
		int res = in;
		in = (in + 1) % 10;

		ReleaseMutex(addMut);
		return res;
	}

	System::Windows::Forms::PictureBox^ get(int &pos) {
		pos = out;
		out = (out + 1) % 10;
		return data[pos];
	}

private:
	array<System::Windows::Forms::PictureBox^>^ data;
	int in;
	int out;
	HANDLE addMut;
};

ref class Producer
{
public:
	Producer(System::Windows::Forms::PictureBox^ picture, CirclBuffer^ buffer){
		hook = picture;
		hSync = CreateMutexW(NULL, false, NULL);
		buf = buffer;
		speed = 5;
	};
	~Producer() {};

	void run() {
		for (int i = 0; i < 50; i++)
		{
			int pos = buf->getPlace();

			while (buf->isFull()) {};

			System::Windows::Forms::PictureBox ^  pic = (System::Windows::Forms::PictureBox^)hook->FindForm()->Controls->Find("Box" + (pos % 10), true)[0];

			this->moveX((pos % 10));
			this->putBox(pic);

			buf->add(pic);
		}
	}

	void moveX(int pos) {
		pos = 70 * pos + 12;
		int dx = 1;
		if (hook->Location.X != pos) {
			dx = (pos - hook->Location.X) / abs(pos - hook->Location.X);
		}
		while (hook->Location.X != pos) {
			hook->Location = System::Drawing::Point(hook->Location.X + dx, hook->Location.Y);
			Sleep(speed);
		}
	}

	void putBox(System::Windows::Forms::PictureBox^ box) {
		box->Location = System::Drawing::Point(hook->Location.X, -100);
		//box->Visible = true;

		while (hook->Location.Y != -450) {
			hook->Location = System::Drawing::Point(hook->Location.X, hook->Location.Y - 1);
			//box->Location = System::Drawing::Point(box->Location.X, box->Location.Y - 1);
			Sleep(speed);
		}

		while (hook->Location.Y != -60) {
			hook->Location = System::Drawing::Point(hook->Location.X, hook->Location.Y + 1);
			box->Location = System::Drawing::Point(box->Location.X, box->Location.Y + 1);
			Sleep(speed);
		}

		while (hook->Location.Y != -266) {
			hook->Location = System::Drawing::Point(hook->Location.X, hook->Location.Y - 1);
			Sleep(speed);
		}
	}

private:
	System::Windows::Forms::PictureBox^ hook;
	CirclBuffer^ buf;
	HANDLE hSync;
	int speed;
};

ref class Consumer
{
public:
	Consumer(System::Windows::Forms::PictureBox^ picture, CirclBuffer^ buffer) {
		hook = picture;
		buf = buffer;
		speed = 40;
	};
	~Consumer() {};

	void run() {
		for (int i = 0; i < 50; i++)
		{
			while (buf->isEmpty()) {};

			int pos;
			System::Windows::Forms::PictureBox^ pic = buf->get(pos);

			this->moveX(pos);
			this->takeBox(pic);
		}
	}

	void moveX(int pos) {
		pos = 70 * pos + 12;
		int dx = 1;
		if (hook->Location.X != pos) {
			dx = (pos - hook->Location.X) / abs(pos - hook->Location.X);
		}
		while (hook->Location.X != pos) {
			hook->Location = System::Drawing::Point(hook->Location.X + dx, hook->Location.Y);
			Sleep(speed);
		}
	}

	void takeBox(System::Windows::Forms::PictureBox^ box) {

		while (hook->Location.Y != -60) {
			hook->Location = System::Drawing::Point(hook->Location.X, hook->Location.Y + 1);
			Sleep(speed);
		}

		while (hook->Location.Y != -450) {
			hook->Location = System::Drawing::Point(hook->Location.X, hook->Location.Y - 1);
			box->Location = System::Drawing::Point(box->Location.X, box->Location.Y - 1);
			Sleep(speed);
		}

		while (hook->Location.Y != -266) {
			hook->Location = System::Drawing::Point(hook->Location.X, hook->Location.Y + 1);
			Sleep(speed);
		}
	}



private:
	System::Windows::Forms::PictureBox^ hook;
	CirclBuffer^ buf;
	int speed;
};