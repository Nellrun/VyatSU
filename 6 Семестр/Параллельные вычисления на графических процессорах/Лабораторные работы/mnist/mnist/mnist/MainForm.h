#pragma once
#include "MnistReader.h"

namespace mnist {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;

	/// <summary>
	/// Сводка для MainForm
	/// </summary>
	public ref class MainForm : public System::Windows::Forms::Form
	{
	public:
		MainForm(void)
		{
			InitializeComponent();
			//
			//TODO: добавьте код конструктора
			//
		}

	protected:
		/// <summary>
		/// Освободить все используемые ресурсы.
		/// </summary>
		~MainForm()
		{
			if (components)
			{
				delete components;
			}
		}
	private: System::Windows::Forms::PictureBox^  imageBox;
	private: System::Windows::Forms::Button^  button1;
	private: MnistReader* mr;
	protected:

	protected:

	private:
		/// <summary>
		/// Обязательная переменная конструктора.
		/// </summary>
		System::ComponentModel::Container ^components;

#pragma region Windows Form Designer generated code
		/// <summary>
		/// Требуемый метод для поддержки конструктора — не изменяйте 
		/// содержимое этого метода с помощью редактора кода.
		/// </summary>
		void InitializeComponent(void)
		{
			this->imageBox = (gcnew System::Windows::Forms::PictureBox());
			this->button1 = (gcnew System::Windows::Forms::Button());
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->imageBox))->BeginInit();
			this->SuspendLayout();
			// 
			// imageBox
			// 
			this->imageBox->Location = System::Drawing::Point(101, 38);
			this->imageBox->Name = L"imageBox";
			this->imageBox->Size = System::Drawing::Size(56, 56);
			this->imageBox->TabIndex = 0;
			this->imageBox->TabStop = false;
			this->imageBox->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// button1
			// 
			this->button1->Location = System::Drawing::Point(92, 163);
			this->button1->Name = L"button1";
			this->button1->Size = System::Drawing::Size(75, 23);
			this->button1->TabIndex = 1;
			this->button1->Text = L"Далее";
			this->button1->UseVisualStyleBackColor = true;
			this->button1->Click += gcnew System::EventHandler(this, &MainForm::button1_Click);
			// 
			// MainForm
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(284, 261);
			this->Controls->Add(this->button1);
			this->Controls->Add(this->imageBox);
			this->Name = L"MainForm";
			this->Text = L"";
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->imageBox))->EndInit();
			this->ResumeLayout(false);

			this->mr = new MnistReader("trainBase/images.idx3-ubyte", "trainBase/labels.idx1-ubyte");

		}
#pragma endregion
	private: System::Void pictureBox1_Click(System::Object^  sender, System::EventArgs^  e) {
	}
	private: System::Void button1_Click(System::Object^  sender, System::EventArgs^  e) {
		this->mr->next();
		this->mr->getImage();
		Image^ img;
		img->
		this->imageBox->CreateGraphics()->draw
	}
	};
}
