#ifndef TAGITEM_H
#define TAGITEM_H
#include <QObject>
#include <QString>
#include <QtGlobal>
struct TagItemData
{
    Q_GADGET
    // register members
    Q_PROPERTY(QString name MEMBER m_name)
    Q_PROPERTY(QString description MEMBER m_description)
    Q_PROPERTY(QString link MEMBER m_link)
public:
    bool operator==(const QString& name) const
    {
        return m_name == name;
    }
    bool operator==(const TagItemData& tagItem) const
    {
        return m_name == tagItem.m_name;
    }
    QString m_name;
    QString m_description;
    QString m_link;
};
Q_DECLARE_METATYPE(TagItemData)
#endif // TAGITEM_H
