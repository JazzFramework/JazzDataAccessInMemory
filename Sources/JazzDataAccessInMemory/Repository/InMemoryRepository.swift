import Foundation;

import JazzDataAccess;

internal final class InMemoryRepository<TResource: Storable>: Repository<TResource> {
    private var data: [String: TResource];

    private let lock: NSLock;

    private let criterionProcessor: CriterionProcessor<TResource>;
    private let hintProcessor: HintProcessor<TResource>;

    internal init(criterionProcessor: CriterionProcessor<TResource>, hintProcessor: HintProcessor<TResource>) {        
        data = [:];
        lock = NSLock();

        self.criterionProcessor = criterionProcessor;
        self.hintProcessor = hintProcessor;

        super.init();
    }

    public final override func create(_ models: [TResource], with hints: [QueryHint]) async throws -> [TResource] {
        for model in models {
            lock.withLock() {
                data[model.getId()] = model;
            }
        }

        return models;
    }

    public final override func delete(for criteria: [QueryCriterion], with hints: [QueryHint]) async throws {
        let toDelete: [TResource] = try await get(for: criteria, with: hints).getData();

        for model in toDelete {
            _ = lock.withLock() {
                data.removeValue(forKey: model.getId());
            }
        }
    }

    public final override func update(_ models: [TResource], with hints: [QueryHint]) async throws -> [TResource] {
        for model in models {
            lock.withLock() {
                data[model.getId()] = model;
            }
        }

        return models;
    }

    public final override func get(for criteria: [QueryCriterion], with hints: [QueryHint]) async throws -> PaginationResult<TResource> {
        let query: InMemoryQuery<TResource> = getQuery();

        try criterionProcessor.handle(for: query, with: criteria);

        try hintProcessor.handle(for: query, with: hints);

        return PaginationResult(data: query.getData(), page: 0, total: 0);
    }

    private final func getQuery() -> InMemoryQuery<TResource> {
        return InMemoryQuery<TResource>(data: Array(data.values));
    }
}