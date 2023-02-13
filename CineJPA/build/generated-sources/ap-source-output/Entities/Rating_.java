package Entities;

import Entities.Person;
import Entities.Usuario;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-02-10T12:14:07")
@StaticMetamodel(Rating.class)
public class Rating_ { 

    public static volatile SingularAttribute<Rating, Short> idrating;
    public static volatile SingularAttribute<Rating, Short> puntos;
    public static volatile SingularAttribute<Rating, Person> idperson;
    public static volatile SingularAttribute<Rating, Usuario> dni;

}