Return-Path: <linux-can+bounces-6283-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDIYFNOBc2n2wwAAu9opvQ
	(envelope-from <linux-can+bounces-6283-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 15:12:35 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA12F76C9D
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 15:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5280301BEDE
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 14:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABFA285CBA;
	Fri, 23 Jan 2026 14:12:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869DD29E11D
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177552; cv=none; b=EDhQFEK8QrbyY3qcJbTjYqixy2YFDCMYW3FH4MVR521cdL4JZytCKa7iPGik5BihebcFksCjMk7VlrvKUa4nmwIKTXhtd41Ewe7bGxi1teGiyzc4/vdpGrweIcuAhNOeypZuU2zcYRaKi+bJfIFChJyWVUQ2PSoCCGJqFnvrGB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177552; c=relaxed/simple;
	bh=XZ3Allm8Mx7N0sdDAOQIxOwcD6KanI0C3QnMTFu58h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNkQl83rqh6e2X5Hvb2FpM8HKZUq/4nhddwfTYXCcD2SH0s2QnZMIpQajFfBO4NlXZmVTf7o+EJEhrMgztuYHcKL2h5ECeM0AWigPErnrfIfgDOsSAvJLsRhJYkGIINWQWcIH1u5m9IbCzXUhYyTPwfYQPmXM1bVSDNn6OX7i1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjHtf-000213-IZ; Fri, 23 Jan 2026 15:12:23 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjHtf-0026dp-3D;
	Fri, 23 Jan 2026 15:12:23 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0B3AF4D6F6F;
	Fri, 23 Jan 2026 14:12:23 +0000 (UTC)
Date: Fri, 23 Jan 2026 15:12:22 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mailhol@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH v3 15/15] can: grcan: Update echo skb handling to match
 variable length CANFD frame
Message-ID: <20260123-sepia-marmoset-of-luxury-ad6d1f-mkl@pengutronix.de>
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
 <20260122121038.7910-16-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3llbyhtzvutwjp42"
Content-Disposition: inline
In-Reply-To: <20260122121038.7910-16-arun.muthusamy@gaisler.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6283-lists,linux-can=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA12F76C9D
X-Rspamd-Action: no action


--3llbyhtzvutwjp42
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 15/15] can: grcan: Update echo skb handling to match
 variable length CANFD frame
MIME-Version: 1.0

On 22.01.2026 13:10:38, Arun Muthusamy wrote:
> Refactor echo socket buffer management by introducing dedicated indices
> for current and next echo slots.
>
> - Introduce "echo_skb_idx" to keep track of the current packet index in
>   the echo buffer, and "next_echo_idx" for the next available slot.
> - Adjust memory allocation for echo skb to calculate the number of slots
>   based on slot size.
> - Enhance logic in catch_up_echo_skb() to correctly process and free echo
>   skbs.
> - Initialize "next_echo_idx" in grcan_set_mode() to ensure proper starting
>   conditions when the device enters proper modes.
> - Improve memory and index handling in grcan_start_xmit() and
>   added a check to stop the network queue when necessary.

consider using
netif_subqueue_maybe_stop()/netif_subqueue_completed_wake() from
netdev_queues.h

> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> ---
>  drivers/net/can/grcan.c | 51 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 38 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index 39afb12c50d0..22c86e5d7002 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -298,6 +298,15 @@ struct grcan_priv {
>
>  	struct sk_buff **echo_skb;	/* We allocate this on our own */
>
> +	/*
> +	 * Since the CAN FD frame has a variable length, this variable is used
> +	 * to keep track of the index of the CAN echo skb (socket buffer) frame.
> +	 */
> +	u32 echo_skb_idx;
> +
> +	/* Next echo skb free slot index */
> +	u32 next_echo_idx;
> +
>  	/* The echo skb pointer, pointing into echo_skb and indicating which
>  	 * frames can be echoed back. See the "Notes on the tx cyclic buffer
>  	 * handling"-comment for grcan_start_xmit for more details.
> @@ -578,7 +587,7 @@ static int catch_up_echo_skb(struct net_device *dev, =
int budget, bool echo)
>  	struct grcan_registers __iomem *regs =3D priv->regs;
>  	struct grcan_dma *dma =3D &priv->dma;
>  	struct net_device_stats *stats =3D &dev->stats;
> -	int i, work_done;
> +	int work_done;
>
>  	/* Updates to priv->eskbp and wake-ups of the queue needs to
>  	 * be atomic towards the reads of priv->eskbp and shut-downs
> @@ -589,19 +598,22 @@ static int catch_up_echo_skb(struct net_device *dev=
, int budget, bool echo)
>  	for (work_done =3D 0; work_done < budget || budget < 0; work_done++) {
>  		if (priv->eskbp =3D=3D txrd)
>  			break;
> -		i =3D priv->eskbp / GRCAN_MSG_SIZE;
> -		if (echo) {
> -			/* Normal echo of messages */
> -			stats->tx_packets++;
> -			stats->tx_bytes +=3D can_get_echo_skb(dev, i, NULL);
> -		} else {
> -			/* For cleanup of untransmitted messages */
> -			can_free_echo_skb(dev, i, NULL);
> -		}
>
>  		priv->eskbp =3D grcan_ring_add(priv->eskbp, GRCAN_MSG_SIZE,
>  					     dma->tx.size);
>  		txrd =3D grcan_read_reg(&regs->txrd);
> +
> +		/* Grab the packet once the  packet is send or free untransmitted pack=
et*/
                                           ^^
one space is enough

> +		if (priv->eskbp =3D=3D txrd) {
> +			if (echo) {
> +				/* Normal echo of messages */
> +				stats->tx_packets++;
> +				stats->tx_bytes +=3D can_get_echo_skb(dev, priv->echo_skb_idx, NULL);
> +			} else {
> +				/* For cleanup of untransmitted messages */
> +				can_free_echo_skb(dev, priv->echo_skb_idx, NULL);
> +			}
> +		}
>  	}
>  	return work_done;
>  }
> @@ -1109,6 +1121,7 @@ static int grcan_set_mode(struct net_device *dev, e=
num can_mode mode)
>  			if (!(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
>  				netif_wake_queue(dev);
>  		}
> +		priv->next_echo_idx =3D 0;
>  		spin_unlock_irqrestore(&priv->lock, flags);
>  		return err;
>  	}
> @@ -1120,6 +1133,7 @@ static int grcan_open(struct net_device *dev)
>  	struct grcan_priv *priv =3D netdev_priv(dev);
>  	struct grcan_dma *dma =3D &priv->dma;
>  	unsigned long flags;
> +	u32 nr_echo_slots;
>  	int err;
>
>  	/* Allocate memory */
> @@ -1130,13 +1144,15 @@ static int grcan_open(struct net_device *dev)
>  		return err;
>  	}
>
> -	priv->echo_skb =3D kcalloc(dma->tx.size, sizeof(*priv->echo_skb),
> +	nr_echo_slots =3D  dma->tx.size / GRCAN_MSG_SIZE;
                       ^^
one space is enough

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3llbyhtzvutwjp42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlzgcMACgkQDHRl3/mQ
kZxregf/YwTP7+xCRtPmqqytzwEVpJdSsXgSYreHLI/lTvLJqOgun7+lBKxhcbw4
M9spdwQtDq6UvogCejoSFy00Q2d18PA43y/yslFCQclLnJhryz5g08E45fMB2Byq
p+E7CVq+DixAchypgkT9ElgJRR9UB8gm/u55pluR1NMc7PHBXZTwR8McE52TYXxg
SXS5/thgNUd18oUBr99M0rwGWY7yvxU/3zP0HOcdCe9KHkmFxejAqvF6fIxc4mhn
EQLtSDKRGstlwJvRpakPyo0DlTw985tpvgA8QSV5aMszrVuS7KhpnZ3Gpw5KI8HA
ndkdVAWBldrxdgmJpyL6GIezVfClGQ==
=/uzm
-----END PGP SIGNATURE-----

--3llbyhtzvutwjp42--

