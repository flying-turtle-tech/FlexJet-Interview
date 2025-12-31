//
//  FlightCardView.swift
//  FlexJetter
//
//  Created by Jonathan on 12/29/25.
//

import SwiftUI

struct FlightCardView: View {
    @State private var flight: FlightViewModel
    
    init(flight: Flight) {
        _flight = State(wrappedValue: FlightViewModel(flight: flight))
    }
    
    init(viewModel: FlightViewModel) {
        _flight = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        HStack {
            VStack(spacing: 0) {
                Text(flight.month.uppercased())
                    .frame(width: 48, height: 18)
                    .font(.custom(.semiBold, relativeTo: .caption))
                    .foregroundStyle(flight.past ? Color.darkGrey : Color.accent)
                    .background(flight.past ? Color.grey : Color.primaryFaded)
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 4, topTrailingRadius: 4))

                Text(flight.day)
                    .frame(width: 48, height: 30)
                    .font(.custom(.semiBold, relativeTo: .headline))
                    .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 4, bottomTrailingRadius: 4))
                    .background(Color.offWhite)
            }.frame(width: 48, height: 48)
            VStack(alignment: .leading, spacing: 4) {
                Text(flight.title)
                    .font(.custom(.semiBold, relativeTo: .footnote))
                Text(flight.subtitle ?? "")
                    .font(.custom(.regular, relativeTo: .footnote))
                    .foregroundStyle(Color.darkGrey)
            }
            Spacer()
            Image(systemName: "checkmark.seal").font(.system(size: 24))
        }
        .if(flight.showTodayBadge) { view in
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
                .strokeBorder(Color.grey, lineWidth: flight.showTodayBadge ? 0 : 1)
        }
        .if(flight.showTodayBadge) { view in
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


#Preview(traits: .sizeThatFitsLayout) {
    FlightCardView(flight:
    Flight(
        id: "1234",
        tripNumber: "1000001",
        flightNumber: "UA203",
        tailNumber: "FLX202",
        origin: "Boston Logan Airport (BOS)",
        originIata: "BOS",
        destination: "John F Kennedy Airport (JFK)",
        destinationIata: "JFK",
        departure: Date.now.advanced(by: 100),
        arrival: Date.now.advanced(by: 5000),
        price: 18000)
    )
}
