//
//  ListAlertBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 6/8/22.
//

import SwiftUI

public struct ListAlertBlock: View {
    
    var missingRequirements: Bool
    var notExported: Bool
    var deleted: Bool
    
    public init(missingRequirements: Bool, notExported: Bool, deleted: Bool = false) {
        self.missingRequirements = missingRequirements
        self.notExported = notExported
        self.deleted = deleted
    }
    
    
    public var body: some View {
        VStack(alignment: .leading) {
            if missingRequirements || notExported || deleted {
                Divider()
                    .frame(width: 20)
            }
            if missingRequirements || deleted {
                Text(deleted ? "Deleted" : "Missing Required Fields")
                    .foregroundColor(Color.red)
                    .font(.caption2)
            }
            if notExported {
                Text("Not Exported")
                    .foregroundColor(Color("NotExported"))
                    .font(.caption2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ListAlertBlock_Previews: PreviewProvider {
    static var previews: some View {
        ListAlertBlock(missingRequirements: true, notExported: true)
    }
}
