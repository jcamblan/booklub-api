# frozen_string_literal: true

julien = User.create_with(username: 'Julien', password: 'password')
             .find_or_create_by(email: 'julien@booklub.app')
cynthia = User.create_with(username: 'Cynthia', password: 'password')
              .find_or_create_by(email: 'cynthia@booklub.app')
maxime = User.create_with(username: 'Maxime', password: 'password')
             .find_or_create_by(email: 'maxime@booklub.app')
henri = User.create_with(username: 'Henri', password: 'password')
            .find_or_create_by(email: 'henri@booklub.app')
mbela = User.create_with(username: 'Mbela', password: 'password')
            .find_or_create_by(email: 'mbela@booklub.app')

club = Club.find_or_create_by(name: 'Tymate', manager: julien)
club.users = [julien, cynthia, maxime, henri, mbela]

session = club.sessions.create_with(
  submission_due_date: 6.months.ago,
  read_due_date: 5.months.ago
).find_or_create_by(name: 'Session 1')

session.submissions
       .create_with(book: Book.find_or_create_by(title: 'Ubik', authors: [Author.find_or_create_by(name: 'Philip K Dick')]))
       .find_or_create_by(user: julien)
session.submissions
       .create_with(book: Book.find_or_create_by(title: 'Le dahlia noir', authors: [Author.find_or_create_by(name: 'James Ellroy')]))
       .find_or_create_by(user: cynthia)
session.submissions
       .create_with(book: Book.find_or_create_by(title: 'Des fleurs pour Algernon', authors: [Author.find_or_create_by(name: 'Daniel Keyes')]))
       .find_or_create_by(user: maxime)
session.submissions
       .create_with(book: Book.find_or_create_by(title: 'Bazaar', authors: [Author.find_or_create_by(name: 'Stephen King')]))
       .find_or_create_by(user: henri)
session.submissions
       .create_with(book: Book.find_or_create_by(title: 'Le monde selon Garp', authors: [Author.find_or_create_by(name: 'John Irving')]))
       .find_or_create_by(user: mbela)
session.update(selected_book: Book.find_by(title: 'Le dahlia noir'), state: 'archived')

session.submissions.find_each do |submission|
  session.notes.create_with(value: Note::VALID_NOTES.sample)
         .find_or_create_by(user: submission.user, book: session.selected_book)
end

session = club.sessions.create_with(
  submission_due_date: 5.months.ago,
  read_due_date: 4.months.ago
).find_or_create_by(name: 'Session 2')
session.submissions
       .create_with(book: Book.find_or_create_by(title: 'Fondation', authors: [Author.find_or_create_by(name: 'Isaac Asimov')]))
       .find_or_create_by(user: julien)
session.submissions
       .create_with(book: Book.find_or_create_by(title: 'Le portrait de Dorian Gray', authors: [Author.find_or_create_by(name: 'Oscar Wilde')]))
       .find_or_create_by(user: cynthia)
session.submissions
       .create_with(book: Book.find_by(title: 'Des fleurs pour Algernon'))
       .find_or_create_by(user: maxime)
session.submissions
       .create_with(book: Book.find_or_create_by(title: "Candide ou l'optimisme", authors: [Author.find_or_create_by(name: 'Voltaire')]))
       .find_or_create_by(user: henri)
session.submissions
       .create_with(book: Book.find_by(title: 'Le monde selon Garp'))
       .find_or_create_by(user: mbela)
session.update(selected_book: Book.find_by(title: 'Le portrait de Dorian Gray'), state: 'archived')

session.submissions.find_each do |submission|
  session.notes.create_with(value: Note::VALID_NOTES.sample)
         .find_or_create_by(user: submission.user, book: session.selected_book)
end

session = club.sessions.create_with(
  submission_due_date: 3.months.ago,
  read_due_date: 2.months.ago
).find_or_create_by(name: 'Session 3')

session.submissions
       .create_with(book: Book.find_or_create_by(title: 'La chute des géants', authors: [Author.find_or_create_by(name: 'Ken Follet')]))
       .find_or_create_by(user: julien)
session.submissions
       .create_with(book: Book.find_or_create_by(title: 'Le vol des cygognes', authors: [Author.find_or_create_by(name: 'Jean Cristophe Grangé')]))
       .find_or_create_by(user: cynthia)
session.submissions
       .create_with(book: Book.find_by(title: 'Des fleurs pour Algernon'))
       .find_or_create_by(user: maxime)
session.submissions
       .create_with(book: Book.find_or_create_by(title: 'Orgueil et Préjugés', authors: [Author.find_or_create_by(name: 'Jane Austen')]))
       .find_or_create_by(user: henri)
session.submissions
       .create_with(book: Book.find_or_create_by(title: 'La Conjuration des imbéciles', authors: [Author.find_or_create_by(name: 'John Kennedy Toole')]))
       .find_or_create_by(user: mbela)
session.update(selected_book: Book.find_by(title: 'Le vol des cygognes'), state: 'archived')

session.submissions.find_each do |submission|
  session.notes.create_with(value: Note::VALID_NOTES.sample)
         .find_or_create_by(user: submission.user, book: session.selected_book)
end

ClubUser.find_each(&:refresh_stats)

session = club.sessions.create_with(
  submission_due_date: Time.zone.now + 1.week,
  read_due_date: Time.zone.now + 1.month
).find_or_create_by(name: 'Session 4')

session.submissions
       .create_with(book: Book.find_or_create_by(title: 'La chute des géants', authors: [Author.find_or_create_by(name: 'Ken Follet')]))
       .find_or_create_by(user: julien)
session.submissions
       .create_with(book: Book.find_or_create_by(title: 'La Ferme des animaux', authors: [Author.find_or_create_by(name: 'George Orwell')]))
       .find_or_create_by(user: cynthia)
session.submissions
       .create_with(book: Book.find_by(title: 'Des fleurs pour Algernon'))
       .find_or_create_by(user: maxime)
session.submissions
       .create_with(book: Book.find_or_create_by(title: 'Les androïdes rêvent-ils de moutons électriques ?', authors: [Author.find_or_create_by(name: 'Philip K. Dick')]))
       .find_or_create_by(user: henri)
session.submissions
       .create_with(book: Book.find_or_create_by(title: 'La Ferme des animaux', authors: [Author.find_or_create_by(name: 'George Orwell')]))
       .find_or_create_by(user: mbela)
session.update(selected_book: Book.find_by(title: 'Les androïdes rêvent-ils de moutons électriques ?'), state: 'reading')
