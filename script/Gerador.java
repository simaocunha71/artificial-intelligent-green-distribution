//package script;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Random;

/**
 * Classe que representa um jogador, que possui um número de camisola, um nome,
 * uma posição, um historial dos clubes por onde passou e atributos
 */
public class Gerador{

    /*
estafeta(
    nome,
    identificacao,
    freguesia,
    meio_transporte,
    soma_classificacoes/classificacoes_totais, 
    lista das entregas,
    penalizacao.
)
*/

    private static final String[] nomes = { "simao", "tiago", "joao", "nuno", "luis", "geremias", "paulo", "goncalo",
            "pedro", "nelson", "fabio", "gil", "antonio", "miguel", "rogerio", "guilherme", "jose", "chico", "rafael",
            "eduardo", "jonas", "rodrigo", "rui", "diogo", "tomas", "tobias", "raul", "jorge", "hugo", "andre", "runlo",
            "ricardo", "eder", "helder", "cristiano", "armindo", "zeferino", "bernardo", "bruno", "xavier", "joaquim",
            "claudio", "patricio", "gustavo", "ruben", "francisco", "oscar", "alexandre", "amilcar", "jo", "sa",
            "silva", "barbosa", "geremias", "barroso", "cunha", "carvalho", "sousa", "carneiro", "braz", "alvim",
            "saraiva", "dias", "fernandes", "rocha", "cardozo", "rodrigues", "ribeiro", "dinis", "tina", "guimaraes",
            "alves", "pereira", "freitas", "queiros", "costa", "pato", "daniel", "oliveira", "santos", "cerqueira",
            "correia", "palmeira", "faria", "fagundes", "ramos", "cruz", "ronaldo", "meireles", "coelho", "afonso",
            "marchel", "jo", "jacinto", "manafa", "conceicao", "leite", "martins", "leal", "amorim"

    };// 50

    private static final String[] nomesContribuinte = { "simao,1", "tiago,2", "joao,3", "nuno,4", "luis,5", "geremias,6", "paulo,7", "goncalo,8",
    "pedro,9", "nelson,10", "fabio,11", "gil,12", "antonio,13", "miguel,14", "rogerio,15", "guilherme,16", "jose,17", "chico,18", "rafael,19",
    "eduardo,20", "jonas,21", "rodrigo,22", "rui,23", "diogo,24", "tomas,25", "tobias,26", "raul,27", "jorge,28", "hugo,29", "andre,30", "runlo,31",
    "ricardo,32", "eder,33", "helder,34", "cristiano,35", "armindo,36", "zeferino,37", "bernardo,38", "bruno,39", "xavier,40", "joaquim,41",
    "claudio,42", "patricio,43", "gustavo,44", "ruben,45", "francisco,46", "oscar,47", "alexandre,48", "amilcar,49", "jo,50"

};// 50

    // Array de strings com apelidos possíveis de ser escolhidos aleatoriamente
    private static final String[] freguesias = {"ferreiros","adaufe","nogueira","lomar","sequeira","real","tadim","ruilhe",
            "figueiredo","tebosa","lamas","priscos","fradelos","cabreiros","semelhe","dume","pedralva","palmeira"

};// 50
    private static final String[] meios_t = {"moto","bicicleta","carro"};// 50
    private static HashSet<Integer> ids = new HashSet<>();


    public static int classficacao (int totalCl){
        Random rand = new Random();
        int r = 0;
        for (int i = 0; i < totalCl; i++){
            r+=rand.nextInt(6);
        }
        return r;
    }

    public static int ids_r(){
        Boolean valid = true;
        Random r = new Random();
        int id = 0;
        while (valid) {
            id = r.nextInt(1000000);
            if (ids.contains(id)) {
                valid = false;
            } else
                ids.add(id);
        }
        return id;
    }

    public static int peso (String mt){
        Random rand = new Random();
        if (mt.equals("moto"))
            return rand.nextInt(20)+1;
        if(mt.equals("bicicleta"))
            return rand.nextInt(5)+1;
        return rand.nextInt(100)+1;
    }

    public static String pedidos (String freg, String mt){
        Random r = new Random();
        String cliente = nomesContribuinte[r.nextInt(nomesContribuinte.length)];
        int id = ids_r();
        int mes = r.nextInt(12)+1;
        int dia = r.nextInt(31)+1;
        if (mes==2 && dia>28){
            dia = dia - 3;            
        } else {
            if(mes <8){
               if((mes%2==0) && dia==31 ){
                dia = dia -1;
                } 
            }else{
                if((mes%2!=0) && dia==31 ){
                    dia = dia -1;
                    }
            }
            
        }
        LocalDate dateLimite = LocalDate.of(2021, mes, dia);
        int dia2 = 32;
        while(dia2 > dia){
            dia2 = r.nextInt(31)+1;
        }
        LocalDate dataPedido = LocalDate.of(2021, mes, dia2);
        String rua = "Rua " + r.nextInt(20); 
        int p = peso(mt);
        int estado = r.nextInt(2);
        StringBuilder sb = new StringBuilder();
        sb.append("pedido(").append("cliente(").append(cliente).append("),")
                            .append(id).append(",")
                            .append(dateLimite.getYear()).append("/").append(dateLimite.getMonthValue()).append("/").append(dateLimite.getDayOfMonth()).append(",")
                            .append("\"").append(rua).append("\"").append(",")
                            .append("\"").append(freg).append("\"").append(",")
                            .append(p).append(",")
                            .append(dataPedido.getYear()).append("/").append(dataPedido.getMonthValue()).append("/").append(dataPedido.getDayOfMonth()).append(",")
                            .append(estado).append(")");
        return sb.toString();
    }

    public static String meioTransporte (String tipo){
        int matricula = ids_r();
        int peso = 0, velocidade = 0;
        if (tipo.equals("moto")){
            peso = 20;
            velocidade = 35;
        }
        if (tipo.equals("bicicleta")) {
            peso = 5;
            velocidade = 10;
        }
        if (tipo.equals("carro")) {
            peso = 100;
            velocidade = 25;
        }
        return "meio_transporte(" +matricula+","+tipo+","+velocidade+","+peso+")";
    }

    public static String randomEstafeta() {
        Random r = new Random();
        int n1 = r.nextInt(nomes.length);
        int n2 = r.nextInt(freguesias.length);
        int n3 = r.nextInt(meios_t.length);
        
        String nome = nomes[n1];
        String freguesia = freguesias[n2];
        String meioT = meios_t[n3];

        int id = ids_r();

        int totalCl = r.nextInt(201);
        int clf = classficacao(totalCl);

        String mt2 = meioTransporte(meioT);
        int p = r.nextInt(20);
        String[] pedidos = new String[p];
        for(int i = 0; i < p;i++){
            pedidos[i] = pedidos(freguesia, meioT);
        }
        int penalizacao = r.nextInt(2);
        StringBuilder sb = new StringBuilder();
        sb.append("estafeta(").append("\"").append(nome).append("\"").append(",")
                            .append(id).append(",")
                            .append("\"").append(freguesia).append("\"").append(",")
                            .append(mt2).append(",")
                            .append(clf).append("/").append(totalCl).append(",")
                            .append("[");
        for(int i = 0; i< pedidos.length;i++){
            sb.append(pedidos[i]);
            if(i!=pedidos.length-1){
                sb.append(",");
            }
        }
        sb.append("]").append(",")
          .append(penalizacao).append(").");

        return sb.toString();
    }

    public static void main(String[] args)
{
	int x = 5;
    String estafeta = null;
    for(int i = 0; i<x; i++){
        estafeta = randomEstafeta();
        System.out.println("---------------------");
        System.out.println(estafeta);
        System.out.println("---------------------");
    }
}

}