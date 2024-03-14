package ca.fubi.player.models;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "tb_albums")
public class Album {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_album")
    private Long id;

    @NotBlank
    @Size(max = 512)
    @Column(name = "album_title")
    private String title;

    @Column(name = "album_image_url")
    private String imageUrl;

    @JsonFormat(pattern = "yyyy-MM-dd")
    @Column(name = "release_date")
    private Date releaseDate;

    @ManyToMany
    @JsonIgnoreProperties("albums")
    @JoinTable(
        name = "tb_albums_artists",
        joinColumns = @JoinColumn(name = "fk_album"),
        inverseJoinColumns = @JoinColumn(name = "fk_artist")
    )
    private Set<Artist> artists = new HashSet<>();
    
    @OneToMany
    @JoinTable(
        name = "tb_songs_album",
        joinColumns = @JoinColumn(name = "fk_song"),
        inverseJoinColumns = @JoinColumn(name = "fk_album")
    )
    private Set<Song> songs = new HashSet<>();

    public Album() {}
    
    public Album(Set<Artist> artists, String title, Date releaseDate, String imageUrl) {
    	this.setArtists(artists);
    	this.setTitle(title);
    	this.setReleaseDate(releaseDate);
    	this.setImageUrl(imageUrl);
    }

    // Getters and setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public Set<Artist> getArtists() {
		return artists;
	}
    
    public void setArtists(Set<Artist> artists) {
		this.artists = artists;
	}
    
    public Set<Song> getSongs() {
		return songs;
	}
    
    public void setSongs(Set<Song> songs) {
		this.songs = songs;
	}
}
