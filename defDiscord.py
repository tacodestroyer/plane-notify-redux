def sendDis(message, config, role_id=None, thread_id=None, *file_names):
    import requests
    from discord_webhook import DiscordWebhook

    # Add role mention if needed
    if role_id is not None:
        message += f" <@&{role_id}>"

    # Get Webhook URL from the config
    webhook_url = config.get('DISCORD', 'URL')

    # Get the Thread ID from the config, if it exists
    thread_id = config.get('DISCORD', 'THREAD_ID', fallback=None)

    # Modify the webhook URL to include the thread_id if provided
    if thread_id:
        webhook_url += f"?thread_id={thread_id}"

    # Create webhook request
    webhook = DiscordWebhook(url=webhook_url, content=message[0:1999], username=config.get('DISCORD', 'USERNAME'))

    # Attach files if provided
    if file_names:
        for file_name in file_names:
            with open(file_name, "rb") as f:
                webhook.add_file(file=f.read(), filename=file_name)

    # Send the webhook request
    try:
        response = webhook.execute()
        if response.status_code != 204:  # Check if the request was successful
            print(f"❌ Discord Error: {response.status_code} - {response.text}")
    except requests.exceptions.RequestException as e:
        print(f"❌ Failed to send Discord message: {e}")

# def sendDis(message, config, role_id = None, *file_names):
#     import requests
#     from discord_webhook import DiscordWebhook
#     if role_id != None:
#         message += f" <@&{role_id}>"
#     webhook = DiscordWebhook(url=config.get('DISCORD', 'URL'), content=message[0:1999], username=config.get('DISCORD', 'USERNAME'))
    
#     if file_names != []:
#         for file_name in file_names:
#             with open(file_name, "rb") as f:
#                 webhook.add_file(file=f.read(), filename=file_name)
#     try:
#         webhook.execute()
#     except requests.exceptions.RequestException:
#         pass

