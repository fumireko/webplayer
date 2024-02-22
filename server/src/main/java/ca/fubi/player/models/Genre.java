package ca.fubi.player.models;

import jakarta.persistence.*;

@Entity
@Table(name = "tb_genres")
public class Genre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_genre")
    private Long id;

    @Column(name = "description", unique = true)
    private String description;
    
    public Genre() {}
    
    public Genre(String description) {
    	this.setDescription(description);
    }

    public Long getId() {
		return id;
	}
    
    public void setId(Long id) {
		this.id = id;
	}
    
    public String getDescription() {
		return description;
	}
    
    public void setDescription(String description) {
		this.description = description;
	}
}

