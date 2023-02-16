import XCTest;

import JazzDataAccess;

@testable import JazzDataAccessInMemory;

final class IdsQueryCriterionHandlerTests: XCTestCase {
    func test_process_whenNoMatch_producesEmptyResult() throws {
        //Arrange
        let subject: IdsQueryCriterionHandler<TestResource> = IdsQueryCriterionHandler();
        let query: InMemoryQuery<TestResource> = InMemoryQuery(data:
            [TestResource(id: "id1"), TestResource(id: "id2"), TestResource(id: "id3")]
        );
        let criterion: IdsQueryCriterion = IdsQueryCriterion(["fake-id"]);

        //Act
        subject.process(for: query, with: criterion);

        //Assert
        XCTAssertEqual(query.getData().count, 0);
    }

    func test_process_whenNoMatch_producesPopulatedResult() throws {
        //Arrange
        let subject: IdsQueryCriterionHandler<TestResource> = IdsQueryCriterionHandler();
        let query: InMemoryQuery<TestResource> = InMemoryQuery(data:
            [
                TestResource(id: "id1"),
                TestResource(id: "id2"),
                TestResource(id: "id3"),
                TestResource(id: "id4"),
                TestResource(id: "id5")
            ]
        );
        let criterion: IdsQueryCriterion = IdsQueryCriterion(["id2", "id4"]);

        //Act
        subject.process(for: query, with: criterion);

        //Assert
        XCTAssertEqual(query.getData().count, 2);
        XCTAssertEqual(query.getData()[0].getId(), "id2");
        XCTAssertEqual(query.getData()[1].getId(), "id4");
    }

    private final class TestResource: Storable {
        var id: String;

        internal init(id: String) {
            self.id = id;
        }

        public final func getId() -> String {
            return id;
        }

        public final func set(id: String) {
            self.id = id;
        }
    }
}