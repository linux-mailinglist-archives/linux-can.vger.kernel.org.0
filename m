Return-Path: <linux-can+bounces-607-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CF28C137A
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 19:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9941A1C20E3B
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269F7CA73;
	Thu,  9 May 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="wkujqMp/"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37129BE66;
	Thu,  9 May 2024 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274434; cv=none; b=WdaW5mFo3n1pM2KwYcGGzHBpRAM/1Is3aaR8tVofPhkUYU264q3mlkED/o/IwNp2NrLmyoMr/CzGgVbO/QBLBnSoocEAM4xglmUKxzGqVj6mN2irh7viyytb0Ckl9nBvgUDes6sdV2y+2qv1/YPu4dW826uyRbUa97xwke3aUOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274434; c=relaxed/simple;
	bh=qQKzjyL1IQaNjz4xdaWTTRvaaU/1FaYaFQfLT3ip0KI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dVa8BtKx3pGRFCOKm6hdwoZKIOyY76lCS8OOvpLhoHM2HELF1++ljrjDUi2bBqwCqKVONOqenT3CiUQcljWQlddiNaOCoAPrnBk4r4fX9P5U/h7h0cfEBpx5JdJfQjBHMkZR1b38lfQ/mkn+ubON/3IDOnxbEKeS6ZN6+wOy/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=wkujqMp/; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6sDubRW5pa//XJZVbD6tK3oCDuOQT/1HE5H51vxpopc=; b=wkujqMp/Hm0B5uCoxSqtUVKIIM
	k02qQRKfJ1wj5YaA7oNxGnbBgfpwyMDhJ8tropj7ok2OTx2AGHZj6nPYaXYNKSyHC7KjiUC6ojVpD
	iZG9pnF5hSjHgl/69kgLhjIzz2LmOR9SJTgmEnIvW7I0QGyCBSyP4N4RQ5ekdKLvyfTM=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s57ER-001jc1-2q;
	Thu, 09 May 2024 19:07:00 +0200
Message-ID: <e3423e336eceaae2365af9583ee368337272868e.camel@hexdev.de>
Subject: Re: [PATCH v3 08/11] can: bcm: Add LIN answer offloading for
 responder mode
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Oliver Hartkopp
 <socketcan@hartkopp.net>,  Marc Kleine-Budde <mkl@pengutronix.de>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Reichel <sre@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Andreas Lauser
 <andreas.lauser@mercedes-benz.com>,  Jonathan Corbet <corbet@lwn.net>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org,  Netdev
 <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org,  linux-serial <linux-serial@vger.kernel.org>
Date: Thu, 09 May 2024 19:06:58 +0200
In-Reply-To: <48a79803-0fc9-3931-08f1-4b26b4a9ae93@linux.intel.com>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>
	 <20240502182804.145926-9-christoph.fritz@hexdev.de>
	 <48a79803-0fc9-3931-08f1-4b26b4a9ae93@linux.intel.com>
Organization: hexDEV GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-05-06 at 20:08 +0300, Ilpo Järvinen wrote:
> On Thu, 2 May 2024, Christoph Fritz wrote:
> 
> > Enhance CAN broadcast manager with RX_LIN_SETUP and RX_LIN_DELETE
> > operations to setup automatic LIN frame responses in responder mode.
> > 
> > Additionally, the patch introduces the LIN_EVENT_FRAME flag to
> > setup event-triggered LIN frames.
> > 
> > Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> > ---
> >  include/uapi/linux/can/bcm.h |  5 ++-
> >  net/can/bcm.c                | 74 +++++++++++++++++++++++++++++++++++-
> >  2 files changed, 77 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/uapi/linux/can/bcm.h b/include/uapi/linux/can/bcm.h
> > index f1e45f533a72c..c46268a114078 100644
> > --- a/include/uapi/linux/can/bcm.h
> > +++ b/include/uapi/linux/can/bcm.h
> > @@ -86,7 +86,9 @@ enum {
> >  	TX_EXPIRED,	/* notification on performed transmissions (count=0) */
> >  	RX_STATUS,	/* reply to RX_READ request */
> >  	RX_TIMEOUT,	/* cyclic message is absent */
> > -	RX_CHANGED	/* updated CAN frame (detected content change) */
> > +	RX_CHANGED,	/* updated CAN frame (detected content change) */
> > +	RX_LIN_SETUP,	/* create auto-response for LIN frame */
> > +	RX_LIN_DELETE,  /* remove auto-response for LIN frame */
> >  };
> >  
> >  #define SETTIMER            0x0001
> > @@ -101,5 +103,6 @@ enum {
> >  #define TX_RESET_MULTI_IDX  0x0200
> >  #define RX_RTR_FRAME        0x0400
> >  #define CAN_FD_FRAME        0x0800
> > +#define LIN_EVENT_FRAME     0x1000
> >  
> >  #endif /* !_UAPI_CAN_BCM_H */
> > diff --git a/net/can/bcm.c b/net/can/bcm.c
> > index 27d5fcf0eac9d..a717e594234d1 100644
> > --- a/net/can/bcm.c
> > +++ b/net/can/bcm.c
> > @@ -59,6 +59,7 @@
> >  #include <linux/can/bcm.h>
> >  #include <linux/slab.h>
> >  #include <net/sock.h>
> > +#include <net/lin.h>
> >  #include <net/net_namespace.h>
> >  
> >  /*
> > @@ -1330,6 +1331,59 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
> >  	return cfsiz + MHSIZ;
> >  }
> >  
> > +static int bcm_lin_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
> > +			 int ifindex, struct sock *sk, int cfsiz, int is_active)
> > +{
> > +	struct lin_responder_answer answ;
> > +	struct net_device *dev;
> > +	struct sk_buff *skb;
> > +	struct canfd_frame cf;
> > +	netdevice_tracker tracker;
> > +	size_t sz;
> > +	int ret;
> > +
> > +	if (msg_head->nframes > 1)
> > +		return -EINVAL;
> > +
> > +	if (!(msg_head->flags & CAN_FD_FRAME))
> > +		return -EINVAL;
> > +
> > +	ret = memcpy_from_msg(&cf, msg, cfsiz);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	answ.lf.lin_id = cf.can_id & LIN_ID_MASK;
> > +	answ.is_active = is_active;
> > +	answ.is_event_frame = !!(msg_head->flags & LIN_EVENT_FRAME);
> > +	answ.event_associated_id = msg_head->can_id;
> > +	answ.lf.len = min(cf.len, LIN_MAX_DLEN);
> > +	memcpy(answ.lf.data, cf.data, answ.lf.len);
> > +	sz = min(sizeof(struct lin_responder_answer), sizeof(cf.data));
> > +	cf.can_id |= LIN_RXOFFLOAD_DATA_FLAG;
> > +	memcpy(cf.data, &answ, sz);
> > +
> > +	dev = netdev_get_by_index(sock_net(sk), ifindex, &tracker, GFP_KERNEL);
> > +	if (!dev)
> > +		return -ENODEV;
> > +
> > +	skb = alloc_skb(cfsiz + sizeof(struct can_skb_priv), gfp_any());
> 
> You just called the other function with GFP_KERNEL and you now need 
> gfp_any(). Which is correct??

I guess GFP_KERNEL but I'm not sure so I'll let gfp_any() decide for
netdev_get_by_index() too.

> 
> > +	if (!skb)
> > +		goto lin_out;
> > +
> > +	can_skb_reserve(skb);
> > +	can_skb_prv(skb)->ifindex = dev->ifindex;
> > +	can_skb_prv(skb)->skbcnt = 0;
> > +	skb_put_data(skb, &cf, cfsiz);
> > +
> > +	skb->dev = dev;
> > +	can_skb_set_owner(skb, sk);
> > +	ret = can_send(skb, 1); /* send with loopback */
> > +
> > +lin_out:
> > +	netdev_put(dev, &tracker);
> > +	return ret;
> > +}
> > +
> >  /*
> >   * bcm_sendmsg - process BCM commands (opcodes) from the userspace
> >   */
> > @@ -1429,12 +1483,30 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
> >  
> >  	case TX_SEND:
> >  		/* we need exactly one CAN frame behind the msg head */
> > -		if ((msg_head.nframes != 1) || (size != cfsiz + MHSIZ))
> > +		if (msg_head.nframes != 1 || size != cfsiz + MHSIZ)
> 
> Unrelated style fix, doesn't belong to this patch.

OK

...

thanks
  -- Christoph


