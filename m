Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5F45E827A
	for <lists+linux-can@lfdr.de>; Fri, 23 Sep 2022 21:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiIWTVb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Sep 2022 15:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiIWTVa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Sep 2022 15:21:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E465E6DC7
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 12:21:29 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d42so1841284lfv.0
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 12:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AO3eDpYD6WFI1Idi2GdcVU7ChWBJdwHKgfyNH2VqdKI=;
        b=iqnDLYL8kttCDzKF6rQ+OjjebO6jGNGNt7LyTJndt4IInV9PvrrWsn4XhZGl4/yV83
         i/H/F6kRejTtvwauwZ2uEK+ZTtACy/SWEX/ZYFGnoMqz9yNVaypJEQZN6aAVmx0g6Dbc
         agFrCuRj8h6BSOV3z74uR4UJroXDPEpYMupcNk1VfLifiqkapv7Jv/PAEZomb9wvIIz6
         Gg4xOh5iQckjJRkJH2BM5YHAxlDXniYmR78ypiH8aAxVQLWnktkgGG6LGhk/fc/yAUGV
         nAqYRr9JfJuEmzwuwQcEU2aRNHXARQyb/IbQc24txgICMmL1VatIuk1y6+dQ1FDtjVuB
         Nr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AO3eDpYD6WFI1Idi2GdcVU7ChWBJdwHKgfyNH2VqdKI=;
        b=HBWV9jYbrXe4GyHUCt6eGcTAKVgZyaWNN6dLEvlNCPum+KqgEB1BBtwgqL8noKq9vf
         VVUA7rZUb7K5n5fxu8S2qbRdnzx39TLKjP18QR50nSxIIB2YrNsfh8xG1VoA92EQ/0i4
         y6NfqiPLhicN5igpNweMof66+zXyqr0RcyYmFGCGt9bk/dqJExblhvfFmkJ+6ToW9hAX
         iQ9V1U3UOJnExUVNsKoR6AQd8xBQMNaTGHKB55hPba/HDGGmp3oKZYdoKkqJx+kIzTSD
         5eeuR/5/+JyFRnFBDDBEh88+2COBGrWoKWsR8vDrHzEa0+oxKsezSazDHfEBsNKiKsiM
         OTVA==
X-Gm-Message-State: ACrzQf3kPajDe2iWfChffH7XusgpPkQghBii+tRdv4R/dmNP42J4OdX2
        mtGZj8vCo0o1kuM9aXCi1v6qpIOeC0iVddkh
X-Google-Smtp-Source: AMsMyM4cEkICzjGZTx9ZQxBRCH400Mx670qiwcW0uNfEGc6bU4Vy98/HnZIt/3pbrG6PHoKSZpTbDQ==
X-Received: by 2002:a05:6512:12d4:b0:49a:e469:8e76 with SMTP id p20-20020a05651212d400b0049ae4698e76mr4051836lfg.213.1663960887491;
        Fri, 23 Sep 2022 12:21:27 -0700 (PDT)
Received: from [192.168.10.124] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id v10-20020a2ea60a000000b0026bf0d71b1esm1510470ljp.93.2022.09.23.12.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 12:21:26 -0700 (PDT)
Message-ID: <8665ef57-17fb-dfd7-afa2-8e5bebceb617@gmail.com>
Date:   Fri, 23 Sep 2022 21:21:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Content-Language: en-US
From:   Jacob Kroon <jacob.kroon@gmail.com>
To:     dariobin@libero.it, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
 <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
 <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
 <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
 <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
 <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
 <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
 <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
 <20220923113638.tjnbuvkzdq24c4as@pengutronix.de>
 <36690382.801104.1663955706569@mail1.libero.it>
 <a162f149-58ba-24eb-474f-294b9fe78e51@gmail.com>
In-Reply-To: <a162f149-58ba-24eb-474f-294b9fe78e51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 9/23/22 21:03, Jacob Kroon wrote:
> Hi Dario,
> 
> On 9/23/22 19:55, dariobin@libero.it wrote:
>> Hi Michael,
>>
>>> Il 23/09/2022 13:36 Marc Kleine-Budde <mkl@pengutronix.de> ha scritto:
>>>
>>> On 16.09.2022 06:14:58, Jacob Kroon wrote:
>>>> What I do know is that if I revert commit:
>>>>
>>>> "can: c_can: cache frames to operate as a true FIFO"
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=387da6bc7a826cc6d532b1c0002b7c7513238d5f
>>>>
>>>> then everything looks good. I don't get any BUG messages, and the host
>>>> has been running overnight without problems, so it seems to have fixed
>>>> the network interface lockup as well.
>>>
>>> Jacob, after this mail, I'll send 2 patches. One tries to disable the
>>> cache feature for C_CAN cores, the other shuts a potential race window.
>>
>> About the "can: c_can: don't cache TX messages for C_CAN cores" patch:
>> Could it make sense to change the c_can_start_xmit in this way
>>
>> -       if (idx < c_can_get_tx_tail(tx_ring))
>> -               cmd &= ~IF_COMM_TXRQST; /* Cache the message */
>> +       if (idx < c_can_get_tx_tail(tx_ring)) {
>> +               if (priv->type == BOSCH_D_CAN) {
>> +                       cmd &= ~IF_COMM_TXRQST; /* Cache the message */
>> +               } else {
>> +                       netif_stop_queue(priv->dev);
>> +                       return NETDEV_TX_BUSY;
>> +               }
>> +       }
>>
>> without changing the c_can_get_tx_{free,busy} routines ?
>>
> 
> I can test, so you suggest only doing the above patch, or were there 
> other parts from Marc's patch you wanted in ?
>

Well I tried only the above, and the patch below

diff --git a/drivers/net/can/c_can/c_can_main.c 
b/drivers/net/can/c_can/c_can_main.c
index a7362af0babb..21d0a55ebbb3 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -468,8 +468,14 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff 
*skb,
  	if (c_can_get_tx_free(tx_ring) == 0)
  		netif_stop_queue(dev);

-	if (idx < c_can_get_tx_tail(tx_ring))
-		cmd &= ~IF_COMM_TXRQST; /* Cache the message */
+	if (idx < c_can_get_tx_tail(tx_ring)) {
+		if (priv->type == BOSCH_D_CAN) {
+			cmd &= ~IF_COMM_TXRQST; /* Cache the message */
+		} else {
+			netif_stop_queue(priv->dev);
+			return NETDEV_TX_BUSY;
+		}
+	}

  	/* Store the message in the interface so we can call
  	 * can_put_echo_skb(). We must do this before we enable
@@ -761,7 +767,7 @@ static void c_can_do_tx(struct net_device *dev)

  	tail = c_can_get_tx_tail(tx_ring);

-	if (tail == 0) {
+	if (priv->type == BOSCH_D_CAN && tail == 0) {
  		u8 head = c_can_get_tx_head(tx_ring);

  		/* Start transmission for all cached messages */


but they both seem to lockup the network.

Jacob
