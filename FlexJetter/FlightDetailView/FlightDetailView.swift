//
//  FlightDetailView.swift
//  FlexJetter
//
//  Created by Jonathan on 12/31/25.
//

import SwiftUI

enum Airport {
    case origin
    case destination
}

struct FlightDetailView: View {
    @Binding var flight: Flight
    private var viewModel: FlightDetailViewModel
    
    init(flight: Binding<Flight>) {
        self._flight = flight
        viewModel = FlightDetailViewModel(flight: flight.wrappedValue)
        
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack(spacing: 16) {
                    airportCard(airport: flight.origin, type: .origin)
                    Spacer()
                    airportCard(airport: flight.destination, type: .destination)
                }
                ForEach(viewModel.items) { item in
                    HStack {
                        Text(item.label)
                            .foregroundStyle(Color.darkGrey)
                        Spacer()
                        Text(item.value)
                    }
                    .padding(.vertical, 4)
                    .font(.custom(.semiBold, relativeTo: .subheadline))
                }
                Button {
                    flight.completed.toggle()
                } label: {
                    if flight.completed {
                        HStack {
                            Image(systemName: "checkmark.seal.fill")
                            Text("Completed")
                        }
                        .frame(height: 44)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                        .background(Color.accent)
                        .foregroundStyle(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                    } else {
                        HStack {
                            Image(systemName: "checkmark.seal")
                            Text("Complete")
                        }
                        .frame(height: 44)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                        .background(Color.white)
                        .foregroundStyle(Color.black)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(Color.grey, lineWidth: 1)
                        }
                    }
                }.disabled(viewModel.completeButtonDisabled)
            }.padding(.horizontal, 16)
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(flight.originIata + " to " + flight.destinationIata)
    }
    
    func airportCard(airport: String, type: Airport) -> some View {
        VStack(alignment: .leading) {
            Text(airport)
                .font(.custom(.semiBold, relativeTo: .footnote))
            Text(type == Airport.origin ? "Origin" : "Destination")
                .font(.custom(.regular, relativeTo: .footnote))
                .foregroundStyle(Color.darkGrey)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.grey, lineWidth: 1)
        }
    }
    
}

//#Preview {
//    FlightDetailView(flight:
//        Flight(
//            id: "1234",
//            tripNumber: "1000001",
//            flightNumber: "UA203",
//            tailNumber: "FLX202",
//            origin: "Las Vegas (LAS)",
//            originIata: "LAS",
//            destination: "New York (JFK)",
//            destinationIata: "JFK",
//            departure: Date.now.advanced(by: 100),
//            arrival: Date.now.advanced(by: 5000),
//            price: 18000,
//            completed: false
//        )
//    )
//}
