import JazzDataAccess;

public final class IdsQueryCriterionHandler<TResource: Storable>: BaseCriterionHandler<TResource, InMemoryQuery<TResource>, IdsQueryCriterion> {
    public override init() {
        super.init();
    }

    public override final func process(for query: InMemoryQuery<TResource>, with criterion: IdsQueryCriterion) {
        query.set(data: query.getData().filter({ criterion.getIds().contains($0.getId()) }));
    }
}