Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5153A2A9AF0
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgKFRdh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:33:37 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:34149 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgKFRdh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:33:37 -0500
X-Greylist: delayed 67392 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2020 12:33:36 EST
Date:   Fri, 06 Nov 2020 17:33:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acoro.eu;
        s=protonmail; t=1604684015;
        bh=x43H6ny8a5VR+tPI34yA7YmXvyRVOsFaR6dhQIkw8Ro=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=txcGKDNsZQZYTvyNDNHZPwX/ZnnKalXNXWhu36O8HOl+ez4wq07gAgFpWb4hjGo7C
         DZHpGDkQepG3B8Ebi8yC6Eq3EBxAwffR5JALLaw0WGxDV1zWxvzhq4JXHX+cnBYrY3
         RrrrmnFIYkQpxa4MeUCBk0KNAkogEn4iDdbApAcHtvE3eZN+8Ca3XNh8UquwJvIFOf
         0FOr6Xkct6dqfJOckyndtC/MrqKb/0OG/I/mJp2bhwGAkH59SX9q6CGxP43W6kwNBQ
         1GLzJTScgUMysMMuEfsQXuRw7PISu9B6T4vhxFFZUdYvLXmKqaHPCtgFgCVgQlHqHO
         yCVr8wtzuExPQ==
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
From:   Alejandro <alejandro@acoro.eu>
Cc:     wg@grandegger.com, davem@davemloft.net, kuba@kernel.org
Reply-To: Alejandro <alejandro@acoro.eu>
Subject: Re: [PATCH] can: dev: can_restart(): post buffer from the right context
Message-ID: <2e152de6-a3b1-ad81-981d-423835eb184e@acoro.eu>
In-Reply-To: <e8dc38e5-5f4d-a1c9-8edb-d612b781467b@pengutronix.de>
References: <bd6d51f4-4a18-e557-46d1-00d3539d163e@acoro.eu> <4e84162b-fb31-3a73-fa9a-9438b4bd5234@acoro.eu> <e8dc38e5-5f4d-a1c9-8edb-d612b781467b@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 6/11/20 11:25, Marc Kleine-Budde wrote:

> On 11/5/20 10:51 PM, Alejandro wrote:
>> From: Alejandro Concepcion Rodriguez<alejandro@acoro.eu>
>>
>> netif_rx() is meant to be called from interrupt contexts. can_restart()
>> may be called by can_restart_work(), which is called from a worqueue, so
>> it may run in process context. Use netif_rx_any_context() which invokes
>> the correct code path depending on context.
>>
>> Co-developed-by: Loris Fauster<loris.fauster@ttcontrol.com>
>> Signed-off-by: Loris Fauster<loris.fauster@ttcontrol.com>
>> Signed-off-by: Alejandro Concepcion Rodriguez<alejandro@acoro.eu>
> I think we either call can_restart() from a netlink callback via
> can_restart_now() or via the can_restart_work(). So we should always use
> netif_rx_ni(skb), right?

Right, I think that currently it is as you say. However, it seems that
can_restart_now() has public visibility (/linux/can/dev.h), and even though
it doesn't seem to be used by other CAN drivers for now, I guess it could
potentially be used in future. netif_rx_any_context() should avoid issues
if can_restart_now() is called from an ISR later.

>
>> ---
>>    drivers/net/can/dev.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>> index b70ded3760f2..83114f8e8c24 100644
>> --- a/drivers/net/can/dev.c
>> +++ b/drivers/net/can/dev.c
>> @@ -584,7 +584,7 @@ static void can_restart(struct net_device *dev)
>>   =20
>>    =09cf->can_id |=3D CAN_ERR_RESTARTED;
>>   =20
>> -=09netif_rx(skb);
>> +=09netif_rx_any_context(skb);
>>   =20
>>    =09stats->rx_packets++;
>>    =09stats->rx_bytes +=3D cf->can_dlc;
>>
> Marc
>
BR,
Alejandro


