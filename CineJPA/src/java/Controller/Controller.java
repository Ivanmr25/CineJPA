/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;


import Entities.Movie;
import Entities.Person;
import Entities.Rating;
import Entities.Usuario;
import java.io.IOException;
import java.sql.Connection;
import javax.persistence.EntityManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;
import Util.JPAUtil;
import java.util.List;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        /*
		 * Crear el singleton con
         */
    
        List<Movie> movies;
        EntityTransaction t;
        List<Person>persons;
        Usuario usuario;
        EntityManager em = (EntityManager) session.getAttribute("em");
        if (em == null) {
            em = JPAUtil.getEntityManagerFactory().createEntityManager();
            session.setAttribute("em", em);
        }
        Query q;
        String op = request.getParameter("op");
      
        if (op.equals("inicio")) {
    q = em.createNamedQuery("Person.findAll");
    persons = q.getResultList();
    session.setAttribute("personas", persons);
   
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } else if (op.equals("vamovie")) {
          q = em.createNamedQuery("Movie.findAll");
           movies = q.getResultList();
        
          
            session.setAttribute("movies", movies);
                  session.removeAttribute("personas");
             request.getRequestDispatcher("home.jsp").forward(request, response);
        }
         else if (op.equals("vaperson")) {
              q = em.createNamedQuery("Person.findAll");
           persons = q.getResultList();
          session.setAttribute("personas", persons);
         
           session.removeAttribute("movies");
       
             request.getRequestDispatcher("home.jsp").forward(request, response);
         
            
        }
         
          else if (op.equals("login")) {
           
             String dni = request.getParameter("dni");
            String nombre = request.getParameter("nombre");
            usuario = em.find(Usuario.class, dni);
            if (usuario == null) {
                usuario = new Usuario(dni);
                usuario.setNombre(nombre);
                t = em.getTransaction();
                   t.begin();
                   em.persist(usuario);
                   t.commit();
                   
            }
            session.setAttribute("msg", "Login o Registro satisfactorio");
            session.setAttribute("user", usuario);
            request.getRequestDispatcher("home.jsp").forward(request, response);
          }
        else if(op.equals("logout")){
                session.removeAttribute("user");
                if (session == null) {
                 session = request.getSession(true);
            }
                session.setAttribute("msg", "Logout satisfactorio");
                
                request.getRequestDispatcher("home.jsp").forward(request, response);
            } 
         
          
            else if (op.equals("resumen")) {
            String persona = request.getParameter("person");
             q = em.createQuery("SELECT m FROM Movie m JOIN m.personList p WHERE p.id ="+persona+"");
            List<Movie> resumen = q.getResultList();
            session.setAttribute("resumen", resumen);
            request.getRequestDispatcher("peliculas.jsp").forward(request, response);
        }else if(op.equals("puntuar")){
             String partido = request.getParameter("pt");
            String goleslocal = request.getParameter("persona");
           
            usuario = (Usuario) session.getAttribute("user");
            Person persona = new Person(Integer.parseInt(goleslocal));
            Rating rating = new Rating();
            rating.setDni(usuario);
            rating.setPuntos(Short.parseShort(partido));
            rating.setIdperson(persona );
            
            t = em.getTransaction();
            t.begin();
            em.persist(rating);
            t.commit();
            session.setAttribute("msg", "Registrada calificacion ...");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }
    
    /* SELECT m.titulo,m.fecha,m.poster FROM Movie m
JOIN m.personList p
WHERE p.id = 31
 */           
          
            
        
    

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}

