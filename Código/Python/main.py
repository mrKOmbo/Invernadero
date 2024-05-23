def main_menu():
    print("Bienvenido al programa de detección de objetos y lectura de sensores:")
    print("1. Detección de colores")
    print("2. Lectura de sensores")
    print("3. Salir")

def run_color_detection():
    import colores
    while True:
        print("\nMenú de Detección de colores:")
        print("1. Iniciar detección")
        print("0. Volver al menú principal")
        choice = input("Ingrese el número de la opción que desea ejecutar: ")
        if choice == "1":
            colores.capture_objects()
        elif choice == "0":
            print("Volviendo al menú principal...")
            break
        else:
            print("Opción no válida. Por favor, ingrese un número válido.")

def run_sensor_readings():
    import dht
    while True:
        print("\nMenú de Lectura de Sensores:")
        print("1. Iniciar lectura")
        print("0. Volver al menú principal")
        choice = input("Ingrese el número de la opción que desea ejecutar: ")
        if choice == "1":
            dht.main()
        elif choice == "0":
            print("Volviendo al menú principal...")
            break
        else:
            print("Opción no válida. Por favor, ingrese un número válido.")

if __name__ == "__main__":
    while True:
        main_menu()
        choice = input("Ingrese el número de la opción que desea ejecutar: ")

        if choice == "1":
            run_color_detection()
        elif choice == "2":
            run_sensor_readings()
        elif choice == "3":
            print("Saliendo del programa...")
            break
        else:
            print("Opción no válida. Por favor, ingrese un número válido.")
