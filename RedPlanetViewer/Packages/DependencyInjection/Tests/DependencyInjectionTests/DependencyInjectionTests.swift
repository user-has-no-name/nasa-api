@testable import DependencyInjection
import Quick
import Nimble

class MockDependency {

    var value: String = ""

    init() {}

    func setValue(_ value: String) {
        self.value = value
    }
}

final class DependencyInjectionTests: QuickSpec {

    override class func spec() {
        describe("DependenciesContainer") {

            beforeEach {
                DependenciesContainer.removeAllDependencies()
                DependenciesContainer.emptyCache()
            }

            it("should be able to resolve automatic dependency") {
                DependenciesContainer.register(type: MockDependency.self, MockDependency())
                let dependency: MockDependency? = DependenciesContainer.resolve(.automatic, MockDependency.self)
                expect(dependency).toNot(beNil())
                expect(dependency).to(beAKindOf(MockDependency.self))
            }

            it("should be able to resolve cached dependency") {
                DependenciesContainer.register(type: MockDependency.self, MockDependency())
                let dependency: MockDependency? = DependenciesContainer.resolve(.cached, MockDependency.self)
                expect(dependency).toNot(beNil())
                expect(dependency).to(beAKindOf(MockDependency.self))
            }

            it("should be able to resolve newCached dependency") {
                DependenciesContainer.register(type: MockDependency.self, MockDependency())
                let dependency: MockDependency? = DependenciesContainer.resolve(.newCached, MockDependency.self)
                expect(dependency).toNot(beNil())
                expect(dependency).to(beAKindOf(MockDependency.self))
            }

            it("dependency should be cached once it's resolved as a cached") {
                DependenciesContainer.register(type: MockDependency.self, MockDependency())
                _ = DependenciesContainer.resolve(.cached, MockDependency.self)

                expect(DependenciesContainer.cache.count).toNot(equal(0))

                let dependencyName: String = .init(describing: MockDependency.self)
                expect(DependenciesContainer.cache[dependencyName]).to(beAKindOf(MockDependency.self))
            }

            it("should return the same instance on multiple resolutions") {
                DependenciesContainer.register(type: MockDependency.self, MockDependency())

                let instance1 = DependenciesContainer.resolve(.cached, MockDependency.self)
                let instance2 = DependenciesContainer.resolve(.cached, MockDependency.self)

                expect(instance1).to(beIdenticalTo(instance2))
            }

            it("should return nil for unregistered dependency") {
                let dependency: MockDependency? = DependenciesContainer.resolve(.automatic, MockDependency.self)
                expect(dependency).to(beNil())
            }

            it("should inject the dependency correctly") {
                DependenciesContainer.register(type: MockDependency.self, MockDependency())

                struct TestClass {
                    @Injected var dependency: MockDependency
                }

                let testInstance = TestClass()

                expect(testInstance.dependency).toNot(beNil())
                expect(testInstance.dependency).to(beAKindOf(MockDependency.self))
            }

            it("should throw fatal error if not registered") {
                expect( { @Injected var dependency: MockDependency }).to(throwAssertion())
            }

            it("should allow mutating set") {
                DependenciesContainer.register(type: MockDependency.self, MockDependency())

                struct TestClass {
                    @Injected var dependency: MockDependency
                }

                var testInstance = TestClass()

                testInstance.dependency = MockDependency()
                testInstance.dependency.setValue("UpdatedValue")

                expect(testInstance.dependency.value).to(equal("UpdatedValue"))
            }
        }
    }
}
