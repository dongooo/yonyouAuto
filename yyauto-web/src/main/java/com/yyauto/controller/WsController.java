package com.yyauto.controller;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Logger;

/**
 * description: websocket双工通信
 * author: dongooo
 * create: 2016-07-22 下午5:19
 * php: https://github.com/dongooo
 **/

@ServerEndpoint("/linking")
public class WsController {

    private static final Logger LOG = Logger.getLogger(WsController.class.getName());
    private static Set<Session> peers = Collections.synchronizedSet(new HashSet<Session>());

    @OnMessage
    public String onMessage(String message){
        if(message != null){
            return "{\"hello\":\"Hello if need the list just press the button....\"}";
        }else {
            return "[{\"name\": \"Nadal, Rafael (ESP)\", \"email\": \"nadalrafael@gmail.com\", \"rank\": \"1\"},"
                    + "{\"name\": \"Djokovic, Novak (SRB)\", \"email\": \"djokovicnovak@gmail.com\", \"rank\": \"2\"},"
                    + "{\"name\": \"Federer, Roger (SUI)\", \"email\": \"federerroger@gmail.com\", \"rank\": \"3\"},"
                    + "{\"name\": \"Wawrinka, Stan (SUI)\", \"email\": \"wawrinkastan@gmail.com\", \"rank\": \"4\"},"
                    + "{\"name\": \"Ferrer, David (ESP)\", \"email\": \"ferrerdavid@gmail.com\", \"rank\": \"5\"}]";
        }
    }

    @OnOpen
    public void onOpen(Session peer){
        LOG.info("Connection opened ...");
        peers.add(peer);
    }

    @OnClose
    public void onClose(Session peer){
        LOG.info("Connection closed ...");
        peers.remove(peer);
    }


}
