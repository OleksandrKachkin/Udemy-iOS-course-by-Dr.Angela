//
//  StoryBrain.swift
//  09.Destini-iOS13
//
//  Created by Oleksandr Kachkin on 09.02.2022.
//

import Foundation

struct StoryBrain {
  
  var storyNumber = 0
  
  let stories = [
    Story(
      title: "У вашей машины лопнула шина на извилистой дороге в глуши, где нет сотовой связи. Вы решаете поехать автостопом. Ржавый пикап с грохотом останавливается рядом с вами. Человек в широкополой шляпе с бездушными глазами открывает пассажирскую дверь для вас и спрашивает: «Подвезти, мальчик?».",
        choice1: "Я соглашусь. Спасибо за помощь!", choice1Destination: 2,
        choice2: "Лучше спрошу его, убийца ли он.", choice2Destination: 1
    ),
    Story(
        title: "Он медленно кивает, не обращая внимания на вопрос.",
        choice1: "Он честный. Я полезу в машину.", choice1Destination: 2,
        choice2: "Я вспоминаю как поменять колесо.", choice2Destination: 3
    ),
    Story(
        title: "Когда вы садитесь, незнакомец начинает рассказывать о своих отношениях с матерью. Он становится все злее и злее с каждой минутой. Он просит вас открыть бардачок. Внутри вы найдете окровавленный нож, два отрубленных пальца и кассету с записью Элтона Джона. Он тянется к бардачку.",
        choice1: "Даете ему кассету.", choice1Destination: 5,
        choice2: "Либо он, либо я! Вы берете нож и наносите ему удары.", choice2Destination: 4
    ),
    Story(
        title: "Какая отмазка! Знаете ли вы, что дорожно-транспортные происшествия являются второй по значимости причиной смерти в результате несчастного случая для большинства взрослых возрастных групп?",
        choice1: "The", choice1Destination: 0,
        choice2: "End", choice2Destination: 0
    ),
    Story(
        title: "Когда вы разбиваете ограждение и кренитесь к зазубренным камням внизу, вы размышляете о сомнительной мудрости нанесения удара ножом кому-то, когда он ведет машину, в которой вы находитесь.",
        choice1: "The", choice1Destination: 0,
        choice2: "End", choice2Destination: 0
    ),
    Story(
        title: "Вы подружились с убийцей. Он высадит вас в следующем городе. Прежде чем вы уйдете, он спрашивает вас, знаете ли вы какие-нибудь хорошие места, где можно сбросить тело. Вы отвечаете: «Попробуйте на пирсе».",
        choice1: "The", choice1Destination: 0,
        choice2: "End", choice2Destination: 0
    )
  ]
  
  mutating func nextStory(userChoice: String) {
    
    let currentStory = stories[storyNumber]
    
    if userChoice == currentStory.choice1 {
      storyNumber = currentStory.choice1Destination
    } else {
      storyNumber = currentStory.choice2Destination
    }
  }
  
  func getStoryText() -> String {
    let storyLabel = stories[storyNumber].title
    return storyLabel
  }
  
  func getChoice1() -> String {
    let choice1 = stories[storyNumber].choice1
    return choice1
  }
  
  func getChoice2() -> String {
    let choice2 = stories[storyNumber].choice2
    return choice2
  }

}
