package ca.fubi.player.models;

import ca.fubi.player.models.enums.EnumRole;
import jakarta.persistence.*;

@Entity
@Table(name = "tb_roles")
public class Role {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Integer id;

  @Enumerated(EnumType.STRING)
  @Column(name = "role_name", length = 20)
  private EnumRole name;

  public Role() {}

  public Role(EnumRole name) {
    this.name = name;
  }

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public EnumRole getName() {
    return name;
  }

  public void setName(EnumRole name) {
    this.name = name;
  }
}