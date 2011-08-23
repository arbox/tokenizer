# -*- coding: utf-8 -*-
require 'test/unit'
require 'tokenizer'

class TestTokenizerDev < Test::Unit::TestCase

  def setup
    @de_tokenizer = Tokenizer::Tokenizer.new(:de)
  end

  def test_tokenization_001
    input = 'ich ging? du, und ich nicht (konnte nicht)? Warum?!!'
    etalon = %w{ ich ging ? du , und ich nicht ( konnte nicht ) ? Warum ? ! !}
    compare(etalon, input)
  end

  def test_tokenization_002
    input = "Die deutschen Umlaute und Sonderzeichen, wie in Mäuse, Scheiß und Tütchen, sind blöd!"
    etalon = %w{Die deutschen Umlaute und Sonderzeichen , wie in Mäuse , Scheiß und Tütchen , sind blöd !}
    compare(etalon, input)
  end
  
  def test_tokenization_003
    input = "Abkürzungen, wie z.B. usw. und d.h. können zu Problemem führen."
    etalon = %w{Abkürzungen , wie z.B. usw. und d.h. können zu Problemem führen .}
    compare(etalon, input)
  end
  
  def test_tokenization_004
    input = "Es gibt mehr als 1.023.345 Menschen in Deutschland, die keine Tausenderpunkte verstehen."
    etalon = %w{Es gibt mehr als 1.023.345 Menschen in Deutschland , die keine Tausenderpunkte verstehen .}
    compare(etalon, input)
  end
  
  def test_tokenization_005
    input = "Cocktails, wie Apfel-Martini, Rum-Kirsche-Cola und andere, bereiten nicht nur Menschen Probleme."
    etalon = %w{ Cocktails , wie Apfel-Martini , Rum-Kirsche-Cola und andere , bereiten nicht nur Menschen Probleme . }
    compare(etalon, input)
  end
  
  def test_tokenization_006
    input = 'Es gibt viele verschiedene Zeichen, die noch in Texten vorkommen können wie - zum Beispiel - diese hier "text" oder (text).'
    etalon = %w{Es gibt viele verschiedene Zeichen , die noch in Texten vorkommen können wie - zum Beispiel - diese hier " text " oder ( text ) .}
    compare(etalon, input)
  end
  
  def test_tokenization_007
    input = "Abkürzungen sind immer ein Problem, da auch Leerzeichen dazwischen stehen können, wie z. B. hier."
    etalon = ["Abkürzungen", "sind", "immer", "ein", "Problem", ",", "da", "auch", "Leerzeichen", "dazwischen", "stehen", "können", ",", "wie", "z. B.", "hier", "."]
    compare(etalon, input)
  end
  
  def test_tokenization_008
    input = "Außerdem kann es nach Abkürzungen und Satzenden auch mit Großschreibung weiter gehen, bei z.B. Aufzählungen."
    etalon = %w{Außerdem kann es nach Abkürzungen und Satzenden auch mit Großschreibung weiter gehen , bei z.B. Aufzählungen .}
    compare(etalon, input)
  end
  
  def test_tokenization_009
    input = "Ein weiteres Problem sind solche Getrennt- und Zusammenschreibungen."
    etalon = %w{Ein weiteres Problem sind solche Getrenntschreibungen und Zusammenschreibungen .}
    compare(etalon, input)
  end
  
  def test_tokenization_010
    input = "In manchen Texten gibt es auch Worttrennung am Zeilen- ende."
    etalon = %w{In manchen Texten gibt es auch Worttrennung am Zeilenende .}
    compare(etalon, input)
  end
  
  def test_tokenization_011 #Ellipsis
    input = "Der Satz endet in einer Ellips..."
    etalon = %w{ Der Satz endet in einer Ellips... } #die elliptischen Punkte sollten nicht vom Wort getrennt werden
    compare(etalon, input)
  end
  
  def test_tokenization_012 #Fehlende Leerzeichen
    input = "Der Satz endet.Das Leerzeichen fehlt."
    etalon = %w{ Der Satz endet . Das Leerzeichen fehlt . } #/\.\s(?=[A-Z])/ wuerde die Saetze nicht trennen
    compare(etalon, input)
  end
  
  def test_tokenization_013 #Bindestriche
    input = "Das Bindeglied - manisch-depressives Verhalten, binden-verbinden"
    etalon = %w{ Das Bindeglied - manisch-depressives Verhalten , binden - verbinden}
    compare(etalon, input)
  end
  
  def test_tokenization_014 #Abkuerzungen
    input = "Der Satz enthielt z.B. Fehler"
    etalon = %w{ Der Satz enthielt z.B. Fehler } #/\.\s(?=[A-Z])/ wuerde hinter Punkt den Satz beenden
    compare(etalon, input)
  end
  
  def test_tokenization_015 #Fehlende Grossbuchstaben
    input = "Der Satz endet. der Satz beginnt"
    etalon = %w{ Der Satz endet . der Satz beginnt } #/\.\s(?=[A-Z])/ wuerde die Saetze nicht trennen
    compare(etalon, input)
  end
  
  def test_tokenization_016 #Franzoesisch
    input = "L'art de l'univers, c'est un art"
    etalon = %w{ L' art de l' univers , c'est un art } #Kontrovers!
    compare(etalon, input)
  end
  
  def test_tokenization_017 #James Bond
    input = "Bond,... James Bond."
    etalon = %w{ Bond , ... James Bond . } #Kontrovers!
    compare(etalon, input)
  end
  
  def test_tokenization_018 #Inches
    input = "The square had four 9\" sides"
    etalon = %w{ The square had four 9" sides }
    compare(etalon, input)
  end
  
  def test_tokenization_019 #Abkuerzung zugleich Lexikon-Eintrag
    input = "In fig. 3, a fig can be seen. Fig. no. 4 shows no fig."
    etalon = %w{ In fig. 3 , a fig can be seen . Fig. no. 4 shows no fig . } #fig sowohl als Abkuerzung als auch als Wort
    compare(etalon, input)
  end
  
  def test_tokenization_020 #Leerzeichen-getrennte Zusammengehörigkeiten
    input = "They booked the flight New York-Los Angeles"
    etalon = ["They", "booked", "the", "flight", "New York", "-", "Los Angeles"] #oder mit Bindestrich verbunden
    compare(etalon, input)
  end
  
  def test_tokenization_021 #Ordinale
    input = "Der 1. Platz ging an den Sieger"
    etalon = %w{ Der 1. Platz ging an den Sieger }
    compare(etalon, input)
  end
  
  def test_tokenization_022 #Klitika
    input = "Er war's, stimmt's?"
    etalon = %w{ Er war es , stimmt es ? } #Kontrovers! Benoetigt komplexere Analyse
    compare(etalon, input)
  end
  
  def test_tokenization_023 #Datums- und Zeitangaben
    input = "Es passierte am 13. Januar 2011 um 12:13 Uhr"
    etalon = [ "Es", "passierte", "am", "13. Januar 2011", "um", "12:13 Uhr"]
    compare(etalon, input)
  end
  
  def test_tokenization_024 #Eingebettete Saetze
    input = "\"This is all?\" George asked."
    etalon = %w{ This is all ? George asked . } #kann zu ungrammatischen Saetzen fuehren
    compare(etalon, input)
  end
  
  def test_tokenization_025 #Eingebettete Saetze 2
    input = "\"Das ist alles?\" fragte sie."
    etalon = %w{ Das ist alles ? fragte sie . } #ungrammatischer Satz "fragte sie."
    compare(etalon, input)
  end
  
  
  def test_tokenization_026
    input = "Die deutschen Umlaute und Sonderzeichen, wie in Mäuse, Scheiß und Tütchen, sind blöd!"
    etalon = %w{ Die deutschen Umlaute und Sonderzeichen , wie in Mäuse , Scheiß und Tütchen , sind blöd ! }
    compare(etalon, input)
  end
  
  def test_tokenization_027
    input = "Abkürzungen, wie z.B. usw. und d.h. können zu Problemem führen."
    etalon = %w{ Abkürzungen , wie z.B. usw. und d.h. können zu Problemem führen . }
    compare(etalon, input)
  end
  
  def test_tokenization_028
    input = "Es gibt mehr als 1.023.345 Menschen in Deutschland, die keine Tausenderpunkte verstehen."
    etalon = %w{ Es gibt mehr als 1.023.345 Menschen in Deutschland , die keine Tausenderpunkte verstehen . }
    compare(etalon, input)
  end
  
  def test_tokenization_029
    input = "Cocktails, wie Apfel-Martini, Rum-Kirsche-Cola und andere, bereiten nicht nur Menschen Probleme."
    etalon = %w{ Cocktails , wie Apfel-Martini , Rum-Kirsche-Cola und andere , bereiten nicht nur Menschen Probleme . }
    compare(etalon, input)
  end
  
  def test_tokenization_030 #Ellipsis
    input = "Der Satz endet in einer Ellips..."
    etalon = %w{ Der Satz endet in einer Ellips... } #die elliptischen Punkte sollten nicht vom Wort getrennt werden
    compare(etalon, input)
  end
  
  def test_tokenization_031 #Fehlende Leerzeichen
    input = "Der Satz endet.Das Leerzeichen fehlt."
    etalon = %w{ Der Satz endet . Das Leerzeichen fehlt . } #/\.\s(?=[A-Z])/ wuerde die Saetze nicht trennen
    compare(etalon, input)
  end
  
  def test_tokenization_032 #Bindestriche
    input = "Das Bindeglied - manisch-depressives Verhalten, binden-verbinden"
    etalon = %w{ Das Bindeglied - manisch-depressives Verhalten , binden - verbinden}
    compare(etalon, input)
  end
  
  def test_tokenization_033 #Abkuerzungen
    input = "Der Satz enthielt z.B. Fehler"
    etalon = %w{ Der Satz enthielt z.B. Fehler } #/\.\s(?=[A-Z])/ wuerde hinter Punkt den Satz beenden
    compare(etalon, input)
  end
  
  def test_tokenization_034 #Fehlende Grossbuchstaben
    input = "Der Satz endet. der Satz beginnt"
    etalon = %w{ Der Satz endet . der Satz beginnt } #/\.\s(?=[A-Z])/ wuerde die Saetze nicht trennen
    compare(etalon, input)
  end
  
  def test_tokenization_035 #Franzoesisch
    input = "L'art de l'univers, c'est un art"
    etalon = %w{ L' art de l' univers , c'est un art } #Kontrovers!
    compare(etalon, input)
  end
  
  def test_tokenization_036 #James Bond
    input = "Bond,... James Bond."
    etalon = %w{ Bond , ... James Bond . } #Kontrovers!
    compare(etalon, input)
  end
  
  def test_tokenization_037 #Inches
    input = "The square had four 9\" sides"
    etalon = %w{ The square had four 9" sides }
    compare(etalon, input)
  end
  
  def test_tokenization_039 #Abkuerzung zugleich Lexikon-Eintrag
    input = "In fig. 3, a fig can be seen. Fig. no. 4 shows no fig."
    etalon = %w{ In fig. 3 , a fig can be seen . Fig. no. 4 shows no fig . } #fig sowohl als Abkuerzung als auch als Wort
    compare(etalon, input)
  end
  
  def test_tokenization_040 #Leerzeichen-getrennte Zusammengehörigkeiten
    input = "They booked the flight New York-Los Angeles"
    etalon = ["They", "booked", "the", "flight", "New York", "-", "Los Angeles"] #oder mit Bindestrich verbunden
    compare(etalon, input)
  end
  
  def test_tokenization_041 #Ordinale
    input = "Der 1. Platz ging an den Sieger"
    etalon = %w{ Der 1. Platz ging an den Sieger }
    compare(etalon, input)
  end
  
  def test_tokenization_042 #Klitika
    input = "Er war's, stimmt's?"
    etalon = %w{ Er war es , stimmt es ? } #Kontrovers! Benoetigt komplexere Analyse
    compare(etalon, input)
  end
  
  #Datums- und Zeitangaben
  def test_tokenization_043 
    input = "Es passierte am 13. Januar 2011 um 12:13 Uhr"
    etalon = ["Es", "passierte", "am", "13. Januar 2011", "um", "12:13 Uhr"]
    compare(etalon, input)
  end
  
  #Eingebettete Sätze
  def test_tokenization_044
    input = '"This is all?" George asked.'
    etalon = %w{ This is all ? George asked . } #kann zu ungrammatischen Saetzen fuehren
    compare(etalon, input)
  end
  
  def test_tokenization_046 #Eingebettete Saetze 2
    input = '"Das ist alles?" fragte sie.'
    etalon = %w{Das ist alles ? fragte sie .} #ungrammatischer Satz "fragte sie."
    compare(etalon, input)
  end
  
  private
  def compare(exp_result, input)
    act_result = @de_tokenizer.tokenize(input)
    assert_equal(exp_result, act_result)
  end
end
