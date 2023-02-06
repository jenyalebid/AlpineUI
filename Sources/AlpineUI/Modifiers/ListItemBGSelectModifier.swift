import SwiftUI

public struct ListItemBGSelectModifier: ViewModifier {
    
    enum SelectionState {
        case selected
        case longPress
        case none
    }
    
    @State var state = SelectionState.none
    @State var selectedID: UUID?
    
    var id: UUID?
    var showSelected: Bool
    
    var selectedColor = Color(hex: "A2C285")
    var longPressColor = Color(hex: "E17355")
    
    var bgColor: Color? {
        switch state {
        case .selected:
            return selectedColor
        case .longPress:
            return longPressColor
        case .none:
            return Color(uiColor: .systemBackground)
        }
    }
    
    public init(id: UUID? = nil, showSelected: Bool) {
        self.id = id
        self.showSelected = showSelected
    }
    
    public func body(content: Content) -> some View {
        content
            .background(bgColor)
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("ListItemLongPress"))) { id in
                if self.id == id.userInfo?.first?.value as? UUID {
                    state = .longPress
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("AlertCancel"))) { _ in
                state = self.id == selectedID ? .selected : .none
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ListItemSelect"))) { id in
                if let selectedID = id.userInfo?.first?.value as? UUID {
                    if self.id == selectedID {
                        state = .selected
                    }
                    else {
                        state = .none
                    }
                }
            }
    }
}

extension View {
    public func listItemBackGround(id: UUID?, showSelected: Bool = true) -> some View {
        return modifier(ListItemBGSelectModifier(id: id, showSelected: showSelected))
    }
}

