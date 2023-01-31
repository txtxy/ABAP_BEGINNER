# Object-Oriented Programming 
(OOP) is a programming paradigm that is based on the concept of objects, which are instances of classes.  
  
OOP in ABAP allows you to create classes and objects, encapsulate data and methods, and create complex applications.   
Here are some of the key concepts of OOP in ABAP:  

## Classes :  

A class is a blueprint that defines the properties and methods of an object.  
Classes are defined using the "CLASS" statement, and they can include data attributes and methods.  

```abap
    CLASS my_class DEFINITION.
      PUBLIC SECTION.
        METHODS: my_method.
        DATA: my_attribute TYPE i.
    ENDCLASS.
```
## Objects:  

An object is an instance of a class.  
You can create an object using the "CREATE OBJECT" statement,  
and you can use the object to access the methods and attributes of the class.  

```abap
    DATA: my_object TYPE REF TO my_class.
    CREATE OBJECT my_object.
```

## Encapsulation:  

Encapsulation is the practice of hiding the implementation details of a class and exposing only the public interface.  
Classes in ABAP can have public and private sections,   
which allow you to control the visibility of the methods and attributes.

```abap
    CLASS my_class DEFINITION.
      PUBLIC SECTION.
        METHODS: my_method.
      PRIVATE SECTION.
        DATA: my_attribute TYPE i.
    ENDCLASS.
```
## Inheritance:  

Inheritance is the ability of a class to inherit the properties and methods of another class.  
ABAP supports single inheritance, where a class can inherit from only one parent class.  

```abap
    CLASS my_child_class DEFINITION INHERITING FROM my_parent_class.
      "Child class definition here
    ENDCLASS.
```

## Polymorphism:  

Polymorphism is the ability of a class to take on multiple forms.  
ABAP supports polymorphism through the use of interfaces and overloading methods.  

```abap
    INTERFACE my_interface.
      METHODS: my_method.
    ENDINTERFACE.
    CLASS my_class IMPLEMENTATION OF my_interface.
      METHOD my_method.
        "Method implementation here
      ENDMETHOD.
    ENDCLASS.
```

## Interfaces:   

An interface defines a set of methods that a class must implement.  
A class can implement multiple interfaces, and an interface can be implemented by multiple classes. 

## Events:   

Events are used to notify other objects of changes in the state of an object.   
ABAP supports events through the use of the **\"RAISING\"** and **\"HANDLING\"** keywords in the class definition

OOP in ABAP allows you to create complex and modular applications, and improve the maintainability and reusability of your code.