import Foundation

class TestModel: ObservableObject{
    
    @Published var items: [TestItem] = [TestItem(), TestItem(), TestItem(), TestItem(), TestItem()]
    @Published var selectedItem: String? = ""
}

struct TestItem : Identifiable {
    
    let id = UUID().uuidString
    let lastMsg : String = ""
}
