#pragma once
#include <windows.h>
#include <process.h>
#include "classes.h"


namespace AnimateLab7 {
	
	const int LEFT = 12;
	const int HOOK_TOP = -266;

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;
	using namespace System::Threading;

	/// <summary>
	/// Ñâîäêà äëÿ MainForm
	/// </summary>
	public ref class MainForm : public System::Windows::Forms::Form
	{
	public:
		MainForm(void)
		{
			SetStyle(ControlStyles::SupportsTransparentBackColor, true);
			SetStyle(ControlStyles::DoubleBuffer, true);
			SetStyle(ControlStyles::UserPaint, true);
			SetStyle(ControlStyles::AllPaintingInWmPaint, true);

			InitializeComponent();
			System::Windows::Forms::Control::CheckForIllegalCrossThreadCalls = false;

			Box0->Location = System::Drawing::Point(Box0->Location.X, -100);
			Box1->Location = System::Drawing::Point(Box1->Location.X, -100);
			Box2->Location = System::Drawing::Point(Box2->Location.X, -100);
			Box3->Location = System::Drawing::Point(Box3->Location.X, -100);
			Box4->Location = System::Drawing::Point(Box4->Location.X, -100);
			Box5->Location = System::Drawing::Point(Box5->Location.X, -100);
			Box6->Location = System::Drawing::Point(Box6->Location.X, -100);
			Box7->Location = System::Drawing::Point(Box7->Location.X, -100);
			Box8->Location = System::Drawing::Point(Box8->Location.X, -100);
			Box9->Location = System::Drawing::Point(Box9->Location.X, -100);
			//
			//TODO: äîáàâüòå êîä êîíñòðóêòîðà
			//
		}

	protected:
		/// <summary>
		/// Îñâîáîäèòü âñå èñïîëüçóåìûå ðåñóðñû.
		/// </summary>
		~MainForm()
		{
			if (components)
			{
				delete components;
			}
		}
	private: System::Windows::Forms::PictureBox^  pictureBox1;
	private: System::Windows::Forms::PictureBox^  pictureBox2;
	private: System::Windows::Forms::PictureBox^  pictureBox3;
	private: System::Windows::Forms::PictureBox^  pictureBox4;
	private: System::Windows::Forms::PictureBox^  pictureBox5;
	private: System::Windows::Forms::PictureBox^  pictureBox6;
	private: System::Windows::Forms::PictureBox^  pictureBox7;
	private: System::Windows::Forms::PictureBox^  pictureBox8;
	private: System::Windows::Forms::PictureBox^  pictureBox9;
	private: System::Windows::Forms::PictureBox^  pictureBox10;
	private: System::Windows::Forms::PictureBox^  hookProd1;
	private: System::Windows::Forms::PictureBox^  Box0;


	private: System::Windows::Forms::PictureBox^  hookProd2;
	private: System::Windows::Forms::PictureBox^  hookCons;
	private: System::Windows::Forms::Button^  startBut;
	private: System::Windows::Forms::PictureBox^  Box1;
	private: System::Windows::Forms::PictureBox^  Box2;
	private: System::Windows::Forms::PictureBox^  Box3;
	private: System::Windows::Forms::PictureBox^  Box4;
	private: System::Windows::Forms::PictureBox^  Box5;
	private: System::Windows::Forms::PictureBox^  Box6;
	private: System::Windows::Forms::PictureBox^  Box7;
	private: System::Windows::Forms::PictureBox^  Box8;








	private: System::Windows::Forms::PictureBox^  Box9;

			 private: CirclBuffer^ buf;
	protected:










	private:
		/// <summary>
		/// Îáÿçàòåëüíàÿ ïåðåìåííàÿ êîíñòðóêòîðà.
		/// </summary>
		System::ComponentModel::Container ^components;

#pragma region Windows Form Designer generated code
		/// <summary>
		/// Òðåáóåìûé ìåòîä äëÿ ïîääåðæêè êîíñòðóêòîðà — íå èçìåíÿéòå 
		/// ñîäåðæèìîå ýòîãî ìåòîäà ñ ïîìîùüþ ðåäàêòîðà êîäà.
		/// </summary>
		void InitializeComponent(void)
		{
			System::ComponentModel::ComponentResourceManager^  resources = (gcnew System::ComponentModel::ComponentResourceManager(MainForm::typeid));
			this->pictureBox1 = (gcnew System::Windows::Forms::PictureBox());
			this->pictureBox2 = (gcnew System::Windows::Forms::PictureBox());
			this->pictureBox3 = (gcnew System::Windows::Forms::PictureBox());
			this->pictureBox4 = (gcnew System::Windows::Forms::PictureBox());
			this->pictureBox5 = (gcnew System::Windows::Forms::PictureBox());
			this->pictureBox6 = (gcnew System::Windows::Forms::PictureBox());
			this->pictureBox7 = (gcnew System::Windows::Forms::PictureBox());
			this->pictureBox8 = (gcnew System::Windows::Forms::PictureBox());
			this->pictureBox9 = (gcnew System::Windows::Forms::PictureBox());
			this->pictureBox10 = (gcnew System::Windows::Forms::PictureBox());
			this->hookProd1 = (gcnew System::Windows::Forms::PictureBox());
			this->Box0 = (gcnew System::Windows::Forms::PictureBox());
			this->hookProd2 = (gcnew System::Windows::Forms::PictureBox());
			this->hookCons = (gcnew System::Windows::Forms::PictureBox());
			this->startBut = (gcnew System::Windows::Forms::Button());
			this->Box1 = (gcnew System::Windows::Forms::PictureBox());
			this->Box2 = (gcnew System::Windows::Forms::PictureBox());
			this->Box3 = (gcnew System::Windows::Forms::PictureBox());
			this->Box4 = (gcnew System::Windows::Forms::PictureBox());
			this->Box5 = (gcnew System::Windows::Forms::PictureBox());
			this->Box6 = (gcnew System::Windows::Forms::PictureBox());
			this->Box7 = (gcnew System::Windows::Forms::PictureBox());
			this->Box8 = (gcnew System::Windows::Forms::PictureBox());
			this->Box9 = (gcnew System::Windows::Forms::PictureBox());
			buf = gcnew CirclBuffer();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox1))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox2))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox3))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox4))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox5))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox6))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox7))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox8))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox9))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox10))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->hookProd1))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box0))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->hookProd2))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->hookCons))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box1))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box2))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box3))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box4))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box5))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box6))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box7))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box8))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box9))->BeginInit();
			this->SuspendLayout();
			// 
			// pictureBox1
			// 
			this->pictureBox1->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"pictureBox1.Image")));
			this->pictureBox1->Location = System::Drawing::Point(12, 328);
			this->pictureBox1->Name = L"pictureBox1";
			this->pictureBox1->Size = System::Drawing::Size(64, 64);
			this->pictureBox1->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->pictureBox1->TabIndex = 0;
			this->pictureBox1->TabStop = false;
			this->pictureBox1->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// pictureBox2
			// 
			this->pictureBox2->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"pictureBox2.Image")));
			this->pictureBox2->Location = System::Drawing::Point(82, 328);
			this->pictureBox2->Name = L"pictureBox2";
			this->pictureBox2->Size = System::Drawing::Size(64, 64);
			this->pictureBox2->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->pictureBox2->TabIndex = 0;
			this->pictureBox2->TabStop = false;
			this->pictureBox2->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// pictureBox3
			// 
			this->pictureBox3->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"pictureBox3.Image")));
			this->pictureBox3->Location = System::Drawing::Point(152, 328);
			this->pictureBox3->Name = L"pictureBox3";
			this->pictureBox3->Size = System::Drawing::Size(64, 64);
			this->pictureBox3->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->pictureBox3->TabIndex = 0;
			this->pictureBox3->TabStop = false;
			this->pictureBox3->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// pictureBox4
			// 
			this->pictureBox4->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"pictureBox4.Image")));
			this->pictureBox4->Location = System::Drawing::Point(222, 328);
			this->pictureBox4->Name = L"pictureBox4";
			this->pictureBox4->Size = System::Drawing::Size(64, 64);
			this->pictureBox4->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->pictureBox4->TabIndex = 0;
			this->pictureBox4->TabStop = false;
			this->pictureBox4->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// pictureBox5
			// 
			this->pictureBox5->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"pictureBox5.Image")));
			this->pictureBox5->Location = System::Drawing::Point(292, 328);
			this->pictureBox5->Name = L"pictureBox5";
			this->pictureBox5->Size = System::Drawing::Size(64, 64);
			this->pictureBox5->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->pictureBox5->TabIndex = 0;
			this->pictureBox5->TabStop = false;
			this->pictureBox5->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// pictureBox6
			// 
			this->pictureBox6->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"pictureBox6.Image")));
			this->pictureBox6->Location = System::Drawing::Point(362, 328);
			this->pictureBox6->Name = L"pictureBox6";
			this->pictureBox6->Size = System::Drawing::Size(64, 64);
			this->pictureBox6->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->pictureBox6->TabIndex = 0;
			this->pictureBox6->TabStop = false;
			this->pictureBox6->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// pictureBox7
			// 
			this->pictureBox7->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"pictureBox7.Image")));
			this->pictureBox7->Location = System::Drawing::Point(432, 328);
			this->pictureBox7->Name = L"pictureBox7";
			this->pictureBox7->Size = System::Drawing::Size(64, 64);
			this->pictureBox7->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->pictureBox7->TabIndex = 0;
			this->pictureBox7->TabStop = false;
			this->pictureBox7->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// pictureBox8
			// 
			this->pictureBox8->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"pictureBox8.Image")));
			this->pictureBox8->Location = System::Drawing::Point(502, 328);
			this->pictureBox8->Name = L"pictureBox8";
			this->pictureBox8->Size = System::Drawing::Size(64, 64);
			this->pictureBox8->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->pictureBox8->TabIndex = 0;
			this->pictureBox8->TabStop = false;
			this->pictureBox8->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// pictureBox9
			// 
			this->pictureBox9->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"pictureBox9.Image")));
			this->pictureBox9->Location = System::Drawing::Point(572, 328);
			this->pictureBox9->Name = L"pictureBox9";
			this->pictureBox9->Size = System::Drawing::Size(64, 64);
			this->pictureBox9->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->pictureBox9->TabIndex = 0;
			this->pictureBox9->TabStop = false;
			this->pictureBox9->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// pictureBox10
			// 
			this->pictureBox10->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"pictureBox10.Image")));
			this->pictureBox10->Location = System::Drawing::Point(642, 328);
			this->pictureBox10->Name = L"pictureBox10";
			this->pictureBox10->Size = System::Drawing::Size(64, 64);
			this->pictureBox10->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->pictureBox10->TabIndex = 0;
			this->pictureBox10->TabStop = false;
			this->pictureBox10->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// hookProd1
			// 
			this->hookProd1->BackColor = System::Drawing::Color::Transparent;
			this->hookProd1->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"hookProd1.Image")));
			this->hookProd1->Location = System::Drawing::Point(12, -266);
			this->hookProd1->Name = L"hookProd1";
			this->hookProd1->Size = System::Drawing::Size(64, 357);
			this->hookProd1->TabIndex = 0;
			this->hookProd1->TabStop = false;
			this->hookProd1->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// Box0
			// 
			this->Box0->BackColor = System::Drawing::Color::Transparent;
			this->Box0->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"Box0.Image")));
			this->Box0->Location = System::Drawing::Point(12, 84);
			this->Box0->Name = L"Box0";
			this->Box0->Size = System::Drawing::Size(64, 64);
			this->Box0->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->Box0->TabIndex = 0;
			this->Box0->TabStop = false;
			this->Box0->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// hookProd2
			// 
			this->hookProd2->BackColor = System::Drawing::Color::Transparent;
			this->hookProd2->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"hookProd2.Image")));
			this->hookProd2->Location = System::Drawing::Point(12, -266);
			this->hookProd2->Name = L"hookProd2";
			this->hookProd2->Size = System::Drawing::Size(64, 357);
			this->hookProd2->TabIndex = 0;
			this->hookProd2->TabStop = false;
			this->hookProd2->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// hookCons
			// 
			this->hookCons->BackColor = System::Drawing::Color::Transparent;
			this->hookCons->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"hookCons.Image")));
			this->hookCons->Location = System::Drawing::Point(12, -266);
			this->hookCons->Name = L"hookCons";
			this->hookCons->Size = System::Drawing::Size(64, 357);
			this->hookCons->TabIndex = 0;
			this->hookCons->TabStop = false;
			this->hookCons->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// startBut
			// 
			this->startBut->Location = System::Drawing::Point(742, 12);
			this->startBut->Name = L"startBut";
			this->startBut->Size = System::Drawing::Size(94, 52);
			this->startBut->TabIndex = 1;
			this->startBut->Text = L"Старт";
			this->startBut->UseVisualStyleBackColor = true;
			this->startBut->Click += gcnew System::EventHandler(this, &MainForm::startBut_Click);
			// 
			// Box1
			// 
			this->Box1->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"Box1.Image")));
			this->Box1->Location = System::Drawing::Point(82, 84);
			this->Box1->Name = L"Box1";
			this->Box1->Size = System::Drawing::Size(64, 64);
			this->Box1->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->Box1->TabIndex = 0;
			this->Box1->TabStop = false;
			this->Box1->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// Box2
			// 
			this->Box2->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"Box2.Image")));
			this->Box2->Location = System::Drawing::Point(152, 84);
			this->Box2->Name = L"Box2";
			this->Box2->Size = System::Drawing::Size(64, 64);
			this->Box2->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->Box2->TabIndex = 0;
			this->Box2->TabStop = false;
			this->Box2->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// Box3
			// 
			this->Box3->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"Box3.Image")));
			this->Box3->Location = System::Drawing::Point(222, 84);
			this->Box3->Name = L"Box3";
			this->Box3->Size = System::Drawing::Size(64, 64);
			this->Box3->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->Box3->TabIndex = 0;
			this->Box3->TabStop = false;
			this->Box3->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// Box4
			// 
			this->Box4->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"Box4.Image")));
			this->Box4->Location = System::Drawing::Point(292, 84);
			this->Box4->Name = L"Box4";
			this->Box4->Size = System::Drawing::Size(64, 64);
			this->Box4->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->Box4->TabIndex = 0;
			this->Box4->TabStop = false;
			this->Box4->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// Box5
			// 
			this->Box5->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"Box5.Image")));
			this->Box5->Location = System::Drawing::Point(362, 84);
			this->Box5->Name = L"Box5";
			this->Box5->Size = System::Drawing::Size(64, 64);
			this->Box5->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->Box5->TabIndex = 0;
			this->Box5->TabStop = false;
			this->Box5->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// Box6
			// 
			this->Box6->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"Box6.Image")));
			this->Box6->Location = System::Drawing::Point(432, 84);
			this->Box6->Name = L"Box6";
			this->Box6->Size = System::Drawing::Size(64, 64);
			this->Box6->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->Box6->TabIndex = 0;
			this->Box6->TabStop = false;
			this->Box6->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// Box7
			// 
			this->Box7->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"Box7.Image")));
			this->Box7->Location = System::Drawing::Point(502, 84);
			this->Box7->Name = L"Box7";
			this->Box7->Size = System::Drawing::Size(64, 64);
			this->Box7->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->Box7->TabIndex = 0;
			this->Box7->TabStop = false;
			this->Box7->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// Box8
			// 
			this->Box8->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"Box8.Image")));
			this->Box8->Location = System::Drawing::Point(572, 84);
			this->Box8->Name = L"Box8";
			this->Box8->Size = System::Drawing::Size(64, 64);
			this->Box8->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->Box8->TabIndex = 0;
			this->Box8->TabStop = false;
			this->Box8->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// Box9
			// 
			this->Box9->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"Box9.Image")));
			this->Box9->Location = System::Drawing::Point(642, 84);
			this->Box9->Name = L"Box9";
			this->Box9->Size = System::Drawing::Size(64, 64);
			this->Box9->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->Box9->TabIndex = 0;
			this->Box9->TabStop = false;
			this->Box9->Click += gcnew System::EventHandler(this, &MainForm::pictureBox1_Click);
			// 
			// MainForm
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(848, 358);
			this->Controls->Add(this->startBut);
			this->Controls->Add(this->Box9);
			this->Controls->Add(this->Box8);
			this->Controls->Add(this->Box7);
			this->Controls->Add(this->Box6);
			this->Controls->Add(this->Box5);
			this->Controls->Add(this->Box4);
			this->Controls->Add(this->Box3);
			this->Controls->Add(this->Box2);
			this->Controls->Add(this->Box1);
			this->Controls->Add(this->Box0);
			this->Controls->Add(this->pictureBox10);
			this->Controls->Add(this->pictureBox9);
			this->Controls->Add(this->pictureBox8);
			this->Controls->Add(this->pictureBox7);
			this->Controls->Add(this->pictureBox6);
			this->Controls->Add(this->pictureBox5);
			this->Controls->Add(this->pictureBox4);
			this->Controls->Add(this->pictureBox3);
			this->Controls->Add(this->pictureBox2);
			this->Controls->Add(this->hookCons);
			this->Controls->Add(this->hookProd2);
			this->Controls->Add(this->hookProd1);
			this->Controls->Add(this->pictureBox1);
			this->FormBorderStyle = System::Windows::Forms::FormBorderStyle::FixedToolWindow;
			this->Name = L"MainForm";
			this->Text = L"Лабораторная работа";
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox1))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox2))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox3))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox4))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox5))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox6))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox7))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox8))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox9))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pictureBox10))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->hookProd1))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box0))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->hookProd2))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->hookCons))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box1))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box2))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box3))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box4))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box5))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box6))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box7))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box8))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->Box9))->EndInit();
			this->ResumeLayout(false);

		}
#pragma endregion
	private: System::Void pictureBox1_Click(System::Object^  sender, System::EventArgs^  e) {
	}

	private: System::Void startBut_Click(System::Object^  sender, System::EventArgs^  e) {

		Producer^ prod1 = gcnew Producer(hookProd1, buf);
		Producer^ prod2 = gcnew Producer(hookProd2, buf);
		Consumer^ cons = gcnew Consumer(hookCons, buf);

		Thread^ t = gcnew Thread(gcnew ThreadStart(prod1, &Producer::run));
		t->Start();

		Thread^ t2 = gcnew Thread(gcnew ThreadStart(cons, &Consumer::run));
		t2->Start();

		Thread^ t3 = gcnew Thread(gcnew ThreadStart(prod2, &Producer::run));
		t3->Start();

		startBut->Enabled = false;
	}
};
}
