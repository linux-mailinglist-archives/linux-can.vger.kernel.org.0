Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20118457AAC
	for <lists+linux-can@lfdr.de>; Sat, 20 Nov 2021 04:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhKTDJi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Nov 2021 22:09:38 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:57495 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbhKTDJh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Nov 2021 22:09:37 -0500
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by smtp.orange.fr with ESMTPA
        id oGhtmfkqZWUfjoGi0mA8Xc; Sat, 20 Nov 2021 04:06:34 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: MDU0YmViZGZmMDIzYiBlMiM2NTczNTRjNWZkZTMwOGRiOGQ4ODf3NWI1ZTMyMzdiODlhOQ==
X-ME-Date: Sat, 20 Nov 2021 04:06:34 +0100
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     extja@kvaser.com, linux-can@vger.kernel.org
Cc:     jimmyassarsson@gmail.com,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v1 1/5] can: kvaser_pciefd: Do not increase stats->rx_{packets,bytes} for error frames
Date:   Sat, 20 Nov 2021 12:06:04 +0900
Message-Id: <20211120030604.217665-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211119131915.2033234-2-extja@kvaser.com>
References: <20211119131915.2033234-2-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 19 Nov 2021 at 05:20, Jimmy Assarsson <extja@kvaser.com> wrote:
> Do not increase net_device_stats rx_{packets,bytes} when receiving
> error frames.
> 
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>  drivers/net/can/kvaser_pciefd.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
> index 74d9899fc904..2c98befcf2a0 100644
> --- a/drivers/net/can/kvaser_pciefd.c
> +++ b/drivers/net/can/kvaser_pciefd.c
> @@ -1304,9 +1304,6 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
>  	cf->data[6] = bec.txerr;
>  	cf->data[7] = bec.rxerr;
>  
> -	stats->rx_packets++;
> -	stats->rx_bytes += cf->len;
> -
>  	netif_rx(skb);
>  	return 0;
>  }

I think that this patch makes sense because the CAN error frames do
not exists on the wire: only an error flag is transmitted.

However, the current consensus is that the rx_packets and rx_bytes
statistics should be incremented for CAN error frames. And I think
that consistency between the drivers is the first priority.

I inquired here in the past to ask if it made sense to stop increasing
the rx stats for CAN error frames:

https://lore.kernel.org/linux-can/CAMZ6Rq+8YSRqXU7CPrT9FKnWZ1G9xkSr3wt185r2CswmxhXPVg@mail.gmail.com/t/#u

But the discussion did not raise interest. I am fine to send a tree
wide cleaning patch, but first, I would like to have people agree on
this.
