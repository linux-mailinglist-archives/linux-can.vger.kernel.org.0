Return-Path: <linux-can+bounces-6313-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO98GOvIeGmNtQEAu9opvQ
	(envelope-from <linux-can+bounces-6313-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 15:17:15 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C41957AC
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 15:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 392B13009806
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 14:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608F026FD9A;
	Tue, 27 Jan 2026 14:13:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70264273D6D
	for <linux-can@vger.kernel.org>; Tue, 27 Jan 2026 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523185; cv=none; b=XOnoWA6Kyc+cp86M6JtvLqtaMb+Ig9n28hm67csRdm5gUiwW6iYKZY3V8kSB2wdVrIkyvNfD7EjP8gdQd3rNVncBrW2D8MNkqrRl8pLLWYEpLcqGWqMPnnpiL09gfEb0sNywD11rf4Rw3Stx8+Wkk38N7QktFdrsH/uNFwkhWp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523185; c=relaxed/simple;
	bh=xjc7u4fz6pmYlwP9Oa0iUMqnWYYtp999qs+HL8d3NQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvtslcPTbomv5n00iWYnwZF2FrSAP9SFDaEk11II6zIYOKuWhHz8Hb1+QVzFlLSsjkiKp2HmQZTnAV0lnwkQOEau4l5EBEnpFDQbees/yXDuKcFrs5xcyeXUf0+Lqtkg1lfvZ0jynbZQnFYu7lJAJs85RXl41p1iiSORXiudO+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vkjoI-0004w0-UY; Tue, 27 Jan 2026 15:12:50 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vkjoJ-002lLQ-1G;
	Tue, 27 Jan 2026 15:12:50 +0100
Received: from pengutronix.de (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 51AD84D95EC;
	Tue, 27 Jan 2026 14:12:50 +0000 (UTC)
Date: Tue, 27 Jan 2026 15:12:49 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mailhol@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH v3 13/15] can: grcan: Add CANFD TX support alongside
 legacy CAN
Message-ID: <20260127-fancy-fast-bird-e7c4c3-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
 <20260122121038.7910-14-arun.muthusamy@gaisler.com>
 <20260123-berserk-crocodile-of-champagne-49d2b0-mkl@pengutronix.de>
 <78a8f06c-da93-4ade-bc69-872aac644724@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rpakgy5wkqvr6pf3"
Content-Disposition: inline
In-Reply-To: <78a8f06c-da93-4ade-bc69-872aac644724@gaisler.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6313-lists,linux-can=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gaisler.com:email,pengutronix.de:url,pengutronix.de:mid]
X-Rspamd-Queue-Id: 67C41957AC
X-Rspamd-Action: no action


--rpakgy5wkqvr6pf3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 13/15] can: grcan: Add CANFD TX support alongside
 legacy CAN
MIME-Version: 1.0

On 27.01.2026 15:06:55, Arun Muthusamy wrote:
>
> On 1/23/26 15:25, Marc Kleine-Budde wrote:
> > On 22.01.2026 13:10:36, Arun Muthusamy wrote:
> > > Include CANFD TX support with the legacy CAN support, enabling
> > > support for extended data payloads to provide higher bit rates.
> > >
> > > Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> > > ---
> > >   drivers/net/can/grcan.c | 102 +++++++++++++++++++++++++++++--------=
---
> > >   1 file changed, 74 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> > > index 9fc18064fab1..508ad5320cff 100644
> > > --- a/drivers/net/can/grcan.c
> > > +++ b/drivers/net/can/grcan.c
> > > @@ -174,6 +174,7 @@ struct grcan_registers {
> > >   #define GRCAN_IRQ_DEFAULT (GRCAN_IRQ_RX | GRCAN_IRQ_TX | GRCAN_IRQ_=
ERRORS)
> > >
> > >   #define GRCAN_MSG_SIZE		16
> > > +#define GRCAN_CLASSIC_DATA_SIZE 8
> > >
> > >   #define GRCAN_MSG_IDE		0x80000000
> > >   #define GRCAN_MSG_RTR		0x40000000
> > > @@ -195,6 +196,10 @@ struct grcan_registers {
> > >   #define GRCAN_MSG_OFF		0x00000002
> > >   #define GRCAN_MSG_PASS		0x00000001
> > >
> > > +#define GRCAN_MSG_EID_MASK      GENMASK(28, 0)
> > > +#define GRCAN_MSG_BID_MASK      GENMASK(28, 18)
> > > +#define GRCAN_MSG_DLC_MASK      GENMASK(31, 28)
> > > +
> > >   #define GRCAN_BUFFER_ALIGNMENT		1024
> > >   #define GRCAN_DEFAULT_BUFFER_SIZE	1024
> > >   #define GRCAN_VALID_TR_SIZE_MASK	0x001fffc0
> > > @@ -227,6 +232,9 @@ struct grcan_registers {
> > >   #define GRCANFD_FDBTR_PS2_BIT 5
> > >   #define GRCANFD_FDBTR_SJW_BIT 0
> > >
> > > +#define GRCAN_TX_BRS  BIT(25)
> > > +#define GRCAN_TX_FDF  BIT(26)
> > > +
> > >   /* Hardware capabilities */
> > >   struct grcan_hwcap {
> > >   	/* CAN-FD capable, indicates GRCANFD IP.
> > > @@ -1218,6 +1226,13 @@ static void grcan_transmit_catch_up(struct net=
_device *dev)
> > >   	spin_unlock_irqrestore(&priv->lock, flags);
> > >   }
> > >
> > > +static int grcan_numbds(int len)
> > > +{
> > > +	if (len <=3D GRCAN_CLASSIC_DATA_SIZE)
> > > +		return 1;
> > > +	return 1 + ((len - GRCAN_CLASSIC_DATA_SIZE + GRCAN_MSG_SIZE) / GRCA=
N_MSG_SIZE);
> > This looks strange, what is calculated here? Why is "<=3D
> > GRCAN_CLASSIC_DATA_SIZE" a special case?
>
> grcan_numbds() calculates the number of buffer descriptors needed based o=
n the data length.
> The condition "len <=3D GRCAN_CLASSIC_DATA_SIZE" addresses cases where th=
e data length fits within a one buffer descriptor.
> For data lengths greater than "GRCAN_CLASSIC_DATA_SIZE", it computes addi=
tional descriptors needed.

What happens if "len =3D GRCAN_CLASSIC_DATA_SIZE + GRCAN_MSG_SIZE"?

| return 1 + ((len - GRCAN_CLASSIC_DATA_SIZE + GRCAN_MSG_SIZE) / GRCAN_MSG_=
SIZE);

=3D 1 + ((GRCAN_CLASSIC_DATA_SIZE + GRCAN_MSG_SIZE - GRCAN_CLASSIC_DATA_SIZ=
E + GRCAN_MSG_SIZE) / GRCAN_MSG_SIZE);
=3D 1 + ((                          GRCAN_MSG_SIZE -                       =
  + GRCAN_MSG_SIZE) / GRCAN_MSG_SIZE);
=3D 1 + 2;
=3D 3

Is this correct?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rpakgy5wkqvr6pf3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAml4x94ACgkQDHRl3/mQ
kZxCEQf/WCNswG5Klzxx8orvUzgaeba72UOu7p+lPT65hmeMJ4lgRbktTCQUC2p3
2kw6hjgrs/Xn6U2/RVxFGNQ5vwEpMaLKDUDLr+0N+6BrqCBOZU5A+XTsAz948C6h
dCyVDrkRzeEGwQGc9+nt+U2U/s4bg6DNqWPMyZsbCOWGY5DsVEj6nfHXt0kiB6Vt
qq6ahDHR7HX4n+kpSr4+8MWAVJiSitJzopA5f2UyevQwjlOerLZv1mgdfpoq1vL6
z+dLpEErj1kDW68DlQTdkToQrBO+838uaM1zDIcpynbmEoAWpGx4AtWBuMNTm8Kx
WsQqIA+Z7sk9ZNPqRVkr9t6q6OyMoQ==
=m7ih
-----END PGP SIGNATURE-----

--rpakgy5wkqvr6pf3--

