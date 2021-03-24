Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A030D348224
	for <lists+linux-can@lfdr.de>; Wed, 24 Mar 2021 20:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbhCXTr1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 24 Mar 2021 15:47:27 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:50594 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237930AbhCXTrV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Mar 2021 15:47:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F229A60A3588;
        Wed, 24 Mar 2021 20:47:19 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MPWbdyruf1r2; Wed, 24 Mar 2021 20:47:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9148960A0E19;
        Wed, 24 Mar 2021 20:47:19 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9tXp6jET54E4; Wed, 24 Mar 2021 20:47:19 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6DD7F60A0723;
        Wed, 24 Mar 2021 20:47:19 +0100 (CET)
Date:   Wed, 24 Mar 2021 20:47:19 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc:     linux-can <linux-can@vger.kernel.org>
Message-ID: <972595778.112313.1616615239337.JavaMail.zimbra@nod.at>
In-Reply-To: <20210324192746.GA7408@x1.vandijck-laurijssen.be>
References: <1883346738.111675.1616599858539.JavaMail.zimbra@nod.at> <20210324190104.GB3342@x1.vandijck-laurijssen.be> <1135648123.112255.1616613706554.JavaMail.zimbra@nod.at> <20210324192746.GA7408@x1.vandijck-laurijssen.be>
Subject: Re: PATCH: Breaking UAPI change?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: PATCH: Breaking UAPI change?
Thread-Index: eJ7i3wjaNjDddPEDkEt2BR/uTgRDKw==
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Kurt,

----- Ursprüngliche Mail -----
> Happy testing?

;-)

 
> commit 124900109ca88d29382ef2e2b848d3a2f9d67b98
> Author: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> Date:   Wed Mar 24 20:08:50 2021
> 
>    can raw: don't increase provided name length
>    
>    The length of the buffer is known by the application,
>    not the kernel. Kernel is supposed to return only the
>    size of used bytes.
>    There is a minimum required size for the struct sockaddr_can
>    to be usefull for can_raw, so errors are returned when
>    the provided size is lower
>    
>    Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 6ec8aa1d0da4..00d352ae221e 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -475,7 +475,7 @@ static int raw_getname(struct socket *sock, struct sockaddr
> *uaddr,
> 	if (peer)
> 		return -EOPNOTSUPP;
> 
> -	memset(addr, 0, sizeof(*addr));
> +	memset(addr, 0, CAN_REQUIRED_SIZE(*addr, ifindex));

can_ifindex?

> 	addr->can_family  = AF_CAN;
> 	addr->can_ifindex = ro->ifindex;
> 
> @@ -806,6 +806,10 @@ static int raw_recvmsg(struct socket *sock, struct msghdr
> *msg, size_t size,
> 		return sock_recv_errqueue(sk, msg, size,
> 					  SOL_CAN_RAW, SCM_CAN_RAW_ERRQUEUE);
> 
> +	if (msg->name && msg->msg_namelen <

msg->msg_name?

> +			CAN_REQUIRED_SIZE(struct sockaddr_can, ifindex))
> +		return -EINVAL;
> +

With the above changes this -EINVAL always triggers.
msg->msg_namelen is 0 in my case.

The application does:
socklen_t addrlen = sizeof(struct sockaddr_can);
recvfrom(s, &frame, sizeof(struct can_frame), 0, (struct sockaddr *)&addr, &addrlen);

Thanks,
//richard
