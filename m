Return-Path: <linux-can+bounces-6687-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFgSFi/PpWm1GwAAu9opvQ
	(envelope-from <linux-can+bounces-6687-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 18:55:59 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C27D01DE224
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 18:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDB3F302866E
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 17:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8143126D0;
	Mon,  2 Mar 2026 17:55:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3C630BBB8
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474148; cv=none; b=XXKXdBUmg7Mq/gg6YTTmGpxqWnAw+YnK0b9tTFmK9C/Z65ulKFNhp4UZXlhZD3bweDOAaugb6ZuIO0cmQeqr+700fEX0jkIVzBFGik5w9xPNSA3lcABHxzUuuG+jMhUQ9FlKwt1cxORLQLKfNeHWkqQxy49g5pBrrarJEYRn8q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474148; c=relaxed/simple;
	bh=peR5Zc8Y4ObVAhfCSybvnP/nGrD+OkxEkgiCzbx1kUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBdnb1feuC9VUcIFc8/duo9R78m/14N61E6OweRGCri8Yp/29cEPukARlSEqxlSRe0MvzyZtXv3vtOl5A7xYm+lXtb+DxreM5y25nLKGv4oYl8VHhexwLwRow1fFPkaN2ZdywODS23sKlaA3v6FegUZUnCy9D4MQoupJ/DXd2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx7UI-0000h1-Lh; Mon, 02 Mar 2026 18:55:22 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx7UE-003Q09-1S;
	Mon, 02 Mar 2026 18:55:19 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6BD1B4F5684;
	Mon, 02 Mar 2026 17:55:19 +0000 (UTC)
Date: Mon, 2 Mar 2026 18:55:19 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Harald Mommer <harald.mommer@oss.qualcomm.com>, 
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-can@vger.kernel.org, virtualization@lists.linux.dev, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, francesco@valla.it
Subject: Re: [PATCH v10] can: virtio: Add virtio CAN driver
Message-ID: <20260302-idealistic-puffin-of-valor-b23733-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <aZRB7Reu/D6HvRcb@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ctag23wbpxqdtfo"
Content-Disposition: inline
In-Reply-To: <aZRB7Reu/D6HvRcb@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Queue-Id: C27D01DE224
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6687-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.869];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


--7ctag23wbpxqdtfo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10] can: virtio: Add virtio CAN driver
MIME-Version: 1.0

On 17.02.2026 11:24:45, Matias Ezequiel Vara Larsen wrote:
> +static void virtio_can_start(struct net_device *ndev)
> +{
> +	struct virtio_can_priv *priv =3D netdev_priv(ndev);
> +	u8 result;
> +
> +	result =3D virtio_can_send_ctrl_msg(ndev, VIRTIO_CAN_SET_CTRL_MODE_STAR=
T);
> +	if (result !=3D VIRTIO_CAN_RESULT_OK)
> +		netdev_err(ndev, "CAN controller start failed\n");

propagate the error value and evaluate it in the caller

[...]

> +static void virtio_can_stop(struct net_device *ndev)
> +{
> +	struct virtio_can_priv *priv =3D netdev_priv(ndev);
> +	struct device *dev =3D &priv->vdev->dev;
> +	u8 result;
> +
> +	result =3D virtio_can_send_ctrl_msg(ndev, VIRTIO_CAN_SET_CTRL_MODE_STOP=
);
> +	if (result !=3D VIRTIO_CAN_RESULT_OK)
> +		dev_err(dev, "CAN controller stop failed\n");

propagate the error value and evaluate it in the caller

> +
> +	priv->busoff_pending =3D false;
> +	priv->can.state =3D CAN_STATE_STOPPED;
> +
> +	/* Switch carrier off if device was connected to the bus */
> +	if (netif_carrier_ok(ndev))
> +		netif_carrier_off(ndev);
> +}

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7ctag23wbpxqdtfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaaXPBAAKCRDMOmT6rpmt
0sNKAQDbTjYRHJWn25iPrwKX+WuFCeZM8bwBGFpoul6nh9Za/AD+NP2ZTRereYFv
vtQKECmg5LxIRzUYoXi14AnYJ7aoNwM=
=x/53
-----END PGP SIGNATURE-----

--7ctag23wbpxqdtfo--

