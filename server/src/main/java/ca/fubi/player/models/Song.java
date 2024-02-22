package ca.fubi.player.models;

import java.util.ArrayList;
import java.util.List;

import ca.fubi.player.models.relations.PlaylistSong;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "tb_songs")
public class Song {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_song")
	private Long id;
	
	@NotBlank
	@Size(max = 512)
	@Column(name = "song_title")
	private String title;
	
	@NotBlank
	@Column(name = "song_length")
	private int length;
	
	@ManyToOne
	@JoinColumn(name = "fk_album")
	private Album album;

    @OneToMany(mappedBy = "song")
    private List<PlaylistSong> playlists = new ArrayList<>();
	
	public Song() {}
	
	public Song(String title, int length, Album album) {
		this.setTitle(title);
		this.setLength(length);
		this.setAlbum(album);
	}
	
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
	
	public int getLength() {
		return length;
	}
	
	public void setLength(int length) {
		this.length = length;
	}
	
	public Album getAlbum() {
		return album;
	}
	
	public void setAlbum(Album album) {
		this.album = album;
	}
}
