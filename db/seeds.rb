preguntas_actor = YAML.load_file("#{Rails.root.to_s}/config/preguntas.yml")["preguntas"]
preguntas_iniciativa = YAML.load_file("#{Rails.root.to_s}/config/preguntas_iniciativa.yml")["preguntas"]
actores = YAML.load_file("#{Rails.root.to_s}/config/actores.yml")["actores"]

if Pregunta.count > 0
  puts "Warning: Removing all #{Pregunta.count} existing preguntas"
  GrupoPreguntas.destroy_all
  Pregunta.destroy_all
end

preguntas_actor.each do |p|
  grupo_preguntas = GrupoPreguntas.create!(title: p.keys.first, kind: :actor)
  p[p.keys.first].each do |attributes|
    grupo_preguntas.preguntas.create!(attributes)
  end
end
preguntas_iniciativa.each do |p|
  grupo_preguntas = GrupoPreguntas.create!(title: p.keys.first, kind: :iniciativa)
  p[p.keys.first].each do |attributes|
    grupo_preguntas.preguntas.create!(attributes)
  end
end
Pregunta.children.each do |pregunta|
  pregunta.update! grupo_preguntas_id: pregunta.parent.grupo_preguntas_id
end
puts "Added #{Pregunta.count} preguntas"

if User.count == 0
  puts "Creating a@macool.me as admin"
  user = User.create!(email: "a@macool.me", admin: true, will_invite: true)
else
  user = User.first
  puts "using #{user} to fill descripciones"
end

if Actor.count > 0
  puts "Warning: Removing all #{Actor.count} existing actores"
  Actor.destroy_all
end
if Respuesta.count > 0
  puts "Warning: Removing all #{Respuesta.count} existing respuestas"
  Respuesta.destroy_all
end
actores.each do |attributes|
  actor = Actor.where(nombre: attributes["nombre"]).first_or_initialize
  descripcion = attributes.delete "descripcion"
  actor.update! attributes

  # create a respuesta for descripcion
  respuesta = Respuesta.create!(user: user, actor: actor)
  RespuestaPregunta.create!(respuesta: respuesta,
                            pregunta: Pregunta.first, # we assume first question is descripcion
                            answer: descripcion)
end
puts "Added #{Actor.count} actores"
puts "Added #{Respuesta.count} respuestas"

# set default logo_url for actores that don't have it
Actor.where(default_logo_url: nil).find_each do |actor|
  actor.update! default_logo_url: "/images/actores/#{actor.slug}.png"
end
