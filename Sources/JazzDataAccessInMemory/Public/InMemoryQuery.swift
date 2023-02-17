import JazzDataAccess;

public final class InMemoryQuery<TResource: Storable>: Query<TResource> {
    private var data: [TResource];

    internal init(data: [TResource]) {
        self.data = data;

        super.init();
    }

    public final func getData() -> [TResource] { data }

    internal final func set(data: [TResource]) {
        self.data = data;
    }
}