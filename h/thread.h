class Thread {
public:
        Thread (void (*body)(void*), void* arg);
        virtual ~Thread ();
        int start ();
        static void dispatch ();
        static int sleep (time_t);
protected:
        Thread ();
        virtual void run () {}
private:
        thread_t myHandle;
};