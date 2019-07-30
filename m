Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C977A16F
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2019 08:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfG3GsT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 Jul 2019 02:48:19 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:22752 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfG3GsT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 30 Jul 2019 02:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1564469294;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=JfldhrNdfBAWchTrdjZt9BXoYvUHpHpMPEe36ugsIfs=;
        b=c3g1AOwGO/Spp2eJjyCIsXnO8ZNrQAYarCu0MkvkJbtXiHwZHoylq+++inGwsCiUEX
        Eh9UBQPb+81qq5zwf5+v7NWNMwpT2ygfCuUt8b7E1FLqRqwJI0Nf04qDX5bqmLHbgFBT
        kpSaOSSXbs2v+Ff3dyE1DO14xSJ7ftU5f7C7dVUDPUV18/a6V3GQR28EdC4zcJC73cGM
        a8ZKXlUXhFVKuRiRbJ25dDsy/jpTxahGDkYf+HWh6KgqJ5d5hUe12CLpdUXecEwLWVRq
        1coD59LGWRBKlQXq/LAS4YKrkLF94XopGSAYYrvKNLVVQb1SDC79UkOckHAI0ogHyHsk
        QD9Q==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJUch5mCA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv6U6mAvxz
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 30 Jul 2019 08:48:10 +0200 (CEST)
Subject: Re: [PATCH net-next v2] can: fix ioctl function removal
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     linux-can@vger.kernel.org, sfr@canb.auug.org.au,
        kernel test robot <rong.a.chen@intel.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <20190730064333.1581-1-socketcan@hartkopp.net>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <7aa4fcc3-893b-7251-f305-80f8930e9da6@hartkopp.net>
Date:   Tue, 30 Jul 2019 08:48:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730064333.1581-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

According to Marc the original patch has already been applied by Dave.

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=473d924d7d46cb57aa4c1863261d18366af345af

Thanks for the support & sorry for the noise!

Best regards,
Oliver

On 30/07/2019 08.43, Oliver Hartkopp wrote:
> Commit 60649d4e0af6c26b ("can: remove obsolete empty ioctl() handler") replaced
> the almost empty can_ioctl() function with sock_no_ioctl() which always returns
> -EOPNOTSUPP.
> 
> Even though we don't have any ioctl() functions on socket/network layer we need
> to return -ENOIOCTLCMD to be able to forward ioctl commands like SIOCGIFINDEX
> to the network driver layer.
> 
> This patch fixes the wrong return codes in the CAN network layer protocols.
> 
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Fixes: 60649d4e0af6c26b ("can: remove obsolete empty ioctl() handler")
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
> 
>   v2: Changed SHA1 tag to be a least 12 digits long
> 
>   net/can/bcm.c | 9 ++++++++-
>   net/can/raw.c | 9 ++++++++-
>   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 8da986b19d88..bf1d0bbecec8 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1680,6 +1680,13 @@ static int bcm_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>   	return size;
>   }
>   
> +int bcm_sock_no_ioctlcmd(struct socket *sock, unsigned int cmd,
> +			 unsigned long arg)
> +{
> +	/* no ioctls for socket layer -> hand it down to NIC layer */
> +	return -ENOIOCTLCMD;
> +}
> +
>   static const struct proto_ops bcm_ops = {
>   	.family        = PF_CAN,
>   	.release       = bcm_release,
> @@ -1689,7 +1696,7 @@ static const struct proto_ops bcm_ops = {
>   	.accept        = sock_no_accept,
>   	.getname       = sock_no_getname,
>   	.poll          = datagram_poll,
> -	.ioctl         = sock_no_ioctl,
> +	.ioctl         = bcm_sock_no_ioctlcmd,
>   	.gettstamp     = sock_gettstamp,
>   	.listen        = sock_no_listen,
>   	.shutdown      = sock_no_shutdown,
> diff --git a/net/can/raw.c b/net/can/raw.c
> index ff720272f7b7..da386f1fa815 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -837,6 +837,13 @@ static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>   	return size;
>   }
>   
> +int raw_sock_no_ioctlcmd(struct socket *sock, unsigned int cmd,
> +			 unsigned long arg)
> +{
> +	/* no ioctls for socket layer -> hand it down to NIC layer */
> +	return -ENOIOCTLCMD;
> +}
> +
>   static const struct proto_ops raw_ops = {
>   	.family        = PF_CAN,
>   	.release       = raw_release,
> @@ -846,7 +853,7 @@ static const struct proto_ops raw_ops = {
>   	.accept        = sock_no_accept,
>   	.getname       = raw_getname,
>   	.poll          = datagram_poll,
> -	.ioctl         = sock_no_ioctl,
> +	.ioctl         = raw_sock_no_ioctlcmd,
>   	.gettstamp     = sock_gettstamp,
>   	.listen        = sock_no_listen,
>   	.shutdown      = sock_no_shutdown,
> 
