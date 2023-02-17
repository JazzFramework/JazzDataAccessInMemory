import JazzDataAccess;

internal final class MaxResultsHintHandler<TResource: Storable>: BaseHintHandler<TResource, InMemoryQuery<TResource>, MaxResultsHint> {
    internal override init() {
        super.init();
    }

    public final override func process(for query: InMemoryQuery<TResource>, with hint: MaxResultsHint) {
        query.set(data: Array(query.getData().prefix(hint.getCount())));
    }
}