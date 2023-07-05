//
//  MissionView.swift
//  P8-Moonshot
//
//  Created by Jonathan Tipton on 7/4/23.
//

import SwiftUI

struct MissionView: View {
    
    let astronauts: [String: Astronaut]
    let mission: Mission
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.6)
                    
                    VStack {
                        Text("\(mission.formattedLaunchDate)")
                            .multilineTextAlignment(.center)
                            .font(.caption.bold())
                            .padding(.top)
                        HStack {
                            HorizontalDividerView()
                            
                            Text("Mission Highlights")
                                .font(.title.bold())
                                .padding([.top, .bottom], 5)
                                .lineLimit(1)
                                .fixedSize()
                                
                            HorizontalDividerView()
                        }
                
                        Text(mission.description)
                    }
                    .padding(.horizontal)
    
                    CrewHorizontalScrollView(mission: mission, astronauts: astronauts)
                }
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.astronauts = astronauts
//        self.crew = mission.crew.map { member in
//            if let astronaut = astronauts[member.name] {
//                return CrewMember(role: member.role, astronaut: astronaut)
//            } else {
//                fatalError("Missing \(member.name)")
//            }
//        }
    }
    
    
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
