//
//  BabyTips.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 06/03/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import Foundation

class BabyTips{
    var tip_title = ""
    var tip_content = ""
    
    static func getSafetyTips() -> [BabyTips] {
        var result : [BabyTips] = []
        var tip = BabyTips()
        
        tip.tip_title = "Daytime is tummy time"
        tip.tip_content = "Newborns and babies in general spend more time asleep than awake. It‘s important to make sure you as a parent are doing everything possible to grant the safest environment in which they can dream.\n All babies should always sleep on their back only to reduce the risk of SIDS (sudden infant death syndrome). Sleeping on the side and stomach is not advised. When they are awake, that‘s a completely different story. Awake means a lot of exploring so babies should be able to move as much as they want during wake time, but always under supervision. Tummy time during the day will help your little one to strengthen neck muscles and avoid flat spots on you angel‘s head."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "Sleeping surface"
        tip.tip_content = "This may seem like the opposite of what you‘re thinking – but you should not leave anything soft in the crib with your baby. Your precious little one is delicate and you should keep that in mind when putting them to sleep in their crib. The baby should always sleep on a firm mattress covered in a fitted bed sheet. The mattress should be fitted to the crib and there shouldn‘t be any extra room around the perimeter of the mattress so the baby does not get caught between the crib and the mattress. You should always use an original mattress for your crib."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "Nothing in the crib"
        tip.tip_content = "Blankets and pillows should be reserved for older children where you don‘t risk any serious damage if the blanket got over your little one‘s head. If you‘re worried about keeping your child warm, simply use a swaddling technique or a wearable blanket – a sleep sack. \n Stuffed animals are a great gift and you will be receiving a lot of stuffed animals and other stuffed soft toys from your relatives. To play with them is great and highly encouraged, but you shouldn‘t leave the toys with your child in their crib. They do give out the vibe of coziness and warmth but they can often do more harm than good."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "To each his own bed"
        tip.tip_content = "Having your little loved one close is a top priority to build up the bond between the two of you. Your baby can feel your presence and knows that you are there for their well-being. Place your baby to sleep in the same room where you sleep, preferably close to your own bed for your own comfort. You should sleep in the same room, but you shouldn’t share the same bed. The baby should sleep on a firm surface without any blankets or pillows and if they sleep in the same bed as you, you risk that they can get tangled in your bedsheets or covers."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "An arm’s length away"
        tip.tip_content = "It may seem impossible in the first few months – it is tiresome caring for a small baby and when you breastfeed or feed from a bottle in the middle of the night, the last thing you want to do is to get up and place your baby in their crib. But the safety of your child is always the priority. So keep the crib at an arm’s length from your own bed so feeding or simply watching your child becomes harmless while you still enjoy each others company."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "Make sure your crib is up to date"
        tip.tip_content = "Check that your crib meets safety standards of associations and make sure it has all the right pieces. Your child will spend endless hours sleeping, mainly in their crib, so it should be in perfect condition. The slats of the crib should be close together so your loved one isn’t under threat of getting stuck between them. You should make sure that there are no sharp cutouts on the headboard and that all the pieces are original. You should always leave the repairs up to a professional, making changes to the crib yourself can result in dangerous scenarios."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = " Watch the temperature"
        tip.tip_content = "Keep the room where your baby sleeps at a comfortable temperature, this goes for babies as well as adults. You should generally sleep in an environment that is a little colder than during the day. Dress your baby in no more than one extra layer than you would wear. Your baby may be too hot if they are sweating or if their chest feels hot. If you are worried that your baby is cold, you can use a wearable blanket or the swaddle technique. The ideal temperature for babies to sleep in should be somewhere between 65 – 70 °F."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "Keep the crib safe"
        tip.tip_content = "Room-sharing is the way to go. But how do you choose where the crib goes in your room? It’s quite easy. Don’t place the crib near windows, especially with draperies or blinds. You also shouldn’t put the crib near the doors so your baby doesn’t experience the draft. Having a playpen hanging above your little one’s crib can be very soothing to them and they will stare at the moving objects with great intensity. But be careful when using a string or a chord to hang it up and make the ends short so the baby can’t pull on them."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "Pacifier"
        tip.tip_content = "Pacifiers can be a great tool when helping you put your baby to sleep and they have been proven to reduce the risk of SIDS (sudden infant death syndrome). You can offer a pacifier to a baby when putting them to sleep. If you are breastfeeding, you should wait approximately one month or after breastfeeding has been established to introduce the pacifier. Donť force the pacifier to your little one if they refuse it. Of course it is completely up to you if you choose to use pacifiers, in any case the decision is yours and yours alone."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "Keep your baby smoke free"
        tip.tip_content = "Both you and your partner should try not to smoke during pregnancy and after birth. Smoking has been proven to greatly increase the chance of SIDS (sudden infant death syndrome). You should also keep your little one out of smoky areas in general and don’t let people smoke around your child in your home, car and other places where your baby spends a lot of time. Don’t sleep in the same bed as your baby when you are a smoker, even if you don’t smoke in the bedroom or in the house."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "Don’t use commercial safety devices"
        tip.tip_content = "You should avoid using commercial devices that claim to reduce the risk of SIDS. These devices such as wedges, positioners, special mattresses and special sleep surfaces have not been proven to reduce the risk of SIDS or that they are in fact safe. Some may even cause more harm than good when the baby turns to the side in their sleep and their heads get positioned between the safety device risking serious damage.\n Your little loved one should sleep in an empty crib on a firm mattress and always on their back. That way, the risk of anything happening is minimal and you can rest well at night knowing your little one is safe."
        result.append(tip)
        return result
    }
    
    static func getSleepingTips() -> [BabyTips] {
        var result : [BabyTips] = []
        
        var tip = BabyTips()
        tip.tip_title = "Routine"
        tip.tip_content = "Humans are creatures of habit, habits and rituals make our days easier so we can focus on the really important things. Creating a daily routine not only for your child, but also for yourself creates a bond unlike any other. The routine you set up for your family give your days meaning and give your children something to look forward to.\n As significant as a daily routine may be, having a bedtime ritual seems even more important. You feed your baby, give them a loving bath, put on pajamas or swaddle your little one so they feel safe. Then you perhaps sing a lullaby or tell a short story and cuddle for a little while. You will have a sleeping baby on your hands in no time if you follow this ritual every night."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "Use lighting to your advantage"
        tip.tip_content = "When your bundle of joy was still in the womb, the lights were dim. Keep these conditions in mind when putting your child to sleep. The world is still a new place, so any added distraction is sure to keep them awake!\n Your baby should get plenty of light during the day and be in relative darkness during the night. The concept of changing day and night is ungraspable for a newborn who needs to sleep up to 20 hours a day. The sooner you start distinguishing between the two, the sooner your baby starts sleeping through the night. For naps during the day, it is generally better to not have total darkness in the room your child is sleeping in."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "Put to bed when drowsy"
        tip.tip_content = "A good idea is to put your child to bed when you can tell they are slowly dozing off, but still not completely asleep. You will soon find that you can tell simply by looking at them when your little ones are tired. They might start rubbing their eyes, tugging on their ears, yawning or being fussy.\n If you pay attention to your child‘s sleeping patterns and the tell tale signs they are tired, you have almost won. Letting fresh air into the baby‘s room, closing the curtains to shield the room from direct sunlight, singing a lullaby and offering reassurance when needed. These are some of the steps to a happy sleeper."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "Don’t overtire your baby"
        tip.tip_content = "Be careful to not overtire your baby too much. If a baby has gone too long without a nap, they might get fussy and whiny and the harder it becomes to actually fall asleep. An overtired baby will need lots of sensory soothing strategies to settle to sleep, particularly if they are already crying. These include swaddling, rocking your baby, playing white noise or just holding your little one until they become drowsy and sleepy. It‘s important to track sleep patterns and avoid these situations as they are stressful for the baby and also for yourself."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "Manage naps"
        tip.tip_content = "Keeping track of naps and snacks can be very useful during the first few months of being a new parent. It can help you monitor how much your child is eating and how the weight gain is going and it helps to establish sleeping patterns. Keep track of how long and when your baby slept and find a pattern that works for longer sleeps during the night. This works best with older children but starting training early has never hurt anyone.\n The most important thing is to try to not get discouraged if you daytime pattern is erratic sometimes. Getting used to your baby and being able to meet all his needs takes some skills and experience along with heaps of time."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "Feeding before sleep time"
        tip.tip_content = "For adults, having some time pass between the last meal and going to bed is important for a healthy night‘s sleep. For a newborn, the need to eat is constant. This need for a heaping helping decreases over time and babies older than six months should be able to sleep through the night without waking up to fill their bellies. To guarantee a restful slumber, you should incorporate breastfeeding or the bottle into your bedtime routine. Even if your baby drinks two or three gulps, it might mean a couple more hours of sleep straight till morning."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "Day feedings"
        tip.tip_content = "Tanking up with frequent feedings during the day is a great way to combat your little one waking up in the middle of the night demanding his share. As babies get bigger, they get busier during the days and forget to eat. Who wouldn‘t when you have the whole world to explore?\n It is your responsibility (and even for your own good) to keep track of their feeding schedule and stick to it. The routine in sleeping and feeding is crucial for their development and help you plan your days so you spend as much time as possible with your little one."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "Don‘t panic with every rustle"
        tip.tip_content = "Baby monitors are a godsend. Having some time for yourself without the need to constantly keep an eye out on you sleeping angel is amazing. Of course you never want your young one to experience any discomfort but letting them sort it out on their own first is the number one step in establishing their sleeping independence.\n The rule is to not jump up with every squeak and rustle coming from the baby monitor. If you hear rumbling, wait a few minutes and let your little one handle it. You‘ll soon find that even if your child wakes up, they settle down and fall asleep immediately after a few minutes. Rushing to their side only makes your child wake up more often and demand your attention."
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "Turn monitor sensivity down"
        tip.tip_content = "If the sounds coming from the monitor make you uneasy, you can try turning the sensitivity down a little, so only louder sounds get through. This will get rid of all those soft whimpers and sounds of the baby turning while still allowing you to hear when your child is experiencing actual discomfort or crying. But often times, your baby will wake up, babble or cry very briefly and still be asleep. Give the baby some time and see if they’ll resettle themselves. If they learn to calm themselves down, it means more time you can spend playing or cuddling – and that’s worth it!"
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "Nursing during the night"
        tip.tip_content = "If your little one wakes up during the night hungry, you should feed them in relative darkness with the lights dimmed. It is also better if you talk in a low voice and make little eye-contact. You want to limit your interactions so your baby doesn‘t feel like it‘s wake up time. During the night, burping after a hefty share of milk may seem like and impossible task. Although babies nurse less anxiously during the night swallowing less air, it still might be necessary to let the air out. In this case, you don‘t have to pick you little one up. Simply put them on your side and give their backs a few pats. That should do the trick!"
        result.append(tip)
        
        tip = BabyTips()
        tip.tip_title = "Go outside"
        tip.tip_content = "You need to be aware that in the first few weeks, babies tend to sleep an awful lot and their habits tend to change week to week so you need to be open to change. Try to go out at least once during the day so your darling can experience some sunlight and new sounds and smells.\n You’ll get as much from this experience as your little one. Active relaxation helps fight depression and gets your energy going. For the baby, sleeping in a pram is every bit as valuable as sleeping at home in a crib. Rock the pram and don‘t worry about your baby sleeping outside – it might even be beneficial!"
        result.append(tip)
        
        return result
    }
}
