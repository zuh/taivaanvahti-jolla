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

    /**
      * @brief Fetch the user parameter if set
      */
    Q_INVOKABLE QString fetchSearchUser();

    /**
      * @brief Fetch the title if set
      */
    Q_INVOKABLE QString fetchSearchTitle();

    /**
      * @brief Fetches the city
      */
    Q_INVOKABLE QString fetchSearchCity();

    /**
      * @brief Sets the search parameters
      */
    Q_INVOKABLE void setSearchParameters(QString user = "",
                                         QString title = "",
                                         QString city = "");

signals:

public slots:

private:
    QMap<QString, bool> stateBank_;
    QString searchUser_ = "";
    QString searchTitle_ = "";
    QString searchCity_ = "";

};

#endif // CONFIG_H
