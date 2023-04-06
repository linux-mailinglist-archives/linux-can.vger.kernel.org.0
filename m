Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9F56D9507
	for <lists+linux-can@lfdr.de>; Thu,  6 Apr 2023 13:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjDFLZW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Apr 2023 07:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbjDFLZV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Apr 2023 07:25:21 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FA383F7
        for <linux-can@vger.kernel.org>; Thu,  6 Apr 2023 04:25:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680780315; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZtU6jHOL/HPRrltdUxo51uE4VDStglr8Kwn1FTP+IUxwif8pc/nXKGmL5lLtnmDtDr
    OwBR/GRx2aYvEjc5XdKiotzeSfbehSfADG2YHW+/w1MgR20gsybZqqemUZ7HeIakySoc
    ZuNRcDyaqNuyQt9Ryp8CdmuFKBatE7LBiOglRUlYHrPjCU2z4DnJ9g6ri2Ky7dW+b1Wy
    6gEb1jnKymptup8h9b48bwnrq4k6CLgm54gqoMbu0UZQ/1Yy/Z58zR4YrK7nO6RViZRf
    FxMM0YW04hxnCBwKQMYTW3U7mRMkwCf+aqiOmZ6Gid3KYeVDqszrYcmj0EPvKGFlpmsU
    9S/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680780315;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0FL8R4SRWIeqjjNp/T3E7ReFpI45y5bthXHfCvUofes=;
    b=oU+P+pasK9Yt6ZyiQi6tskjpzh1uwY33pA1M3Z9Gg1ksi+zgUM6g4hhWbcWB63kpl7
    cFGxha7LsxzH1dNOW0g3ruXCw+pt36FMF9QULu79NlXiA2QsLUZAMu0yjKjLTgR3W3Lp
    Md7HHhu3ernoN5Q4mUofFO7McDjYBiYhLopbTP1X6MvbdRdAhQm9+mVm19+l0Jzvk693
    pRhV910iziCQjGhEB0tohWWvQizi37g5QY1Lnp2YRgrZWPL/CgJobeOciwpS4l3MF1jF
    OwshaR+x8bUHqqbYvf5GXqOu1mXPgHbClpkM019NS14894SvwMOYhysEIG0MoTu5HxFy
    fb1w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680780315;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0FL8R4SRWIeqjjNp/T3E7ReFpI45y5bthXHfCvUofes=;
    b=fC11QlbF+QIDsg7ZWb7f1fk1r82fpnEobyzF9ZO8fBJNAuea3Sz4trx1eVKwst7q0E
    +6y0lgI0oQHdmr0WvTZaRV89llCTFr4682e1dOOCTwNZ+sKQ8h/6pqQ5Qh0Y9ExzcUvC
    uYvSmRDpJgFSZ9nZ5kqYPLMGdNymr7szK9HCHqPNlV+8KVN+yLnSpoiL8coc7IidcgkC
    mX/O21s9ZAVFf4WqCittxfC4alJqnazti5i6cY8xy4G2scpN4h3dn8i+r+EuM5a8f5Hy
    4JVCZ3EpTmmlmwd0CacL4oyrpdWy35Dp9/E1C38zao/GY5XYuqz+Z00iWbckgd/akIPm
    sGcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1680780315;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0FL8R4SRWIeqjjNp/T3E7ReFpI45y5bthXHfCvUofes=;
    b=Jujs5STRXrfJojob2pMGCil62IF7aGKLkE7vZfQN2hHYeLqWvNDgMQVQfPfH6dVOqy
    0x8cEbtEBKRhyAis17Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.4.0 AUTH)
    with ESMTPSA id x06214z36BPF8qp
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 6 Apr 2023 13:25:15 +0200 (CEST)
Message-ID: <dbf2020b-98bc-9ca2-ed54-8f86bdb99ee8@hartkopp.net>
Date:   Thu, 6 Apr 2023 13:25:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] can: allow MSG_CMSG_COMPAT flag in recvmsg() syscalls
To:     linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
References: <20230406110845.5180-1-socketcan@hartkopp.net>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230406110845.5180-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

I should probably split this into two patches when thinking of stable 
kernels.

E.g. we have to handle two "Fixes:" tags here:

Fixes: 42bf50a1795a ("can: isotp: support MSG_TRUNC flag when reading 
from socket")

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

@Oleksij: Can you please check if adding this flag is fine for you too - 
and if you can "ack" it?

Thanks,
Oliver

On 06.04.23 13:08, Oliver Hartkopp wrote:
> The control messages provided by j1939 and isotp support MSG_CMSG_COMPAT
> but blocked recvmsg() syscalls that have set this flag, e.g. on 32bit
> ARM systems.
> 
> Link: https://github.com/hartkopp/can-isotp/issues/59
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   net/can/isotp.c        | 2 +-
>   net/can/j1939/socket.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 9bc344851704..fd0e297a8584 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1099,11 +1099,11 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>   	struct sock *sk = sock->sk;
>   	struct sk_buff *skb;
>   	struct isotp_sock *so = isotp_sk(sk);
>   	int ret = 0;
>   
> -	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK))
> +	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK | MSG_CMSG_COMPAT))
>   		return -EINVAL;
>   
>   	if (!so->bound)
>   		return -EADDRNOTAVAIL;
>   
> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 7e90f9e61d9b..1790469b2580 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -796,11 +796,11 @@ static int j1939_sk_recvmsg(struct socket *sock, struct msghdr *msg,
>   	struct sock *sk = sock->sk;
>   	struct sk_buff *skb;
>   	struct j1939_sk_buff_cb *skcb;
>   	int ret = 0;
>   
> -	if (flags & ~(MSG_DONTWAIT | MSG_ERRQUEUE))
> +	if (flags & ~(MSG_DONTWAIT | MSG_ERRQUEUE | MSG_CMSG_COMPAT))
>   		return -EINVAL;
>   
>   	if (flags & MSG_ERRQUEUE)
>   		return sock_recv_errqueue(sock->sk, msg, size, SOL_CAN_J1939,
>   					  SCM_J1939_ERRQUEUE);
