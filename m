Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429C5348BDB
	for <lists+linux-can@lfdr.de>; Thu, 25 Mar 2021 09:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhCYIr2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Mar 2021 04:47:28 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:50780 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhCYIrR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Mar 2021 04:47:17 -0400
X-ASG-Debug-ID: 1616662035-15c4354a946d1a00001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.176.adsl.dyn.edpnet.net [77.109.77.176]) by relay-b03.edpnet.be with ESMTP id 8nEt3pECRc3zGi2G; Thu, 25 Mar 2021 09:47:15 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.176.adsl.dyn.edpnet.net[77.109.77.176]
X-Barracuda-Apparent-Source-IP: 77.109.77.176
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 9338B12F8A2B;
        Thu, 25 Mar 2021 09:47:15 +0100 (CET)
Date:   Thu, 25 Mar 2021 09:47:14 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2] [RFC] can: fix msg_namelen values depending on
 CAN_REQUIRED_SIZE
Message-ID: <20210325084714.GE8446@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH v2] [RFC] can: fix msg_namelen values depending on
 CAN_REQUIRED_SIZE
Mail-Followup-To: Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Richard Weinberger <richard@nod.at>
References: <20210325081326.1652-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210325081326.1652-1-socketcan@hartkopp.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.77.176.adsl.dyn.edpnet.net[77.109.77.176]
X-Barracuda-Start-Time: 1616662035
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 8093
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.88769
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Acked-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

On Thu, 25 Mar 2021 09:13:26 +0100, Oliver Hartkopp wrote:
> Since commit f5223e9eee65 ("can: extend sockaddr_can to include j1939
> members") the sockaddr_can has been extended in size and a new
> CAN_REQUIRED_SIZE macro has been introduced to calculate the protocol
> specific needed size.
> 
> The ABI for the msg_name and msg_namelen has not been adapted to the
> new CAN_REQUIRED_SIZE macro for the other CAN protocols which leads
> to a problem when an existing binary reads the (increased)
> struct sockaddr_can in msg_name.
> 
> Fixes: f5223e9eee65 ("can: extend sockaddr_can to include j1939 members")
> Link: https://lore.kernel.org/linux-can/1135648123.112255.1616613706554.JavaMail.zimbra@nod.at/T/#t
> Reported-by: Richard Weinberger <richard@nod.at>
> Suggested-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  net/can/bcm.c   | 10 ++++++----
>  net/can/isotp.c | 11 +++++++----
>  net/can/raw.c   | 14 ++++++++------
>  3 files changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 0e5c37be4a2b..909b9e684e04 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -84,10 +84,12 @@
>  MODULE_DESCRIPTION("PF_CAN broadcast manager protocol");
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_AUTHOR("Oliver Hartkopp <oliver.hartkopp@volkswagen.de>");
>  MODULE_ALIAS("can-proto-2");
>  
> +#define BCM_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_ifindex)
> +
>  /*
>   * easy access to the first 64 bit of can(fd)_frame payload. cp->data is
>   * 64 bit aligned so the offset has to be multiples of 8 which is ensured
>   * by the only callers in bcm_rx_cmp_to_index() bcm_rx_handler().
>   */
> @@ -1290,11 +1292,11 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  
>  	if (!ifindex && msg->msg_name) {
>  		/* no bound device as default => check msg_name */
>  		DECLARE_SOCKADDR(struct sockaddr_can *, addr, msg->msg_name);
>  
> -		if (msg->msg_namelen < CAN_REQUIRED_SIZE(*addr, can_ifindex))
> +		if (msg->msg_namelen < BCM_MIN_NAMELEN)
>  			return -EINVAL;
>  
>  		if (addr->can_family != AF_CAN)
>  			return -EINVAL;
>  
> @@ -1532,11 +1534,11 @@ static int bcm_connect(struct socket *sock, struct sockaddr *uaddr, int len,
>  	struct sock *sk = sock->sk;
>  	struct bcm_sock *bo = bcm_sk(sk);
>  	struct net *net = sock_net(sk);
>  	int ret = 0;
>  
> -	if (len < CAN_REQUIRED_SIZE(*addr, can_ifindex))
> +	if (len < BCM_MIN_NAMELEN)
>  		return -EINVAL;
>  
>  	lock_sock(sk);
>  
>  	if (bo->bound) {
> @@ -1614,12 +1616,12 @@ static int bcm_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>  	}
>  
>  	sock_recv_ts_and_drops(msg, sk, skb);
>  
>  	if (msg->msg_name) {
> -		__sockaddr_check_size(sizeof(struct sockaddr_can));
> -		msg->msg_namelen = sizeof(struct sockaddr_can);
> +		__sockaddr_check_size(BCM_MIN_NAMELEN);
> +		msg->msg_namelen = BCM_MIN_NAMELEN;
>  		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
>  	}
>  
>  	skb_free_datagram(sk, skb);
>  
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 3ef7f78e553b..86945dbb6c76 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -75,10 +75,12 @@
>  MODULE_DESCRIPTION("PF_CAN isotp 15765-2:2016 protocol");
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_AUTHOR("Oliver Hartkopp <socketcan@hartkopp.net>");
>  MODULE_ALIAS("can-proto-6");
>  
> +#define ISOTP_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_addr.tp)
> +
>  #define SINGLE_MASK(id) (((id) & CAN_EFF_FLAG) ? \
>  			 (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG) : \
>  			 (CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG))
>  
>  /* ISO 15765-2:2016 supports more than 4095 byte per ISO PDU as the FF_DL can
> @@ -987,11 +989,12 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>  	}
>  
>  	sock_recv_timestamp(msg, sk, skb);
>  
>  	if (msg->msg_name) {
> -		msg->msg_namelen = sizeof(struct sockaddr_can);
> +		__sockaddr_check_size(ISOTP_MIN_NAMELEN);
> +		msg->msg_namelen = ISOTP_MIN_NAMELEN;
>  		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
>  	}
>  
>  	skb_free_datagram(sk, skb);
>  
> @@ -1057,11 +1060,11 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>  	struct net_device *dev;
>  	int err = 0;
>  	int notify_enetdown = 0;
>  	int do_rx_reg = 1;
>  
> -	if (len < CAN_REQUIRED_SIZE(struct sockaddr_can, can_addr.tp))
> +	if (len < ISOTP_MIN_NAMELEN)
>  		return -EINVAL;
>  
>  	/* do not register frame reception for functional addressing */
>  	if (so->opt.flags & CAN_ISOTP_SF_BROADCAST)
>  		do_rx_reg = 0;
> @@ -1153,17 +1156,17 @@ static int isotp_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
>  	struct isotp_sock *so = isotp_sk(sk);
>  
>  	if (peer)
>  		return -EOPNOTSUPP;
>  
> -	memset(addr, 0, sizeof(*addr));
> +	memset(addr, 0, ISOTP_MIN_NAMELEN);
>  	addr->can_family = AF_CAN;
>  	addr->can_ifindex = so->ifindex;
>  	addr->can_addr.tp.rx_id = so->rxid;
>  	addr->can_addr.tp.tx_id = so->txid;
>  
> -	return sizeof(*addr);
> +	return ISOTP_MIN_NAMELEN;
>  }
>  
>  static int isotp_setsockopt(struct socket *sock, int level, int optname,
>  			    sockptr_t optval, unsigned int optlen)
>  {
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 37b47a39a3ed..139d9471ddcf 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -58,10 +58,12 @@
>  MODULE_DESCRIPTION("PF_CAN raw protocol");
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_AUTHOR("Urs Thuermann <urs.thuermann@volkswagen.de>");
>  MODULE_ALIAS("can-proto-1");
>  
> +#define RAW_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_ifindex)
> +
>  #define MASK_ALL 0
>  
>  /* A raw socket has a list of can_filters attached to it, each receiving
>   * the CAN frames matching that filter.  If the filter list is empty,
>   * no CAN frames will be received by the socket.  The default after
> @@ -392,11 +394,11 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>  	struct raw_sock *ro = raw_sk(sk);
>  	int ifindex;
>  	int err = 0;
>  	int notify_enetdown = 0;
>  
> -	if (len < CAN_REQUIRED_SIZE(*addr, can_ifindex))
> +	if (len < RAW_MIN_NAMELEN)
>  		return -EINVAL;
>  	if (addr->can_family != AF_CAN)
>  		return -EINVAL;
>  
>  	lock_sock(sk);
> @@ -473,15 +475,15 @@ static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
>  	struct raw_sock *ro = raw_sk(sk);
>  
>  	if (peer)
>  		return -EOPNOTSUPP;
>  
> -	memset(addr, 0, sizeof(*addr));
> +	memset(addr, 0, RAW_MIN_NAMELEN);
>  	addr->can_family  = AF_CAN;
>  	addr->can_ifindex = ro->ifindex;
>  
> -	return sizeof(*addr);
> +	return RAW_MIN_NAMELEN;
>  }
>  
>  static int raw_setsockopt(struct socket *sock, int level, int optname,
>  			  sockptr_t optval, unsigned int optlen)
>  {
> @@ -737,11 +739,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  	int err;
>  
>  	if (msg->msg_name) {
>  		DECLARE_SOCKADDR(struct sockaddr_can *, addr, msg->msg_name);
>  
> -		if (msg->msg_namelen < CAN_REQUIRED_SIZE(*addr, can_ifindex))
> +		if (msg->msg_namelen < RAW_MIN_NAMELEN)
>  			return -EINVAL;
>  
>  		if (addr->can_family != AF_CAN)
>  			return -EINVAL;
>  
> @@ -830,12 +832,12 @@ static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>  	}
>  
>  	sock_recv_ts_and_drops(msg, sk, skb);
>  
>  	if (msg->msg_name) {
> -		__sockaddr_check_size(sizeof(struct sockaddr_can));
> -		msg->msg_namelen = sizeof(struct sockaddr_can);
> +		__sockaddr_check_size(RAW_MIN_NAMELEN);
> +		msg->msg_namelen = RAW_MIN_NAMELEN;
>  		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
>  	}
>  
>  	/* assign the flags that have been recorded in raw_rcv() */
>  	msg->msg_flags |= *(raw_flags(skb));
> -- 
> 2.30.2
> 
