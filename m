Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2812FC334
	for <lists+linux-can@lfdr.de>; Tue, 19 Jan 2021 23:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbhASWTv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jan 2021 17:19:51 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:21346 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbhASWTp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jan 2021 17:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1611094599;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=HVsv07Ood4+Zr/CO1jrz3f9ZaQ0KatiPlPoj6z0CB+4=;
        b=tfC3XYDVokn/wIPl2iLyRGMoLcX+pwg1aaabEnDHvoJVTDufeC19mmrG/5A81+s1ia
        N2Hw34n+1961p+Ak7gKweLBfTlHFe00xbQQkvF/ezCcn979nBwM9KhhJBUlZC4O8N3Ay
        rjtidYR/iKomItApFbt3rtk2sEx1e+X3y+n7/s0iiPEP1Hksw6cNvCLWZKTZFH/lrdUn
        zjv7uF83rhLrefePx9m3BOigWQ8pzpOMeE6HhKMgUl8ollEQmddNVZLRoWWewYFo5s4u
        0xxLnut8QilFydvTwK7jpjDmluFxMh2Y99jxN9KhwwTd+yUksWHLFnczrLtt95MmTvN3
        4Xaw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVNiOMtqpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.177]
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id k075acx0JMGYhcg
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 19 Jan 2021 23:16:34 +0100 (CET)
Subject: Re: [PATCH 2/3] can: vxcan: vxcan_xmit: fix use after free bug
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Loris Fauster <loris.fauster@ttcontrol.com>,
        Alejandro Concepcion Rodriguez <alejandro@acoro.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20210119162512.5236-1-mailhol.vincent@wanadoo.fr>
 <20210119162512.5236-3-mailhol.vincent@wanadoo.fr>
 <CAMZ6RqJb=y9E3tmT+kPwAB1cYyDE2v4e5iMaoB_J17U-W+WB3w@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <360fe995-6f8a-81e6-bd0e-fd5d1cca5a92@hartkopp.net>
Date:   Tue, 19 Jan 2021 23:16:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqJb=y9E3tmT+kPwAB1cYyDE2v4e5iMaoB_J17U-W+WB3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 19.01.21 18:07, Vincent MAILHOL wrote:
> On Wed. 20 Jan 2021 at 01:25, Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
>>
>> After calling netif_rx_ni(skb), dereferencing skb is unsafe.
>> Especially, the canfd_frame cfd which aliases skb memory is accessed
>> after the netif_rx_ni().
>>
>> fixes: a8f820a380a2 ("can: add Virtual CAN Tunnel driver (vxcan)")
>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> ---
>>   drivers/net/can/vxcan.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
>> index fa47bab510bb..a525ef8d19b0 100644
>> --- a/drivers/net/can/vxcan.c
>> +++ b/drivers/net/can/vxcan.c
>> @@ -39,6 +39,7 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *skb, struct net_device *dev)
>>          struct net_device *peer;
>>          struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>>          struct net_device_stats *peerstats, *srcstats = &dev->stats;
>> +       u8 len;
>>
>>          if (can_dropped_invalid_skb(dev, skb))
>>                  return NETDEV_TX_OK;
>> @@ -61,12 +62,13 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *skb, struct net_device *dev)
>>          skb->dev        = peer;
>>          skb->ip_summed  = CHECKSUM_UNNECESSARY;
>>
>> +       u8 len = cfd->len;
> 
> len = cfd->len;
> Silly mistake: u8 not needed twice of course...

not tested -> compile tested -> runtime tested

Choose your level!

:-D

> 
>>          if (netif_rx_ni(skb) == NET_RX_SUCCESS) {
>>                  srcstats->tx_packets++;
>> -               srcstats->tx_bytes += cfd->len;
>> +               srcstats->tx_bytes += len;
>>                  peerstats = &peer->stats;
>>                  peerstats->rx_packets++;
>> -               peerstats->rx_bytes += cfd->len;
>> +               peerstats->rx_bytes += len;
>>          }
>>
>>   out_unlock:
>> --
>> 2.26.2
>>
