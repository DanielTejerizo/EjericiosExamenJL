/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package misclases;

/**
 *
 * @author DAW
 */
public class Constructor {
    private String pais;
    private int numeroClientes;
    private double mediaLimiteCredito;

    public Constructor(String pais, int numeroClientes, double mediaLimiteCredito) {
        this.pais = pais;
        this.numeroClientes = numeroClientes;
        this.mediaLimiteCredito = mediaLimiteCredito;
    }
    
    

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public int getNumeroClientes() {
        return numeroClientes;
    }

    public void setNumeroClientes(int numeroClientes) {
        this.numeroClientes = numeroClientes;
    }

    public double getMediaLimiteCredito() {
        return mediaLimiteCredito;
    }

    public void setMediaLimiteCredito(double mediaLimiteCredito) {
        this.mediaLimiteCredito = mediaLimiteCredito;
    }
    
    
}
