import CoreData
import Foundation
import SwiftUI

enum Predicate {
    case beginsWith(caseSensitive: Bool = false)
    case smaller
    case bigger
    case equals
    case notBeginsWith(caseSensitive: Bool = false)
    case contains

    func predication(filterKey: String, filterValue: String) -> NSPredicate {
        switch self {
        case .beginsWith(let caseSensitive):
            return caseSensitive
                ? NSPredicate(format: "%K BEGINSWITH[c] %@", filterKey, filterValue)
                : NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue)
        case .smaller: return NSPredicate(format: "%K < %@", filterKey, filterValue)
        case .bigger: return NSPredicate(format: "%K > %@", filterKey, filterValue)
        case .equals: return NSPredicate(format: "%K == %@", filterKey, filterValue)
        case .notBeginsWith(let caseSensitive):
            return caseSensitive
                ? NSPredicate(format: "NOT %K BEGINSWITH[c] %@", filterKey, filterValue)
                : NSPredicate(format: "NOT %K BEGINSWITH %@", filterKey, filterValue)
        case .contains: return NSPredicate(format: "%K IN %@", filterKey, filterValue)
        }
    }
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String,
         filterValue: String,
         sortDescriptors: [NSSortDescriptor] = [],
         predicate: Predicate,
         @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(),
                                       sortDescriptors: sortDescriptors,
                                       predicate: predicate.predication(filterKey: filterKey, filterValue: filterValue))
        self.content = content
    }
}
