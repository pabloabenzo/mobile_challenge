//
//  MapView.swift
//  mobile_challenge
//
//  Created by Pablo Benzo on 04/12/2024.
//

import SwiftUI
import MapKit

struct UserMapView: View {
    let listResult: ChallengeResponse.User.Address
    let userResult: ChallengeResponse.User
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            MapView(latitude: Double(listResult.geo.lat) ?? 0.0, longitude: Double(listResult.geo.lng) ?? 0.0)
                .ignoresSafeArea(.container, edges: .bottom)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .tint(.gray)
                        Text("Back")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct MapView: UIViewRepresentable {
    
    let latitude: Double
    let longitude: Double
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        view.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        view.addAnnotation(annotation)
    }
}
