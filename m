Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ED2525401
	for <lists+linux-can@lfdr.de>; Thu, 12 May 2022 19:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357287AbiELRqb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 May 2022 13:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357251AbiELRqV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 May 2022 13:46:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FFD26130
        for <linux-can@vger.kernel.org>; Thu, 12 May 2022 10:46:14 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1npCt1-0002EN-MC; Thu, 12 May 2022 19:46:03 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1npCt0-0000Xi-IW; Thu, 12 May 2022 19:46:02 +0200
Date:   Thu, 12 May 2022 19:46:02 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, David Jander <david@protonic.nl>,
        Devid Antonio Filoni <devid.filoni@egluetechnologies.com>
Subject: Re: [PATCH v2] can: skb: add extended skb support
Message-ID: <20220512174602.GA10124@pengutronix.de>
References: <20220512125934.774836-1-o.rempel@pengutronix.de>
 <2cc53d1b-2e16-803f-f528-6b94a812d2d7@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2cc53d1b-2e16-803f-f528-6b94a812d2d7@hartkopp.net>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 19:27:44 up 43 days,  5:57, 76 users,  load average: 0.07, 0.10,
 0.14
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

On Thu, May 12, 2022 at 06:54:46PM +0200, Oliver Hartkopp wrote:
> Hi Oleksij,
> 
> On 12.05.22 14:59, Oleksij Rempel wrote:
> > Add CAN specific skb extension support and add first currently needed
> > local_origin variable.
> > 
> > On the CAN stack we push same skb data in different direction depending
> > on the interface type:
> > - to the HW egress and at same time back to the stack as echo
> > - over virtual vcan/vxcan interfaces as egress on one side and ingress on other
> >    side of the vxcan tunnel.
> > We can't use skb->sk as marker of the origin, because not all packets
> > not all packets with local_origin are assigned to some socket. Some of
> > them are generate from the kernel, for example like J1939 control messages.
> > So, to properly detect flow direction is is better to store this information
> > as part of the SKB.
> > 
> > The advantage of using skb_ext is that it is options and extendable
> > without affecting other skb users. It can be shared between cloned skbs and
> > duplicated only if needed.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Cc: Devid Antonio Filoni <devid.filoni@egluetechnologies.com>
> > ---
> > changes v2:
> > - migrate it to SKB_EXT
> 
> The use of SKB_EXT seems to be very costly to just store a boolean value.
> 
> What I could see from some of the other SKB_EXT users this extension (which
> performs alloc & COW) is used in special circumstances.
> 
> With your suggestion this additional effort is needed for every CAN related
> skb.
> 
> So at least for this use-case extending struct can_skb_priv seems to be more
> efficient.
> 
> https://elixir.bootlin.com/linux/latest/source/include/linux/can/skb.h#L44
> 
> We might get into problems with PF_PACKET sockets when extending the
> can_skb_priv length beyond HH_DATA_MOD, see:
> 
> https://elixir.bootlin.com/linux/latest/source/include/linux/can/skb.h#L99
> 
> But for now I'm not sure that SKB_EXT isn't too heavy to store that single
> flag.

Yes, I was thinking about potential overkill for, currently, just one
bit of storage. But here is my motivation:
CAN frameworks is currently using two ways to store metaadata (expecpt
of SKB):
1. skb->cb. This variant is not extendable and can be used only insight
   of one driver.
2. can_skb_priv as part of skb->data->head. Is potentially extendable
   but we will need to use skb_copy instead of skb_clone. Because we
   can't modify head for clone only. IMO, this will add potentially more
   overhead than SKB_EXT.

In long term, as soon as we will need to extend can specific meta
data, we will have same situation: it will be not big enough to migrate
to SKB_EXT. Maybe we need to move can_skb_priv to SKB_EXT as well?


> > 
> >   drivers/net/can/vxcan.c |  4 ++++
> >   include/linux/can/skb.h |  4 ++++
> >   include/linux/skbuff.h  |  3 +++
> >   net/can/Kconfig         |  1 +
> >   net/can/af_can.c        |  5 +++++
> >   net/can/raw.c           | 10 ++++++++--
> >   net/core/skbuff.c       |  7 +++++++
> >   7 files changed, 32 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> > index 577a80300514..93701a698008 100644
> > --- a/drivers/net/can/vxcan.c
> > +++ b/drivers/net/can/vxcan.c
> > @@ -39,6 +39,7 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
> >   	struct net_device *peer;
> >   	struct canfd_frame *cfd = (struct canfd_frame *)oskb->data;
> >   	struct net_device_stats *peerstats, *srcstats = &dev->stats;
> > +	struct can_skb_ext *can_ext;
> >   	struct sk_buff *skb;
> >   	u8 len;
> > @@ -66,6 +67,9 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
> >   	skb->pkt_type   = PACKET_BROADCAST;
> >   	skb->dev        = peer;
> >   	skb->ip_summed  = CHECKSUM_UNNECESSARY;
> > +	can_ext = skb_ext_add(skb, SKB_EXT_CAN);
> > +	if (can_ext)
> > +		can_ext->local_origin = false;
> >   	len = cfd->can_id & CAN_RTR_FLAG ? 0 : cfd->len;
> >   	if (netif_rx(skb) == NET_RX_SUCCESS) {
> > diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> > index fdb22b00674a..401b08890d74 100644
> > --- a/include/linux/can/skb.h
> > +++ b/include/linux/can/skb.h
> > @@ -55,6 +55,10 @@ struct can_skb_priv {
> >   	struct can_frame cf[];
> >   };
> > +struct can_skb_ext {
> > +	bool local_origin;
> > +};
> > +
> >   static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
> >   {
> >   	return (struct can_skb_priv *)(skb->head);
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 3270cb72e4d8..d39e70e5f7f2 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -4563,6 +4563,9 @@ enum skb_ext_id {
> >   #endif
> >   #if IS_ENABLED(CONFIG_MCTP_FLOWS)
> >   	SKB_EXT_MCTP,
> > +#endif
> > +#if IS_ENABLED(CONFIG_CAN)
> > +	SKB_EXT_CAN,
> >   #endif
> >   	SKB_EXT_NUM, /* must be last */
> >   };
> > diff --git a/net/can/Kconfig b/net/can/Kconfig
> > index a9ac5ffab286..eb826e3771fe 100644
> > --- a/net/can/Kconfig
> > +++ b/net/can/Kconfig
> > @@ -5,6 +5,7 @@
> >   menuconfig CAN
> >   	tristate "CAN bus subsystem support"
> > +	select SKB_EXTENSIONS
> >   	help
> >   	  Controller Area Network (CAN) is a slow (up to 1Mbit/s) serial
> >   	  communications protocol. Development of the CAN bus started in
> > diff --git a/net/can/af_can.c b/net/can/af_can.c
> > index 1fb49d51b25d..329c540d3ddf 100644
> > --- a/net/can/af_can.c
> > +++ b/net/can/af_can.c
> > @@ -201,6 +201,7 @@ int can_send(struct sk_buff *skb, int loop)
> >   	struct sk_buff *newskb = NULL;
> >   	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> >   	struct can_pkg_stats *pkg_stats = dev_net(skb->dev)->can.pkg_stats;
> > +	struct can_skb_ext *can_ext;
> >   	int err = -EINVAL;
> >   	if (skb->len == CAN_MTU) {
> > @@ -240,6 +241,10 @@ int can_send(struct sk_buff *skb, int loop)
> >   	skb_reset_network_header(skb);
> >   	skb_reset_transport_header(skb);
> > +	can_ext = skb_ext_add(skb, SKB_EXT_CAN);
> > +	if (can_ext)
> > +		can_ext->local_origin = true;
> > +
> >   	if (loop) {
> >   		/* local loopback of sent CAN frames */
> > diff --git a/net/can/raw.c b/net/can/raw.c
> > index b7dbb57557f3..cba18cdf017f 100644
> > --- a/net/can/raw.c
> > +++ b/net/can/raw.c
> > @@ -121,6 +121,7 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
> >   {
> >   	struct sock *sk = (struct sock *)data;
> >   	struct raw_sock *ro = raw_sk(sk);
> > +	struct can_skb_ext *can_ext;
> >   	struct sockaddr_can *addr;
> >   	struct sk_buff *skb;
> >   	unsigned int *pflags;
> > @@ -173,8 +174,13 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
> >   	/* add CAN specific message flags for raw_recvmsg() */
> >   	pflags = raw_flags(skb);
> >   	*pflags = 0;
> > -	if (oskb->sk)
> > -		*pflags |= MSG_DONTROUTE;
> > +
> > +	can_ext = skb_ext_find(oskb, SKB_EXT_CAN);
> > +	if (can_ext) {
> > +		if (can_ext->local_origin)
> > +			*pflags |= MSG_DONTROUTE;
> > +	}
> > +
> >   	if (oskb->sk == sk)
> >   		*pflags |= MSG_CONFIRM;
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 475183f37891..5a5409ccb767 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -61,6 +61,7 @@
> >   #include <linux/if_vlan.h>
> >   #include <linux/mpls.h>
> >   #include <linux/kcov.h>
> > +#include <linux/can/skb.h>
> >   #include <net/protocol.h>
> >   #include <net/dst.h>
> > @@ -4338,6 +4339,9 @@ static const u8 skb_ext_type_len[] = {
> >   #if IS_ENABLED(CONFIG_MCTP_FLOWS)
> >   	[SKB_EXT_MCTP] = SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
> >   #endif
> > +#if IS_ENABLED(CONFIG_CAN)
> > +	[SKB_EXT_CAN] = SKB_EXT_CHUNKSIZEOF(struct can_skb_ext),
> > +#endif
> >   };
> >   static __always_inline unsigned int skb_ext_total_length(void)
> > @@ -4357,6 +4361,9 @@ static __always_inline unsigned int skb_ext_total_length(void)
> >   #endif
> >   #if IS_ENABLED(CONFIG_MCTP_FLOWS)
> >   		skb_ext_type_len[SKB_EXT_MCTP] +
> > +#endif
> > +#if IS_ENABLED(CONFIG_CAN)
> > +		skb_ext_type_len[SKB_EXT_CAN] +
> >   #endif
> >   		0;
> >   }
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
