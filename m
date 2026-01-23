Return-Path: <linux-can+bounces-6285-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK6EOuCEc2kDxAAAu9opvQ
	(envelope-from <linux-can+bounces-6285-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 15:25:36 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC0477010
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 15:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18BC0301E7FD
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C91A930;
	Fri, 23 Jan 2026 14:25:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B113B5AE
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178333; cv=none; b=IN4Be4VpkPaqwAHz11JQ8jX7DWiQLAPzANtwi+N7DCQbASPYqfb+4aR/xFHnBW7hAmEMwXHRdHvKEv0Ei9Wc+mUexCPxWwSHXbJiBvR+/qRwdLz05409n7VFcrOrEhdtkNWqZLes3C2/KVHFr+LKYoqgF3Ma3/H5+t41XKY9WHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178333; c=relaxed/simple;
	bh=fbJTvAegLNy8obdD3xIT8wnMQVwN8ckpnOiiBgFcdxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4oYgKKwRjiX6GVFpEGkdNjbqiSLsKgE3D7Ck765p4Ub8uJk7+DDDh8Wjp3yc0BBHUzXx6bar1jTvT6WcC39ZP5STf1q1q1a6fKexRINkC3YOc7Q3J+VVMqlrOhCzYHJG5d2KSQOCOFgU0Algw0xAgptNsBh6nTb2QZzsLf2gKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjI6F-0003sz-HL; Fri, 23 Jan 2026 15:25:23 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjI6F-0026hu-3C;
	Fri, 23 Jan 2026 15:25:23 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 088F54D6F96;
	Fri, 23 Jan 2026 14:25:23 +0000 (UTC)
Date: Fri, 23 Jan 2026 15:25:22 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mailhol@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH v3 13/15] can: grcan: Add CANFD TX support alongside
 legacy CAN
Message-ID: <20260123-berserk-crocodile-of-champagne-49d2b0-mkl@pengutronix.de>
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
 <20260122121038.7910-14-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gfzuvzgifz5pg42n"
Content-Disposition: inline
In-Reply-To: <20260122121038.7910-14-arun.muthusamy@gaisler.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6285-lists,linux-can=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 6AC0477010
X-Rspamd-Action: no action


--gfzuvzgifz5pg42n
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 13/15] can: grcan: Add CANFD TX support alongside
 legacy CAN
MIME-Version: 1.0

On 22.01.2026 13:10:36, Arun Muthusamy wrote:
> Include CANFD TX support with the legacy CAN support, enabling
> support for extended data payloads to provide higher bit rates.
>
> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> ---
>  drivers/net/can/grcan.c | 102 +++++++++++++++++++++++++++++-----------
>  1 file changed, 74 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index 9fc18064fab1..508ad5320cff 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -174,6 +174,7 @@ struct grcan_registers {
>  #define GRCAN_IRQ_DEFAULT (GRCAN_IRQ_RX | GRCAN_IRQ_TX | GRCAN_IRQ_ERROR=
S)
>
>  #define GRCAN_MSG_SIZE		16
> +#define GRCAN_CLASSIC_DATA_SIZE 8
>
>  #define GRCAN_MSG_IDE		0x80000000
>  #define GRCAN_MSG_RTR		0x40000000
> @@ -195,6 +196,10 @@ struct grcan_registers {
>  #define GRCAN_MSG_OFF		0x00000002
>  #define GRCAN_MSG_PASS		0x00000001
>
> +#define GRCAN_MSG_EID_MASK      GENMASK(28, 0)
> +#define GRCAN_MSG_BID_MASK      GENMASK(28, 18)
> +#define GRCAN_MSG_DLC_MASK      GENMASK(31, 28)
> +
>  #define GRCAN_BUFFER_ALIGNMENT		1024
>  #define GRCAN_DEFAULT_BUFFER_SIZE	1024
>  #define GRCAN_VALID_TR_SIZE_MASK	0x001fffc0
> @@ -227,6 +232,9 @@ struct grcan_registers {
>  #define GRCANFD_FDBTR_PS2_BIT 5
>  #define GRCANFD_FDBTR_SJW_BIT 0
>
> +#define GRCAN_TX_BRS  BIT(25)
> +#define GRCAN_TX_FDF  BIT(26)
> +
>  /* Hardware capabilities */
>  struct grcan_hwcap {
>  	/* CAN-FD capable, indicates GRCANFD IP.
> @@ -1218,6 +1226,13 @@ static void grcan_transmit_catch_up(struct net_dev=
ice *dev)
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  }
>
> +static int grcan_numbds(int len)
> +{
> +	if (len <=3D GRCAN_CLASSIC_DATA_SIZE)
> +		return 1;
> +	return 1 + ((len - GRCAN_CLASSIC_DATA_SIZE + GRCAN_MSG_SIZE) / GRCAN_MS=
G_SIZE);

This looks strange, what is calculated here? Why is "<=3D
GRCAN_CLASSIC_DATA_SIZE" a special case?

> +}
> +
>  static int grcan_receive(struct net_device *dev, int budget)
>  {
>  	struct grcan_priv *priv =3D netdev_priv(dev);
> @@ -1400,15 +1415,22 @@ static netdev_tx_t grcan_start_xmit(struct sk_buf=
f *skb,
>  				    struct net_device *dev)
>  {
>  	struct grcan_priv *priv =3D netdev_priv(dev);
> -	struct grcan_registers __iomem *regs =3D priv->regs;
> +	struct grcan_registers __iomem *regs;
> +	u32 eff, rtr, dlc, tmp, err, can_id;
>  	struct grcan_dma *dma =3D &priv->dma;
> -	struct can_frame *cf =3D (struct can_frame *)skb->data;
> +	u32 bds, copy_len, payload_offset;
>  	u32 id, txwr, txrd, space, txctrl;
> -	int slotindex;
> -	u32 *slot;
> -	u32 rtr, eff, dlc, tmp, err;
> +	struct canfd_frame *cfd;
> +	struct can_frame *cf;
>  	unsigned long flags;
> -	u32 oneshotmode =3D priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
> +	u32 oneshotmode;
> +	u8 *payload;
> +	u32 *slot;
> +	u8 len;
> +	int i;
> +
> +	regs =3D priv->regs;
> +	oneshotmode =3D priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
>
>  	if (can_dev_dropped_skb(dev, skb))
>  		return NETDEV_TX_OK;
> @@ -1419,6 +1441,18 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff=
 *skb,
>  	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
>  		return NETDEV_TX_BUSY;
>
> +	cfd =3D (struct canfd_frame *)skb->data;
> +	len     =3D cfd->len;
> +	can_id  =3D cfd->can_id;
> +	payload =3D cfd->data;

one space in front of the "=3D" please

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gfzuvzgifz5pg42n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlzhM8ACgkQDHRl3/mQ
kZx90gf9ECnQ9XSNqazfmdERkIKsvpBeY3qmOUiX7l0lE7EY5hIaLzjRSmkWEGqj
urc0A/f2yPDs1eQucIQ7WfPhuZZRPjLpS/9fAEqpIP7vmk6RjYSrkOBRY4S7ama/
fERTSxSJqYVnMqjQyiiSTPv1G7u74qp4JEooi/gwzAiPnJMHOwAaFBcsF5bd13gp
sLNi6hVSJAHTigawoHRTqgnkyCXE+RFFefirgaW0LE4WFbr7JU+5JTYSISGCvjx6
z5vhgmxR49BN3skl5zuTpLnuoK5RXGrFu5+mV9AAikaZUte5qu/NBZp0DmfBrB91
YHDfY8ct5Ofl1tj7cHOQcclxWFZBhw==
=+joU
-----END PGP SIGNATURE-----

--gfzuvzgifz5pg42n--

