class Nave{
  var velocidad
  var direccion
  var combustible

  method cargarCombustible(cuanto){
    combustible += cuanto
  }

  method descargarCombustible(cuanto){
    combustible = 0.max(combustible - cuanto)
  }

  method acelerar(cuanto){
    velocidad = 100000.min(velocidad + cuanto)
  }

  method desacelerar(cuanto){
    velocidad = 0.max(velocidad - cuanto)
  }

  method irHaciaElSol()  {direccion = 10}
  method escaparDelSol() {direccion = -10}
  method ponerseParaleloAlSol() {direccion = 0}

  method acercarseUnPocoAlSol(){
    direccion = 10.min(direccion +1)
  }

  method alejarseUnPocoDelSol(){
    direccion = -10.max(direccion -1)
  }
  method prepararViaje(){// abstracto en superclase
    
    self.cargarCombustible(30000)
    self.acelerar(5000)
    self.condicionAdicional()
  } 
  method condicionAdicional() //abstracto para ver cada caso

  method estaTranquila(){
    return combustible >= 4000 && velocidad <= 12000
  }
  method recibirAmenaza(){
    self.escapar()
    self.avisar()
  }

  method escapar()
  method avisar()
}

class NaveBaliza inherits Nave{
  var baliza = "verde"
  const coloresValidos = #{"verde","rojo","azul"}//para validar que no sea otro color
  method cambiarColorBaliza(colorNuevo){
    if(!coloresValidos.contains(colorNuevo))//para saber si el color que le pasamos esta en el conjunto
    //PODEMOS NEGAR EL IF,"SI NO LO CONTIENE", EJECUTAR EL CODIGO (SIN EL ELSE)
                                        //PONER LA EJECUCION DEL CODIGO FUERA DEL IF (fijarse pdf del profe)
      self.error("el color nuevo no es valido") //para lanzar un error si lo piden
    baliza = colorNuevo
  }
  
  override method condicionAdicional(){
    self.cambiarColorBaliza("verde")
    self.ponerseParaleloAlSol()
  } 

  override method estaTranquila(){ //sobreescribimos el metodo
    return super() && baliza != "rojo"
  }
        
}
class NaveDePasajeros inherits Nave{
  const pasajeros
  var comida
  var bebida
  method cargarComida(cuanto){comida += cuanto}
  method cargarBebida(cuanto){bebida += cuanto}
  
  method descargarComida(cuanto){comida = 0.max(comida)}
  method descargarBebida(cuanto){bebida = 0.max(bebida)}

  override method condicionAdicional(){
    self.cargarComida(4*pasajeros)
    self.cargarBebida(6*pasajeros)
    self.acercarseUnPocoAlSol()
  }
}

class NaveDeCombate inherits Nave{
  var estaInvisible = false
  var misilesDesplegados = false
  const mensajesEmitidos = [] //lista pq tiene orden, se puede repetir
  method ponerseVisible() {estaInvisible = false}
  method ponerseInvisible() {estaInvisible = true}
  method estaInvisible() = estaInvisible
  method desplegarMisiles(){misilesDesplegados=true}
  method replegarMisiles(){misilesDesplegados=false}
  method misilesDesplegados() = misilesDesplegados
  method emitirMensaje(mensaje){
    mensajesEmitidos.add(mensaje)

  }
  method mensajesEmitidos() = mensajesEmitidos //muestra la lista
  method primerMensajeEmitido(){
    if(mensajesEmitidos.isEmpty()) self.error("No")//EN EL IF VA EL ERROR, LO Q NO IENE Q PASAR 
    return mensajesEmitidos.first() // esto esta fuera del if
  }

  method ultimoMensajeEmitido(){
    if(mensajesEmitidos.isEmpty()) self.error("No")//EN EL IF VA EL ERROR, LO Q NO IENE Q PASAR 
    return mensajesEmitidos.last() // esto esta fuera del if
  }
  method emitioMensaje(mensaje) = mensajesEmitidos.contains(mensaje)
  method esEscueta() =mensajesEmitidos.all({m => m.length() < 30}) //o size para el tamaño

  override method condicionAdicional(){
 
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en misión")
  }

  override method estaTranquila(){ //sobreescribimos el metodo
    return super() && !misilesDesplegados
  }
  

}
class NaveHospital inherits NaveDePasajeros{
    var quirofanosPreparados = false
    method quirofanosPreparados()= quirofanosPreparados
    method alternarPrepararQuirofanos() {quirofanosPreparados=!quirofanosPreparados}
    override method estaTranquila(){ //sobreescribimos el metodo
    return super() && !quirofanosPreparados // al no estar en NaveDePasajeros se encuentra en Nave || podemos usar !self.quirofanospreparados()
  }

  }
class NaveSigilosa inherits NaveDeCombate{
  override method estaTranquila(){ //sobreescribimos el metodo
    return super() && !estaInvisible // x herencia podemos acceder al atributo | super es naveDeCOmbate
  }

}