Return-Path: <linux-can+bounces-225-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF518517F3
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 16:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC67283B95
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 15:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97863A8F5;
	Mon, 12 Feb 2024 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YFnxHnXv";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="kQO77l7C"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5E3C47A
	for <linux-can@vger.kernel.org>; Mon, 12 Feb 2024 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751789; cv=pass; b=VFf2seHtFu9GCOgof1wcJaa8WuRjvhAY3/u39QWwVePWt1zFkh7YKnCfQGBQgvL50s48GlBHACvvc9cq4ePRNf8ddOzsua8NwjJWsnKi/HXeAEUi7yyp89kczTBQ92ASaxLgmwR5eppBreqvXx2nlzE96gAJhN1929P01Xd7roQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751789; c=relaxed/simple;
	bh=Nnnoy7NY8z2P8Lf8MsICZbueww4QFbmKtpeKK1ZVJ4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnFZ10pYmqmME0nUGL8khyHOlKC/Vb1iT6LC4+Ip23RK+zsKUBZBHXrrGk5B6PO0tdqgWlyIDf59S3ufXE05DuipB87CjXDc9KyT0yOYpwzg7RO5PXAS6HIn0ASlMej5YSvtyC+xI95bBdoY+LBYDJn+idQWKw6sv6FHoKM74ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YFnxHnXv; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kQO77l7C; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1707751598; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YYW/ItnW6hNhhi5JP0XuAw9hUudd4C8lH4PXoeGNaH+ges7Fh3wlbQjtNTmo4loUOj
    MBfkScP7tvjR06QA8AqkEkzfqkBALLMMoqudKZqbbVLEJRMTEzn75ex0u+qClOPQNXXI
    7yXHUWBG8lzFh5Feccexk4qS2JVRzycAJu+EaskOTrwwkXSQdVwQhSIpPKTrLlmnDtCl
    uc67Kckd3HJGbh4a/1/e0ZJ1IZWtaPFjvKlhAMoM1dN1ELj5dxP/g5q7baC4fw6gF7hT
    XE4xL0ABR0vsJeZXrvF6uokFHdmwzMDFkBWZ8VFRKu05h9ErLWL6hndUUrSPiXK7thIy
    7SmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1707751598;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zEazXys59fLB8Js6V85dei973g54Jnmxuzk7CSdn/YQ=;
    b=mC1fH4XT8waFUBDBLYiTHwSdHbU6QhXa7oRv8sTRoQKoc+1EJdUAoJWUZ168b90Nb4
    HJbsPxCL4rohjpMzqVKbHWkL4RBILsQWWrJWMhOd74RWDjBwjT7Pz0yFH9OIaj72SG+b
    i1+FOlLHEMsrbMN6dBAYWw2hI0sJQwa/gDuCEX4KGoWflkBbPSuJC+gYhEcQtsbAYSkQ
    16vluuwE7zzbACYuHg451Q/SssWiIp2r2KL+8TtFeggEMjrCxrAv8hw3MoYLqblEjBgw
    sc/7LsefT7P2EFvG6g53x9pnqRtMwGPcEj4/8/ILkInwNaC2TEznilBJJRhjhK9jYZF4
    eENA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1707751598;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zEazXys59fLB8Js6V85dei973g54Jnmxuzk7CSdn/YQ=;
    b=YFnxHnXvjzcDbWlI7T9349CS9q55EaYdqt8520bViOuWXdnKFkLrFBUru4c+mnVjSm
    hPz3yCwEetzTgnbpngxD5k2SmnKVV6O93ImZXpBH97I8nWhwmFazFibh6/LIbihvUyNy
    34DsrZXYopsPXCmOGS9O8Wn4Y50Gnzjc6TIgNvF7kl8rgnWCN62Q9mzHOYtTG8KTnKsY
    sBmN0qQfd8KfnartbJS3shKnozWKtFDdcof+IEOfxGjHNUXex7xkg2C+7Bd7NWSALPzU
    UkNUxoWkvWR1TbDvmbaSkwBg7TkhZwX8DrHhtUwv5tEIGanou3hnvRyf2thtIh/7Y52V
    q3Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1707751598;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zEazXys59fLB8Js6V85dei973g54Jnmxuzk7CSdn/YQ=;
    b=kQO77l7CxG3AgdbQbcbSYvwdRbZQ6+PZE5G77j+AKWCJjz+IlbxiFQueFbxG+vZYW8
    Je4/Lz4Jh5tdnCvMpFDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0USEbHoO0g=="
Received: from [IPV6:2a00:6020:4a8e:5010::923]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01CFQcpeT
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 12 Feb 2024 16:26:38 +0100 (CET)
Message-ID: <4a3f3605-6a54-4ca0-9581-eff900e6b169@hartkopp.net>
Date: Mon, 12 Feb 2024 16:26:34 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rework v1] canxl: add virtual CAN network identifier
 support
To: Guy Harris <gharris@sonic.net>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: linux-can@vger.kernel.org
References: <20240212151404.60828-1-socketcan@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20240212151404.60828-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I'm currently in discussion with Guy Harris who's working on the 
Linux-CAN support in Wireshark.

We current have two approaches how to integrate the VCID into the struct 
canxl_frame:

1. Add the VCID at a specific 16 bit offset (above the 11 bit Prio ID)
2. Create a endian-dependent data structure with a separate uint8 VCID

1: 
https://lore.kernel.org/linux-can/20240212151404.60828-1-socketcan@hartkopp.net/
2: 
https://lore.kernel.org/linux-can/20240128183758.68401-1-socketcan@hartkopp.net/

The endian-dependent data structure looks like this:

struct canxl_frame {
#if defined(__LITTLE_ENDIAN)
         __u16 prio;   /* 11 bit priority for arbitration */
         __u8  vcid;   /* virtual CAN network identifier */
         __u8  __res0; /* reserved / padding must be set to zero */
#elif defined(__BIG_ENDIAN)
         __u8  __res0; /* reserved / padding must be set to zero */
         __u8  vcid;   /* virtual CAN network identifier */
         __u16 prio;   /* 11 bit priority for arbitration */
#else
#error "Unknown endianness"
#endif
         __u8  flags;  /* additional flags for CAN XL */
         __u8  sdt;    /* SDU (service data unit) type */
         __u16 len;    /* frame payload length in byte */
         __u32 af;     /* acceptance field */
         __u8  data[CANXL_MAX_DLEN];
};

@Guy: Besides the fact that suggestion 2 does not win a design prize I'm 
not sure whether solution 1 or 2 are better to maintain over lifetime.

Feedback about the two suggestions is highly appreciated.

Many thanks,
Oliver

ps. @Vincent: The reworked patch below includes all the readability and 
typo fixes as well as the code cleanup we have discussed until the V5 
patch of solution 2.

On 12.02.24 16:14, Oliver Hartkopp wrote:
> CAN XL data frames contain an 8-bit virtual CAN network identifier (VCID).
> A VCID value of zero represents an 'untagged' CAN XL frame.
> 
> To receive and send these optional VCIDs via CAN_RAW sockets a new socket
> option CAN_RAW_XL_VCID_OPTS is introduced to define/access VCID content:
> 
> - tx: set the outgoing VCID value by the kernel (one fixed 8-bit value)
> - tx: pass through VCID values from the user space (e.g. for traffic replay)
> - rx: apply VCID receive filter (value/mask) to be passed to the user space
> 
> With the 'tx pass through' option CAN_RAW_XL_VCID_TX_PASS all valid VCID
> values can be sent, e.g. to replay full qualified CAN XL traffic.
> 
> The VCID value provided for the CAN_RAW_XL_VCID_TX_SET option will
> override the VCID value in the struct canxl_frame.prio defined for
> CAN_RAW_XL_VCID_TX_PASS when both flags are set.
> 
> With a rx_vcid_mask of zero all possible VCID values (0x00 - 0xFF) are passed
> to the user space when the CAN_RAW_XL_VCID_RX_FILTER flag is set. Without this
> flag only untagged CAN XL frames (VCID = 0x00, CANXL_VCID flag unset) are
> delivered to the user space.
> 
> The 8-bit VCID is stored inside the CAN XL prio element (only in CAN XL
> frames!) to not interfere with other CAN content or the CAN filters
> provided by the CAN_RAW sockets and kernel infrastruture.
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   include/uapi/linux/can.h     |  9 +++-
>   include/uapi/linux/can/raw.h | 16 +++++++
>   net/can/af_can.c             |  2 +
>   net/can/raw.c                | 93 ++++++++++++++++++++++++++++++++----
>   4 files changed, 110 insertions(+), 10 deletions(-)
> 
> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> index 939db2388208..e78cbd85ce7c 100644
> --- a/include/uapi/linux/can.h
> +++ b/include/uapi/linux/can.h
> @@ -191,23 +191,28 @@ struct canfd_frame {
>    * Undefined bits in canxl_frame.flags are reserved and shall be set to zero.
>    */
>   #define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
>   #define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
>   
> +/* the 8-bit VCID is optionally placed in the canxl_frame.prio element */
> +#define CANXL_VCID_OFFSET 16 /* bit offset of VCID in prio element */
> +#define CANXL_VCID_VAL_MASK 0xFFUL /* VCID is an 8-bit value */
> +#define CANXL_VCID_MASK (CANXL_VCID_VAL_MASK << CANXL_VCID_OFFSET)
> +
>   /**
>    * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame structure
> - * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
> + * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags / VCID
>    * @flags: additional flags for CAN XL
>    * @sdt:   SDU (service data unit) type
>    * @len:   frame payload length in byte (CANXL_MIN_DLEN .. CANXL_MAX_DLEN)
>    * @af:    acceptance field
>    * @data:  CAN XL frame payload (CANXL_MIN_DLEN .. CANXL_MAX_DLEN byte)
>    *
>    * @prio shares the same position as @can_id from struct can[fd]_frame.
>    */
>   struct canxl_frame {
> -	canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
> +	canid_t prio;  /* 11 bit priority for arbitration / 8 bit VCID */
>   	__u8    flags; /* additional flags for CAN XL */
>   	__u8    sdt;   /* SDU (service data unit) type */
>   	__u16   len;   /* frame payload length in byte */
>   	__u32   af;    /* acceptance field */
>   	__u8    data[CANXL_MAX_DLEN];
> diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
> index 31622c9b7988..e024d896e278 100644
> --- a/include/uapi/linux/can/raw.h
> +++ b/include/uapi/linux/can/raw.h
> @@ -63,8 +63,24 @@ enum {
>   	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
>   	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
>   	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
>   	CAN_RAW_JOIN_FILTERS,	/* all filters must match to trigger */
>   	CAN_RAW_XL_FRAMES,	/* allow CAN XL frames (default:off) */
> +	CAN_RAW_XL_VCID_OPTS,	/* CAN XL VCID configuration options */
>   };
>   
> +/* configuration for CAN XL virtual CAN identifier (VCID) handling */
> +struct can_raw_vcid_options {
> +
> +	__u8 flags;		/* flags for vcid (filter) behaviour */
> +	__u8 tx_vcid;		/* VCID value set into canxl_frame.prio */
> +	__u8 rx_vcid;		/* VCID value for VCID filter */
> +	__u8 rx_vcid_mask;	/* VCID mask for VCID filter */
> +
> +};
> +
> +/* can_raw_vcid_options.flags for CAN XL virtual CAN identifier handling */
> +#define CAN_RAW_XL_VCID_TX_SET		0x01
> +#define CAN_RAW_XL_VCID_TX_PASS		0x02
> +#define CAN_RAW_XL_VCID_RX_FILTER	0x04
> +
>   #endif /* !_UAPI_CAN_RAW_H */
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 7343fd487dbe..707576eeeb58 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -863,10 +863,12 @@ static __init int can_init(void)
>   	int err;
>   
>   	/* check for correct padding to be able to use the structs similarly */
>   	BUILD_BUG_ON(offsetof(struct can_frame, len) !=
>   		     offsetof(struct canfd_frame, len) ||
> +		     offsetof(struct can_frame, len) !=
> +		     offsetof(struct canxl_frame, flags) ||
>   		     offsetof(struct can_frame, data) !=
>   		     offsetof(struct canfd_frame, data));
>   
>   	pr_info("can: controller area network core\n");
>   
> diff --git a/net/can/raw.c b/net/can/raw.c
> index e6b822624ba2..cb8e6f788af8 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -89,10 +89,14 @@ struct raw_sock {
>   	struct list_head notifier;
>   	int loopback;
>   	int recv_own_msgs;
>   	int fd_frames;
>   	int xl_frames;
> +	struct can_raw_vcid_options raw_vcid_opts;
> +	canid_t tx_vcid_shifted;
> +	canid_t rx_vcid_shifted;
> +	canid_t rx_vcid_mask_shifted;
>   	int join_filters;
>   	int count;                 /* number of active filters */
>   	struct can_filter dfilter; /* default/single filter */
>   	struct can_filter *filter; /* pointer to filter(s) */
>   	can_err_mask_t err_mask;
> @@ -132,14 +136,33 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
>   	/* check the received tx sock reference */
>   	if (!ro->recv_own_msgs && oskb->sk == sk)
>   		return;
>   
>   	/* make sure to not pass oversized frames to the socket */
> -	if ((!ro->fd_frames && can_is_canfd_skb(oskb)) ||
> -	    (!ro->xl_frames && can_is_canxl_skb(oskb)))
> +	if (!ro->fd_frames && can_is_canfd_skb(oskb))
>   		return;
>   
> +	if (can_is_canxl_skb(oskb)) {
> +		struct canxl_frame *cxl = (struct canxl_frame *)oskb->data;
> +
> +		/* make sure to not pass oversized frames to the socket */
> +		if (!ro->xl_frames)
> +			return;
> +
> +		/* filter CAN XL VCID content */
> +		if (ro->raw_vcid_opts.flags & CAN_RAW_XL_VCID_RX_FILTER) {
> +			/* apply VCID filter if user enabled the filter */
> +			if ((cxl->prio & ro->rx_vcid_mask_shifted) !=
> +			    (ro->rx_vcid_shifted & ro->rx_vcid_mask_shifted))
> +				return;
> +		} else {
> +			/* no filter => do not forward VCID tagged frames */
> +			if (cxl->prio & CANXL_VCID_MASK)
> +				return;
> +		}
> +	}
> +
>   	/* eliminate multiple filter matches for the same skb */
>   	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
>   	    this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
>   		if (!ro->join_filters)
>   			return;
> @@ -696,10 +719,23 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   		/* Enabling CAN XL includes CAN FD */
>   		if (ro->xl_frames)
>   			ro->fd_frames = ro->xl_frames;
>   		break;
>   
> +	case CAN_RAW_XL_VCID_OPTS:
> +		if (optlen != sizeof(ro->raw_vcid_opts))
> +			return -EINVAL;
> +
> +		if (copy_from_sockptr(&ro->raw_vcid_opts, optval, optlen))
> +			return -EFAULT;
> +
> +		/* prepare 32 bit values for handling in hot path */
> +		ro->tx_vcid_shifted = ro->raw_vcid_opts.tx_vcid << CANXL_VCID_OFFSET;
> +		ro->rx_vcid_shifted = ro->raw_vcid_opts.rx_vcid << CANXL_VCID_OFFSET;
> +		ro->rx_vcid_mask_shifted = ro->raw_vcid_opts.rx_vcid_mask << CANXL_VCID_OFFSET;
> +		break;
> +
>   	case CAN_RAW_JOIN_FILTERS:
>   		if (optlen != sizeof(ro->join_filters))
>   			return -EINVAL;
>   
>   		if (copy_from_sockptr(&ro->join_filters, optval, optlen))
> @@ -784,10 +820,25 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>   		if (len > sizeof(int))
>   			len = sizeof(int);
>   		val = &ro->xl_frames;
>   		break;
>   
> +	case CAN_RAW_XL_VCID_OPTS:
> +		/* user space buffer to small for VCID opts? */
> +		if (len < sizeof(ro->raw_vcid_opts)) {
> +			/* return -ERANGE and needed space in optlen */
> +			err = -ERANGE;
> +			if (put_user(sizeof(ro->raw_vcid_opts), optlen))
> +				err = -EFAULT;
> +		} else {
> +			if (len > sizeof(ro->raw_vcid_opts))
> +				len = sizeof(ro->raw_vcid_opts);
> +			if (copy_to_user(optval, &ro->raw_vcid_opts, len))
> +				err = -EFAULT;
> +		}
> +		break;
> +
>   	case CAN_RAW_JOIN_FILTERS:
>   		if (len > sizeof(int))
>   			len = sizeof(int);
>   		val = &ro->join_filters;
>   		break;
> @@ -801,36 +852,55 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>   	if (copy_to_user(optval, val, len))
>   		return -EFAULT;
>   	return 0;
>   }
>   
> -static bool raw_bad_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
> +static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
> +{
> +	struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
> +
> +	/* sanitize non CAN XL bits */
> +	cxl->prio &= (CANXL_PRIO_MASK | CANXL_VCID_MASK);
> +
> +	/* clear VCID in CAN XL frame if pass through is disabled */
> +	if (!(ro->raw_vcid_opts.flags & CAN_RAW_XL_VCID_TX_PASS))
> +		cxl->prio &= CANXL_PRIO_MASK;
> +
> +	/* set VCID in CAN XL frame if enabled */
> +	if (ro->raw_vcid_opts.flags & CAN_RAW_XL_VCID_TX_SET) {
> +		cxl->prio &= CANXL_PRIO_MASK;
> +		cxl->prio |= ro->tx_vcid_shifted;
> +	}
> +}
> +
> +static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
>   {
>   	/* Classical CAN -> no checks for flags and device capabilities */
>   	if (can_is_can_skb(skb))
> -		return false;
> +		return CAN_MTU;
>   
>   	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
>   	if (ro->fd_frames && can_is_canfd_skb(skb) &&
>   	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
> -		return false;
> +		return CANFD_MTU;
>   
>   	/* CAN XL -> needs to be enabled and a CAN XL device */
>   	if (ro->xl_frames && can_is_canxl_skb(skb) &&
>   	    can_is_canxl_dev_mtu(mtu))
> -		return false;
> +		return CANXL_MTU;
>   
> -	return true;
> +	return 0;
>   }
>   
>   static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   {
>   	struct sock *sk = sock->sk;
>   	struct raw_sock *ro = raw_sk(sk);
>   	struct sockcm_cookie sockc;
>   	struct sk_buff *skb;
>   	struct net_device *dev;
> +	unsigned int txmtu;
>   	int ifindex;
>   	int err = -EINVAL;
>   
>   	/* check for valid CAN frame sizes */
>   	if (size < CANXL_HDR_SIZE + CANXL_MIN_DLEN || size > CANXL_MTU)
> @@ -867,13 +937,20 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   	err = memcpy_from_msg(skb_put(skb, size), msg, size);
>   	if (err < 0)
>   		goto free_skb;
>   
>   	err = -EINVAL;
> -	if (raw_bad_txframe(ro, skb, dev->mtu))
> +
> +	/* check for valid CAN (CC/FD/XL) frame content */
> +	txmtu = raw_check_txframe(ro, skb, dev->mtu);
> +	if (!txmtu)
>   		goto free_skb;
>   
> +	/* only CANXL: clear/forward/set VCID value */
> +	if (txmtu == CANXL_MTU)
> +		raw_put_canxl_vcid(ro, skb);
> +
>   	sockcm_init(&sockc, sk);
>   	if (msg->msg_controllen) {
>   		err = sock_cmsg_send(sk, msg, &sockc);
>   		if (unlikely(err))
>   			goto free_skb;

