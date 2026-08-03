#include "alarmmodel.h"

AlarmModel::AlarmModel(QObject *parent) : QAbstractListModel(parent)
{
}

QHash<int, QByteArray> AlarmModel::roleNames() const
{
    return {
        { TimeRole, "time" },
        { ParameterRole, "parameter" },
        { MessageRole, "message" },
        { ValueRole, "value" },
        { CategoryRole, "category" },
        { PriorityRole, "priority" },
        { ActiveRole, "active" },
        { AcknowledgedRole, "acknowledged" }
    };
}

int AlarmModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) return 0;

    return m_alarms.size();
}

QVariant AlarmModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return {};

    if (index.row() < 0 || index.row() >= m_alarms.size())
        return {};

    const AlarmRecord &alarm = m_alarms.at(index.row());

    switch (role) {
    case TimeRole:
        return alarm.time;
    case ParameterRole:
        return alarm.parameter;
    case MessageRole:
        return alarm.message;
    case ValueRole:
        return alarm.value;
    case CategoryRole:
        return alarm.category;
    case PriorityRole:
        return alarm.priority;
    case ActiveRole:
        return alarm.active;
    case AcknowledgedRole:
        return alarm.acknowledged;
    default:
        return {};
    }
}

Qt::ItemFlags AlarmModel::flags(const QModelIndex &index) const
{
    if(!index.isValid()) return Qt::NoItemFlags;

    return QAbstractListModel::flags(index) | Qt::ItemIsEditable;

}

bool AlarmModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid()
        || index.row() < 0
        || index.row() >= m_alarms.size()
        || role != AcknowledgedRole) {
        return false;
    }

    AlarmRecord &alarm = m_alarms[index.row()];

    const bool acknowledged = value.toBool();

    if (alarm.acknowledged == acknowledged)
        return true;

    alarm.acknowledged = acknowledged;

    emit dataChanged(index, index, {AcknowledgedRole});

    return true;
}
