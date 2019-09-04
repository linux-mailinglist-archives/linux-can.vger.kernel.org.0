Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4261A80AB
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2019 12:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfIDKtz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Sep 2019 06:49:55 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:35040 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfIDKtz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2019 06:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567594192;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=NZyuFE/LzLGLrfE3YjidBI4bftAxKum6KbQjzWy4Q4Q=;
        b=c6uwxWa7mD7yrvK3ZggwDx4oUpaJ4ntrbVsy+Kq4FEHcqZwNbqnpE1WWrmQBjSwhdg
        gxEj49RZVDTd1sTzNm25gyxu4lPO8ZqhVvOJhmFmhatczFNdWwUeNJk4iAEhbJrkymFz
        OrSPXBl3uEZIhGqjn8gC5aIivc2mE9LYYCsZVPZdZGmZfSrwHIOSS+qTiX7VoP06g9ZZ
        uGTKQ9ittkZhNjJ9pvVeQ2xheW+S3VuSSB5Gmqu9uKAxa2SbFCPTX5Rim/JrnGtfqT0r
        gSVqDrJ8s0PBy4pQxIPlC+IwWRafzSjCBGvg5KOaaJ26ufQ/wZHxjRn36hfM+aaMuwDQ
        SfTA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1q3DbdV+MXxt8X0BVxvFP"
X-RZG-CLASS-ID: mo00
Received: from [172.20.10.6]
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id j0667fv84AnpQUz
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 4 Sep 2019 12:49:51 +0200 (CEST)
Subject: Re: [PATCH v2 18/21] can: introduce CAN_REQUIRED_SIZE macro
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Kurt Van Dijck <kurt.van.dijck@eia.be>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Oleksij Rempel <o.rempel@pengutronix.de>
References: <20190904104405.21675-1-mkl@pengutronix.de>
 <20190904104405.21675-19-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <6ebf3ac9-e18b-d36e-1a4f-bf8629859eaa@hartkopp.net>
Date:   Wed, 4 Sep 2019 12:49:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904104405.21675-19-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 04/09/2019 12.44, Marc Kleine-Budde wrote:
> From: Kurt Van Dijck <kurt.van.dijck@eia.be>
> 
> The size of this structure will be increased with J1939 support. To stay
> binary compatible, the CAN_REQUIRED_SIZE macro is introduced for
> existing CAN protocols.
> 
> Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks,
Oliver

> ---
>   include/linux/can/core.h | 8 ++++++++
>   net/can/bcm.c            | 4 ++--
>   net/can/raw.c            | 4 ++--
>   3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/can/core.h b/include/linux/can/core.h
> index 708c10d3417a..8339071ab08b 100644
> --- a/include/linux/can/core.h
> +++ b/include/linux/can/core.h
> @@ -41,6 +41,14 @@ struct can_proto {
>   	struct proto *prot;
>   };
>   
> +/* required_size
> + * macro to find the minimum size of a struct
> + * that includes a requested member
> + */
> +#define CAN_REQUIRED_SIZE(struct_type, member) \
> +	(offsetof(typeof(struct_type), member) + \
> +	 sizeof(((typeof(struct_type) *)(NULL))->member))
> +
>   /* function prototypes for the CAN networklayer core (af_can.c) */
>   
>   extern int  can_proto_register(const struct can_proto *cp);
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 28fd1a1c8487..c96fa0f33db3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1294,7 +1294,7 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   		/* no bound device as default => check msg_name */
>   		DECLARE_SOCKADDR(struct sockaddr_can *, addr, msg->msg_name);
>   
> -		if (msg->msg_namelen < sizeof(*addr))
> +		if (msg->msg_namelen < CAN_REQUIRED_SIZE(*addr, can_ifindex))
>   			return -EINVAL;
>   
>   		if (addr->can_family != AF_CAN)
> @@ -1536,7 +1536,7 @@ static int bcm_connect(struct socket *sock, struct sockaddr *uaddr, int len,
>   	struct net *net = sock_net(sk);
>   	int ret = 0;
>   
> -	if (len < sizeof(*addr))
> +	if (len < CAN_REQUIRED_SIZE(*addr, can_ifindex))
>   		return -EINVAL;
>   
>   	lock_sock(sk);
> diff --git a/net/can/raw.c b/net/can/raw.c
> index fdbc36140e9b..59c039d73c6d 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -396,7 +396,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>   	int err = 0;
>   	int notify_enetdown = 0;
>   
> -	if (len < sizeof(*addr))
> +	if (len < CAN_REQUIRED_SIZE(*addr, can_ifindex))
>   		return -EINVAL;
>   	if (addr->can_family != AF_CAN)
>   		return -EINVAL;
> @@ -733,7 +733,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   	if (msg->msg_name) {
>   		DECLARE_SOCKADDR(struct sockaddr_can *, addr, msg->msg_name);
>   
> -		if (msg->msg_namelen < sizeof(*addr))
> +		if (msg->msg_namelen < CAN_REQUIRED_SIZE(*addr, can_ifindex))
>   			return -EINVAL;
>   
>   		if (addr->can_family != AF_CAN)
> 
