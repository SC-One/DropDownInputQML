#ifndef FILTEREDTAGS_H
#define FILTEREDTAGS_H

#include <QObject>
#include <QQmlEngine>
#include <QStringList>
class TagItemsModel;
class QSortFilterProxyModel;
class FilteredTags : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QSortFilterProxyModel* filteredModel READ filteredModel CONSTANT)
    Q_PROPERTY(TagItemsModel* originalModel READ originalModel WRITE setOriginalModel NOTIFY
                   originalModelChanged)
    Q_PROPERTY(QString filterPattern READ filterPattern WRITE setFilterPattern NOTIFY
                   filterPatternsChanged)
public:
    explicit FilteredTags(QObject* parent = nullptr);

    QSortFilterProxyModel* filteredModel() const;

    TagItemsModel* originalModel() const;
    void setOriginalModel(TagItemsModel* newOriginalModel);

    const QString& filterPattern() const;
    void setFilterPattern(const QString& newFilterPatterns);

    static inline void RegisterToQML()
    {
        qmlRegisterType<QSortFilterProxyModel>("ir.hcoding.models", 1, 0, "QSortFilterProxyModel");
        qmlRegisterType<FilteredTags>("ir.hcoding.models", 1, 0, "FilteredTags");
    }
signals:

    void originalModelChanged();

    void filterPatternsChanged();

private:
    void setNewFilter();

private:
    QString _patternString;
    QSortFilterProxyModel* _filteredModel;
    TagItemsModel* _originalModel;
};

#endif // FILTEREDTAGS_H
