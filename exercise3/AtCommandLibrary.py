import serial

class AtCommandLibrary(object):
    ''' Library for interacting with a simple device using AT commands
    '''
    #ROBOT_LIBRARY_SCOPE = 'SUITE'
    
    def __init__(self, comp_port):
        # self._port = serial.Serial('/dev/tty.usbmodem144201', 115200, timeout = 1)
        self._port = serial.Serial(comp_port, 115200, timeout = 1)

    def send_text(self, text):
        self._port.reset_input_buffer()
        self._port.write(bytes('AT+SEND="' + text + '"\n', 'iso-8859-1'))

    def send_at_command(self):
        self._port.reset_input_buffer()
        self._port.write(bytes('AT\n', 'iso-8859-1'))

    def send_ate0_command(self):
        self._port.reset_input_buffer()
        self._port.write(bytes('ATE0\n', 'iso-8859-1'))
        
    def send_ate1_command(self):
        self._port.reset_input_buffer()
        self._port.write(bytes('ATE1\n', 'iso-8859-1'))
        
    def response_should_be(self, expected_text):
        text = self._port.readline().strip().decode('iso-8859-1')
        if text != expected_text:
            raise AssertionError('Expected: ' + expected_text + ' got: ' + text)
        
        