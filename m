Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590DC687DAE
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 13:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjBBMoc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 07:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjBBMoZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 07:44:25 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1818BDDC
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 04:43:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675341793; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=V+6HJBi3RgQnWu4PioyfeBYwqrNvBDpgRixLDaZWhbHidAmAxhMf/zZzJwGT149R/+
    A7EMDpYSAXmWBB1VHAcgbSnz5BacjwkmGFSV9cddtgWsU+LHJtzqb2aUBS4sLss33LrA
    VB7Izh2lI+sjLO/hRmJTIYchrJPUyk58Yy40rVPe099YdJfd9IH/j1E1bC6Bui4Kw4II
    TnAjdkfMpnatZeNgs4Yla9eO3RmAwZs1m2x6bxXh9SESHCUj+97ToKL4kcuIThqyTYtR
    sjCl+QYb795AvrUIKbr3K4qHARxy1OJRyLhWoPJ81GZjA9ZTAUikoSZqfQk05e+17iYj
    go5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675341793;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=omknhUDNxd3d2m9tT/tP2FBVOFQf0FzZvdetFL870qE=;
    b=LHrt7CPCDBkDiVUeMozLJfYoZjMS8BdlzDhoJ64w9nSEck9nkNGPuXAjE0bKsbETpz
    MPTQwmWJ4nresHSUDc6EDGIkrxdXyuX4OrWSF23Xdnz2nIZZDgmcJTJmmy8xJp/8TZjQ
    LLNskVqT7Fk86zG+q4HCbMLKMZpT1yCK9LpJOH32p7L9ON0Gm6pJiSia4sXyds7jU1aH
    qWElVY3+8huFhwL9hm07AlxsorkcZo5Br4D7BrL3r3vlDtex7HtCdCwDF0CA9qZ5kqYf
    /0uyRj5y19hPu6t9hFMwVc4SD2LhD7G4+HNaJvRwYW4z4ZK7mEPFQOWQ3HrZF40HpsbL
    dlvw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675341793;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=omknhUDNxd3d2m9tT/tP2FBVOFQf0FzZvdetFL870qE=;
    b=iYCbO2vVMowxocOx43y0uvUcu6GAcZCmVy4nHdOX8Sf452GJ02cgPE2RkpuFmJ/pv4
    k1RdQjJpXxvioK9HlzWSBEmsdT8RUd/HNhryXOxMXGJvbKNwX9cxEg8/CJ+v0rgCxmrh
    aD8sYj7Kwh/Ux668I+06EJmh4J5cgx40mmCU2yyz3p3qcFIBmfmkpyiHiLjKGNhKmA42
    w4aQKHnoyM+I+xqQbL0Qer+aYe0X3HnwcnbMGRbgPqx7f4CWODSfCgO+f9Ys99ou/8He
    Nedub34fQrVFNe/pkL+gX/aaTI32/tn3TOXWRy1a96HsG/Jb7c63ZA7PYDX0FFUCUTXI
    jPaA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1q3jXdVqE32oRVrGn+Gi68g=="
Received: from [100.82.11.11]
    by smtp.strato.de (RZmta 49.2.2 AUTH)
    with ESMTPSA id qa71b9z12ChCRey
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 2 Feb 2023 13:43:12 +0100 (CET)
Message-ID: <b71b8544-7e55-b86e-a32c-7ebdc0e4ea78@hartkopp.net>
Date:   Thu, 2 Feb 2023 13:43:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH net 2/5] can: raw: fix CAN FD frame transmissions over CAN
 XL devices
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20230202094135.2293939-1-mkl@pengutronix.de>
 <20230202094135.2293939-3-mkl@pengutronix.de>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230202094135.2293939-3-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

you asked me to introduce a new variable instead of rolling back the 
ro->fd_frames setting in setsockopt.

I just wondered why you didn't pick the V4 patch then:

https://lore.kernel.org/linux-can/20230131112657.59247-1-socketcan@hartkopp.net/T/#u

It has no functional drawback but I was able to add an error return code 
in V4. I just wanted to know.

Best regards,
Oliver


On 02.02.23 10:41, Marc Kleine-Budde wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> A CAN XL device is always capable to process CAN FD frames. The former
> check when sending CAN FD frames relied on the existence of a CAN FD
> device and did not check for a CAN XL device that would be correct
> too.
> 
> With this patch the CAN FD feature is enabled automatically when CAN
> XL is switched on - and CAN FD cannot be switch off while CAN XL is
> enabled.
> 
> This precondition also leads to a clean up and reduction of checks in
> the hot path in raw_rcv() and raw_sendmsg(). Some conditions are
> reordered to handle simple checks first.
> 
> changes since v1: https://lore.kernel.org/all/20230131091012.50553-1-socketcan@hartkopp.net
> - fixed typo: devive -> device
> changes since v2: https://lore.kernel.org/all/20230131091824.51026-1-socketcan@hartkopp.net/
> - reorder checks in if statements to handle simple checks first
> 
> Fixes: 626332696d75 ("can: raw: add CAN XL support")
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Link: https://lore.kernel.org/all/20230131105613.55228-1-socketcan@hartkopp.net
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   net/can/raw.c | 47 +++++++++++++++++++++++++++++++----------------
>   1 file changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 81071cdb0301..ba86782ba8bb 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -132,8 +132,8 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
>   		return;
>   
>   	/* make sure to not pass oversized frames to the socket */
> -	if ((can_is_canfd_skb(oskb) && !ro->fd_frames && !ro->xl_frames) ||
> -	    (can_is_canxl_skb(oskb) && !ro->xl_frames))
> +	if ((!ro->fd_frames && can_is_canfd_skb(oskb)) ||
> +	    (!ro->xl_frames && can_is_canxl_skb(oskb)))
>   		return;
>   
>   	/* eliminate multiple filter matches for the same skb */
> @@ -670,6 +670,11 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   		if (copy_from_sockptr(&ro->fd_frames, optval, optlen))
>   			return -EFAULT;
>   
> +		/* Enabling CAN XL includes CAN FD */
> +		if (ro->xl_frames && !ro->fd_frames) {
> +			ro->fd_frames = ro->xl_frames;
> +			return -EINVAL;
> +		}
>   		break;
>   
>   	case CAN_RAW_XL_FRAMES:
> @@ -679,6 +684,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   		if (copy_from_sockptr(&ro->xl_frames, optval, optlen))
>   			return -EFAULT;
>   
> +		/* Enabling CAN XL includes CAN FD */
> +		if (ro->xl_frames)
> +			ro->fd_frames = ro->xl_frames;
>   		break;
>   
>   	case CAN_RAW_JOIN_FILTERS:
> @@ -786,6 +794,25 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>   	return 0;
>   }
>   
> +static bool raw_bad_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
> +{
> +	/* Classical CAN -> no checks for flags and device capabilities */
> +	if (can_is_can_skb(skb))
> +		return false;
> +
> +	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
> +	if (ro->fd_frames && can_is_canfd_skb(skb) &&
> +	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
> +		return false;
> +
> +	/* CAN XL -> needs to be enabled and a CAN XL device */
> +	if (ro->xl_frames && can_is_canxl_skb(skb) &&
> +	    can_is_canxl_dev_mtu(mtu))
> +		return false;
> +
> +	return true;
> +}
> +
>   static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   {
>   	struct sock *sk = sock->sk;
> @@ -833,20 +860,8 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   		goto free_skb;
>   
>   	err = -EINVAL;
> -	if (ro->xl_frames && can_is_canxl_dev_mtu(dev->mtu)) {
> -		/* CAN XL, CAN FD and Classical CAN */
> -		if (!can_is_canxl_skb(skb) && !can_is_canfd_skb(skb) &&
> -		    !can_is_can_skb(skb))
> -			goto free_skb;
> -	} else if (ro->fd_frames && dev->mtu == CANFD_MTU) {
> -		/* CAN FD and Classical CAN */
> -		if (!can_is_canfd_skb(skb) && !can_is_can_skb(skb))
> -			goto free_skb;
> -	} else {
> -		/* Classical CAN */
> -		if (!can_is_can_skb(skb))
> -			goto free_skb;
> -	}
> +	if (raw_bad_txframe(ro, skb, dev->mtu))
> +		goto free_skb;
>   
>   	sockcm_init(&sockc, sk);
>   	if (msg->msg_controllen) {
