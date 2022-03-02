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
    setFilterRole(256);
    setDynamicSortFilter(true);
    connect(this, &FilteredTags::originalModelChanged, this, [this]() {
        setSourceModel(originalModel());
    });
    connect(this, &FilteredTags::filterPatternsChanged, this, &FilteredTags::setNewFilter);
}

bool FilteredTags::filterAcceptsRow(int sourceRow, const QModelIndex& sourceParent) const
{
    QModelIndex index0 = sourceModel()->index(sourceRow, 0, sourceParent);
    return sourceModel()
        ->data(index0, TagItemsModel::TagItemDataRole::Name)
        .toString()
        .contains(filterPattern());
    //    {
    //        QModelIndex index0 = sourceModel()->index(sourceRow, 0, sourceParent);
    //        QModelIndex index1 = sourceModel()->index(sourceRow, 1, sourceParent);
    //        QModelIndex index2 = sourceModel()->index(sourceRow, 2, sourceParent);

    //        return (sourceModel()->data(index0).toString().contains(filterRegExp()) ||
    //                sourceModel()->data(index1).toString().contains(filterRegExp()) ||
    //                sourceModel()->data(index2).toString().contains(filterRegExp()));
    //    }
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
    setFilterRegExp(QRegExp("(\\d+)"));
    //    setFilterRegExp(regExp);
    //    QRegularExpression re(filterPattern());
    //    re.setPatternOptions(QRegularExpression::PatternOption::MultilineOption);
    //     setFilterRegularExpression(re);
}
