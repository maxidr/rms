# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101202122214) do

  create_table "caracteristicas", :force => true do |t|
    t.string   "nombre"
    t.string   "valor"
    t.integer  "material_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "condiciones_pagos", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "empresas", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "materiales", :force => true do |t|
    t.string   "nombre"
    t.string   "cantidad"
    t.text     "detalle"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "requerimiento_id"
  end

  create_table "monedas", :force => true do |t|
    t.string   "simbolo"
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proveedores", :force => true do |t|
    t.string   "razon_social"
    t.text     "domicilio"
    t.string   "telefono"
    t.string   "cuit"
    t.text     "contacto"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requerimientos", :force => true do |t|
    t.integer  "solicitante_id"
    t.integer  "empresa_id"
    t.integer  "sector_id"
    t.integer  "rubro_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rubros", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sectores", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "identificador"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
