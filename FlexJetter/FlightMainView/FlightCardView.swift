//
//  FlightCardView.swift
//  FlexJetter
//
//  Created by Jonathan on 12/29/25.
//

import SwiftUI

struct FlightCardView: View {
    @StateObject var viewModel: FlightCardViewModel
//    @Binding var flight: Flight
    
    init(flight: Flight) {
//        _flight = flight
        _viewModel = StateObject(wrappedValue: FlightCardViewModel(flight: flight))
    }
    
    var body: some View {
        let _ = print("Card rendering - completed: \(viewModel.completed)")
        HStack {
            VStack(spacing: 0) {
                Text(viewModel.month.uppercased())
                    .frame(width: 48, height: 18)
                    .font(.custom(.semiBold, relativeTo: .caption))
                    .foregroundStyle(viewModel.past ? Color.darkGrey : Color.accent)
                    .background(viewModel.past ? Color.grey : Color.primaryFaded)
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 4, topTrailingRadius: 4))

                Text(viewModel.day)
                    .frame(width: 48, height: 30)
                    .font(.custom(.semiBold, relativeTo: .headline))
                    .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 4, bottomTrailingRadius: 4))
                    .background(Color.offWhite)
                    .foregroundStyle(Color.darkText)
            }.frame(width: 48, height: 48)
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.title)
                    .font(.custom(.semiBold, relativeTo: .footnote))
                    .foregroundStyle(Color.darkText)
                Text(viewModel.subtitle ?? "")
                    .font(.custom(.regular, relativeTo: .footnote))
                    .foregroundStyle(Color.darkGrey)
            }
            Spacer()
            Image(systemName: viewModel.completed ? "checkmark.seal.fill" : "checkmark.seal")
                .font(.system(size: 24))
                .foregroundStyle(viewModel.completed ? Color.accent : Color.black)
        }
        .if(viewModel.showTodayBadge) { view in
            VStack(alignment: .leading) {
                view
                HStack(spacing: 10) {
                    Image(systemName: "calendar")
                    Text("Flight Today")
                }
                .font(.custom(.extraBold, relativeTo: .footnote))
                .padding(.vertical, 4)
                .padding(.horizontal, 16)
                .background(Color.accent)
                .foregroundStyle(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 34))
            }
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.grey, lineWidth: viewModel.showTodayBadge ? 0 : 1)
        }
        .if(viewModel.showTodayBadge) { view in
            // Only show shadow when Flight is today.
            view.background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.09), radius: 5.3, x: 0, y: 2)
                )}
    }
}

extension View {
    /// Applies a transformation to the view if a condition is met.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

//
//#Preview(traits: .sizeThatFitsLayout) {
//    FlightCardView(flight:
//    Flight(
//        id: "1234",
//        tripNumber: "1000001",
//        flightNumber: "UA203",
//        tailNumber: "FLX202",
//        origin: "Boston Logan Airport (BOS)",
//        originIata: "BOS",
//        destination: "John F Kennedy Airport (JFK)",
//        destinationIata: "JFK",
//        departure: Date.now.advanced(by: 100),
//        arrival: Date.now.advanced(by: 5000),
//        price: 18000)
//    )
//}
