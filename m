Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B99029D4BB
	for <lists+linux-can@lfdr.de>; Wed, 28 Oct 2020 22:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgJ1VyO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Oct 2020 17:54:14 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:19640 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgJ1VyN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Oct 2020 17:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603922050;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=PGs6iCcKUiQcyPOLS/63ygioHtBECU8ZErkYhSM6EOI=;
        b=ZSIKzlF+oO3lygXLi1b18ou3V8KB1MJJGJ3ZwYhfJ7U6peh8c9LPcsomBBe30LlSpF
        lIdRzDYATXAGFlIvSAxbpRgy6lc07LU31G8G46JMDH9kfJb1DCicVwyVEKWmEMnkCgc8
        6pHgaMhxYueyJZ6OKTxHcNBrBjBzIxkA9XxeepI3ZoZHB7EMLoDi60bmqK4jX9utPJaA
        DjtDnt6a/tgj+aVoqXu3FNe2UXdHvJwaPh2wxvWi0Wue8OGnW8B6JL1I0IwJFAP+uENv
        INonDcVEUHgfxV3YxVpzlsb79UFc954yz3g7rQbn835cV5EF9IfJgRzucSp1JrDejKH+
        CYgQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR/J8xuy10="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.2.3 DYNA|AUTH)
        with ESMTPSA id J01b14w9SBs50dV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 28 Oct 2020 12:54:05 +0100 (CET)
Subject: Re: [PATCH 4/4] can: rename can_dlc with len for all struct can_frame
 users
To:     Marc Kleine-Budde <mkl@pengutronix.de>, mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org
References: <20201028110033.113702-1-socketcan@hartkopp.net>
 <20201028110033.113702-5-socketcan@hartkopp.net>
 <febc25d0-e715-1494-c972-0939ac46d481@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <63426205-95d1-6c2e-5551-746fd009fc86@hartkopp.net>
Date:   Wed, 28 Oct 2020 12:54:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <febc25d0-e715-1494-c972-0939ac46d481@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 28.10.20 12:20, Marc Kleine-Budde wrote:
> On 10/28/20 12:00 PM, Oliver Hartkopp wrote:
>> Cleanup the can_dlc usage by renaming it with len from can_frame.len
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> [...]
> 
>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>> index 6dee4f8f2024..537dd4636c90 100644
>> --- a/drivers/net/can/dev.c
>> +++ b/drivers/net/can/dev.c
>> @@ -28,14 +28,14 @@ MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
>>   /* CAN DLC to real data length conversion helpers */
>>   
>>   static const u8 dlc2len[] = {0, 1, 2, 3, 4, 5, 6, 7,
>>   			     8, 12, 16, 20, 24, 32, 48, 64};
>>   
>> -/* get data length from can_dlc with sanitized can_dlc */
>> -u8 can_dlc2len(u8 can_dlc)
>> +/* get data length from dlc with sanitized len */
>> +u8 can_dlc2len(u8 dlc)
>>   {
>> -	return dlc2len[can_dlc & 0x0F];
>> +	return dlc2len[dlc & 0x0F];
>>   }
>>   EXPORT_SYMBOL_GPL(can_dlc2len);
> 
> unrelated change.

Probably the commit message has to be altered.
The plan is to remove can_dlc as it was misnamed/misused.

In this specific case we provide a real (raw) dlc and not the can_dlc 
which was a length value.

> 
> [...]
> 
> 
>> diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
>> index cc01db0c18b8..c25cb53eba4e 100644
>> --- a/drivers/net/can/peak_canfd/peak_canfd.c
>> +++ b/drivers/net/can/peak_canfd/peak_canfd.c
> 
> [...]
> 
>> @@ -650,11 +650,11 @@ static netdev_tx_t peak_canfd_start_xmit(struct sk_buff *skb,
>>   	struct pucan_tx_msg *msg;
>>   	u16 msg_size, msg_flags;
>>   	unsigned long flags;
>>   	bool should_stop_tx_queue;
>>   	int room_left;
>> -	u8 can_dlc;
>> +	u8 len;
> 
> unrelated change

Same here. can_dlc was just wrong in all cases.

>>   
>>   	if (can_dropped_invalid_skb(ndev, skb))
>>   		return NETDEV_TX_OK;
>>   
>>   	msg_size = ALIGN(sizeof(*msg) + cf->len, 4);
>> @@ -680,22 +680,22 @@ static netdev_tx_t peak_canfd_start_xmit(struct sk_buff *skb,
>>   		msg->can_id = cpu_to_le32(cf->can_id & CAN_SFF_MASK);
>>   	}
>>   
>>   	if (can_is_canfd_skb(skb)) {
>>   		/* CAN FD frame format */
>> -		can_dlc = can_len2dlc(cf->len);
>> +		len = can_len2dlc(cf->len);
>>   
>>   		msg_flags |= PUCAN_MSG_EXT_DATA_LEN;
>>   
>>   		if (cf->flags & CANFD_BRS)
>>   			msg_flags |= PUCAN_MSG_BITRATE_SWITCH;
>>   
>>   		if (cf->flags & CANFD_ESI)
>>   			msg_flags |= PUCAN_MSG_ERROR_STATE_IND;
>>   	} else {
>>   		/* CAN 2.0 frame format */
>> -		can_dlc = cf->len;
>> +		len = cf->len;
>>   
>>   		if (cf->can_id & CAN_RTR_FLAG)
>>   			msg_flags |= PUCAN_MSG_RTR;
>>   	}
>>   
>> @@ -705,11 +705,11 @@ static netdev_tx_t peak_canfd_start_xmit(struct sk_buff *skb,
>>   	/* set driver specific bit to differentiate with application loopback */
>>   	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
>>   		msg_flags |= PUCAN_MSG_SELF_RECEIVE;
>>   
>>   	msg->flags = cpu_to_le16(msg_flags);
>> -	msg->channel_dlc = PUCAN_MSG_CHANNEL_DLC(priv->index, can_dlc);
>> +	msg->channel_dlc = PUCAN_MSG_CHANNEL_DLC(priv->index, len);
>>   	memcpy(msg->d, cf->data, cf->len);
>>   
>>   	/* struct msg client field is used as an index in the echo skbs ring */
>>   	msg->client = priv->echo_idx;
>>   
> 
> [...]
> 
>> diff --git a/drivers/net/can/softing/softing_fw.c b/drivers/net/can/softing/softing_fw.c
>> index ccd649a8e37b..7e1536877993 100644
>> --- a/drivers/net/can/softing/softing_fw.c
>> +++ b/drivers/net/can/softing/softing_fw.c
>> @@ -622,11 +622,11 @@ int softing_startstop(struct net_device *dev, int up)
>>   	 * from here, no errors should occur, or the failed: part
>>   	 * must be reviewed
>>   	 */
>>   	memset(&msg, 0, sizeof(msg));
>>   	msg.can_id = CAN_ERR_FLAG | CAN_ERR_RESTARTED;
>> -	msg.can_dlc = CAN_ERR_DLC;
>> +	msg.len = CAN_ERR_DLC;
> 
> unrelated?

No, definitely not. msg is a struct can_frame. Therefore 'len' should be 
used.

When implementing the stuff for len8_dlc we are now very clear where we 
have a length value and where we have a data length code.

(..) (skipping tons of 'same here?')

>> -/* get data length from can_dlc with sanitized can_dlc */
>> -u8 can_dlc2len(u8 can_dlc);
>> +/* get data length from dlc with sanitized len */
>> +u8 can_dlc2len(u8 dlc);
> 
> unrealted?

Same as at its first occurance. Remove can_dlc from the radar.

Thanks for the review,
Oliver
