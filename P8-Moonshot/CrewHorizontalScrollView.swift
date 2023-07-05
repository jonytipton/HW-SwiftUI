//
//  CrewHorizontalScrollView.swift
//  P8-Moonshot
//
//  Created by Jonathan Tipton on 7/6/23.
//

import SwiftUI

struct CrewHorizontalScrollView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let crew: [CrewMember]
    let mission: Mission
    
    var body: some View {
        VStack {
            HStack {
                HorizontalDividerView()
                
                Text("Crew")
                    .font(.headline)
                
                HorizontalDividerView()
            }
            .padding([.leading, .trailing])
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(crew, id: \.role) { crewMember in
                        NavigationLink {
                            AstronautView(astronaut: crewMember.astronaut)
                        } label: {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 104, height: 72)
                                    .clipShape(Capsule())
                                
                                VStack(alignment: .leading) {
                                    
                                    Text(crewMember.astronaut.name)
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                    
                                    Text(crewMember.role)
                                        .foregroundStyle(.white.opacity(0.8))
                                }
                                .padding(.trailing)
                            }
                            
                            .overlay(
                                Capsule()
                                    .fill(crewOverlayFill(member: crewMember))
                            )
                            .padding(.trailing)
                        }
                    }
                }.padding(.leading)
            }
        }
        .padding([.top, .bottom])
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    func crewOverlayFill(member: CrewMember) -> Color {
        if (member.role == "Command Pilot" || member.role == "Commander") {
            return .red.opacity(0.1)
        }
        
        if (member.role == "Senior Pilot" || member.role.lowercased() == "command module pilot" ) {
            return .blue.opacity(0.1)
        }
        return .white.opacity(0.1)
    }
}

struct CrewHorizontalScrollView_Previews: PreviewProvider {

    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        CrewHorizontalScrollView(mission: missions[1], astronauts: astronauts)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
    }
}
