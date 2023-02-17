import JazzDataAccess;

internal final class IdQueryCriterionHandler<TResource: Storable>: BaseCriterionHandler<TResource, InMemoryQuery<TResource>, IdQueryCriterion> {
    internal override init() {
        super.init();
    }

    public override final func process(for query: InMemoryQuery<TResource>, with criterion: IdQueryCriterion) {
        query.set(data: query.getData().filter({ $0.getId() == criterion.getId() }));
    }
}