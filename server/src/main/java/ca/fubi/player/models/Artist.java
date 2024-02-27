package ca.fubi.player.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.util.*;

import ca.fubi.player.models.enums.EnumCountry;
import ca.fubi.player.models.relations.AlbumArtist;

@Entity
@Table(name = "tb_artists")
public class Artist {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_artist")
    private Long id;

    @NotBlank
    @Size(max = 512)
    @Column(name = "artist_name", unique = true)
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "country_code", columnDefinition = "CHAR(4)")
    private EnumCountry countryCode;

    @OneToMany(mappedBy = "artist")
    private List<AlbumArtist> albums = new ArrayList<>();

    @ManyToMany
    @JoinTable(
        name = "tb_artists_genre",
        joinColumns = @JoinColumn(name = "fk_artist"),
        inverseJoinColumns = @JoinColumn(name = "fk_genre")
    )
    private Set<Genre> genres = new HashSet<>();

    public Artist() {}
    
    public Artist(String name, EnumCountry countryCode, List<AlbumArtist> albums, Set<Genre> genres) {
    	this.setName(name);
    	this.setCountryCode(countryCode);
    	this.setAlbums(albums);
    	this.setGenres(genres);
    }
    
    @Override
    public String toString() {
        return "Artist{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", countryCode=" + countryCode +
                ", albums=" + albums +
                ", genres=" + genres +
                '}';
    }
    
    public Long getId() {
		return id;
	}
    
    public void setId(Long id) {
		this.id = id;
	}
    
    public String getName() {
		return name;
	}
    
    public void setName(String name) {
		this.name = name;
	}
    
    public String getDescription() {
		return description;
	}
    
    public void setDescription(String description) {
		this.description = description;
	}
    
    public EnumCountry getCountryCode() {
		return countryCode;
	}
    
    public void setCountryCode(EnumCountry countryCode) {
		this.countryCode = countryCode;
	}
    
    public List<AlbumArtist> getAlbums() { 
		return albums;
	}
    
    public void addAlbum(Album album) {
        AlbumArtist albumArtist = new AlbumArtist(album, this);
        this.albums.add(albumArtist);
    }
    
    public void setAlbums(List<AlbumArtist> albums) {
		this.albums = albums;
	}
    
    public Set<Genre> getGenres() {
		return genres;
	}
    
    public void addGenre(Genre genre) {
        this.genres.add(genre);
    }
    
    public void setGenres (Set<Genre> genres) {
		this.genres = genres;
	}
}
