require "open-uri"

if Rails.env.development?
 puts "Deleting data"
 Tournament.destroy_all
 Participation.destroy_all
 User.destroy_all
 puts "Data deleted successfully"
end

user1 = User.create!(name: "Marcelo", last_name:"Dalmau", nickname: "user1", email: "Marcelo@gmail.com", password: "123456", phone: "911223344")
archivo1 = URI.open("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg")
user1.photo.attach(io: archivo1, filename: "marcelo.png", content_type: "image/png")
user1.save
puts "#{user1.name} creado exitosamente"

user2 = User.create!(name: "Enrique", last_name: "Noriega ", nickname: "user2", email: "Enrique@gmail.com", password: "123456", phone: "911223344")
archivo2 = URI.open("https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg")
user2.photo.attach(io: archivo2, filename: "enrrique.png", content_type: "image/png")
user2.save
puts "#{user2.name} creado exitosamente"

user3 = User.create!(name: "Ana", last_name:"García", nickname: "user3", email: "AnaGarcia@gmail.com", password: "123456", phone: "911223344")
archivo3 = URI.open("https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg")
user3.photo.attach(io: archivo3, filename: "ana.png", content_type: "image/png")
user3.save
puts "#{user3.name} creado exitosamente"

user4 = User.create!(name: "Pedro", last_name:"Méndez", nickname: "user4", email: "PedroMendez@gmail.com", password: "123456", phone: "911223344")
archivo4 = URI.open("https://images.pexels.com/photos/10709335/pexels-photo-10709335.jpeg")
user4.photo.attach(io: archivo4, filename: "pedro.png", content_type: "image/png")
user4.save
puts "#{user4.name} creado exitosamente"

user5 = User.create!(name: "Luisa", last_name:"Hernández", nickname: "user5", email: "LuisaHernandez@gmail.com", password: "123456", phone: "911223344")
archivo5 = URI.open("https://images.pexels.com/photos/712513/pexels-photo-712513.jpeg")
user5.photo.attach(io: archivo5, filename: "luisa.png", content_type: "image/png")
user5.save
puts "#{user5.name} creado exitosamente"

user6 = User.create!(name: "Juan", last_name:"Pérez", nickname: "user6", email: "JuanPerez@gmail.com", password: "123456", phone: "911223344")
archivo6 = URI.open("https://images.pexels.com/photos/10709335/pexels-photo-10709335.jpeg")
user6.photo.attach(io: archivo6, filename: "juan.png", content_type: "image/png")
user6.save
puts "#{user6.name} creado exitosamente"

user7 = User.create!(name: "Miguel", last_name:"González", nickname: "user7", email: "miguel.gonzalez@gmail.com", password: "123456", phone: "911223344")
archivo7 = URI.open("https://images.pexels.com/photos/1121796/pexels-photo-1121796.jpeg")
user7.photo.attach(io: archivo7, filename: "miguel.png", content_type: "image/png")
user7.save
puts "#{user7.name} creado exitosamente"

user8 = User.create!(name: "Laura", last_name:"López", nickname: "user8", email: "laura.lopez@gmail.com", password: "123456", phone: "911223344")
archivo8 = URI.open("https://images.pexels.com/photos/712513/pexels-photo-712513.jpeg")
user8.photo.attach(io: archivo8, filename: "laura.png", content_type: "image/png")
user8.save
puts "#{user8.name} creado exitosamente"

user9 = User.create!(name: "Carla", last_name:"García", nickname: "user9", email: "carla.garcia@gmail.com", password: "123456", phone: "911223344")
archivo9 = URI.open("https://tse3.mm.bing.net/th/id/OIP.tStooT58hVyoqmeg9nKnaQHaE7?pid=ImgDet&rs=1")
user9.photo.attach(io: archivo9, filename: "carla.png", content_type: "image/png")
user9.save
puts "#{user9.name} creado exitosamente"

user10 = User.create!(name: "Julia", last_name:"Fernández", nickname: "user10", email: "Julia@gmail.com", password: "123456", phone: "911223344")
archivo10 = URI.open("https://guiapadel.com/wp-content/uploads/chica-padel.jpg")
user10.photo.attach(io: archivo10, filename: "julia.png", content_type: "image/png")
user10.save
puts "#{user10.name} creado exitosamente"

user11 = User.create!(name: "Fabian", last_name: "Rubio", nickname: "user11", email: "fabian@gmail.com", password: "123456", phone: "911223344")
file = URI.open("https://avatars.githubusercontent.com/u/108149366?v=4")
user11.photo.attach(io: file, filename: "fabian.png", content_type: "image/png")
user11.save
puts "#{user11.name} created successfully"

user12 = User.create!(name: "Steve", last_name: "Brusa", nickname: "user12", email: "steve@gmail.com", password: "123456", phone: "911223344")
file = URI.open("https://avatars.githubusercontent.com/u/121344930?v=4")
user12.photo.attach(io: file, filename: "steve.png", content_type: "image/png")
user12.save
puts "#{user12.name} created successfully"

user13 = User.create!(name: "Fernando", last_name: "Gonzalez", nickname: "user13", email: "fernando@gmail.com", password: "123456", phone: "911223344")
file = URI.open("https://avatars.githubusercontent.com/u/108149366?v=4")
user13.photo.attach(io: file, filename: "fdo.png", content_type: "image/png")
user13.save
puts "#{user13.name} created successfully"

user14 = User.create!(name: "Claudio", last_name: "Vergara", nickname: "user14", email: "claudio@gmail.com", password: "123456", phone: "911223344")
file = URI.open("https://avatars.githubusercontent.com/u/108149366?v=4")
user14.photo.attach(io: file, filename: "fdo.png", content_type: "image/png")
user14.save
puts "#{user14.name} created successfully"

user15 = User.create!(name: "Nicolas", last_name: "Massu", nickname: "user15", email: "nicolas@gmail.com", password: "123456", phone: "911223344")
file = URI.open("https://avatars.githubusercontent.com/u/108149366?v=4")
user15.photo.attach(io: file, filename: "fdo.png", content_type: "image/png")
user15.save
puts "#{user15.name} created successfully"

user16 = User.create!(name: "Jorge", last_name: "Gonzalez", nickname: "user16", email: "jorge@gmail.com", password: "123456", phone: "911223344")
file = URI.open("https://avatars.githubusercontent.com/u/108149366?v=4")
user16.photo.attach(io: file, filename: "fdo.png", content_type: "image/png")
user16.save
puts "#{user16.name} created successfully"

user17 = User.create!(name: "Julian", last_name: "Alvarez", nickname: "user17", email: "julian@gmail.com", password: "123456", phone: "911223344")
file = URI.open("https://avatars.githubusercontent.com/u/108149366?v=4")
user17.photo.attach(io: file, filename: "fdo.png", content_type: "image/png")
user17.save
puts "#{user17.name} created successfully"

user18 = User.create!(name: "Marcelo", last_name: "Rios", nickname: "user18", email: "marcelor@gmail.com", password: "123456", phone: "911223344")
file = URI.open("https://avatars.githubusercontent.com/u/108149366?v=4")
user18.photo.attach(io: file, filename: "fdo.png", content_type: "image/png")
user18.save
puts "#{user18.name} created successfully"

user19 = User.create!(name: "Tomas", last_name: "Valdivia", nickname: "user19", email: "tomas@gmail.com", password: "123456", phone: "911223344")
file = URI.open("https://avatars.githubusercontent.com/u/108149366?v=4")
user19.photo.attach(io: file, filename: "fdo.png", content_type: "image/png")
user19.save
puts "#{user19.name} created successfully"

user20 = User.create!(name: "Gonzalo", last_name: "Martinez", nickname: "user20", email: "gonzalo@gmail.com", password: "123456", phone: "911223344")
file = URI.open("https://avatars.githubusercontent.com/u/108149366?v=4")
user20.photo.attach(io: file, filename: "fdo.png", content_type: "image/png")
user20.save
puts "#{user20.name} created successfully"

puts "Creating Tournaments"

tournament1 = Tournament.create!(name: "Champions League", ubication_name: "Club de Padel RedPadel", address: "Av Vitacura 8751", user_id: user1.id, price: 10000, start_date: "2023-03-24", end_date: "2023-03-26", duration: "3 horas", type: "Champions League", category: "Mixto A", min_matches: 3, max_matches: 5, places: 16, available_places: 16, match_duration: "1 hora", awards: "Trofeo y Medalla", other: "Inscrpicion Hasta el 22 de Marzo")

file = URI.open("https://www.lapadel.com/wp-content/uploads/2016/10/P-EMO_01.jpg")
tournament1.photo.attach(io: file, filename: "t1.png", content_type: "image/png")
tournament1.save

tournament2 = Tournament.create!(name: "Americano", ubication_name: "Alto Padel", address: "Avenida Las Condes 11755", user_id: user2.id, price: 8000, start_date: "2023-03-31", end_date: "2023-03-31", duration: "1 hora", type: "Americano", category: "Femenino B", min_matches: 2, max_matches: 8, places: 8, available_places: 8, match_duration: "20 minutos", awards: "Dinero en Efectivo", other: "Inscrpicion Hasta el 29 de Marzo")

file = URI.open("https://canariasnoticias.es/sites/default/files/2018/03/canchas_de_padel21.jpg")
tournament2.photo.attach(io: file, filename: "t2.png", content_type: "image/png")
tournament2.save


tournament3 = Tournament.create!(name: "Express", ubication_name: "Pasco Club", address: "El Aguilucho 3308", user_id: 3, price: 8000, start_date: "2023-04-07", end_date: "2023-04-07", duration: "4 horas", type: "Express", category: "Masculino 1ra", min_matches: 3, max_matches: 3, places: 8, available_places: 8, match_duration: "1 hora", awards: "Trofeo", other: "Inscrpicion Hasta el 05 de Abril")


file = URI.open("https://i.pinimg.com/originals/90/ca/50/90ca500c7219727670904935c8f0fbfa.jpg")
tournament3.photo.attach(io: file, filename: "t3.png", content_type: "image/png")
tournament3.save

puts "Torneos Creados"

puts "Creando Participations"

# range(2..17).each do |i|
#   Participation.create!(tournament_id: 1, user_id: i, status: "pagado")
# end

# p1 = Participation.create!(tournament_id: 1, user_id: 2, status: "pagado")
# p2 = Participation.create!(tournament_id: 1, user_id: 3, status: "pagado")
# p3 = Participation.create!(tournament_id: 1, user_id: 4, status: "pagado")
# p4 = Participation.create!(tournament_id: 1, user_id: 5, status: "pagado")
# p5 = Participation.create!(tournament_id: 1, user_id: 6, status: "pagado")
# p6 = Participation.create!(tournament_id: 1, user_id: 7, status: "pagado")
# p7 = Participation.create!(tournament_id: 1, user_id: 8, status: "pagado")
# p8 = Participation.create!(tournament_id: 1, user_id: 9, status: "pagado")
# p9 = Participation.create!(tournament_id: 1, user_id: 10, status: "pagado")
# p10 = Participation.create!(tournament_id: 1, user_id: 11, status: "pagado")
# p11 = Participation.create!(tournament_id: 1, user_id: 12, status: "pagado")
# p12 = Participation.create!(tournament_id: 1, user_id: 13, status: "pagado")
# p13 = Participation.create!(tournament_id: 1, user_id: 14, status: "pagado")
# p14 = Participation.create!(tournament_id: 1, user_id: 15, status: "pagado")
# p15 = Participation.create!(tournament_id: 1, user_id: 16, status: "pagado")
# p16 = Participation.create!(tournament_id: 1, user_id: 17, status: "pagado")
# tournament1 = Tournament.find(1)
# tournament1.available_places = 0
# tournament1.save

p1 = Participation.create!(tournament_id: 3, user_id: 1, status: "pagado")
p2 = Participation.create!(tournament_id: 3, user_id: 2, status: "pagado")
p3 = Participation.create!(tournament_id: 3, user_id: 4, status: "pagado")
p4 = Participation.create!(tournament_id: 3, user_id: 5, status: "pagado")
p5 = Participation.create!(tournament_id: 3, user_id: 6, status: "pagado")
p6 = Participation.create!(tournament_id: 3, user_id: 7, status: "pagado")
p7 = Participation.create!(tournament_id: 3, user_id: 8, status: "pagado")
p8 = Participation.create!(tournament_id: 3, user_id: 9, status: "pagado")
tournament3 = Tournament.find(3)
tournament3.available_places = 0
tournament3.save

# p1 = Participation.create!(tournament_id: 2, user_id: 1, status: "pagado")
# p2 = Participation.create!(tournament_id: 2, user_id: 3, status: "pagado")
# p3 = Participation.create!(tournament_id: 2, user_id: 4, status: "pagado")
# p4 = Participation.create!(tournament_id: 2, user_id: 5, status: "pagado")
# p5 = Participation.create!(tournament_id: 2, user_id: 6, status: "pagado")
# p6 = Participation.create!(tournament_id: 2, user_id: 7, status: "pagado")
# p7 = Participation.create!(tournament_id: 2, user_id: 8, status: "pagado")
# p8 = Participation.create!(tournament_id: 2, user_id: 9, status: "pagado")
# tournament2 = Tournament.find(2)
# tournament2.available_places = 0
# tournament2.save


puts "Participations creadas"
