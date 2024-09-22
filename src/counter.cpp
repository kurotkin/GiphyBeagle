#include "counter.h"
#include <QDebug>

counter::counter() : QObject() {
    this->count = 0;
}

void counter::increment() {
    this->count++;
    emit countChanged();
}

void counter::reset() {
    this->count = 0;
    emit countChanged();
}

void counter::print() {
    qDebug() << "Current count: " << this->count;
}

int counter::getCount() {
    return this->count;
}

void counter::setCount(int count) {
    this->count = count;
    emit countChanged();
}
