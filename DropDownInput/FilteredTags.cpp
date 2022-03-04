#include "FilteredTags.h"
#include "TagItemsModel.h"
#include <QGuiApplication>
#include <QModelIndex>
#include <QRegExp>

FilteredTags::FilteredTags(QObject* parent)
    : QSortFilterProxyModel(parent)
{
    //    setSortCaseSensitivity(Qt::CaseInsensitive);
    //    setFilterKeyColumn(0);
    setFilterRole(TagItemsModel::TagItemDataRole::Name);
    setDynamicSortFilter(true);
    connect(this, &FilteredTags::originalModelChanged, this, [this]() {
        setSourceModel(originalModel());
    });
    connect(this, &FilteredTags::filterPatternsChanged, this, &FilteredTags::setNewFilter);
}

TagItemsModel* FilteredTags::originalModel() const
{
    return _originalModel;
}

void FilteredTags::setOriginalModel(TagItemsModel* newOriginalModel)
{
    if(_originalModel == newOriginalModel)
        return;
    _originalModel = newOriginalModel;
    _originalModel->generateHeader();
    emit originalModelChanged();
}

const QString& FilteredTags::filterPattern() const
{
    return _patternString;
}

void FilteredTags::setFilterPattern(const QString& newFilterPatterns)
{
    if(_patternString == newFilterPatterns)
        return;
    _patternString = newFilterPatterns;
    emit filterPatternsChanged();
}

void FilteredTags::setNewFilter()
{
    QRegExp::PatternSyntax syntax = QRegExp::PatternSyntax::RegExp; //TODO options
    Qt::CaseSensitivity caseSensitivity = Qt::CaseInsensitive; //TODO options!
    QRegExp regExp(filterPattern(), caseSensitivity, syntax);
    setFilterRegExp(regExp);
}
