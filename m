Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1381217EC
	for <lists+linux-can@lfdr.de>; Mon, 16 Dec 2019 19:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfLPSDq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Dec 2019 13:03:46 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:29507 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbfLPSDp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Dec 2019 13:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576519419;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=jGtSHQ9HU+09PNiqRajW9fTC8K3YqTFT/lPuBBPFnh4=;
        b=dacO/uj9Glg4DlMG1UnsWfJ5jaR9OcB40ap6AH/4QKTdEB+xuGS+XI15gLWGwqQ48Q
        zvvmaFUImUBLEfwRpAe8apducQZOaeyRbC0LuTYaxdQRj/G7YZjK+33NM7ZdFg2bsUDF
        LO4iNtdqsa69HaCScm2edeK7ldBgi4HGN5Sdvf6gcq9zrBqoVWJvsMHjca+BplU79ZAa
        EfXO+h/WawhI8GqEKZQssvfW8vN50MOf3wrytbIe5sxyj66IQa8TL2frF93zr6XMeaA7
        i3XUyVGD5SzfeRgAelmOXM1FoAEm5BWh6OeWMbML6Nhe8t8DFjZQGVoZbpQxN2InSK5c
        hQhA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJUMh6kkRA"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 46.0.7 DYNA|AUTH)
        with ESMTPSA id x04ebavBGI3bDuM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 16 Dec 2019 19:03:37 +0100 (CET)
Subject: Re: [PATCH v3] can: ensure an initialized headroom in outgoing CAN
 sk_buffs
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com
References: <20191210103130.11201-1-mkl@pengutronix.de>
 <ea12de3d-e258-f4a7-6219-71995dbe8134@hartkopp.net>
Message-ID: <202358df-df7b-b999-b820-33006ba0b264@hartkopp.net>
Date:   Mon, 16 Dec 2019 19:03:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ea12de3d-e258-f4a7-6219-71995dbe8134@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 16/12/2019 18.17, Oliver Hartkopp wrote:
> 
> 
> On 10/12/2019 11.31, Marc Kleine-Budde wrote:
>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> KMSAN sysbot detected a read access to an untinitialized value in the
>> headroom of an outgoing CAN related sk_buff. When using CAN sockets this
>> area is filled appropriately - but when using a packet socket this
>> initialization is missing.
>>
>> The problematic read access occurs in the CAN receive path which can
>> only be triggered when the sk_buff is sent through a (virtual) CAN
>> interface. So we check in the sending path whether we need to perform
>> the missing initializations.
>>
>> Fixes: d3b58c47d330d ("can: replace timestamp as unique skb attribute")
>> Reported-by: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> When do you want to push it upstream?

... together with the hint for the stable trees

Cc: linux-stable <stable@vger.kernel.org> # >= v4.1

> The patch is ok for me.
> Do you need another Acked-by or Tested-by tag?

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>

Just for the record:

With this patch for vcan.c

diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index 39ca14b0585d..eb7023043385 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -83,15 +83,32 @@ static void vcan_rx(struct sk_buff *skb, struct 
net_device *dev)
  	netif_rx_ni(skb);
  }

+static void vcan_print_skb(struct sk_buff *skb)
+{
+       printk("len: %d, end-data: %ld, tail-data %ld, data-head %ld, 
ifindex = %d, skbcnt = %d, pkt_type = %d, ip_summed = %d\n",
+	      skb->len,
+	      skb_end_pointer(skb) - skb->data,
+	      skb_tail_pointer(skb) - skb->data,
+	      skb->data - skb->head,
+	      can_skb_prv(skb)->ifindex,
+	      can_skb_prv(skb)->skbcnt,
+	      skb->pkt_type,
+	      skb->ip_summed);
+}
+
  static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
  {
  	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
  	struct net_device_stats *stats = &dev->stats;
  	int loop;

+	vcan_print_skb(skb);
+
  	if (can_dropped_invalid_skb(dev, skb))
  		return NETDEV_TX_OK;

+	vcan_print_skb(skb);
+
  	stats->tx_packets++;
  	stats->tx_bytes += cfd->len;


And then starting
cansend vcan0 12345678#112233

dmesg:
[   95.567858] len: 16, end-data: 184, tail-data 16, data-head 8, 
ifindex = 8, skbcnt = 0, pkt_type = 5, ip_summed = 1
[   95.567862] len: 16, end-data: 184, tail-data 16, data-head 8, 
ifindex = 8, skbcnt = 0, pkt_type = 5, ip_summed = 1

Alternatively
linux-can/can-tests/netlayer# ./tst-packet -s

dmesg:
[  124.740592] len: 16, end-data: 176, tail-data 16, data-head 16, 
ifindex = 0, skbcnt = 0, pkt_type = 0, ip_summed = 0
[  124.740596] len: 16, end-data: 176, tail-data 16, data-head 16, 
ifindex = 10, skbcnt = 0, pkt_type = 5, ip_summed = 1

So ifindex, skbcnt, pkt_type, ip_summed have been set correctly - even 
for skb's that have not been created by the CAN subsystem (e.g. packet 
socket).

Regards,
Oliver

