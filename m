Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1474F5792E9
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 08:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbiGSGAW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 02:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbiGSGAV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 02:00:21 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAAA19C23
        for <linux-can@vger.kernel.org>; Mon, 18 Jul 2022 23:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658210418;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=x6s51DKrhEhetcRXxYzshbjaSJX/HA1UBXxeTlR+BFo=;
    b=OWa4svfa/E5OyH02Wwk0E1zm9si1AcFaoDoJhDrDTVbWFJc4FL0iPD8rgwKBwozWLD
    TnSapGi81pIuAhD6Ch6vSilt9ZIhDPmMCZ3+IuSMK11Z6uEvjNtEvz9kEpdAuuhxhLPM
    bhHlg7s09GnlGQTKe3i1PohxLkwc1w4zJBQQhfoecXob5smbHcKUYV+537Dm5JT5Bmaq
    gj8v8au+/WgKjNcoTxoZ3eYztVS00gmMG32bDbt6qlnx0L2wu2AvJq0fSrN8TKyxNYWd
    2twwLSe2ykAl3pUTO6ziwdTQHDYGQM0FVMbY2rgCnLAg/AQSSl2cK1d70IDrMPn29VM9
    VbYg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6J60IF8T
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
    for <linux-can@vger.kernel.org>;
    Tue, 19 Jul 2022 08:00:18 +0200 (CEST)
Message-ID: <e331e579-26d6-a672-19b2-0050c81af2c1@hartkopp.net>
Date:   Tue, 19 Jul 2022 08:00:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v4 5/5] can: raw: add CAN XL support
Content-Language: en-US
To:     linux-can <linux-can@vger.kernel.org>
References: <20220719054204.29061-1-socketcan@hartkopp.net>
 <20220719054204.29061-6-socketcan@hartkopp.net>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220719054204.29061-6-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Moving the 'err = -EINVAL;' was correct but introduced a missing 
initialization for sock_alloc_send_skb() failure :-/

Will fix in V5.

Regards,
Oliver

diff --git a/net/can/raw.c b/net/can/raw.c
index 48b9499d13a4..9153957391a9 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -797,11 +797,11 @@ static int raw_sendmsg(struct socket *sock, struct 
msghdr *msg, size_t size)
         struct sockcm_cookie sockc;
         struct sk_buff *skb;
         struct net_device *dev;
         unsigned int skb_sz = size;
         int ifindex;
-       int err;
+       int err = -EINVAL;

         /* valid CAN frame sizes */
         if (size < CANXL_HDR_SZ + CANXL_MIN_DLEN || size > CANXL_MTU)
                 return -EINVAL;




On 19.07.22 07:42, Oliver Hartkopp wrote:
> Enable CAN_RAW sockets to read and write CAN XL frames analogue to the
> CAN FD extension (new CAN_RAW_XL_FRAMES sockopt).
> 
> A CAN XL network interface is capable to handle Classical CAN, CAN FD and
> CAN XL frames. When CAN_RAW_XL_FRAMES is enabled, the CAN_RAW socket checks
> whether the addressed CAN network interface is capable to handle the
> provided CAN frame.
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   include/uapi/linux/can/raw.h |  6 +++
>   net/can/raw.c                | 97 +++++++++++++++++++++++++++++++-----
>   2 files changed, 90 insertions(+), 13 deletions(-)
> 
> diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
> index 3386aa81fdf2..5a0e480887ff 100644
> --- a/include/uapi/linux/can/raw.h
> +++ b/include/uapi/linux/can/raw.h
> @@ -60,8 +60,14 @@ enum {
>   	CAN_RAW_ERR_FILTER,	/* set filter for error frames       */
>   	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
>   	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
>   	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
>   	CAN_RAW_JOIN_FILTERS,	/* all filters must match to trigger */
> +	CAN_RAW_XL_FRAMES,	/* allow CAN XL frames (default:off) */
>   };
>   
> +/* CAN XL data transfer modes for CAN_RAW_XL_FRAMES sockopt */
> +#define CAN_RAW_XL_ENABLE (1 << 0) /* enable CAN XL frames on this socket */
> +#define CAN_RAW_XL_RX_DYN (1 << 1) /* enable truncated data[] for read() */
> +#define CAN_RAW_XL_TX_DYN (1 << 2) /* enable truncated data[] for write() */
> +
>   #endif /* !_UAPI_CAN_RAW_H */
> diff --git a/net/can/raw.c b/net/can/raw.c
> index d1bd9cc51ebe..48b9499d13a4 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -85,10 +85,11 @@ struct raw_sock {
>   	int ifindex;
>   	struct list_head notifier;
>   	int loopback;
>   	int recv_own_msgs;
>   	int fd_frames;
> +	int xl_frames;
>   	int join_filters;
>   	int count;                 /* number of active filters */
>   	struct can_filter dfilter; /* default/single filter */
>   	struct can_filter *filter; /* pointer to filter(s) */
>   	can_err_mask_t err_mask;
> @@ -127,12 +128,13 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
>   
>   	/* check the received tx sock reference */
>   	if (!ro->recv_own_msgs && oskb->sk == sk)
>   		return;
>   
> -	/* do not pass non-CAN2.0 frames to a legacy socket */
> -	if (!ro->fd_frames && oskb->len != CAN_MTU)
> +	/* make sure to not pass oversized frames to the socket */
> +	if ((oskb->len > CAN_MTU && !ro->fd_frames && !ro->xl_frames) ||
> +	    (oskb->len == CANXL_MTU && !ro->xl_frames))
>   		return;
>   
>   	/* eliminate multiple filter matches for the same skb */
>   	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
>   	    this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
> @@ -344,10 +346,11 @@ static int raw_init(struct sock *sk)
>   
>   	/* set default loopback behaviour */
>   	ro->loopback         = 1;
>   	ro->recv_own_msgs    = 0;
>   	ro->fd_frames        = 0;
> +	ro->xl_frames        = 0;
>   	ro->join_filters     = 0;
>   
>   	/* alloc_percpu provides zero'ed memory */
>   	ro->uniq = alloc_percpu(struct uniqframe);
>   	if (unlikely(!ro->uniq))
> @@ -667,10 +670,23 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   		if (copy_from_sockptr(&ro->fd_frames, optval, optlen))
>   			return -EFAULT;
>   
>   		break;
>   
> +	case CAN_RAW_XL_FRAMES:
> +		if (optlen != sizeof(ro->xl_frames))
> +			return -EINVAL;
> +
> +		if (copy_from_sockptr(&ro->xl_frames, optval, optlen))
> +			return -EFAULT;
> +
> +		/* sanitize flags */
> +		if (ro->xl_frames & (CAN_RAW_XL_RX_DYN | CAN_RAW_XL_TX_DYN))
> +			ro->xl_frames |= CAN_RAW_XL_ENABLE;
> +
> +		break;
> +
>   	case CAN_RAW_JOIN_FILTERS:
>   		if (optlen != sizeof(ro->join_filters))
>   			return -EINVAL;
>   
>   		if (copy_from_sockptr(&ro->join_filters, optval, optlen))
> @@ -749,10 +765,16 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>   		if (len > sizeof(int))
>   			len = sizeof(int);
>   		val = &ro->fd_frames;
>   		break;
>   
> +	case CAN_RAW_XL_FRAMES:
> +		if (len > sizeof(int))
> +			len = sizeof(int);
> +		val = &ro->xl_frames;
> +		break;
> +
>   	case CAN_RAW_JOIN_FILTERS:
>   		if (len > sizeof(int))
>   			len = sizeof(int);
>   		val = &ro->join_filters;
>   		break;
> @@ -773,13 +795,18 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   	struct sock *sk = sock->sk;
>   	struct raw_sock *ro = raw_sk(sk);
>   	struct sockcm_cookie sockc;
>   	struct sk_buff *skb;
>   	struct net_device *dev;
> +	unsigned int skb_sz = size;
>   	int ifindex;
>   	int err;
>   
> +	/* valid CAN frame sizes */
> +	if (size < CANXL_HDR_SZ + CANXL_MIN_DLEN || size > CANXL_MTU)
> +		return -EINVAL;
> +
>   	if (msg->msg_name) {
>   		DECLARE_SOCKADDR(struct sockaddr_can *, addr, msg->msg_name);
>   
>   		if (msg->msg_namelen < RAW_MIN_NAMELEN)
>   			return -EINVAL;
> @@ -794,20 +821,15 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   
>   	dev = dev_get_by_index(sock_net(sk), ifindex);
>   	if (!dev)
>   		return -ENXIO;
>   
> -	err = -EINVAL;
> -	if (ro->fd_frames && dev->mtu == CANFD_MTU) {
> -		if (unlikely(size != CANFD_MTU && size != CAN_MTU))
> -			goto put_dev;
> -	} else {
> -		if (unlikely(size != CAN_MTU))
> -			goto put_dev;
> -	}
> +	/* alloc full CAN XL space */
> +	if (ro->xl_frames && dev->mtu == CANXL_MTU)
> +		skb_sz = CANXL_MTU;
>   
> -	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
> +	skb = sock_alloc_send_skb(sk, skb_sz + sizeof(struct can_skb_priv),
>   				  msg->msg_flags & MSG_DONTWAIT, &err);
>   	if (!skb)
>   		goto put_dev;
>   
>   	can_skb_reserve(skb);
> @@ -816,10 +838,49 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   
>   	err = memcpy_from_msg(skb_put(skb, size), msg, size);
>   	if (err < 0)
>   		goto free_skb;
>   
> +	err = -EINVAL;
> +
> +	if (ro->xl_frames && dev->mtu == CANXL_MTU) {
> +		struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
> +
> +		if (cfx->flags & CANXL_XLF) {
> +			/* check for valid CAN XL frame */
> +			if (cfx->len < CANXL_MIN_DLEN ||
> +			    cfx->len > CANXL_MAX_DLEN)
> +			goto free_skb;
> +
> +			if (ro->xl_frames & CAN_RAW_XL_TX_DYN) {
> +				/* check truncated CAN XL frame structure */
> +				if (size != cfx->len + CANXL_HDR_SZ)
> +					goto free_skb;
> +
> +				/* push skb->len to CANXL_MTU */
> +				if (size < CANXL_MTU)
> +					skb_put_zero(skb, CANXL_MTU - size);
> +			} else {
> +				/* check complete CAN XL frame structure */
> +				if (size != CANXL_MTU)
> +					goto free_skb;
> +			}
> +		} else {
> +			/* check for CAN FD and Classical CAN */
> +			if (unlikely(size != CANFD_MTU && size != CAN_MTU))
> +				goto free_skb;
> +		}
> +	} else if (ro->fd_frames && dev->mtu == CANFD_MTU) {
> +		/* CAN FD and Classical CAN */
> +		if (unlikely(size != CANFD_MTU && size != CAN_MTU))
> +			goto free_skb;
> +	} else {
> +		/* Classical CAN */
> +		if (unlikely(size != CAN_MTU))
> +			goto free_skb;
> +	}
> +
>   	sockcm_init(&sockc, sk);
>   	if (msg->msg_controllen) {
>   		err = sock_cmsg_send(sk, msg, &sockc);
>   		if (unlikely(err))
>   			goto free_skb;
> @@ -850,25 +911,35 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   
>   static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>   		       int flags)
>   {
>   	struct sock *sk = sock->sk;
> +	struct raw_sock *ro = raw_sk(sk);
>   	struct sk_buff *skb;
> +	struct canxl_frame *cfx;
> +	unsigned int rx_len;
>   	int err = 0;
>   
>   	if (flags & MSG_ERRQUEUE)
>   		return sock_recv_errqueue(sk, msg, size,
>   					  SOL_CAN_RAW, SCM_CAN_RAW_ERRQUEUE);
>   
>   	skb = skb_recv_datagram(sk, flags, &err);
>   	if (!skb)
>   		return err;
>   
> -	if (size < skb->len)
> +	rx_len = skb->len;
> +	if (rx_len == CANXL_MTU && ro->xl_frames & CAN_RAW_XL_RX_DYN) {
> +		cfx = (struct canxl_frame *)skb->data;
> +		if (cfx->len >= CANXL_MIN_DLEN && cfx->len < CANXL_MAX_DLEN)
> +			rx_len = CANXL_HDR_SZ + cfx->len;
> +	}
> +
> +	if (size < rx_len)
>   		msg->msg_flags |= MSG_TRUNC;
>   	else
> -		size = skb->len;
> +		size = rx_len;
>   
>   	err = memcpy_to_msg(msg, skb->data, size);
>   	if (err < 0) {
>   		skb_free_datagram(sk, skb);
>   		return err;
