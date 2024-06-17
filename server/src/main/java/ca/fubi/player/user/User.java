package ca.fubi.player.user;

import java.util.Set;
import java.util.HashSet;

import ca.fubi.player.playlist.Playlist;
import ca.fubi.player.role.Role;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinTable;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "tb_users",
       uniqueConstraints = {
           @UniqueConstraint(columnNames = "username"),
           @UniqueConstraint(columnNames = "email")
       })
public class User {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id_user")
  private Long id;

  @NotBlank
  @Size(max = 64)
  @Column(name = "username")
  private String username;

  @NotBlank
  @Size(max = 64)
  @Email
  @Column(name = "email")
  private String email;

  @NotBlank
  @Size(max = 128)
  @Column(name = "password")
  private String password;

  @ManyToMany(fetch = FetchType.EAGER)
  @JoinTable(name = "tb_user_roles", 
             joinColumns = @JoinColumn(name = "fk_user"),
             inverseJoinColumns = @JoinColumn(name = "fk_role"))
  private Set<Role> roles = new HashSet<>();
  
  @OneToMany(fetch = FetchType.EAGER)
  @JoinTable(name = "tb_user_playlists",
  			 joinColumns = @JoinColumn(name = "fk_user"),
  			 inverseJoinColumns = @JoinColumn(name = "fk_playlist"))
  private Set<Playlist> playlists = new HashSet<>();

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public Set<Role> getRoles() {
    return roles;
  }

  public void setRoles(Set<Role> roles) {
    this.roles = roles;
  }

  public Set<Playlist> getPlaylists() {
	  return playlists;
  }
  
  public void setPlaylists(Set<Playlist> playlists) {
	this.playlists = playlists;
  }
}
