Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD1BE68C6B
	for <lists+linux-can@lfdr.de>; Mon, 15 Jul 2019 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbfGONve (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 Jul 2019 09:51:34 -0400
Received: from first.geanix.com ([116.203.34.67]:38290 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731685AbfGONvc (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 15 Jul 2019 09:51:32 -0400
Received: from [192.168.8.20] (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 2983F43685
        for <linux-can@vger.kernel.org>; Mon, 15 Jul 2019 13:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1563198667; bh=puyKyU52lCSXhv3+j8+DqnOrbgRUyU4q2DPnj9YY5uo=;
        h=Subject:From:To:References:Date:In-Reply-To;
        b=XcMfpqUZ72kLXC5Jt82ilFoLyVssVkbtfWN5Bybh3iecA8XVIpdPL7CoMnZdjAYoO
         QkfPKLtPU6Ul9uCNFjtlWAd+Q439XJpV0Jb468a4ZHwxoveWkTs50KGJlyUWYFq6Sr
         KpXOAWx6mcMsBpUWb1w+4jE4/1LZCTvMl++rHQFSAr25NNGvhbZEtsEZxhMMsoiDEk
         YrV1ns2/2Mnj7jimaPxmHem6+dyhELw0ODzYVPRh7r5jmbIokTjD8e3aOb4fcXHO3f
         BxJbJH/h/MrzKeLhU7I14Uy8SLkg0WS88fjmdmvWLp/7GdnW+vXPoHPuZwa9k7m7y+
         oP2vDkYT3xlpQ==
Subject: Re: Flexcan memory leak
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
To:     linux-can@vger.kernel.org
References: <899874c1-8916-a71a-9426-b65961c01a7b@geanix.com>
Message-ID: <7419db83-1e9b-7724-af9c-ca1d57392322@geanix.com>
Date:   Mon, 15 Jul 2019 15:51:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <899874c1-8916-a71a-9426-b65961c01a7b@geanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8945dcc0271d
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 15/07/2019 15.10, Martin Hundebøll wrote:
> I have also tried to partially revert commit 
> 30164759db1bb1062bdf0f92451f57ed295cfa48 ("can: flexcan: make use of 
> rx-offload's irq_offload_fifo") to circumvent the rx-offload queuing:
> 
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 4e3caf421a54..3e13d2480828 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -677,7 +677,9 @@ static void flexcan_irq_bus_err(struct net_device 
> *dev, u32 reg_esr)
>          if (tx_errors)
>                  dev->stats.tx_errors++;
> 
> -       can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
> +       dev->stats.rx_packets++;
> +       dev->stats.rx_bytes += cf->can_dlc;
> +       netif_receive_skb(skb);
>   }
> 
>   static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
> 
> 
> But that doesn't make a difference either.

My fault; I forgot to build/deploy the module when testing the change above.

It seems like circumventing the rx-offloading "fixes" the issue.

// Martin
