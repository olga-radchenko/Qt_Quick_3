#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QQmlApplicationEngine>

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    void on_stateMachineBttn_clicked();

    void on_bookListBttn_clicked();

private:
    Ui::MainWindow *ui;
    QQmlApplicationEngine *stateMachine{nullptr};
    QQmlApplicationEngine *bookList{nullptr};
};
#endif // MAINWINDOW_H
