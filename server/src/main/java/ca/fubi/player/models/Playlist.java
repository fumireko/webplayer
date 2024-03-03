package ca.fubi.player.models;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "tb_playlists")
public class Playlist {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_playlist")
    private Long id;

    @NotBlank
    @Size(max = 100)
    @Column(name = "playlist_name")
    private String name;

    @ManyToOne
    @JoinColumn(name = "fk_user")
    private User user;

    @ManyToMany
    @JoinTable(
        name = "tb_songs_playlist",
        joinColumns = @JoinColumn(name = "fk_playlist"),
        inverseJoinColumns = @JoinColumn(name = "fk_song")
    )
    private List<Song> songs = new ArrayList<>();

    public Playlist() {}
    
    public Playlist(String name, User user) {
    	this.setName(name);
    	this.setUser(user);
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
    
    public User getUser() {
		return user;
	}
    
    public void setUser(User user) {
		this.user = user;
	}
    
    public List<Song> getSongs() {
        return songs;
    }
    
    public void setSongs(List<Song> songs) {
		this.songs = songs;
	}
}
