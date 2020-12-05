Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B69F2CFF28
	for <lists+linux-can@lfdr.de>; Sat,  5 Dec 2020 22:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgLEVTO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 5 Dec 2020 16:19:14 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:19035 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLEVTN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 5 Dec 2020 16:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607202921;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Q654KfCoqvjdIvqBT4q18lDliJ1BsGgnmytP09f+scw=;
        b=MlmLxZbJJX4SMMElgqigWTKAYxk87Bl50Lu4B9s1fcD+jpbkbADWHPSfAnZjLwiGaR
        QAi0UDSzhY7QMKaE8kGNBqZp0i9Yt/8RtuE+J69N0ytpAG8H1yRbvajdJHMpZIURIaxa
        Tn/Vu5Owksd/e6IweenYJwC9c3LUU1xxcS7+U66nLGA/tBW2HRc9uVQ7wNedDHk33nLq
        pFZooD3JIKpQZqQedxuQe5w2lHa16NM29WPhVO0T0KOFMXpGcZiO14hK6c6NSwwVzhKZ
        e01hgdla4muQlAcov1QuJepYATqkb55tdYh/sPwqyYG9Xs0WTRRvGUbFxKx76wE48vYQ
        U/IA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVch5kErC"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwB5LFLMBh
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 5 Dec 2020 22:15:21 +0100 (CET)
Subject: Re: [PATCH] isotp: do not validate RX address when the broadcast flag
 is active
To:     Thomseeen <thwa1@web.de>, linux-can@vger.kernel.org
References: <20201204135557.55599-1-thwa1@web.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <d7f4c720-199f-8837-829e-653c435f52d1@hartkopp.net>
Date:   Sat, 5 Dec 2020 22:15:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201204135557.55599-1-thwa1@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 04.12.20 14:55, Thomseeen wrote:
> EADDRNOTAVAIL shouldn't be thrown when an invalid RX address (e.g. NO_CAN_ID)
> is set while the socket is used with the CAN_ISOTP_SF_BROADCAST flag.
> 
> Signed-off-by: Thomseeen <thwa1@web.de>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

> ---
>   net/can/isotp.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index fb6dba1..ae939bf 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1106,20 +1106,25 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>   #endif
>   		return -EINVAL;
> 
> -	if (addr->can_addr.tp.rx_id == addr->can_addr.tp.tx_id)
> -		return -EADDRNOTAVAIL;
> +	/* do not register frame reception for functional addressing */
> +	if (so->opt.flags & CAN_ISOTP_SF_BROADCAST)
> +		do_rx_reg = 0;
> +
> +	/* do not validate rx address for functional addressing */
> +	if (do_rx_reg) {
> +		if (addr->can_addr.tp.rx_id == addr->can_addr.tp.tx_id)
> +			return -EADDRNOTAVAIL;
> 
> -	if ((addr->can_addr.tp.rx_id | addr->can_addr.tp.tx_id) &
> -	    (CAN_ERR_FLAG | CAN_RTR_FLAG))
> +		if (addr->can_addr.tp.rx_id & (CAN_ERR_FLAG | CAN_RTR_FLAG))
> +			return -EADDRNOTAVAIL;
> +	}
> +
> +	if (addr->can_addr.tp.tx_id & (CAN_ERR_FLAG | CAN_RTR_FLAG))
>   		return -EADDRNOTAVAIL;
> 
>   	if (!addr->can_ifindex)
>   		return -ENODEV;
> 
> -	/* do not register frame reception for functional addressing */
> -	if (so->opt.flags & CAN_ISOTP_SF_BROADCAST)
> -		do_rx_reg = 0;
> -
>   	lock_sock(sk);
> 
>   	if (so->bound && addr->can_ifindex == so->ifindex &&
> --
> 2.25.1
> 
