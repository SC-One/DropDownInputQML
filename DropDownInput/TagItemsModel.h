#ifndef TAGITEMSMODEL_H
#define TAGITEMSMODEL_H
#include <QAbstractListModel>
#include <QMap>
#include <QQmlEngine>
#include <QSortFilterProxyModel>

#include "TagItemData.h"
class TagItemsModel : public QAbstractListModel
{
    Q_OBJECT
public:
    TagItemsModel(QObject* parent = nullptr);

    enum TagItemDataRole
    {
        Name = Qt::UserRole + 1,
        Description,
        Link
    };
    Q_ENUM(TagItemDataRole)
public:
    ///////////////////@@ QAbstractListModel interface @@///////////////////
    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    int columnCount(const QModelIndex& parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override;
    QVariant
    headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const override;
    ///////////////////////////////////////////////////////////////////

public:
    Q_INVOKABLE bool addTagItem(const TagItemData& data);
    Q_INVOKABLE void generateHeader();
    Q_INVOKABLE bool contains(const QString& name);
    Q_INVOKABLE TagItemData getTagItemData(const QString& name) const
    {
        for(auto const& item : _tagItems)
        {
            if(item == name)
            {
                return item;
            }
        }
        return createTagItem();
    }

public:
    Q_INVOKABLE static inline TagItemData createTagItem()
    {
        TagItemData result;
        result.m_name = "None";
        result.m_description = "description";
        result.m_link = "link";
        return result;
    }

    static inline void RegisterToQML()
    {
        qRegisterMetaType<TagItemData>("TagItemData");
        qmlRegisterType<TagItemsModel>("ir.hcoding.models", 1, 0, "TagItemsModel");
    }

private:
    QHash<int, QByteArray> _roles;
    QVector<TagItemData> _tagItems;
};

#endif // TAGITEMSMODEL_H
