import SwiftUI

struct TestView: View {
    @StateObject var testModel:TestModel = TestModel()
    @State private var selection: String? = nil
    
    var body: some View {
        List(selection:$selection){
            ForEach(testModel.items){item in
                Text("Item")
            }
        }
        .onAppear(){
            selection = testModel.selectedItem
        }
        .onChange(of: selection){
            print("onChange")
            testModel.selectedItem = selection
        }
    }
}

#Preview {
    TestView()
}
