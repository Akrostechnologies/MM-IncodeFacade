# Testing

# Testing

<details>
<summary>Relevant source files</summary>

The following files were used as context for generating this wiki page:

- [Package.swift](Package.swift)
- [README.md](README.md)

</details>



The `MMIncodeFacade` project includes a dedicated test target designed to validate the integration between the facade layer and the underlying `IncdOnboarding` SDK. Testing in this environment involves managing hardware constraints (such as the camera) and ensuring that the Combine-based event stream correctly reports the status of signature flows.

## Test Target Configuration

The testing infrastructure is located within the `Tests/MMIncodeFacadeTests/` directory. It is defined as a standard `testTarget` within the Swift Package Manager configuration.

| Property | Value |
| :--- | :--- |
| **Target Name** | `MMIncodeFacadeTests` |
| **Location** | `Tests/MMIncodeFacadeTests/` |
| **Dependencies** | `MMIncodeFacade` |

### Code Entity Mapping: Test Definition
The following diagram illustrates how the test target is linked to the main library within the package manifest.

**Target Dependency Graph**
```mermaid
graph TD
    subgraph "Package.swift"
        [Package] --> [MMIncodeFacade_Library]
        [MMIncodeFacade_Library] --> [MMIncodeFacade_Target]
        [MMIncodeFacade_Target] --> [IncdOnboarding_Binary]
        [MMIncodeFacadeTests_Target] --> [MMIncodeFacade_Target]
    end

    style [MMIncodeFacadeTests_Target] stroke-dasharray: 5 5
```
Sources: [Package.swift:27-35]()

## Simulator Testing with testMode

A significant challenge when testing onboarding SDKs is the requirement for physical hardware (camera) to capture signatures or biometric data. The `MMIncodeFacade` addresses this through the `testMode` flag within the `IncodeParams` configuration.

### Implementation Details
When initializing the `MMIncodeManager`, the `testMode` boolean determines how the underlying `IncdOnboarding` SDK behaves on simulator targets.

*   **`testMode: true`**: Enables simulator-based testing. This allows the flow to bypass certain hardware checks that would otherwise cause the SDK to crash or hang on a simulator.
*   **`testMode: false`**: Standard production mode; requires a physical device for camera-dependent modules.

### Code Entity Mapping: Configuration Flow
The diagram below shows how the `testMode` flag travels from the consumer initialization into the manager logic.

**Test Mode Data Flow**
```mermaid
graph LR
    subgraph "Consumer Code"
        [ViewModel] -- "init" --> [IncodeParams]
    end

    subgraph "MMIncodeFacade"
        [IncodeParams] -- "testMode: Bool" --> [MMIncodeManager]
        [MMIncodeManager] -- "configure" --> [IncdOnboardingManager]
    end

    subgraph "IncdOnboarding SDK"
        [IncdOnboardingManager] -- "Internal Logic" --> [SimulatorBehavior]
    end
```
Sources: [README.md:26-30](), [Package.swift:27-30]()

## Integration Testing Guidance

While the repository contains a placeholder test, meaningful integration tests against the facade should focus on the `onFinishFlow` `PassthroughSubject`. Because the signature flow is asynchronous and UI-driven, tests should utilize expectations to wait for SDK callbacks.

### Key Areas for Testing

1.  **Initialization**: Verify that `MMIncodeManager` correctly processes `IncodeParams` and prepares the `IncdOnboarding` singleton.
2.  **Flow Result Mapping**: Validate that the `FlowStatus` enum correctly captures outcomes from the `SignatureContentViewModel`.
3.  **Document Handling**: Ensure that `SignatureModel` and `DocumentModel` correctly transform URLs for the `PDFKitView`.

### Example Test Structure
When writing tests in `MMIncodeFacadeTests`, follow this pattern to observe the flow status:

```swift
// Guidance for future test implementation
func testSignatureFlowEmission() {
    let params = INCodeParams(urlString: "...", apiKey: "...", testMode: true)
    let manager = MMIncodeManager(params)
    let expectation = XCTestExpectation(description: "Flow should emit status")
    
    manager.onFinishFlow
        .sink { result in
            // Assert on FlowStatus cases (success, userFinish, error)
            expectation.fulfill()
        }
        .store(in: &cancellables)
        
    // Triggering the flow manually in a test environment
}
```
Sources: [README.md:36-52](), [Package.swift:31-34]()

## Environment Constraints

| Environment | Camera Access | `testMode` Requirement |
| :--- | :--- | :--- |
| **Physical Device** | Available | Can be `false` |
| **iOS Simulator** | Unavailable | Must be `true` |
| **CI/CD Runner** | Unavailable | Must be `true` |

Sources: [README.md:29-29]()

---