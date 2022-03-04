#include "TagItemsModel.h"

#include <QHash>

TagItemsModel::TagItemsModel(QObject* parent)
    : QAbstractListModel(parent)
{
    _roles = QHash<int, QByteArray>{{TagItemsModel::TagItemDataRole::Name, "Name"},
                                    {TagItemsModel::TagItemDataRole::Description, "Description"},
                                    {TagItemsModel::TagItemDataRole::Link, "Link"}};
}

int TagItemsModel::rowCount(const QModelIndex& parent) const
{
    return _tagItems.size();
}

int TagItemsModel::columnCount(const QModelIndex& parent) const
{
    return 3;
}

QVariant TagItemsModel::data(const QModelIndex& index, int role) const
{
    auto const row = index.row();
    if(row > _tagItems.size())
        return createTagItem().m_name;
    auto& res = _tagItems[row];
    switch(role)
    {
    case TagItemsModel::Name:
        return res.m_name;
    case TagItemsModel::Description:
        return res.m_description;
    case TagItemsModel::Link:
        return res.m_link;
    default:
        return "";
    }
}

QVariant TagItemsModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    return _roles[role];
}

QHash<int, QByteArray> TagItemsModel::roleNames() const
{
    return _roles;
}

bool TagItemsModel::addTagItem(const TagItemData& data)
{
    if(_tagItems.contains(data))
    {
        return false;
    }
    // tell QT what you will be doing
    beginInsertRows(QModelIndex(), _tagItems.size(), _tagItems.size());
    _tagItems.append(data);
    // tell QT you are done
    endInsertRows();
    return true;
}

void TagItemsModel::generateHeader()
{

    for(int i = TagItemsModel::TagItemDataRole::Name; i <= TagItemsModel::TagItemDataRole::Link;
        ++i)
    {
        setHeaderData(0, Qt::Horizontal, _roles[i], i);
    }
}

bool TagItemsModel::contains(const QString& name)
{
    for(auto const& item : qAsConst(_tagItems))
    {
        if(item == name)
        {
            return true;
        }
    }
    return false;
}
