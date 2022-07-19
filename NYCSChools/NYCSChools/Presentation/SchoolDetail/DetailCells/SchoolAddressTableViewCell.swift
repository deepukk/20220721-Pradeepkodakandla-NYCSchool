//
//  SchoolAddressTableViewCell.swift
//  NYCSChools
//
//  Created by Pradeep Kodakandla on 7/18/22.
//

import UIKit
import MapKit

class SchoolAddressTableViewCell: UITableViewCell {

    var viewModel: SchoolDetailViewModel? {
        didSet {
            self.setup()
        }
    }
    
    @IBOutlet var hsAddressMapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func addHSAnnotaionWithCoordinates(_ hsCoordinates: CLLocationCoordinate2D){
        let highSchoolAnnotation = MKPointAnnotation()
        highSchoolAnnotation.coordinate = hsCoordinates
        self.hsAddressMapView.addAnnotation(highSchoolAnnotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: highSchoolAnnotation.coordinate, span: span)
        let adjustRegion = self.hsAddressMapView.regionThatFits(region)
        self.hsAddressMapView.setRegion(adjustRegion, animated:true)
    }
    
    func setup() {
        guard let coordinates = self.viewModel?.coordiantes else {
            return
        }
        self.addHSAnnotaionWithCoordinates(coordinates)
    }
}
