#ifndef WMMODEL_H
#define WMMODEL_H

#include <QAbstractListModel>

class WMModel : public QAbstractListModel
{
    Q_OBJECT

public:
    // Custom roles set to manipulate data in QML
    enum Roles {
        AnswerRole = Qt::UserRole + 1,
        LeftSliderRole,
        BottomSliderRole,
    };

    WMModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    Qt::ItemFlags flags(const QModelIndex& index) const override;
    virtual QHash<int, QByteArray> roleNames() const;

private:
    double res;
    double initWeight;
    double waterPerc;
};

#endif // WMMODEL_H
