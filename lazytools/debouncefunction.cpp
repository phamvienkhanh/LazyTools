#include "debouncefunction.h"

#include <QDateTime>
#include <QTimerEvent>

#include <QDebug>

DebounceFunction::DebounceFunction(const InitParams& params)
{
    setParent(params.parent);
    _params = params;
}

DebounceFunction::~DebounceFunction()
{
    qDebug() << "DebounceFunction::~DebounceFunction()";
}

void DebounceFunction::call()
{
    qDebug() << "DebounceFunction::call()";

    if(_params.isLeading) {
        invokeCallback();
    }

    if(_params.msMaxWait > 0) {
        qint64 curTime = QDateTime::currentMSecsSinceEpoch();
        if(curTime - _lastTimeCall >= _params.msMaxWait) {
            invokeCallback();
        }
    }

    if(_params.isTrailing) {
        if(_timeId) killTimer(_timeId);
        _timeId = startTimer(_params.msWait);
    }
}

void DebounceFunction::timerEvent(QTimerEvent* event)
{
    qint32 tId = event->timerId();
    if(tId == _timeId) {
        invokeCallback();
        killTimer(tId);
        _timeId = 0;
    }
}

void DebounceFunction::invokeCallback()
{
    if(_params.callback.isCallable())
        _params.callback.call();

    _lastTimeCall = QDateTime::currentMSecsSinceEpoch();
}
