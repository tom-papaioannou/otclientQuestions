// A4

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    bool createdNewPlayer = false;

    // Check if the player is already loaded in the game
    if (!player) {
        player = new Player(nullptr);  // Create a new Player if not found
        createdNewPlayer = true;       // Remember that we created a new Player

        // Try to load the player data; if failed, clean up and return
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player;             // Delete the player to prevent memory leak
            return;
        }
    }

    // Create the item
    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (createdNewPlayer) {
            delete player;             // Clean up the newly created player if item creation failed to prevent memory leak
        }
        return;
    }

    // Add the item to the player's inbox
    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    // Handle saving the player if they are offline
    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
        if (createdNewPlayer) {
            delete player;             // Clean up the new player after saving to prevent memory leak
        }
    } else if (createdNewPlayer) {
        delete player;                 // Clean up the new player if not offline to prevent memory leak
    }
}
