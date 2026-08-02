#pragma once

#include <QAbstractTableModel>
#include <QQmlEngine>

class TrendModel : public QAbstractTableModel
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit TrendModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

private:
    enum Column {
        TimeColumn,
        HeartRateColumn,
        OxygenSaturationColumn,
        RespiratoryRateColumn,
        NibpColumn,
        ColumnCount
    };

    struct TrendRecord
    {
        QString time;
        int heartRate;
        int oxygenSaturation;
        int respiratoryRate;
        QString nibp;
    };

    QVector<TrendRecord> m_records{{"10:50", 79, 98, 16, "119/75"},
                                   {"10:40", 78, 97, 16, "118/74"},
                                   {"10:30", 77, 97, 17, "120/76"},
                                   {"10:20", 75, 98, 16, "118/74"},
                                   {"10:10", 74, 97, 15, "—"},
                                   {"10:00", 76, 97, 16, "117/73"},
                                   {"09:50", 78, 98, 17, "119/74"},
                                   {"09:40", 77, 98, 16, "118/74"},
                                   {"09:30", 75, 97, 16, "120/75"},
                                   {"09:20", 76, 97, 17, "—"},
                                   {"09:10", 74, 98, 17, "119/75"},
                                   {"09:00", 72, 98, 16, "121/76"}};
};
