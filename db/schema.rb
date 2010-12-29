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

ActiveRecord::Schema.define(:version => 20101228223142) do

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

  create_table "detalles_aprobacion_compras", :force => true do |t|
    t.integer "autorizante_id"
    t.integer "presupuesto_id"
  end

  create_table "detalles_aprobacion_sector", :force => true do |t|
    t.integer  "autorizante_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "detalles_pendiente_aprobacion", :force => true do |t|
    t.integer "autorizante_id"
  end

  create_table "detalles_rechazo_compras", :force => true do |t|
    t.integer "rechazado_por_id"
    t.text    "motivo"
  end

  create_table "detalles_rechazo_sector", :force => true do |t|
    t.integer "autorizante_id"
    t.text    "motivo"
  end

  create_table "empresas", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estados_historicos", :force => true do |t|
    t.integer  "codigo_estado",    :default => 0, :null => false
    t.integer  "requerimiento_id"
    t.integer  "detalle_id"
    t.string   "detalle_type"
    t.datetime "created_at"
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

  create_table "presupuestos", :force => true do |t|
    t.integer  "proveedor_id"
    t.integer  "moneda_id"
    t.decimal  "monto"
    t.integer  "condicion_pago_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "requerimiento_id"
    t.string   "detalle"
    t.boolean  "aprobado",          :default => false
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
    t.integer  "estado",         :default => 0, :null => false
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
    t.integer  "responsable_id"
    t.string   "email"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "identificador"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sector_id"
  end

end
