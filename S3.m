classdef S3 < handle
    properties
        url char
        access_key char
        secret_key char
%         port {mustBeNumeric}
%         password char = ''
%         db {mustBeNumeric} = 0
%         timeout = 2
%         read_wait = 0.001
    end
    
    properties (Access=private)
        socket = []
        multi_stack = []
        multi_counter = 0
        read_buffer = []
        terminator = sprintf('\r\n')
    end
        
    methods (Access=private, Static)
        hashStr = sha1(str)
        p = params;
    end
    methods (Access=private)  
        send_command(obj, varargin)
        res = socket_read(obj, mode)
        response = read_response(obj)
        resp_str = command_to_resp_str(obj, varargin)
    end
    
    methods
        function obj = S3(url, access_key, secret_key)
            obj.url = url;
            obj.access_key = access_key;
            obj.secret_key = secret_key;
        end
        
        function mb(name)
            
        end        
        
        function ls(obj, url)
        
        end
        
        function signature = auth(obj, string_to_sign)
            import java.security.MessageDigest;
            import javax.crypto.Mac;
            import javax.crypto.spec.SecretKeySpec;
            
            hmac = Mac.getInstance('HmacSHA1');
            key = SecretKeySpec(uint8(obj.secret_key), 'HmacSHA1');
            hmac.init(key);
            signature = strip(matlab.net.base64encode(hmac.doFinal(uint8(string_to_sign))));

%             
%             md = MessageDigest.getInstance('SHA1');
%             md.digest(uint8('testing'))
%             
%                         signature = HMAC(obj.secret_key, string_to_sign, 'SHA-1')));            
% 
%             signature = strip(matlab.net.base64encode(HMAC(obj.secret_key, string_to_sign, 'SHA-1')));            
        end
    end
end
            