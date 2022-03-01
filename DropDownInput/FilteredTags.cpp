#include "FilteredTags.h"
#include "TagItemsModel.h"
#include <QGuiApplication>
#include <QModelIndex>
#include <QRegExp>
#include <QSortFilterProxyModel>

FilteredTags::FilteredTags(QObject* parent)
    : QObject(parent)
    , _filteredModel(new QSortFilterProxyModel(this))
{
    //    _filteredModel->setSortCaseSensitivity(Qt::CaseInsensitive);
    //    _filteredModel->setFilterKeyColumn(0);
    _filteredModel->setFilterRole(256);
    //    _filteredModel->setDynamicSortFilter(true);
    connect(this, &FilteredTags::originalModelChanged, this, [this]() {
        _filteredModel->setSourceModel(originalModel());
    });
    connect(this, &FilteredTags::filterPatternsChanged, this, &FilteredTags::setNewFilter);
}

QSortFilterProxyModel* FilteredTags::filteredModel() const
{
    return _filteredModel;
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
    filteredModel()->setFilterRegExp(QRegExp("(\\d+)"));
    //    QRegularExpression re(filterPattern());
    //    re.setPatternOptions(QRegularExpression::PatternOption::MultilineOption);
    //    filteredModel()->setFilterRegularExpression(re);
}
