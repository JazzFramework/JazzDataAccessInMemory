import JazzDataAccess;

public final class InMemoryRepositoryBuilder<TResource: Storable> {
    private var criterionHandlers: [CriterionHandler<TResource>] = [
        IdQueryCriterionHandler<TResource>(),
        IdsQueryCriterionHandler<TResource>()
    ];

    private var hintHandlers: [HintHandler<TResource>] = [
        MaxResultsHintHandler<TResource>(),
        PageHintHandler<TResource>()
    ];

    public init() {}

    public final func with(criterionHandler: CriterionHandler<TResource>) -> InMemoryRepositoryBuilder<TResource> {
        criterionHandlers.append(criterionHandler);

        return self;
    }

    public final func with(hintHandler: HintHandler<TResource>) -> InMemoryRepositoryBuilder<TResource> {
        hintHandlers.append(hintHandler);

        return self;
    }

    public final func build() async throws -> Repository<TResource> {
        InMemoryRepository<TResource>(
            criterionProcessor: CriterionProcessorImpl<TResource>(criterionHandlers: criterionHandlers),
            hintProcessor: HintProcessorImpl<TResource>(hintHandlers: hintHandlers)
        )
    }
}