
import com.github.twitch4j.TwitchClient;
import com.github.twitch4j.TwitchClientBuilder;
import com.github.philippheuer.credentialmanager.domain.OAuth2Credential;
import com.github.twitch4j.chat.events.channel.ChannelMessageEvent;

import java.util.Random;

public class TwitchBot {

    public static void main(String[] args) {

        String token = System.getenv("TWITCH_TOKEN");
        String channel = System.getenv("TWITCH_CHANNEL");

        if(token == null || channel == null){
            System.out.println("Missing environment variables.");
            return;
        }

        OAuth2Credential credential = new OAuth2Credential("twitch", token);

        TwitchClient client = TwitchClientBuilder.builder()
                .withEnableChat(true)
                .withChatAccount(credential)
                .build();

        client.getChat().joinChannel(channel);

        System.out.println("Bot connected to channel: " + channel);

        Random random = new Random();

        client.getEventManager().onEvent(ChannelMessageEvent.class, event -> {

            String message = event.getMessage();
            String user = event.getUser().getName();

            // ===== Команда !hello =====
            if(message.equalsIgnoreCase("!hello")){
                client.getChat().sendMessage(channel,
                        "Hello " + user + " 👋");
            }

            // ===== Команда !roll =====
            if(message.equalsIgnoreCase("!roll")){
                int number = random.nextInt(100) + 1;
                client.getChat().sendMessage(channel,
                        user + " rolled " + number + " 🎲");
            }

            // ===== Команда !coin =====
            if(message.equalsIgnoreCase("!coin")){
                String result = random.nextBoolean() ? "Heads" : "Tails";
                client.getChat().sendMessage(channel,
                        "Coin result: " + result + " 🪙");
            }

            // ===== Команда !fight =====
            if(message.startsWith("!fight")){
                String[] parts = message.split(" ");
                if(parts.length > 1){
                    String enemy = parts[1];
                    boolean win = random.nextBoolean();
                    String winner = win ? user : enemy;
                    client.getChat().sendMessage(channel,
                            "⚔️ Winner: " + winner);
                }else{
                    client.getChat().sendMessage(channel,
                            "Usage: !fight @user");
                }
            }

        });

    }
}
