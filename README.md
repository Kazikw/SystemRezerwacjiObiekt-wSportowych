# SystemRezerwacjiObiekt-wSportowych
Kompleksowa aplikacja webowa zbudowana w Javie z wykorzystaniem frameworku Spring Boot. System umożliwia zaawansowane zarządzanie dostępnością obiektów sportowych i rezerwacjami grupowymi.

W celu poprawnego uruchomienia aplikacji wykonaj poniższe kroki:

1. Konfiguracja Bazy Danych PostgreSQL
Zainstaluj i skonfiguruj serwer PostgreSQL.

Zaimportuj schemat i dane bazy danych z pliku rezerwacja_obiektow.sql. Użyj narzędzia pgAdmin lub klienta psql.

Dostosuj konfigurację bazy danych w pliku src/main/resources/application.properties:

Jeśli serwer PostgreSQL używa portu innego niż domyślny 5432, zaktualizuj linię:
spring.datasource.url=jdbc:postgresql://localhost:5432/sport-reservations
Zmień 5432 na numer portu Twojego serwera.

Upewnij się, że dane do logowania do bazy są również poprawne:
spring.datasource.username=NAZWA_UZYTKOWNIKA
spring.datasource.password=HASLO

2. Przygotowanie Projektu
Rozpakuj archiwum projektu do wybranej lokalizacji.

Otwórz projekt w zintegrowanym środowisku programistycznym (IDE), np. IntelliJ IDEA. W większości IDE wystarczy otworzyć katalog główny projektu, a IDE samo wykryje plik pom.xml i skonfiguruje projekt Maven.

3. Instalacja Zależności i Budowanie Projektu
Zainstaluj wymagane zależności Maven. Twoje IDE powinno to zrobić automatycznie po otwarciu projektu. Jeśli nie, wykonaj ręczną synchronizację projektu Maven (np. w IntelliJ IDEA: Maven tool window -> Reimport All Maven Projects).
Zbuduj projekt. 
4. Uruchomienie Aplikacji
Uruchom główną klasę aplikacji: Znajdź plik Demo3Application.java (katalog src/main/java/com/example/demo/) i uruchom go.
Aplikacja powinna się uruchomić i być dostępna pod skonfigurowanym adresem localhost:8080
