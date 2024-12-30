public class FutureClass {

    public FutureClass(){
        takeShower();
        haveBreakfast();
        carServicing();
        movieWithFriends();
    }
    public static void takeShower(){
        System.debug('I am taking shower');
    }
    public static void haveBreakfast(){
        System.debug('I am having BF');
    }
    @future
    public static void carServicing(){
        System.debug('Car is being repaired');
    } 
    public static void movieWithFriends(){
        System.debug('Watching Movie with Friends');
    }
}