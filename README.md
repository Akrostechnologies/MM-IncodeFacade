# MMIncodeFacade


## Demo 

https://github.com/Akrostechnologies/MM-IncodeFacade/assets/120066463/5c1e2b70-f49d-4223-8490-0f8f548c951e

### Installation 💾

SPM

Open Xcode and your project, click File / Swift Packages / Add package dependency... . In the textfield "Enter package repository URL", write https://github.com/Akrostechnologies/MM-IncodeFacade and press Next twice



### Getting Started

1. Lets create a viewModel, where all logic will be handle here

```swift
class ViewModel: ObservableObject {

  var cancellables = Set<AnyCancellable>()
  @Published var showModal = false

  let manager = MMIncodeManager(INCodeParams(
    urlString: "http://some-url.com",
    apiKey: "some api key",
    testMode: false // Test mode only works for simulator
   ))
  
  init() {
    setupBindings()
  }
   
  private func setupBindings() {
    manager.onFinishFlow
          .receive(on: DispatchQueue.main)
          .sink { [weak self] result in
              switch result {
                  case .success(let documents):
                      break
                  case .userFinish:
                      break
                  case .error(let message):
                      print("El error es: ", message)
                  default: break
              }

              self?.showModal = false
          }.store(in: &cancellables)
  }
  
  func buildSignature() -> SignatureModel {
        
        let documents: [DocumentModel] = [
            .init(
                title: "Documento 1",
                urlString: "https://www.africau.edu/images/default/sample.pdf"
            ),
            .init(
                title: "Documento 2",
                urlString: "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"
            ),
            .init(
                title: "Documento 3",
                urlString: "https://s29.q4cdn.com/175625835/files/doc_downloads/test.pdf"
            ),
        ]
        
        return .init(
            documents: documents
        )
    }
}
```

2. Now let's create a ContentView

```swift
struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Button {
                viewModel.showModal.toggle()
            } label: {
                Text("Tap me")
                    .font(.title)
                    .frame(width: 200, height: 40)
            }
        }.fullScreenCover(isPresented: $viewModel.showModal, content: {
            viewModel.manager.presentSignature(
                item: viewModel.buildSignature()
            )
        })
    }
}
```

### Localizable strings:

```swift
"incdOnboarding.signature.signDocument.acceptButton" = "Continuar";
"incdOnboarding.signature.btnClear" = "Borrar firma";
"incdOnboarding.signature.signHere" = "Por favor, firme aquí";
"incdOnboarding.global.button.done" = "Continuar";
"incdOnboarding.signature.title" = "Firma para autorizar";
"incdOnboarding.signature.description" = "Realiza tu firma en el recuadro para dar de alta tu cuenta.";
"incdOnboarding.signature.preview.title" = "Autoriza tu cuenta";
"incdOnboarding.signature.preview.description" = "Lee y firma el documento que aparece en la siguiente pantalla para autorizar tu cuenta.";
"incdOnboarding.signature.error.title" = "Intenta de nuevo";
"incdOnboarding.signature.error.message" = "Hubo un problema de conexión con el sistema, intenta de nuevo";
"incdOnboarding.signature.error.firstButton" = "Intenta de nuevo";
"incdOnboarding.signature.error.defaultButton" = "Volver";
```


### Update Incode frameworks
1. Go to install-frameworks folder
2. Open terminal and run next command: `sh install-incode.sh RELEASE_TAG`
e.g:

```console
sh install-incode.sh 5.16.0-d
```

### Structure


![MMIncodeFacade](https://github.com/Akrostechnologies/MM-IncodeFacade/assets/120066463/3b1b055a-ea0d-4388-8656-bdc09ca9fe8d)

