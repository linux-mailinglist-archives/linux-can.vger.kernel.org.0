Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E33034030E
	for <lists+linux-can@lfdr.de>; Thu, 18 Mar 2021 11:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCRKVr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Mar 2021 06:21:47 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:16284 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCRKVe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Mar 2021 06:21:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616062892; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ij/D6FZ+3fnqxuYyFYKxrxqLSMiyiGZSG32Z2vmgbSOegyZHomGqLyBvkfoOQ07o58
    cOs7kykOboSRX8Ko2pSoumaIq4FzAMPQ5zN9ihN3Qycs8cXkoyi5xiAKM8EZVBNWF2qW
    oWgPmY5bYpuusJgYwAEfk3ZcQnz2vQFJeyugUaHIP4BbACH+jAWFKQtkVUaL5NheQ07g
    A7ipgVQVl9InPKR/OnwYiBzEwIkjdOGK93JvKRQTcNAeKGl+9CClJwpNbNjax/nOAnni
    kmleMxD/0k3tVN7p3b6XWY2v/ivY6nAFz9lHlqjfirQT/KN1KQBmJEY8R8lI3BmR8kil
    Gmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616062892;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=m5ilTrG73K5Mz+m+vt36UFX8QexKEFYvzyfH/MIxUi8=;
    b=rxLOx3KSDxEPy6j1bQRwwMpu3jHS0woo8+d1vfrBqYLM0+raODk1qjPEqE6Np+cDUi
    7OexnysenEZ6bgK7K5DBIbZxfNbjLZMRc1FuDZRXPhPjobd03Qhz9Hi5sCfH0LOXjZCk
    dCs3ztzBkEmk3PLHJMaZTutH8LPpXyUpas20cTZz99tsuq4h5EKWk6Wk+/LctBmbunu2
    zjB2DNZvtIaN86eIAkMXS6xPERwXyLdLzPIIUynLoQZfMFzBHmDVY2zycSX5/SuEhAA4
    blrxEibLiJQjcBs7SuWo+ry/NeRUI+o7ORw5Uo0jpqwbVp1NyK3vTvZocMmmRv9vNJ25
    uAvg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616062891;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=m5ilTrG73K5Mz+m+vt36UFX8QexKEFYvzyfH/MIxUi8=;
    b=YAyakw4SG93ZbKX9ySJnFwFtUYqinI02fX8goXO+HNrbHpJQITnsdIrfOfAOTbkHBJ
    n+HyJHkJO8qNop8TPfzsAO5mjUAvl8MfeZv5E/RAb1X64SwoKRPY9MpzeHUAHj5dOD+z
    ZnOJav7tfJmAzOjltGoB4jdVSz89gQhwww8cubkELGQph//93cnI5nhkwfEv5emPKMvZ
    DOgMgIcl242pAAh1hrF5uvCQ+yQIUO10+Ot3+8siWx1Q0mIVNwLQSREW/I/LE+mS2fXc
    PEET9bOqruj+mkfTyckfty5rMeEfcztIqImJuOLJiNv4+6SBnJ5WMt5iLy5UhOE0rgaO
    r2vg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVxiOMpjpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.21.0 DYNA|AUTH)
    with ESMTPSA id R01debx2IALV1tj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 18 Mar 2021 11:21:31 +0100 (CET)
Subject: Re: [PATCH can-next] can: dev: always create TX echo skb
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de
References: <20210309211904.3348700-1-mkl@pengutronix.de>
 <CAMZ6Rq+QNj6ajmTyqtZt0HnJjg95Y_Ud-eokhZj9AvN1dPpRYg@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <b4c7b62d-7004-7862-32e3-00f3bd73383c@hartkopp.net>
Date:   Thu, 18 Mar 2021 11:21:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6Rq+QNj6ajmTyqtZt0HnJjg95Y_Ud-eokhZj9AvN1dPpRYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vincent,

On 18.03.21 11:03, Vincent MAILHOL wrote:
> Hi Marc,
> 
> On Wed. 10 Mar 2021 at 06:19, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>
>> So far the creation of the TX echo skb was optional and can be
>> controlled by the local sender of a CAN frame.
>>
>> It turns out that the TX echo CAN skb can be piggybacked to carry
>> information in the driver from the TX- to the TX-complete handler.
>>
>> Several drivers already use the return value of
>> can_get_echo_skb() (which is the length of the data field in the CAN
>> frame) for their number of transferred bytes statistics. The
>> statistics are not working if CAN echo skbs are disabled.
>>
>> Another use case is to calculate and set the CAN frame length on the
>> wire, which is needed for BQL support in both the TX and TX-completion
>> handler.
>>
>> For now in can_put_echo_skb(), which is called from the TX handler,
>> the skb carrying the CAN frame is discarded if no TX echo is
>> requested, leading to the above illustrated problems.
>>
>> This patch changes the can_put_echo_skb() function, so that the echo
>> skb is always generated. If the sender requests no echo, the echo skb
>> is consumed in __can_get_echo_skb() without being passed into the RX
>> handler of the networking stack, but the CAN data length and CAN frame
>> length information is properly returned.
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>   drivers/net/can/dev/skb.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
>> index 6a64fe410987..22b0472a5fad 100644
>> --- a/drivers/net/can/dev/skb.c
>> +++ b/drivers/net/can/dev/skb.c
>> @@ -45,7 +45,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>>          BUG_ON(idx >= priv->echo_skb_max);
>>
>>          /* check flag whether this packet has to be looped back */
>> -       if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK ||
>> +       if (!(dev->flags & IFF_ECHO) ||
>>              (skb->protocol != htons(ETH_P_CAN) &&
>>               skb->protocol != htons(ETH_P_CANFD))) {
>>                  kfree_skb(skb);
>> @@ -58,7 +58,6 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>>                          return -ENOMEM;
>>
>>                  /* make settings for echo to reduce code in irq context */
>> -               skb->pkt_type = PACKET_BROADCAST;
>>                  skb->ip_summed = CHECKSUM_UNNECESSARY;
>>                  skb->dev = dev;
>>
>> @@ -111,6 +110,13 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
>>
>>                  priv->echo_skb[idx] = NULL;
>>
>> +               if (skb->pkt_type == PACKET_LOOPBACK) {
>> +                       skb->pkt_type = PACKET_BROADCAST;
>> +               } else {
>> +                       dev_consume_skb_any(skb);
>> +                       return NULL;
>> +               }
>> +
>>                  return skb;
>>          }
> 
> I do see any particular issues on this patch at the moment,
> however, while looking at the TX echo functionality, it reminded
> me of a point which has always been a bit unclear to me: the
> CAN_CTRLMODE_LOOPBACK. So let me go a bit off topic.
> 
> Like all other controller's mode, I would expect the
> CAN_CTRLMODE_LOOPBACK flag to do two things:
>    - Announce that the device is capable of doing loopback
>    - Control this feature (enable/disable it)
> 
> But, by default, this flag is set to 0 unless the user
> explicitly passes the "loopback on" argument when configuring
> the device.
> 
> So isn't this supposed to be an issue for all the drivers which
> expect to get a TX loopback in order to trigger the TX completion
> handler?
> 
> Personally, for my driver, I would like to use the
> can_set_static_ctrlmode() to force CAN_CTRLMODE_LOOPBACK so that
> I do not need a different TX completion logic when
> CAN_CTRLMODE_LOOPBACK is off.
> 
> The issue is that because CAN_CTRLMODE_LOOPBACK is per default
> off, doing:
>    can_set_static_ctrlmode(netdev, CAN_CTRLMODE_LOOPBACK);
> would lead to a
>    RTNETLINK answers: Operation not supported
> when configuring the device unless "loopback on" is explicitly
> passed on the command line.
> 
> At the moment, I have the feeling that many drivers just ignore
> the value of this flag and activate the loopback regardless.
> 
> Do you think that it would make sense to set
> CAN_CTRLMODE_LOOPBACK by default to on?

Definitely not.

CAN_CTRLMODE_LOOPBACK defines that the CAN controller establishes a 
shortcut below the rx/tx bitstream engines on chip level. So the 
attached CAN transceiver is not in operation anymore.

Please do not mix up CAN_CTRLMODE_LOOPBACK with the IFF_ECHO flag that 
echoes CAN frames in the sending host to reflect the correct CAN traffic 
e.g. in candump.

Best,
Oliver
