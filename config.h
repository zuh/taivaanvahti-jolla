#ifndef CONFIG_H
#define CONFIG_H

#include <QMap>
#include <QObject>
#include <QtQuick>
#include <QString>
#include <QFile>

/**
 * @brief The Config class provides api for reading and writing application
 * data. The data right now is only search related so search parameters are
 * respected / remembered in future use of application
 */
class Config : public QObject
{
    Q_OBJECT
public:
    explicit Config(QObject *parent = nullptr);

    /**
      * @brief Writes the status for application
      */
    Q_INVOKABLE void writeStatus();

    /**
     * @brief Reads the status from file
     */
    Q_INVOKABLE bool readStatus();

    /**
     * @brief Sets status for current stateBank
     * @pre Object must be in stateBank already
     */
    Q_INVOKABLE void setStatus(QString object, bool status);

    /**
      * @brief Fetches a single object's status from stateBank
      */
    Q_INVOKABLE bool fetchStatus(QString object);

signals:

public slots:

private:
    QMap<QString, bool> stateBank_;

    const QString dataFile_ = "$XDG_CONFIG_HOME/harbour-taivaanvahti/config.txt";

};

#endif // CONFIG_H
