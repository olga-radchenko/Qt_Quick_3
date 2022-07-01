#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_stateMachineBttn_clicked()
{
    if(stateMachine == nullptr)
        stateMachine = new QQmlApplicationEngine(this);

    stateMachine->load(QUrl(QStringLiteral("qrc:/LoginForm/MainWindow.qml")));
}

void MainWindow::on_bookListBttn_clicked()
{
    if(bookList == nullptr)
        bookList = new QQmlApplicationEngine(this);

    bookList->load(QUrl(QStringLiteral("qrc:/BookListView/bookList.qml")));
}
