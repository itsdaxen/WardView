#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QSortFilterProxyModel>

class AlarmProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(bool showResolved READ showResolved WRITE setShowResolved NOTIFY showResolvedChanged)

public:
    explicit AlarmProxyModel(QObject *parent = nullptr);

    bool showResolved() const;
    void setShowResolved(bool show);

signals:
    void showResolvedChanged();

protected:
    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const override;

private:
    bool m_showResolved = true;
};
