#pragma once

#include <QAbstractListModel>
#include <QQmlEngine>

class AlarmModel : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit AlarmModel(QObject *parent = nullptr);

    enum Role {
        TimeRole = Qt::UserRole + 1,
        ParameterRole,
        MessageRole,
        ValueRole,
        PriorityRole,
        ActiveRole,
        AcknowledgedRole
    };

    Q_ENUM(Role);

    QHash<int, QByteArray> roleNames() const override;

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role) const override;

    Qt::ItemFlags flags(const QModelIndex &index) const override;

    bool setData(const QModelIndex &index, const QVariant &value, int role) override;

private:
    struct AlarmRecord {
        QString time;
        QString parameter;
        QString message;
        QString value;
        QString priority;
        bool active;
        bool acknowledged;
    };

    QVector<AlarmRecord> m_alarms {
        {"14:32", "SpO₂", "Low oxygen saturation", "88 %", "High", true, false},
        {"14:18", "ECG", "Lead disconnected", "Lead II", "Medium", false, true},
        {"13:54", "Heart rate", "High heart rate", "128 bpm", "High", false, true},
        {"13:27", "NIBP", "High systolic pressure", "154/92 mmHg", "Medium", false, true},
        {"12:46", "Respiratory rate", "Low respiratory rate", "8 /min", "High", false, true},
        {"12:11", "SpO₂", "Probe disconnected", "No signal", "Medium", false, true},
        {"11:38", "Heart rate", "Low heart rate", "46 bpm", "High", false, true},
        {"10:52", "ECG", "Signal quality poor", "Lead III", "Low", false, true},
        {"10:16", "NIBP", "Measurement unsuccessful", "Retry", "Low", false, true},
        {"09:41", "Respiratory rate", "High respiratory rate", "31 /min", "Medium", false, true},
        {"09:03", "SpO₂", "Low oxygen saturation", "89 %", "High", false, true},
        {"08:24", "ECG", "Lead disconnected", "Lead V", "Medium", false, true}
    };
};

