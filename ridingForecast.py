import matplotlib.pyplot as plt

class partyForecast():
    """
    Class for holding the forecast for a specific party
    """
    def __init__(self, partyName=None, forecast = -1, high=-1, low=-1):
        self.partyName = partyName
        self.high = high
        self.low = low
        self.forecast = forecast

    def __str__(self):
        return "{} Party, low = {}, forecast = {}, high = {}".format(
            self.partyName,
            self.low, 
            self.forecast, 
            self.high)
        



class ridingForecast():
    """
    Class for holding the party forecasts in a riding
    """
    def __init__(self, riding, forecastProb=-1):
        self.ridingName = riding
        self.forecastProb = forecastProb
        self.partyList = []


    def addParty(self, newPartyForecast):
        self.partyList.append(newPartyForecast)

    def getWinner(self):
        maxForecast = 0
        winner = None
        for party in self.partyList:
            if party.forecast >= maxForecast:
                maxForecast = party.forecast
                winner = party.partyName
        return (winner, maxForecast)

    def getSecond(self):
        forecasts = sorted([(party.partyName, party.forecast) for party in self.partyList], 
                           reverse=True, key=lambda x: x[1])
        return forecasts[1]


    def getForecast(self, partyName):
        for party in self.partyList:
            if partyName == party.partyName:
                return party.forecast
        print("Warning: {} Party not found".format(partyName))
        return -1.0

    def print308(self):
         print("Low / Bas     {}     {}    {}    {}     {}     {}".format(
             self.partyList[0].low,
             self.partyList[1].low,
             self.partyList[2].low,
             self.partyList[3].low,
             self.partyList[4].low,
             self.partyList[5].low))
         print("{}     {}     {}    {}    {}     {}     {}     {}%".format(
             self.ridingName,
             self.partyList[0].forecast,
             self.partyList[1].forecast,
             self.partyList[2].forecast,
             self.partyList[3].forecast,
             self.partyList[4].forecast,
             self.partyList[5].forecast,
             self.forecastProb*100))
         print("High / Haut     {}     {}    {}    {}     {}     {}".format(
             self.partyList[0].high,
             self.partyList[1].high,
             self.partyList[2].high,
             self.partyList[3].high,
             self.partyList[4].high,
             self.partyList[5].high))
         return
        


    def __str__(self):
        output = [self.ridingName, 
                  "Winner: {} prob: {}".format(
                      self.getWinner(), self.forecastProb),
                  ""] + self.partyList
        return '\n'.join(map(str, output))

    
def parseCleanForecasts(clean_contents):
    """
    Function for parsing the election forcasts to a dictionary 
    of ridingForecast objects assuming the following format:
    [['Low / Bas', '41.8', '22.0', '22.8', '0.0', '0.0', '6.9', '0.1', '\n'],
    ['Abbotsford', '44.0', '24.4', '23.7', '0.0', '0.0', '7.7', '0.1', '86%\n'],
    ['High / Haut', '48.4', '26.1', '25.6', '0.0', '0.0', '8.2', '0.2', '\n'],
    ['Low / Bas', '21.7', '33.7', '32.9', '0.0', '0.0', '4.8', '0.1', '\n'],
    ['Burnaby North – Seymour','22.8','37.4','34.3','0.0','0.0','5.4','0.1','58%\n'],
    ['High / Haut', '25.1', '40.0', '37.0', '0.0', '0.0', '5.8', '0.2', '\n'],
    ...etc...
    """
    ridingDict = {}
    for row in clean_contents:
        if row[0] == 'Low / Bas':
            try:
                conlow = float(row[1])
                liblow = float(row[2])
                ndplow = float(row[3])
                bloclow = float(row[4])
                greenlow = float(row[6])
                otherlow = float(row[7])
            except ValueError:
                print("Oops. Non-float detected...")
        elif row[0] == 'High / Haut':
            try:
                conhigh = float(row[1])
                libhigh = float(row[2])
                ndphigh = float(row[3])
                blochigh =float(row[4])
                greenhigh = float(row[6])
                otherhigh = float(row[7])
            except ValueError:
                print("Oops. Non-float detected...")
            
            ridingDict[riding] = ridingForecast(riding, forecast)
            ridingDict[riding].addParty(partyForecast(partyName='Conservative', 
                                 forecast = conforecast, 
                                 high=conhigh, 
                                 low=conlow))
            ridingDict[riding].addParty(partyForecast(partyName='Liberal', 
                                 forecast = libforecast, 
                                 high=libhigh, 
                                 low=liblow))
            ridingDict[riding].addParty(partyForecast(partyName='New Democratic', 
                                 forecast = ndpforecast, 
                                 high=ndphigh, 
                                 low=ndplow))
            ridingDict[riding].addParty(partyForecast(partyName='Bloc Quebecois', 
                                 forecast = blocforecast, 
                                 high=blochigh, 
                                 low=bloclow))
            ridingDict[riding].addParty(partyForecast(partyName='Green', 
                                 forecast = greenforecast, 
                                 high=greenhigh, 
                                 low=greenlow))
            ridingDict[riding].addParty(partyForecast(partyName='Other', 
                                 forecast = otherforecast, 
                                 high=otherhigh, 
                                 low=otherlow))
            


        else:
        #Other rows specify the riding name, the forecast, and the forecastProb
            riding = row[0]
            try:
                conforecast = float(row[1])
                libforecast = float(row[2])
                ndpforecast = float(row[3])
                blocforecast =float(row[4])
                greenforecast = float(row[6])
                otherforecast = float(row[7])
                forecast = float(row[8][:-2])/100.0
            except ValueError:
                print("Oops. Non-float detected...")
        
    return ridingDict
