#include "wmmodel.h"

WMModel::WMModel(QObject *parent)
    : QAbstractListModel(parent)
{
    initWeight = 5.0;
    waterPerc = 98.0;
    res = 2.5;
}

int WMModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    // Single-element model
    return 1;
}

QVariant WMModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    // Return value based on requested role
    switch (role) {
        case AnswerRole:
            return res;
        case LeftSliderRole:
            return initWeight;
        case BottomSliderRole:
            return waterPerc;
        default:
            return QVariant();
    }
}

QHash<int, QByteArray> WMModel::roleNames() const
{
    // Append custom roles with QML role names
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[AnswerRole] = "answer";
    roles[LeftSliderRole] = "initweight";
    roles[BottomSliderRole] = "initwater";

    return roles;
}

bool WMModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid()) {
        return false;
    }
    switch (role) {
        case AnswerRole:
            return false;
        case LeftSliderRole:
            initWeight = value.toDouble();
            res = initWeight / (100 - waterPerc);
            break;
        case BottomSliderRole:
            waterPerc = value.toDouble();
            res = initWeight / (100 - waterPerc);
            break;
        default:
            return false;
    }
    // Update both altered value and the result
    emit dataChanged(index, index, QVector<int>() << role << AnswerRole);

    return true;
}

Qt::ItemFlags WMModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;
    // Make editable
    return Qt::ItemIsEditable;
}
