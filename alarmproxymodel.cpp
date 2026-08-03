#include "alarmproxymodel.h"

#include "alarmmodel.h"

AlarmProxyModel::AlarmProxyModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{
}

bool AlarmProxyModel::showResolved() const
{
    return m_showResolved;
}

void AlarmProxyModel::setShowResolved(bool show)
{
    if (m_showResolved == show)
        return;

    beginFilterChange();
    m_showResolved = show;
    endFilterChange(Direction::Rows);

    emit showResolvedChanged();
}

bool AlarmProxyModel::filterAcceptsRow(int sourceRow,
                                       const QModelIndex &sourceParent) const
{
    if (m_showResolved)
        return true;

    const QModelIndex sourceIndex = sourceModel()->index(sourceRow, 0, sourceParent);
    const bool active = sourceModel()->data(sourceIndex, AlarmModel::ActiveRole).toBool();

    return active;
}
