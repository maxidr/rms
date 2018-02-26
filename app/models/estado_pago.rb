class EstadoPago < ActiveRecord::Base

    def enabled?
      self.disabled_at.nil?
    end

    # Evita que el sector sea eliminado físicamente de la base.
    def destroy
      self.update_attribute(:disabled_at, Time.now)
    end

end
