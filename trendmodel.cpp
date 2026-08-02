#include "trendmodel.h"

TrendModel::TrendModel(QObject *parent)
    : QAbstractTableModel(parent)
{}

int TrendModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_records.size();
}

int TrendModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return ColumnCount;
}

QVariant TrendModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_records.size()
        || role != Qt::DisplayRole) {
        return {};
    }

    const TrendRecord &record = m_records.at(index.row());

    switch (index.column()) {
    case TimeColumn:
        return record.time;
    case HeartRateColumn:
        return record.heartRate;
    case OxygenSaturationColumn:
        return record.oxygenSaturation;
    case RespiratoryRateColumn:
        return record.respiratoryRate;
    case NibpColumn:
        return record.nibp;
    default:
        return {};
    }
}
