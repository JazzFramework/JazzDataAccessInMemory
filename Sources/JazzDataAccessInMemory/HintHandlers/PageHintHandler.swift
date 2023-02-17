import JazzDataAccess;

internal final class PageHintHandler<TResource: Storable>: BaseHintHandler<TResource, InMemoryQuery<TResource>, PageHint> {
    internal override init() {
        super.init();
    }

    public final override func process(for query: InMemoryQuery<TResource>, with hint: PageHint) {
        let startIndex: Int = hint.getSize() * hint.getPage();

        query.set(data: Array(query.getData()[startIndex..<(startIndex + hint.getSize())]));
    }
}