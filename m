Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7556E3C3417
	for <lists+linux-can@lfdr.de>; Sat, 10 Jul 2021 12:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhGJKWC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 10 Jul 2021 06:22:02 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:23226 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhGJKWC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 10 Jul 2021 06:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1625912354;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=zCfx4vj48pAgELypx7MiHxb46M+ImK1cAk63eqQKIkg=;
    b=NtNfZPIQyC1dcVhFdskjKxFUFwoz5lwmYVoqZBbqRVbUw68EBYXZHw3QNRnB1Q5sNK
    WQfOTfc33DDxkP3chvDPOl++4oQ0oUarzCUIEEmg0sLtV6/v3+olYz4219Njk0mKKJnW
    NoWd8Wa4cUmTuEg0aD3VaZmJLu2y/fZiQ+nkD8DZ7zh8azdAL935PSfA4rK/R7GI28F2
    8KoEEnCMi34xI7iuQVsQIotF12WpsCYZQiU3+143CAfKSJfJJcOupbbdPCISEuosZTpr
    /+DZzh2ciO/ARVv6KJQNIarra95zgTuTZLMEeOu6pckUmZRl6SyX1pLFuCidbdJmiI+x
    43fA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3htNmYasgbo6AhaFdcg=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a00:6020:1cee:8300::b82]
    by smtp.strato.de (RZmta 47.28.1 AUTH)
    with ESMTPSA id h0143fx6AAJEOrr
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 10 Jul 2021 12:19:14 +0200 (CEST)
Subject: Re: ip link valid options checking
To:     =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>,
        "engnfrc@gmail.com" <engnfrc@gmail.com>,
        "mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <002501d77357$d93c36b0$8bb4a410$@gmail.com>
 <CAMZ6RqLWLPtviMJHOXQJEc430cUPnZeP3N8BdvnV6_dLHYFTpg@mail.gmail.com>
 <b1da5bb9b940c7cb262184ec828568a38af8f5af.camel@esd.eu>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <2b09f159-097c-feab-ad5f-d65523f90a5c@hartkopp.net>
Date:   Sat, 10 Jul 2021 12:19:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b1da5bb9b940c7cb262184ec828568a38af8f5af.camel@esd.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Stefan,

On 09.07.21 17:07, Stefan Mätje wrote:
> Am Freitag, den 09.07.2021, 14:00 +0200 schrieb Vincent MAILHOL:

> 
> Unfortunately the netlink kernel interface gives access only to the
> IFLA_CAN_CTRLMODE data which boils down to an access of the netdev_priv(dev)-
>> priv->ctrlmode flags set in the driver (see also in a Linux tree under
> drivers/net/can/dev/netlink.c). But the "ctrlmode" flags represent only the
> current setup. So you can see if CAN-FD mode is currently enabled.
> 
> But I think the thread opener wants to know in advance if the kernel gives us
> the information what modes a certain driver supports. That is encoded in
> netdev_priv(dev)->priv->ctrlmode_supported and netdev_priv(dev)->priv-
>> ctrlmode_static. But for these flags there is no netlink interface to
> interrogate that settings at the moment.
> 
> So you can't see in advance if a CAN driver would support for instance triple-
> sampling or the CAN_CTRLMODE_CC_LEN8_DLC mode. To know it you must try to set
> such option atm. I think.

Yes, but the settings of priv->ctrlmode_static may lead into problems 
too as there might be a fixed setting that can not be altered.

As you already pointed out the netlink interface only provides the 
current setting of priv->ctrlmode.

Btw. the struct can_ctrlmode has two u32 elements, so we could use the 
mask element to pass the priv->ctrlmode_supported value to the user space:

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index e38c2566aff4..91c6ae06a576 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -259,11 +259,12 @@ static size_t can_get_size(const struct net_device 
*dev)
  }

  static int can_fill_info(struct sk_buff *skb, const struct net_device 
*dev)
  {
         struct can_priv *priv = netdev_priv(dev);
-       struct can_ctrlmode cm = {.flags = priv->ctrlmode};
+       struct can_ctrlmode cm = {.flags = priv->ctrlmode,
+               .mask = priv->ctrlmode_supported};
         struct can_berr_counter bec = { };
         enum can_state state = priv->state;

         if (priv->do_get_state)
                 priv->do_get_state(dev, &state);

Additionally we could also make the mask element in struct can_ctrlmode 
a union with a 'supported' element ...

But this is, what would be needed here, right?

Best regards,
Oliver
