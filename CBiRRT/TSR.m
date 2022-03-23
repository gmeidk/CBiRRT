classdef TSR

    properties
        T0_w
        Tw_e
        x_min
        x_max
        y_min
        y_max
        z_min
        z_max
        R_min
        R_max
        P_min
        P_max
        Y_min
        Y_max
    end

    methods

        function obj = TSR(T0_w,Tw_e,Bw)
            obj.T0_w = T0_w;
            obj.Tw_e = Tw_e;
            obj.x_min = Bw(1,1);
            obj.x_max = Bw(1,2);
            obj.y_min = Bw(2,1);
            obj.y_max = Bw(2,2);
            obj.z_min = Bw(3,1);
            obj.z_max = Bw(3,2);
            obj.R_min = Bw(4,1);
            obj.R_max = Bw(4,2);
            obj.P_min = Bw(5,1);
            obj.P_max = Bw(5,2);
            obj.Y_min = Bw(6,1);
            obj.Y_max = Bw(6,2);
        end

        function print(obj)
            disp('TSR:')
            disp('T0_w:')
            disp(obj.T0_w)
            disp('Tw_e:')
            disp(obj.Tw_e)
            Bw = [obj.x_min, obj.x_max
                obj.y_min, obj.y_max
                obj.z_min, obj.z_max
                obj.R_min, obj.R_max
                obj.P_min, obj.P_max
                obj.Y_min, obj.Y_max];
            disp('Bw:')
            disp(Bw);
        end

        function Dw = TSRDistance(obj, T0_s)
            T0_s1 = obj.Tw_e\T0_s;
            Tw_s1 = obj.T0_w\T0_s1;
            D_RPY = tform2eul(Tw_s1);
            D_t = tform2trvec(Tw_s1);
            Dw = [D_t  D_RPY]';
        end

        function delta_x = displacement(obj, T0_s)
            Dw = TSRDistance(obj, T0_s);
            Bw = [obj.x_min, obj.x_max
                  obj.y_min, obj.y_max
                  obj.z_min, obj.z_max
                  obj.R_min, obj.R_max
                  obj.P_min, obj.P_max
                  obj.Y_min, obj.Y_max];
            delta_x = zeros(6,1);
            for i = 1:6
                if Dw(i) < Bw(i,1)
                    delta_x(i) = Dw(i) - Bw(i,1);
                elseif Dw(i) > Bw(i,2)
                    delta_x(i) = Dw(i) - Bw(i,2);
                else
                    delta_x(i) = 0;
                end
            end
            delta_x = [delta_x(4:6);delta_x(1:3)];
        end

    end
end

