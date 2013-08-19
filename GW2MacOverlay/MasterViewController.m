//
//  MasterViewController.m
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import "MasterViewController.h"
#import "Event.h"
#import "World.h"
#import "WorldNamesJSONParser.h"
#import "EventsJSONParser.h"
#import "EventGroup.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // INITIALIZATION
        // Last updated
        self._lastUpdatedFormatter = [[NSDateFormatter alloc] init];
        [self._lastUpdatedFormatter setDateFormat:@"'Last Updated:' HH:mm:ss"];
        
        // Worlds - Init
        WorldNamesJSONParser *wnjp = [[WorldNamesJSONParser alloc] initFromURL];
        self._worldNames = wnjp._worldNames;
        
        // Worlds - Sort
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"_name" ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        self._worldNames = [self._worldNames sortedArrayUsingDescriptors:sortDescriptors];
        
        // Events Parser
        self._ejp = [EventsJSONParser alloc];
        
        // EVENT DATA
        // Shadow Behemot
        Event *evShadowBehemotBoss = [[Event alloc] initWithId:@"31CEBA08-E44D-472F-81B0-7143D73797F5" andName:@"Defeat the shadow behemoth."];
        EventGroup *egShadowBehemot = [[EventGroup alloc] initWithName:@"Shadow Behemot" andObjects:evShadowBehemotBoss, nil];
        
        // Fire Elemental
        Event *evFireElementalPre1 = [[Event alloc] initWithId:@"5E4E9CD9-DD7C-49DB-8392-C99E1EF4E7DF" andName:@"Escort the C.L.E.A.N. 5000 golem while it absorbs clouds of chaos magic."];
        Event *evFireElementalPre2 = [[Event alloc] initWithId:@"2C833C11-5CD5-4D96-A4CE-A74C04C9A278" andName:@"Defend the C.L.E.A.N. 5000 golem."];
        Event *evFireElementalBoss = [[Event alloc] initWithId:@"33F76E9E-0BB6-46D0-A3A9-BE4CDFC4A3A4" andName:@"Destroy the fire elemental created from chaotic energy fusing with the C.L.E.A.N. 5000's energy core."];
        EventGroup *egFireElemental = [[EventGroup alloc] initWithName:@"Fire Elemental" andObjects:evFireElementalPre1, evFireElementalPre2, evFireElementalBoss, nil];
        
        // Great Jungle Wurm
        Event *evJumgleWurmPre1 = [[Event alloc] initWithId:@"613A7660-8F3A-4897-8FAC-8747C12E42F8" andName:@"Protect Gamarien as he scouts Wychmire Swamp."];
        Event *evJumgleWurmPre2 = [[Event alloc] initWithId:@"456DD563-9FDA-4411-B8C7-4525F0AC4A6F" andName:@"Destroy the blighted growth."];
        Event *evJumgleWurmPre3 = [[Event alloc] initWithId:@"1DCFE4AA-A2BD-44AC-8655-BBD508C505D1" andName:@"Kill the giant blighted grub."];
        Event *evJumgleWurmPre4a = [[Event alloc] initWithId:@"61BA7299-6213-4569-948B-864100F35E16" andName:@"Destroy the avatars of blight."];
        Event *evJumgleWurmPre4b = [[Event alloc] initWithId:@"CF6F0BB2-BD6C-4210-9216-F0A9810AA2BD" andName:@"Destroy the avatars of blight."];
        Event *evJumgleWurmBoss = [[Event alloc] initWithId:@"C5972F64-B894-45B4-BC31-2DEEA6B7C033" andName:@"Defeat the great jungle wurm."];
        EventGroup *egJungleWurm = [[EventGroup alloc] initWithName:@"Great Jungle Wurm" andObjects:evJumgleWurmPre1, evJumgleWurmPre2, evJumgleWurmPre3, evJumgleWurmPre4a, evJumgleWurmPre4b, evJumgleWurmBoss, nil];
        
        // The Shatterer
        Event *evShattererPre1 = [[Event alloc] initWithId:@"8E064416-64B5-4749-B9E2-31971AB41783" andName:@"Escort the Sentinel squad to the Vigil camp in Lowland Burns."];
        Event *evShattererPre2 = [[Event alloc] initWithId:@"580A44EE-BAED-429A-B8BE-907A18E36189" andName:@"Collect siege weapon pieces for Crusader Blackhorn."];
        Event *evShattererBoss = [[Event alloc] initWithId:@"03BF176A-D59F-49CA-A311-39FC6F533F2F" andName:@"Slay the Shatterer"];
        EventGroup *egShatterer = [[EventGroup alloc] initWithName:@"The Shatterer" andObjects:evShattererPre1, evShattererPre2, evShattererBoss, nil];
        
        // Tequalt
        Event *evTequalt = [[Event alloc] initWithId:@"568A30CF-8512-462F-9D67-647D69BEFAED" andName:@"Defeat Tequatl the Sunless."];
        EventGroup *egTequalt = [[EventGroup alloc] initWithName:@"Tequalt" andObjects:evTequalt, nil];
        
        // Golem Mark II
        Event *evGolemMarkPre = [[Event alloc] initWithId:@"3ED4FEB4-A976-4597-94E8-8BFD9053522F" andName:@"Disable the containers before they release their toxins."];
        Event *evGolemMarkBoss = [[Event alloc] initWithId:@"9AA133DC-F630-4A0E-BB5D-EE34A2B306C2" andName:@"Defeat the Inquest's golem Mark II."];
        EventGroup *egGolemMark = [[EventGroup alloc] initWithName:@"Golem Mark II" andObjects:evGolemMarkPre, evGolemMarkBoss, nil];
        
        // Jormag
        Event *evJormagPre = [[Event alloc] initWithId:@"BFD87D5B-6419-4637-AFC5-35357932AD2C" andName:@"Lure out the Claws of Jormag by destroying the final dragon crystal."];
        Event *evJormagBoss = [[Event alloc] initWithId:@"0464CB9E-1848-4AAA-BA31-4779A959DD71" andName:@"Defeat the Claw of Jormag."];
        EventGroup *egJormag = [[EventGroup alloc] initWithName:@"Jormag" andObjects:evJormagPre, evJormagBoss, nil];
        
        // Balthazar
        Event *evBalthazarPre1 = [[Event alloc] initWithId:@"D0ECDACE-41F8-46BD-BB17-8762EF29868C" andName:@"Help the Pact reach the Altar of Betrayal before their morale is depleted."];
        Event *evBalthazarPre2 = [[Event alloc] initWithId:@"7B7D6D27-67A0-44EF-85EA-7460FFA621A1" andName:@"Seize the Altar of Betrayal before Pact morale can be broken."];
        Event *evBalthazarBoss = [[Event alloc] initWithId:@"2555EFCB-2927-4589-AB61-1957D9CC70C8" andName:@"Defeat the Risen Priest of Balthazar before it can summon a horde of Risen."];
        EventGroup *egBalthazar = [[EventGroup alloc] initWithName:@"Balthazar" andObjects:evBalthazarPre1, evBalthazarPre2, evBalthazarBoss, nil];
        
        // Lyssa
        Event *evLyssaPre1 = [[Event alloc] initWithId:@"F66922B5-B4BD-461F-8EC5-03327BD2B558" andName:@"Protect the Pact golems until they charge the neutralizer device."];
        Event *evLyssaPre2 = [[Event alloc] initWithId:@"35997B10-179B-4E39-AD7F-54E131ECDD57" andName:@"Destroy the Risen fortifications to capture the Seal of Union."];
        Event *evLyssaPre3 = [[Event alloc] initWithId:@"590364E0-0053-4933-945E-21D396B10B20" andName:@"Defend the Seal of Lyss until the Pact cannon is online."];
        Event *evLyssaBoss = [[Event alloc] initWithId:@"0372874E-59B7-4A8F-B535-2CF57B8E67E4" andName:@"Kill the Corrupted High Priestess"];
        EventGroup *egLyssa = [[EventGroup alloc] initWithName:@"Lyssa" andObjects:evLyssaPre1, evLyssaPre2, evLyssaPre3, evLyssaBoss, nil];
        
        // Dwayna
        Event *evDwaynaPre1 = [[Event alloc] initWithId:@"F531683F-FC09-467F-9661-6741E8382E24" andName:@"Escort Historian Vermoth to the Altar of Tempests."];
        Event *evDwaynaBoss1 = [[Event alloc] initWithId:@"7EF31D63-DB2A-4FEB-A6C6-478F382BFBCB" andName:@"Defeat the Risen Priestess of Dwayna."];
        Event *evDwaynaPre2 = [[Event alloc] initWithId:@"526732A0-E7F2-4E7E-84C9-7CDED1962000" andName:@"Drive Malchor to the Altar of Tempests."];
        Event *evDwaynaBoss2 = [[Event alloc] initWithId:@"6A6FD312-E75C-4ABF-8EA1-7AE31E469ABA" andName:@"Defeat the possessed statue of Dwayna."];
        EventGroup *egDwayna = [[EventGroup alloc] initWithName:@"Dwayna" andObjects:evDwaynaPre1, evDwaynaBoss1, evDwaynaPre2, evDwaynaBoss2, nil];
        
        // Grenth
        Event *evGrenthPre = [[Event alloc] initWithId:@"E16113B1-CE68-45BB-9C24-91523A663BCB" andName:@"Use portals to fight shades, slay the Risen Priest of Grenth, and protect Keeper Jonez Deadrun."];
        Event *evGrenthBoss = [[Event alloc] initWithId:@"99254BA6-F5AE-4B07-91F1-61A9E7C51A51" andName:@"Cover Keeper Jonez Deadrun as he performs the cleansing ritual."];
        EventGroup *egGrenth = [[EventGroup alloc] initWithName:@"Grenth" andObjects:evGrenthPre, evGrenthBoss, nil];
        
        // Melandru
        Event *evMelandruPre1 = [[Event alloc] initWithId:@"351F7480-2B1C-4846-B03B-ED1B8556F3D7" andName:@"Escort the Pact forces to the Temple of Melandru."];
        Event *evMelandruPre2 = [[Event alloc] initWithId:@"7E24F244-52AF-49D8-A1D7-8A1EE18265E0" andName:@"Destroy the Risen Priest of Melandru."];
        Event *evMelandruBoss = [[Event alloc] initWithId:@"A5B5C2AF-22B1-4619-884D-F231A0EE0877" andName:@"Defend the Pact interrupter device while it charges to cleanse the temple."];
        EventGroup *egMelandru = [[EventGroup alloc] initWithName:@"Melandru" andObjects:evMelandruPre1, evMelandruPre2, evMelandruBoss, nil];
        
        // Frozen Maw
        Event *evFrozenMawPre1 = [[Event alloc] initWithId:@"6F516B2C-BD87-41A9-9197-A209538BB9DF" andName:@"Protect Tor the Tall's supplies from the grawl."];
        Event *evFrozenMawPre2 = [[Event alloc] initWithId:@"D5F31E0B-E0E3-42E3-87EC-337B3037F437" andName:@"Protect Scholar Brogun as he investigates the grawl tribe."];
        Event *evFrozenMawPre3 = [[Event alloc] initWithId:@"6565EFD4-6E37-4C26-A3EA-F47B368C866D" andName:@"Destroy the dragon totem."];
        Event *evFrozenMawPre4 = [[Event alloc] initWithId:@"90B241F5-9E59-46E8-B608-2507F8810E00" andName:@"Defeat the shaman's elite guard."];
        Event *evFrozenMawPre5 = [[Event alloc] initWithId:@"DB83ABB7-E5FE-4ACB-8916-9876B87D300D" andName:@"Defeat the Svanir shamans spreading the dragon's corruption."];
        Event *evFrozenMawPre6 = [[Event alloc] initWithId:@"374FC8CB-7AB7-4381-AC71-14BFB30D3019" andName:@"Destroy the corrupted portals summoning creatures from the mists."];
        Event *evFrozenMawBoss = [[Event alloc] initWithId:@"F7D9D427-5E54-4F12-977A-9809B23FBA99" andName:@"Kill the Svanir shaman chief to break his control over the ice elemental."];
        EventGroup *egFrozenMaw = [[EventGroup alloc] initWithName:@"Frozen Maw" andObjects:evFrozenMawPre1, evFrozenMawPre2, evFrozenMawPre3, evFrozenMawPre4, evFrozenMawPre5, evFrozenMawPre6, evFrozenMawBoss, nil];
        
        // Foulbear Chieftain
        Event *evFoulbearPre1 = [[Event alloc] initWithId:@"D9F1CF48-B1CB-49F5-BFAF-4CEC5E68C9CF" andName:@"Assault Foulbear Kraal by killing its leaders before the ogres can rally."];
        Event *evFoulbearPre2 = [[Event alloc] initWithId:@"4B478454-8CD2-4B44-808C-A35918FA86AA" andName:@"Destroy Foulbear Kraal before the ogres can rally."];
        Event *evFoulbearBoss = [[Event alloc] initWithId:@"B4E6588F-232C-4F68-9D58-8803D67E564D" andName:@"Kill the Foulbear Chieftain and her elite guards before the ogres can rally."];
        EventGroup *egFoulbear = [[EventGroup alloc] initWithName:@"Foulbear Chieftain" andObjects:evFoulbearPre1, evFoulbearPre2, evFoulbearBoss, nil];
        
        // Ulgoth
        Event *evUlgothPre1 = [[Event alloc] initWithId:@"C3A1BAE2-E7F2-4929-A3AA-92D39283722C" andName:@"Capture the camps before more centaurs arrive."];
        Event *evUlgothPre2 = [[Event alloc] initWithId:@"DDC0A526-A239-4791-8984-E7396525B648" andName:@"Assault Kingsgate and drive the centaurs back before they can rally their forces."];
        Event *evUlgothPre3 = [[Event alloc] initWithId:@"A3101CDC-A4A0-4726-85C0-147EF8463A50" andName:@"Kill the centaur war council before reinforcements arrive."];
        Event *evUlgothPre4 = [[Event alloc] initWithId:@"DA465AE1-4D89-4972-AD66-A9BE3C5A1823" andName:@"Keep the Modniir invaders from retaking Kingsgate."];
        Event *evUlgothBoss = [[Event alloc] initWithId:@"E6872A86-E434-4FC1-B803-89921FF0F6D6" andName:@"Defeat Ulgoth the Modniir and his minions."];
        EventGroup *egUlgoth = [[EventGroup alloc] initWithName:@"Ulgoth the Mondniir" andObjects:evUlgothPre1, evUlgothPre2, evUlgothPre3, evUlgothPre4, evUlgothBoss, nil];
        
        // Dredge Commissar
        Event *evDredgePre1 = [[Event alloc] initWithId:@"" andName:@""];
        Event *evDredgePre2 = [[Event alloc] initWithId:@"" andName:@""];
        Event *evDredgePre3 = [[Event alloc] initWithId:@"" andName:@""];
        Event *evDredgeBoss = [[Event alloc] initWithId:@"95CA969B-0CC6-4604-B166-DBCCE125864F" andName:@"Defeat the dredge commissar."];
        EventGroup *egDredge = [[EventGroup alloc] initWithName:@"Dredge Commissar" andObjects:evDredgePre1, evDredgePre2, evDredgePre3, evDredgeBoss, nil];
        
        // Taidha
        Event *evTaidhaPre1 = [[Event alloc] initWithId:@"B6B7EE2A-AD6E-451B-9FE5-D5B0AD125BB2" andName:@"Eliminate the cannons at the northern defensive tower."];
        Event *evTaidhaPre2 = [[Event alloc] initWithId:@"189E7ABE-1413-4F47-858E-4612D40BF711" andName:@"Capture Taidha Covington's southern defensive tower."];
        Event *evTaidhaPre3 = [[Event alloc] initWithId:@"0E0801AF-28CF-4FF7-8064-BB2F4A816D23" andName:@"Defend the galleon and help it destroy Taidha's gate."];
        Event *evTaidhaBoss = [[Event alloc] initWithId:@"242BD241-E360-48F1-A8D9-57180E146789" andName:@"Kill Admiral Taidha Covington."];
        EventGroup *egTaidha = [[EventGroup alloc] initWithName:@"Taidha Covington" andObjects:evTaidhaPre1, evTaidhaPre2, evTaidhaPre3, evTaidhaBoss, nil];
        
        // Fire Shaman
        Event *evFireShamanBoss = [[Event alloc] initWithId:@"295E8D3B-8823-4960-A627-23E07575ED96" andName:@"Defeat the fire shaman and his minions."];
        EventGroup *egFireShaman = [[EventGroup alloc] initWithName:@"Fire Shaman" andObjects:evFireShamanBoss, nil];
        
        // Eye of Zaithan
        Event *evEyePre = [[Event alloc] initWithId:@"42884028-C274-4DFA-A493-E750B8E1B353" andName:@"Defend the Pact team as they search Zho'qafa Catacombs for artifacts."];
        Event *evEyeBoss = [[Event alloc] initWithId:@"A0796EC5-191D-4389-9C09-E48829D1FDB2" andName:@"Destroy the Eye of Zhaitan."];
        EventGroup *egEye = [[EventGroup alloc] initWithName:@"Eye of Zaithan" andObjects:evEyePre, evEyeBoss, nil];
        
        // Karka
        Event *evKarkaBossA = [[Event alloc] initWithId:@"E1CC6E63-EFFE-4986-A321-95C89EA58C07" andName:@"Defeat the Karka Queen threatening the settlements."];
        Event *evKarkaBossB = [[Event alloc] initWithId:@"F479B4CF-2E11-457A-B279-90822511B53B" andName:@"Defeat the Karka Queen threatening the settlements."];
        Event *evKarkaBossC = [[Event alloc] initWithId:@"5282B66A-126F-4DA4-8E9D-0D9802227B6D" andName:@"Defeat the Karka Queen threatening the settlements."];
        Event *evKarkaBossD = [[Event alloc] initWithId:@"4CF7AA6E-4D84-48A6-A3D1-A91B94CCAD56" andName:@"Defeat the Karka Queen threatening the settlements."];
        EventGroup *egKarka = [[EventGroup alloc] initWithName:@"Karka Queen" andObjects:evKarkaBossA, evKarkaBossB, evKarkaBossC, evKarkaBossD, nil];
        
        // EventGroup
        self._eventGroups = [[NSMutableArray alloc] initWithObjects:
                             egShadowBehemot, egFireElemental, egJungleWurm, egShatterer, egTequalt, egGolemMark, egJormag,
                             egBalthazar, egLyssa, egDwayna, egGrenth, egMelandru,
                             egFrozenMaw, egFoulbear, egUlgoth, egDredge, egTaidha, egFireShaman, egEye,
                             egKarka, nil];
    }
    
    return self;
}

- (void) createGUI{
    // World Selection
    NSMenu *menu = [[NSMenu alloc] init];
    for(World *w in self._worldNames){
        NSMenuItem *menuItem = [[NSMenuItem alloc] init];
        [menuItem setTag:w._id];
        [menuItem setTitle:w._name];
        [menu addItem:menuItem];
    }
    [self._worldSelection setMenu:menu];
    
    // Worlds - Selected
    //NSInteger worldInit = [[self._worldNamesEU objectAtIndex:0] _id];
    NSInteger worldInit = 2104;
    self._selectedWorldId = worldInit;
    [self._worldSelection selectItemWithTag:worldInit];
    
    // Events and date
    [self updateEvents];
}


- (void) updateEvents{
    // Update events and activity
    [self._ejp updateFromURL:self._selectedWorldId andEventGroups:self._eventGroups];
    
    // Sort events
    NSSortDescriptor *sortActive = [NSSortDescriptor sortDescriptorWithKey:@"_isActive" ascending:NO selector:@selector(compare:)];
    NSSortDescriptor *sortName = [NSSortDescriptor sortDescriptorWithKey:@"_name" ascending:YES selector:@selector(compare:)];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortActive, sortName, nil];
    self._eventGroups = [self._eventGroups sortedArrayUsingDescriptors:sortDescriptors];
    
    //
    for(EventGroup *eg in self._eventGroups){
        if (eg._isActive) {
            [eg printDetails];
        }
    }
    
    // Update date
    NSDate *date = [NSDate date];
    NSString *formattedDateString = [self._lastUpdatedFormatter stringFromDate:date];
    [self._updateText setStringValue:formattedDateString];
    
    // Reload view
    [self._statusTable reloadData];
}

/**********/
/* POP UP */
/**********/

-(IBAction)worldSelected:(id)sender{
    NSPopUpButton *btn = (NSPopUpButton*)sender;
    self._selectedWorldId = [[btn selectedItem] tag];
    NSLog(@"Pop Up");
    [self updateEvents];
}


/*********/
/* TABLE */
/*********/

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    [tableView setBackgroundColor:[NSColor lightGrayColor]];
    
    // Get a new ViewCell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    // Get EventGroup
    EventGroup *eg = [self._eventGroups objectAtIndex:row];
    
    //Multicolumn
    if( [tableColumn.identifier isEqualToString:@"eventColumn"] ){
        cellView.textField.stringValue = eg._name;
        return cellView;
    }
    
    if( [tableColumn.identifier isEqualToString:@"statusColumn"] ){
        NSFont* boldFont = [NSFont boldSystemFontOfSize:[NSFont systemFontSize]];
        [cellView.textField setFont:boldFont];
        if (eg._isActive) {
            cellView.textField.stringValue = @"Active";
        }else{
            cellView.textField.stringValue = @"--";
        }
        return cellView;
    }
    
    return cellView;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    //return [self._events count];
    return [self._eventGroups count];
}

@end

