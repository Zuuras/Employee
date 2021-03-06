package org.danit.energym3.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "post")
public class Post {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private  Long id;

  @Column(name = "name")
  private String name;

  @Column(name = "percent")
  private String percent;

  @Column(name = "description")
  private String description;

}
