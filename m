Return-Path: <linux-can+bounces-6284-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MHHLaCDc2kXxAAAu9opvQ
	(envelope-from <linux-can+bounces-6284-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 15:20:16 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C5376EDC
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 15:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17897303E2C7
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DBB27B352;
	Fri, 23 Jan 2026 14:17:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ABE20C463
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177863; cv=none; b=QyDf/VLOo+6iGloNCs7wbVTjkncG3OCMd2dO6duceZHfki87EAPSrFyic8SV2ZGSx3JTPvaaze03ciPWz5Xbe+XcID8xZaG8RraNQRqCbflJu+73CZ13t6o6GtkeM00tg/OFMD+/4/BULEEF+gxOp7TiwXU5KR+5B7MFaTDW6Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177863; c=relaxed/simple;
	bh=tZQdaapFyjK/60l8c6qEELow9aA4TJhUEJgJSERxvHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlw7m8iG7v7JbDrC4tsa3FBFh6MFJsIYF+j9gTxvb5cCJyWRY73zOeF1bMDpxq837bqIebOMxvJag63229CK41kKIr7+B0a60NM29iEZMgEYAcnvYFDMfGK8DJHJaAwn0ZFq89sKGDhVczm64zSuCGHQcVsfY24W3vV0jY1nC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjHyf-0002jI-Ax; Fri, 23 Jan 2026 15:17:33 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjHyf-0026gG-2R;
	Fri, 23 Jan 2026 15:17:33 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C7C524D6F7D;
	Fri, 23 Jan 2026 14:17:32 +0000 (UTC)
Date: Fri, 23 Jan 2026 15:17:32 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mailhol@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH v3 15/15] can: grcan: Update echo skb handling to match
 variable length CANFD frame
Message-ID: <20260123-jolly-orangutan-of-finesse-5a9bb3-mkl@pengutronix.de>
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
 <20260122121038.7910-16-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="di6szzwy2btquo6k"
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6284-lists,linux-can=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47C5376EDC
X-Rspamd-Action: no action


--di6szzwy2btquo6k
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 15/15] can: grcan: Update echo skb handling to match
 variable length CANFD frame
MIME-Version: 1.0

On 22.01.2026 13:10:38, Arun Muthusamy wrote:
[...]

> @@ -1575,7 +1591,16 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff=
 *skb,
>  	 * can_put_echo_skb would be an error unless other measures are
>  	 * taken.
>  	 */
> -	can_put_echo_skb(skb, dev, slotindex, 0);
> +
> +	priv->echo_skb_idx =3D priv->next_echo_idx;
> +
> +	can_put_echo_skb(skb, dev, priv->next_echo_idx, 0);
> +
> +	/* Move to the next index in the echo skb buffer */
> +	priv->next_echo_idx =3D (priv->next_echo_idx + 1) % priv->can.echo_skb_=
max;
> +
> +	if (priv->can.echo_skb[priv->echo_skb_idx])
> +		netif_stop_queue(dev);

You also use "if (unlikely(space =3D=3D 1)) netif_stop_queue(dev);", that
looks suspicious. Why have 2 independent ways to check if the TX queue
is full?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--di6szzwy2btquo6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlzgvkACgkQDHRl3/mQ
kZznWwgAq/9I/ClKJvOD5Q4TVO2sMzbDGU6vs9G82gYb3e/12vfgeNohhG7eyEU8
4F3CP4Ptf9lHHYcCpCQp7tF9az7eO7MN17lFegXNGJ6L3Qz9fA8JZ5NJWV7rJrZa
3TsdaJxv5eH/u2/B+9sySlEwOHmt3YAlXGjgoTXPsfm9RCVtgdcoUTIYXAK4DTCr
cbRjvII8KKRb+KvPqAK2qMnnA6ZCnOUN7+KKRnQ7U69+uLhR+12gEmLpMS7CCzog
XtSwVhQcKIHLQEh8GFCNX5o061YDtnLyGFr/GNzut+xDMSU4bVh0gMRnkhUtE5e/
PZlVwgO4q1p6mDOIDQNmMMpPeWHYzw==
=4o+f
-----END PGP SIGNATURE-----

--di6szzwy2btquo6k--

