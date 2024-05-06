Return-Path: <linux-can+bounces-587-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B852D8BD3A2
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 19:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5C21C21782
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 17:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7844156993;
	Mon,  6 May 2024 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ml/O/thn"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B6C1DA21;
	Mon,  6 May 2024 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715015343; cv=none; b=TmtcS8RarlY+jwNod5NhTBPbfuhmeTHLu9dZy2S/7yF6oiFVEr861G1DhG3IarCvis7R1iqsKcqIl96e1hx6+c1hHp+iGlfDQhXOuvD35MQUVj+1DHtp5VK+Ve/jQinaec3IFtIw5KsKUZZrZXEsKKFdxDW9WCqeujOPAB4Qu40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715015343; c=relaxed/simple;
	bh=MmVw+0F4SE674GI2t7dn2j9JYHc4Dcay+HL3ysgg0wc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZMCLjojx+zDBL5qlmleMwccmUgivWxZqVCvy6xffIfwN9Q1bp6x9IKAcIP8IYyuLAXkQofg7xAzQYpHJoWeWRJB+dyn7TFZnQJBHSjXKsmjDHKschH2+s/LBLDbWSS9KUBErFb8GUHhhgRet0fTO1rkT7xYd9YI9iSSeUF4t2S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ml/O/thn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715015342; x=1746551342;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MmVw+0F4SE674GI2t7dn2j9JYHc4Dcay+HL3ysgg0wc=;
  b=ml/O/thnpoc1yef+b7qTLExpyooRUvzgKwr1yB8Yb7Y5/jb6t6rGeqvD
   fLrgzPShYzkhnFr3n9PfJjZWJJzjwWJ6jj4KtUo7EFw6+65qAHqsZKupO
   LTJlykVNCOdQyDaX4rEoUsY7okIZnac+jHsndM5WJsyXWpY9ZSoXJu0fi
   sj4jTyTG4S9QHBnH8HDkphgElRYKprOC59RyxB/ioN+EDhRmxv7VjxH0M
   nPBv1AljtAgTzdLpCqHrocgOBndVfyDcST3rMWpN+r4xhZnLiaz6AewnG
   g9FGVCDS1HMpaJrVc87ItWqsFsxpS5TqvQjkvzl2bExeMbsvHhHqTrtMg
   A==;
X-CSE-ConnectionGUID: wfhmwwJ8RhOGcX0d3p7zuQ==
X-CSE-MsgGUID: ou8Qm294Tl+9kRRyxP+EhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="33279164"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="33279164"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 10:09:02 -0700
X-CSE-ConnectionGUID: m7t/2etwRMOlCDOwKfwv2w==
X-CSE-MsgGUID: CDJL5THESt6i+Mr3mEIqjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="59085676"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.68])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 10:08:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 6 May 2024 20:08:49 +0300 (EEST)
To: Christoph Fritz <christoph.fritz@hexdev.de>
cc: Jiri Slaby <jirislaby@kernel.org>, 
    Oliver Hartkopp <socketcan@hartkopp.net>, 
    Marc Kleine-Budde <mkl@pengutronix.de>, 
    Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
    "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Sebastian Reichel <sre@kernel.org>, 
    Linus Walleij <linus.walleij@linaro.org>, 
    Andreas Lauser <andreas.lauser@mercedes-benz.com>, 
    Jonathan Corbet <corbet@lwn.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
    linux-can@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
    devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3 08/11] can: bcm: Add LIN answer offloading for responder
 mode
In-Reply-To: <20240502182804.145926-9-christoph.fritz@hexdev.de>
Message-ID: <48a79803-0fc9-3931-08f1-4b26b4a9ae93@linux.intel.com>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de> <20240502182804.145926-9-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 2 May 2024, Christoph Fritz wrote:

> Enhance CAN broadcast manager with RX_LIN_SETUP and RX_LIN_DELETE
> operations to setup automatic LIN frame responses in responder mode.
> 
> Additionally, the patch introduces the LIN_EVENT_FRAME flag to
> setup event-triggered LIN frames.
> 
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> ---
>  include/uapi/linux/can/bcm.h |  5 ++-
>  net/can/bcm.c                | 74 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 77 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/can/bcm.h b/include/uapi/linux/can/bcm.h
> index f1e45f533a72c..c46268a114078 100644
> --- a/include/uapi/linux/can/bcm.h
> +++ b/include/uapi/linux/can/bcm.h
> @@ -86,7 +86,9 @@ enum {
>  	TX_EXPIRED,	/* notification on performed transmissions (count=0) */
>  	RX_STATUS,	/* reply to RX_READ request */
>  	RX_TIMEOUT,	/* cyclic message is absent */
> -	RX_CHANGED	/* updated CAN frame (detected content change) */
> +	RX_CHANGED,	/* updated CAN frame (detected content change) */
> +	RX_LIN_SETUP,	/* create auto-response for LIN frame */
> +	RX_LIN_DELETE,  /* remove auto-response for LIN frame */
>  };
>  
>  #define SETTIMER            0x0001
> @@ -101,5 +103,6 @@ enum {
>  #define TX_RESET_MULTI_IDX  0x0200
>  #define RX_RTR_FRAME        0x0400
>  #define CAN_FD_FRAME        0x0800
> +#define LIN_EVENT_FRAME     0x1000
>  
>  #endif /* !_UAPI_CAN_BCM_H */
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 27d5fcf0eac9d..a717e594234d1 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -59,6 +59,7 @@
>  #include <linux/can/bcm.h>
>  #include <linux/slab.h>
>  #include <net/sock.h>
> +#include <net/lin.h>
>  #include <net/net_namespace.h>
>  
>  /*
> @@ -1330,6 +1331,59 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
>  	return cfsiz + MHSIZ;
>  }
>  
> +static int bcm_lin_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
> +			 int ifindex, struct sock *sk, int cfsiz, int is_active)
> +{
> +	struct lin_responder_answer answ;
> +	struct net_device *dev;
> +	struct sk_buff *skb;
> +	struct canfd_frame cf;
> +	netdevice_tracker tracker;
> +	size_t sz;
> +	int ret;
> +
> +	if (msg_head->nframes > 1)
> +		return -EINVAL;
> +
> +	if (!(msg_head->flags & CAN_FD_FRAME))
> +		return -EINVAL;
> +
> +	ret = memcpy_from_msg(&cf, msg, cfsiz);
> +	if (ret < 0)
> +		return ret;
> +
> +	answ.lf.lin_id = cf.can_id & LIN_ID_MASK;
> +	answ.is_active = is_active;
> +	answ.is_event_frame = !!(msg_head->flags & LIN_EVENT_FRAME);
> +	answ.event_associated_id = msg_head->can_id;
> +	answ.lf.len = min(cf.len, LIN_MAX_DLEN);
> +	memcpy(answ.lf.data, cf.data, answ.lf.len);
> +	sz = min(sizeof(struct lin_responder_answer), sizeof(cf.data));
> +	cf.can_id |= LIN_RXOFFLOAD_DATA_FLAG;
> +	memcpy(cf.data, &answ, sz);
> +
> +	dev = netdev_get_by_index(sock_net(sk), ifindex, &tracker, GFP_KERNEL);
> +	if (!dev)
> +		return -ENODEV;
> +
> +	skb = alloc_skb(cfsiz + sizeof(struct can_skb_priv), gfp_any());

You just called the other function with GFP_KERNEL and you now need 
gfp_any(). Which is correct??

> +	if (!skb)
> +		goto lin_out;
> +
> +	can_skb_reserve(skb);
> +	can_skb_prv(skb)->ifindex = dev->ifindex;
> +	can_skb_prv(skb)->skbcnt = 0;
> +	skb_put_data(skb, &cf, cfsiz);
> +
> +	skb->dev = dev;
> +	can_skb_set_owner(skb, sk);
> +	ret = can_send(skb, 1); /* send with loopback */
> +
> +lin_out:
> +	netdev_put(dev, &tracker);
> +	return ret;
> +}
> +
>  /*
>   * bcm_sendmsg - process BCM commands (opcodes) from the userspace
>   */
> @@ -1429,12 +1483,30 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  
>  	case TX_SEND:
>  		/* we need exactly one CAN frame behind the msg head */
> -		if ((msg_head.nframes != 1) || (size != cfsiz + MHSIZ))
> +		if (msg_head.nframes != 1 || size != cfsiz + MHSIZ)

Unrelated style fix, doesn't belong to this patch.

>  			ret = -EINVAL;
>  		else
>  			ret = bcm_tx_send(msg, ifindex, sk, cfsiz);
>  		break;
>  
> +	case RX_LIN_SETUP:
> +		/* we need exactly one CAN frame behind the msg head */
> +		if (msg_head.nframes != 1 || size != cfsiz + MHSIZ)
> +			ret = -EINVAL;
> +		else
> +			ret = bcm_lin_setup(&msg_head, msg, ifindex, sk, cfsiz,
> +					    1);
> +		break;
> +
> +	case RX_LIN_DELETE:
> +		/* we need exactly one CAN frame behind the msg head */
> +		if (msg_head.nframes != 1 || size != cfsiz + MHSIZ)
> +			ret = -EINVAL;
> +		else
> +			ret = bcm_lin_setup(&msg_head, msg, ifindex, sk, cfsiz,
> +					    0);
> +		break;
> +
>  	default:
>  		ret = -EINVAL;
>  		break;
> 

-- 
 i.


