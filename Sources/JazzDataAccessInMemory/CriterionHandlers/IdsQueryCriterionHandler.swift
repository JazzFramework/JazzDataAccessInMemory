import JazzDataAccess;

internal final class IdsQueryCriterionHandler<TResource: Storable>: BaseCriterionHandler<TResource, InMemoryQuery<TResource>, IdsQueryCriterion> {
    internal override init() {
        super.init();
    }

    public final override func process(for query: InMemoryQuery<TResource>, with criterion: IdsQueryCriterion) {
        query.set(data: query.getData().filter({ criterion.getIds().contains($0.getId()) }));
    }
}