Return-Path: <linux-can+bounces-6142-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D74B1D1E542
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 12:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3823301B80C
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 11:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB8D38E5F1;
	Wed, 14 Jan 2026 11:11:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA34D393DC2
	for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389069; cv=none; b=WiJo/cYKNSgK6JdmqG0cac+c13mkwgcijj0DbH9Idg2V57pdQqPwuP4zgGni49nwfGR58LlM/oGTfWNC9LpTqhqPpJFctQsj0vpARV1WUDFAoLWkemox5Uc7J5cf4zSZnpVeRkzihvpi6qGkQKwlHWHzu4MVGhmYzFw0DeKmWCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389069; c=relaxed/simple;
	bh=w+p7EAgJ1oDAf7NRZ/VmHVrqYW/Jgd3OQBcXUx5bKTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C63ZnTY6jxzhsrU0xBUEhHOzziDs901OrL0VuQlnd4N+XmiYTBZgnT1CIMpHfDsFnFjSqhLQjFaTzyW9IpKJJotHagjT2mfuLhjhCjgxnwJRxUzVlB4u8qQ1dTxneujp9XwoxW3J6M06I7OMtuC/fMqjFLD0EWNH9zpSrm+mqtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vfymA-0001hv-Dm; Wed, 14 Jan 2026 12:10:58 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vfymA-000ZxT-1N;
	Wed, 14 Jan 2026 12:10:57 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vfym9-00000006mp0-2rH6;
	Wed, 14 Jan 2026 12:10:57 +0100
Date: Wed, 14 Jan 2026 12:10:57 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Vincent Mailhol <mailhol@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, davem@davemloft.net
Subject: Re: [can-next 0/5] can: remove private skb headroom infrastructure
Message-ID: <aWd5wdMhpEuN9NFB@pengutronix.de>
References: <20260112150908.5815-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260112150908.5815-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hi Oliver,

On Mon, Jan 12, 2026 at 04:09:03PM +0100, Oliver Hartkopp wrote:
> CAN bus related skbuffs (ETH_P_CAN/ETH_P_CANFD/ETH_P_CANXL) simply contain
> CAN frame structs for CAN CC/FD/XL of skb->len length at skb->data.
> Those CAN skbs do not have network/mac/transport headers nor other such
> references for encapsulated protocols like ethernet/IP protocols.
>
> To store data for CAN specific use-cases all CAN bus related skbuffs are
> created with a 16 byte private skb headroom (struct can_skb_priv).
> Using the skb headroom and accessing skb->head for this private data
> led to several problems in the past likely due to "The struct can_skb_priv
> business is highly unconventional for the networking stack." [1]
>
> This patch set aims to remove the unconventional skb headroom usage for
> CAN bus related skbuffs. To store the data for CAN specific use-cases
> unused space in CAN skbs is used, namely the inner protocol space for
> ethernet/IP encapsulation.
>
> [1] https://lore.kernel.org/linux-can/20260104074222.29e660ac@kernel.org/
>
> Oliver Hartkopp (5):
>   can: use skb hash instead of private variable in headroom
>   can: move can_iif from private headroom to struct sk_buff
>   can: move frame length from private headroom to struct sk_buff
>   can: remove private skb headroom infrastructure
>   can: gw: use new can_gw_hops variable instead of re-using csum_start
>
>  drivers/net/can/dev/skb.c | 45 ++++++++++++++++-----------------------
>  include/linux/can/core.h  |  1 +
>  include/linux/can/skb.h   | 33 ----------------------------
>  include/linux/skbuff.h    | 27 +++++++++++++++++------
>  net/can/af_can.c          | 35 +++++++++++++++++++-----------
>  net/can/bcm.c             | 13 ++++-------
>  net/can/gw.c              | 25 ++++++----------------
>  net/can/isotp.c           | 18 ++++++----------
>  net/can/j1939/socket.c    |  7 ++----
>  net/can/j1939/transport.c | 13 ++++-------
>  net/can/raw.c             | 14 ++++++------
>  11 files changed, 92 insertions(+), 139 deletions(-)

J1939 related part seems to work without regressions.
For j1939:
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Best Regards,
Oleksij

