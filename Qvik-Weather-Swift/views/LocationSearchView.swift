//
//  SearchView.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 5.1.2025.
//

import SwiftUI

public struct LocationSearchView: View {
    @Binding var isSearching: Bool
    @Binding var selectedLocation: Geo.GeoObject?
    
    @State private var searchResults: [Geo.GeoObject] = []
    @State private var searchQuery: String = ""
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack {
                LocationSearchTextFieldView(
                    searchText: self.$searchQuery,
                    isSearching: self.$isSearching
                )
                
                if isSearching {
                    LocationSearchCancelButtonView(
                        isSearching: self.$isSearching,
                        searchText: self.$searchQuery
                    )
                }
            }
                .padding(.horizontal)
            
            if self.searchResults.count > 0 && self.searchQuery.count > 0 {
                LocationSearchResultsView(
                    searchText: self.$searchQuery,
                    searchResults: self.$searchResults,
                    selectedResult: self.$selectedLocation
                )
            } else if self.isSearching {
                NoResultsView()
            }
            
            Spacer()
        }
            .padding(.top, 20)
            .padding(.bottom, self.isSearching ? 400 : 0)
            .animation(.easeInOut, value: self.isSearching)
            .frame(maxHeight: .infinity)
            .onChange(of: self.searchQuery) {
                self.search()
            }
    }
    
    private func search() {
        let query = self.searchQuery
        guard query.count > 0 else { return }
        
        do {
            let geo = try Geo(q: query)
            self.searchResults = geo.geo
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}

private struct LocationSearchTextFieldView: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            Image("search_search_symbol")
                .frame(width: 24, height: 24)
                .padding(.leading, 10)
            
            LocationSearchTextField(
                searchText: self.$searchText,
                isSearching: self.$isSearching
            )
            
            if self.searchText.count > 0 {
                LocationSearchTextFieldEmptyButtonView(
                    searchText: self.$searchText
                )
            }
        }
            .background(Color.white)
            .cornerRadius(20)
            .font(.custom("Inter-Regular", size: 16))
            .foregroundStyle(Color.textFieldText)
            .onTapGesture {
                if !self.isSearching {
                    withAnimation {
                        self.isSearching = true
                    }
                }
            }
    }
    
}

private struct LocationSearchTextField: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        TextField(
            "",
            text: self.$searchText,
            prompt: Text(
                "Search country, region, city")
            .foregroundStyle(Color.textFieldText)
        )
            .padding(.vertical, 10)
            .foregroundStyle(Color.textFieldText)
            .onChange(of: self.searchText) {
                withAnimation {
                    if self.searchText.count == 0 {
                        self.isSearching = false
                    } else if !self.isSearching {
                        self.isSearching = true
                    }
                }
            }
    }
    
}

private struct LocationSearchTextFieldEmptyButtonView: View {
    @Binding var searchText: String
    
    var body: some View {
        Image("close_close_symbol")
            .frame(width: 24, height: 24)
            .padding(.trailing, 10)
            .foregroundStyle(Color.textFieldText)
            .onTapGesture {
                withAnimation {
                    self.searchText = ""
                }
            }
    }
    
}

private struct LocationSearchCancelButtonView: View {
    @Binding var isSearching: Bool
    @Binding var searchText: String
    
    var body: some View {
        Button("Cancel") {
            withAnimation {
                self.isSearching = false
                self.searchText = ""
            }
        }
            .padding(.horizontal, 5)
            .transition(.move(edge: .trailing))
            .font(.custom("Inter-Regular", size: 14))
            .foregroundStyle(Color.white)
    }
    
}

private struct LocationSearchResultsView: View {
    @Binding var searchText: String
    @Binding var searchResults: [Geo.GeoObject]
    @Binding var selectedResult: Geo.GeoObject?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ForEach(self.searchResults) { result in
                    self.searchResultListItem(result: result)
                        .onTapGesture {
                            print("Selected city: \(result.name)")
                            self.selectedResult = result
                            self.searchResults = []
                        }
                        .tag(result.id)
                        .padding(.top, 5)
                }.listRowBackground(Color.clear)
            }
                .scrollContentBackground(.hidden)
                .frame(maxHeight: .infinity)
                .padding(.horizontal, 60)
            
            Spacer()
        }
    }
    
    private func attributedResult(for result: String) -> AttributedString {
        var attributedString = AttributedString(result)
        
        if let stringRange = result.range(
            of: self.searchText,
            options: [.caseInsensitive, .anchored]
        ) {
            let attributedRange = Range(stringRange, in: attributedString)
            if let attributedRange {
                attributedString[attributedRange].font = .custom("Inter-Regular_Bold", size: 16)
            }
        }

        return attributedString
    }
    
    private func searchResultListItem(result: Geo.GeoObject) -> some View {
        let string = result.state != nil
            ? "\(result.name), \(result.country) \(result.state!)"
            : "\(result.name), \(result.country)"
        
        return Text(self.attributedResult(for: string))
            .font(.custom("Inter-Regular", size: 16))
            .foregroundStyle(Color.mainText)
    }
    
}

private struct NoResultsView: View {
    var body: some View {
        Text("No Results")
            .font(.custom("Inter-Regular_Bold", size: 30))
            .foregroundStyle(Color.mainText)
            .padding()
            .padding(.top, 40)
    }
    
}

#if DEBUG
#Preview("Search On - Not Selected") {
    VStack {
        LocationSearchView(
            isSearching: .constant(true),
            selectedLocation: .constant(nil)
        )
        Spacer()
    }
        .background(weatherBackgroundGradientView)
}

#Preview("Search On") {
    VStack {
        LocationSearchView(
            isSearching: .constant(true),
            selectedLocation: .constant(Geo.sampleResponseCopen.geo.first)
        )
        Spacer()
    }
        .background(weatherBackgroundGradientView)
}

#Preview("Search Off") {
    VStack {
        LocationSearchView(
            isSearching: .constant(false),
            selectedLocation: .constant(Geo.sampleResponseCopen.geo.first)
        )
        Spacer()
    }
        .background(weatherBackgroundGradientView)
}
#endif
