Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A1D786178
	for <lists+linux-can@lfdr.de>; Wed, 23 Aug 2023 22:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjHWU1C (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Aug 2023 16:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbjHWU0r (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Aug 2023 16:26:47 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D2A1A5
        for <linux-can@vger.kernel.org>; Wed, 23 Aug 2023 13:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692822402; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pFQBpL+Y6uV9yR1uy0NFeEur2nInDmAjUR6jTRQuboZO1A2BrP3HceBjZZsulOIzFv
    Egdtq1pLdepsCsV2W44uNIQJ41DUkWYY++ysxUE5rh06OoZ6W4WN58FKP4ljLrPoYEPM
    USP0KaMrq31ZjHM4ZT6NonsdY7GKQ6incGvG4F6I6BKmsyuJmrc9rB/SWDj6NH3HB5oL
    U9wat2J+mXjD6xZCdMhY83gw9A2yuRwNEJZNkR3xhbzcPCtoBcuieB5ULmpKQwiu4io4
    eeZ4zw4w+JNzRy5QyuGP2vvKODg/5rHr4dKzaCnE+vs8sAFFpEnm8oPoSGJL1lUYuAN/
    nXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692822402;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wuqn2CqTA1ibdm8UBlU488CxR400PSEYwirxZZk7280=;
    b=XvN3xFFoUUqkttBKwNIsPUTssA+0nfV+zA4PjWX3E6/CsjnyyPsyAu2Yyy2Ll03+eM
    R0d5xHKvlLK0yY9eEbEOZ64TWuNTWVLgbXqR9/EGkxHTHN2CUUs8YxbLsu9pdpXpz1uC
    GoTYTQRyl/ZKbZ+bBAq/INzltJhUHeeFPIfdSDkLnQcRcZ0pyxYZ6N8d3FlUUXg1qPwS
    QkT3P6PsTGbiUfFhYqyhbF7KPckjXrki2YgkADQ7dzt9IQe/v957UqXE7kVLEQSbICMj
    s7skAKEDS3K0d8/8PGCbHonW2hwj0f7/sqHVVzyeXfYINHIdsm8uL3wAFCkj3Hf6xwsm
    tjcg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692822402;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wuqn2CqTA1ibdm8UBlU488CxR400PSEYwirxZZk7280=;
    b=Df5+y+RT3zkT+cFzBSYSbDYsJVIfRhrygK2HqGoDk22M5RrapHTPWv/3Zs22avkl09
    KyO9Pth9Moqd4aEDtsZ8h/1p/xNMivwKg/BnQOLEZFHFatnT7acb2F2uYErVuUTZPdM4
    gW/lCqdUJPbJ2Zj/Ospb0sMsY3jOQ5ZIwjeTYP8tp9qbYI0Df/zbPMz8rC2N2061ndEL
    vg7+nYrD5oYEa2/OBHrJyjEz7EsFQb+5YeOtW/qps8YjaBW9gKOoe+FW6p3sePBfq7Mm
    iG7H6BydsA62KlJzMGg8W9uyhD8GpFYATDc+cfuOcmj0nLdwz0mSqL0OclheD56D6SAp
    OGBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692822402;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wuqn2CqTA1ibdm8UBlU488CxR400PSEYwirxZZk7280=;
    b=3jcLeBxCgenkuJYsStRH7vbA0Swa0DOw+4ekoDXK5u9wZJ3t9G07SMMjRAAfAmEJLG
    BPx993V2a0czqlJmX7Dg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USKM0piYgo2RPibaP8l+kwVcqIglg=="
Received: from [IPV6:2a00:6020:4a8e:5000:4f94:2675:a144:19cf]
    by smtp.strato.de (RZmta 49.8.1 AUTH)
    with ESMTPSA id K723f1z7NKQg6fx
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 23 Aug 2023 22:26:42 +0200 (CEST)
Message-ID: <d68f9c32-77b6-f763-01b3-f9cde2214ed0@hartkopp.net>
Date:   Wed, 23 Aug 2023 22:26:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] can: isotp: isotp_sendmsg(): fix TX state detection and
 wait behavior
To:     Lukas Magel <lukas.magel@posteo.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Michal Sojka <michal.sojka@cvut.cz>,
        Maxime Jayat <maxime.jayat@mobile-devices.fr>
Cc:     linux-can@vger.kernel.org
References: <20230818114345.142983-1-lukas.magel@posteo.net>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230818114345.142983-1-lukas.magel@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Just to comment inside this patch and not on a second thread at

https://lore.kernel.org/linux-can/04fd32bc-b1c4-b9c3-3f8b-7987704a1f85@hartkopp.net/T/#m25dc4514fb03cbe3f4b72b570a22d63a42ccbf5e

On 2023-08-18 13:43, Lukas Magel wrote:
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
> The patch also takes a direct exit if the wait is interrupted before
> changing so->tx.state. Previously, the code jumped to err_event_drop,
> resetting so->tx.state.
> 
> [1] https://lore.kernel.org/all/20230331125511.372783-1-michal.sojka@cvut.cz
> 
> Reported-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>
> Closes: https://lore.kernel.org/linux-can/11328958-453f-447f-9af8-3b5824dfb041@munic.io/
> Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
> 
> ---
> ---
>   net/can/isotp.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 99770ed285..653cdb93f5 100644
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
> +			return err;

NAK. Please use the former

if (err)
         goto err_event_drop;

here.

Best regards,
Oliver

>   	}
>   
>   	/* PDU size > default => try max_pdu_size */
