import SwiftUI

struct SettingsView: View {

    @AppStorage("retroarchConfigPath") private var configPath: String = Path.DEFAULT_CONFIGURATION_PATH
    @State private var showFileImporter = false

    var body: some View {
        Form {
            Section("RetroArch") {
                LabeledContent("retroarch.cfg") {
                    HStack {
                        Text(configPath)
                            .lineLimit(1)
                            .truncationMode(.middle)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Button("Browse...") {
                            showFileImporter = true
                        }
                    }
                }

                Button("Reset to Default") {
                    configPath = Path.DEFAULT_CONFIGURATION_PATH
                }
                .foregroundStyle(.secondary)
            }
        }
        .formStyle(.grouped)
        .fileImporter(
            isPresented: $showFileImporter,
            allowedContentTypes: [.data],
            allowsMultipleSelection: false
        ) { result in
            if case .success(let urls) = result, let url = urls.first {
                configPath = url.path
            }
        }
    }
}

#Preview {
    SettingsView()
}
