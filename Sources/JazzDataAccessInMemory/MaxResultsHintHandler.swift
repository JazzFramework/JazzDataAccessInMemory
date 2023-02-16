import JazzDataAccess;

public final class MaxResultsHintHandler<TResource: Storable>: BaseHintHandler<TResource, InMemoryQuery<TResource>, MaxResultsHint> {
    public override init() {
        super.init();
    }

    public override final func process(for query: InMemoryQuery<TResource>, with hint: MaxResultsHint) {
        query.set(data: Array(query.getData().prefix(hint.getCount())));
    }
}