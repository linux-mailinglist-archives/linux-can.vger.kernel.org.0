Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEC8789DD4
	for <lists+linux-can@lfdr.de>; Sun, 27 Aug 2023 14:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjH0MTX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 27 Aug 2023 08:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjH0MTK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 27 Aug 2023 08:19:10 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FDB13D
        for <linux-can@vger.kernel.org>; Sun, 27 Aug 2023 05:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1693138743; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=klORhWPv76+zwl2szuvlhVMV5a6RlWerR0rOAOMi1dvK2/8vZr9Q0gLBjVQ6fVcIWB
    DGjo6MsRTuRYUAC6x7imGgdiBDULF1RLFQZQs44ouRGoT8CrLLuN57A2CeW5nPhqPlp0
    87fB4BMYqO7LiZpcx9qJjKcSuE+CIBDadBd2/Jp7YlGCkGSq9TPOKiyBqDMsidxzSDSO
    He33rq+jQfrD280BVP1Q0slMITQKIDZTRnEpRn4waT99gRn29LfwPwv+IjwLo06fCRAg
    c2lrmT6kB1A5gcEPVxKQW63tJrPIvmJuYW/bDXD+L1SohlUI6IiJpYXJ0XePjzRsJ1vA
    fCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1693138743;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6PBnreg3Q619UxPwRBbw5xl6l2a7vH5pv9UQgkOl7LY=;
    b=Q4qyefkqRecDjFWjG6jUj6EUTeBe5ZjJswyMqCA/bNeGOdp7A/atOaEjrpGYL0BScJ
    ++QFbE0lkZDS9T90SgQpKJKFBFL/HksjYSHhOisC3SJXd19TYs36SEZMv0OmkCOcojWo
    xUCdQ+hThqIf9mtojeteoBWn/sPvEbxUz7Ohu3lfcUIZeJisLGa8I8kqVV70gAgdpbfO
    cWwVK+9b+V6JpaJ7Iil9rKyvrei2GQLrH9DXJbF3mA6F4HKpb113BJeVy/BA97ca8Wni
    nzbi76vsC01za3oWqhG+0KX7EEPsb4eLCA17CJfya1DzQSQk4q3iLVpM1gIJF54/YcS5
    v5hQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1693138743;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6PBnreg3Q619UxPwRBbw5xl6l2a7vH5pv9UQgkOl7LY=;
    b=fpePmdvgE96P+LF8IPBCQJwv86VhAsgYcqu+eHq8ZWdGcsUFgAQlHZgj0x0JK3HnMl
    ZbsgvqlZIHDLNvIlxc6evMn4LbeoEZ6tvaKMcfTWfTn5KDtEry7Q2y2SXrZ4ivAxOvNq
    9ywW9S5APJQOOX5oTGY/PLK/TAl9LBB/WKXlJEwhbXPujBNIRoNI6/z46UOPMb9ZTXs7
    sQYHYeOJeuW2mJRRV0nkzIyYy1L4Ei7M3KFHxIPiaC2Y7Mhem1huD3o6ia3flEOJETq+
    SN2jZB9sPBz8sKm3NOeOpAwUiVzlzhVEUdVj0fG3nDiskWdk2/Lhn8HDZYeUpS/jcCPq
    8+cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1693138743;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6PBnreg3Q619UxPwRBbw5xl6l2a7vH5pv9UQgkOl7LY=;
    b=q7m425iYs2M9KHNL6TyLtktMx2oivvslXw9u1DaxKrQDj6w47RR5I04bGn7T0nl2mf
    OlS6skQAd+KuTE55VDAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq1USEbMhpqw=="
Received: from [IPV6:2a00:6020:4a8e:5004::923]
    by smtp.strato.de (RZmta 49.8.1 AUTH)
    with ESMTPSA id K723f1z7RCJ2Er7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 27 Aug 2023 14:19:02 +0200 (CEST)
Message-ID: <96d31e8c-fa26-4e32-4c36-768981f20a54@hartkopp.net>
Date:   Sun, 27 Aug 2023 14:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] can: isotp: isotp_sendmsg(): fix TX state detection
 and wait behavior
Content-Language: en-US
To:     Lukas Magel <lukas.magel@posteo.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Michal Sojka <michal.sojka@cvut.cz>,
        Maxime Jayat <maxime.jayat@mobile-devices.fr>
Cc:     linux-can@vger.kernel.org
References: <20230818114345.142983-1-lukas.magel@posteo.net>
 <20230827092205.7908-1-lukas.magel@posteo.net>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230827092205.7908-1-lukas.magel@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thanks Lukas!

On 27.08.23 11:22, Lukas Magel wrote:
> With patch [1], isotp_poll was updated to also queue the poller in the
> so->wait queue, which is used for send state changes. Since the queue
> now also contains polling tasks that are not interested in sending, the
> queue fill state can no longer be used as an indication of send
> readiness. As a consequence, nonblocking writes can lead to a race and
> lock-up of the socket if there is a second task polling the socket in
> parallel.
> 
> With this patch, isotp_sendmsg does not consult wq_has_sleepers but
> instead tries to atomically set so->tx.state and waits on so->wait if it
> is unable to do so. This behavior is in alignment with isotp_poll, which
> also checks so->tx.state to determine send readiness.
> 
> V2:
> - Revert direct exit to goto err_event_drop
> 
> [1] https://lore.kernel.org/all/20230331125511.372783-1-michal.sojka@cvut.cz
> 
> Reported-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>
> Closes: https://lore.kernel.org/linux-can/11328958-453f-447f-9af8-3b5824dfb041@munic.io/
> Signed-off-by: Lukas Magel <lukas.magel@posteo.net>

Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Fixes: 79e19fa79cb5 ("can: isotp: isotp_ops: fix poll() to not report 
false EPOLLOUT events")

I would suggest to add this Fixes tag here to give a qualified hint 
since when it makes sense to apply this patch from Lukas. It definitely 
fixes the introduced isotp_poll() function from Michal.

Btw. before the patch from Michal the poll() syscall was completely 
brocken o_O

Many thanks to all of you!

Best regards,
Oliver

> 
> ---
> 
>   net/can/isotp.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 99770ed285..61caf48cf7 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -954,21 +954,18 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
>   		return -EADDRNOTAVAIL;
>   
> -wait_free_buffer:
> -	/* we do not support multiple buffers - for now */
> -	if (wq_has_sleeper(&so->wait) && (msg->msg_flags & MSG_DONTWAIT))
> -		return -EAGAIN;
> +	while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
> +		/* we do not support multiple buffers - for now */
> +		if (msg->msg_flags & MSG_DONTWAIT)
> +			return -EAGAIN;
>   
> -	/* wait for complete transmission of current pdu */
> -	err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
> -	if (err)
> -		goto err_event_drop;
> -
> -	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
>   		if (so->tx.state == ISOTP_SHUTDOWN)
>   			return -EADDRNOTAVAIL;
>   
> -		goto wait_free_buffer;
> +		/* wait for complete transmission of current pdu */
> +		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
> +		if (err)
> +			goto err_event_drop;
>   	}
>   
>   	/* PDU size > default => try max_pdu_size */
