import java.util.ArrayList;

public class HW1_Q1 {
    public static void main(String[] args){
        AnimalShelter _AnimalShelter = new AnimalShelter();
        for (String str : args) {
            String[] inputs = str.split(" ");
            if(inputs[0].equals("d"))
            {
                _AnimalShelter.addAnimal(new Dog(inputs[1]));
            }
            else if(inputs[0].equals("c"))
            {
                _AnimalShelter.addAnimal(new Cat(inputs[1]));
            }
        }
        _AnimalShelter.remainingAnimals();
        _AnimalShelter.adopt();
        _AnimalShelter.remainingAnimals();
        _AnimalShelter.adoptDog();
        _AnimalShelter.remainingAnimals();
        _AnimalShelter.adoptCat();
        _AnimalShelter.remainingAnimals();
        _AnimalShelter.remainingDogs();
        _AnimalShelter.remainingCats();
        System.out.println();
    }
}

abstract class Animal { 

    private String name;

    public int order;

    private String cry;
    
    public Animal()
    {

    }

    public Animal(String _name){
        name = _name;
    }

    public Animal(String _name, int _order, String _cry)
    {
        name = _name;
        order = _order;
        cry = _cry;
    }

    public String getName()
    {
        return name;
    }
    
    public int getOrder()
    {
        return order;
    }

    public String cry()
    {
        return cry;
    }

}

class Cat extends Animal {

    public Cat()
    {
        super();
    }

    public Cat(String _name)
    {
        super(_name, 0, "meow");
    }

    public Cat(String _name, int _order)
    {
        super(_name, _order, "meow");
    }

}

class Dog extends Animal {

    public Dog()
    {
        super();
    }

    public Dog(String _name)
    {
        super(_name, 0 ,"bark");
    }

    public Dog(String _name, int _order)
    {
        super(_name, _order, "bark");
    }

}

class AnimalShelter {

    ArrayList<Animal> Shelter = new ArrayList<Animal>();
    int serial = 0;

    public int addAnimal(Animal animalia)
    {
        animalia.order = serial++;
        Shelter.add(animalia);
        return serial;
    }
    public void adopt()
    {
        Shelter.remove(0);
        serial--;
        for (int len = 0; len < serial; len++) {
            (Shelter.get(len)).order = (Shelter.get(len)).order-1;
        }
    }
    public void adoptCat()
    {
        for (int len = 0; len < serial; len++) {
            if ((Shelter.get(len)).cry() == "meow") {
                Shelter.remove(len);
                serial--;
                for (int len2 = len; len2 < serial; len2++) {
                    (Shelter.get(len2)).order = (Shelter.get(len2)).order-1;
                }
                break;
            }
        }
    }
    public void adoptDog()
    {
        for (int len = 0; len < serial; len++) {
            if ((Shelter.get(len)).cry() == "bark") {
                Shelter.remove(len);
                serial--;
                for (int len2 = len; len2 < serial; len2++) {
                    (Shelter.get(len2)).order = (Shelter.get(len2)).order-1;
                }
                break;
            }
        }
    }
    public void remainingAnimals()
    {
        System.out.println();
        for (int len = 0; len < serial; len++) {
            System.out.println((Shelter.get(len)).getName() + " " + (Shelter.get(len)).getOrder() + " " + (Shelter.get(len)).cry());
        }
    }
    public void remainingCats()
    {
        System.out.println();
        for (int len = 0; len < serial; len++) {
            if ((Shelter.get(len)).cry() == "meow") {
                System.out.println((Shelter.get(len)).getName() + " " + (Shelter.get(len)).getOrder() + " " + (Shelter.get(len)).cry());
            }
        }
    }
    public void remainingDogs()
    {
        System.out.println();
        for (int len = 0; len < serial; len++) {
            if ((Shelter.get(len)).cry() == "bark") {
                System.out.println((Shelter.get(len)).getName() + " " + (Shelter.get(len)).getOrder() + " " + (Shelter.get(len)).cry());
            }
        }
    }

}