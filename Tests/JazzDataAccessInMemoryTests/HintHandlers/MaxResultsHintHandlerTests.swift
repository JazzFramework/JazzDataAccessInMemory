import XCTest;

import JazzDataAccess;

@testable import JazzDataAccessInMemory;

final class MaxResultsHintHandlerTests: XCTestCase {
    func test_process_whenMaxIsMoreThanQuery_returnsTheMaxQuery() throws {
        //Arrange
        let subject: MaxResultsHintHandler<TestResource> = MaxResultsHintHandler();
        let query: InMemoryQuery<TestResource> = InMemoryQuery(data:
            [
                TestResource(id: "id1"),
                TestResource(id: "id2"),
                TestResource(id: "id3"),
                TestResource(id: "id4"),
                TestResource(id: "id5")
            ]
        );
        let hint: MaxResultsHint = MaxResultsHint(10);

        //Act
        subject.process(for: query, with: hint);

        //Assert
        XCTAssertEqual(query.getData().count, 5);
    }

    func test_process_whenMaxIsLessThanQuery_returnsTheTruncatedQuery() throws {
        //Arrange
        let subject: MaxResultsHintHandler<TestResource> = MaxResultsHintHandler();
        let query: InMemoryQuery<TestResource> = InMemoryQuery(data:
            [
                TestResource(id: "id1"),
                TestResource(id: "id2"),
                TestResource(id: "id3"),
                TestResource(id: "id4"),
                TestResource(id: "id5")
            ]
        );
        let hint: MaxResultsHint = MaxResultsHint(3);

        //Act
        subject.process(for: query, with: hint);

        //Assert
        XCTAssertEqual(query.getData().count, 3);
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