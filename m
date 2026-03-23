Return-Path: <linux-can+bounces-7218-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF9dO5UYwWn5QQQAu9opvQ
	(envelope-from <linux-can+bounces-7218-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 11:40:21 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C9A2F057E
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 11:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 713E6303EEAE
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 10:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CF73859D4;
	Mon, 23 Mar 2026 10:36:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEFC38B7D2
	for <linux-can@vger.kernel.org>; Mon, 23 Mar 2026 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262200; cv=none; b=Dw/XRJDKF5gXQZ59F1ExGe5QLE1Z1EvPfG8PdeaxWkmCONlOlTEO9T3Waqivq1xujHsZ832CmDw0/cQKZ6GKzpg93Q6R5hgJnqEI7kODZjWM1eIJo6TIdQMoGJlMDU3wX/HhvuWoInxXh95d8YjSx8FwwkZ1BEZ7ElYjD8APiro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262200; c=relaxed/simple;
	bh=84cWpFOEfJUrl7OHPV0gcP7TAT6ro+QeEH6UHJ61bvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jw3XuhE9CCucGFFizT+mKEfKYq8m7jCX3aHp/guUoKhQnCipj1T/wvvQO9CGoG0CdiVXQp6lK/CmTqsxf80JYQ7K6g54ru14pp+XZJ4STJIOiWd1hfvakYLIeEoIRfzH/kLehas8XzdOd2NGzDq819+oKkePival/axofjKMMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4cdw-0000dP-Ab; Mon, 23 Mar 2026 11:36:20 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4cdv-001iAm-1I;
	Mon, 23 Mar 2026 11:36:19 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 114E250A7F9;
	Mon, 23 Mar 2026 10:36:19 +0000 (UTC)
Date: Mon, 23 Mar 2026 11:36:18 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Harald Mommer <harald.mommer@oss.qualcomm.com>, 
	Vincent Mailhol <mailhol@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, linux-can@vger.kernel.org, virtualization@lists.linux.dev, 
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, Stefano Garzarella <sgarzare@redhat.com>, francesco@valla.it
Subject: Re: [PATCH v13] can: virtio: Add virtio CAN driver
Message-ID: <20260323-hilarious-active-eagle-a0ee74-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <ab2FlQTWUxl0KmlT@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zsnxvdx43cvgpphl"
Content-Disposition: inline
In-Reply-To: <ab2FlQTWUxl0KmlT@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7218-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 67C9A2F057E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--zsnxvdx43cvgpphl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v13] can: virtio: Add virtio CAN driver
MIME-Version: 1.0

Hello,

The nipa/ai-review bot found these problems:

| https://netdev-ai.bots.linux.dev/ai-review.html?id=3Db046d75a-2de1-4063-b=
b96-8f64abc65e7d

commit 0f3cb3b3bc94eaff9b9709b528e498fe6150f9c1
Author: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>

can: virtio: Add virtio CAN driver

This commit adds a virtio CAN driver implementing a complete CAN bus
interface over Virtio transport, supporting both CAN Classic and CAN-FD
frames.

> diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
> new file mode 100644
> index 000000000000..57641c3ed6d0
> --- /dev/null
> +++ b/drivers/net/can/virtio_can.c

[ ... ]

> +static int __maybe_unused virtio_can_restore(struct virtio_device *vdev)
> +{
> +	struct virtio_can_priv *priv =3D vdev->priv;
> +	struct net_device *ndev =3D priv->dev;
> +	size_t size;
> +	int err;
> +
> +	napi_enable(&priv->napi);
> +	napi_enable(&priv->napi_tx);
> +
> +	err =3D virtio_can_find_vqs(priv);
> +	if (err !=3D 0)
> +		return err;

What happens to the enabled NAPI instances when this error path is taken?
virtio_can_restore() enables both NAPI instances at the start, but if
virtio_can_find_vqs() fails here, the function returns without calling
napi_disable().

The corresponding virtio_can_freeze() function disables both NAPIs before
returning, so the restore function leaves the NAPI subsystem in an
inconsistent state on failure.

If the PM framework retries restore after this failure, the second
napi_enable() call on an already-enabled NAPI will hit the BUG_ON in
napi_enable_locked():

net/core/dev.c:napi_enable_locked() {
	BUG_ON(!test_bit(NAPI_STATE_SCHED, &n->state));
	...
}

In contrast, virtio_can_probe() enables NAPI only after all setup
succeeds, avoiding this issue.

> +
> +	size =3D priv->rpkt_len * priv->vqs[VIRTIO_CAN_QUEUE_RX]->num_free;
> +	priv->rpkt =3D devm_krealloc(&vdev->dev, priv->rpkt, size, GFP_KERNEL |=
 __GFP_ZERO);
> +	if (!priv->rpkt) {
> +		virtio_can_del_vq(vdev);
> +		return -ENOMEM;
> +	}

The same NAPI state issue occurs on this error path.

> +	virtio_can_populate_rx_vq(vdev);
> +
> +	if (netif_running(ndev)) {
> +		err =3D virtio_can_start(ndev);
> +		if (err) {
> +			virtio_can_del_vq(vdev);
> +			return err;
> +		}

And again on this error path.

Should all three error paths call napi_disable(&priv->napi_tx) and
napi_disable(&priv->napi) before returning the error code?

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zsnxvdx43cvgpphl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCacEXoAAKCRDMOmT6rpmt
0oc0AP4r/E0p8/W4XH5xFsFvHnvCil/2ybFe0uqsmduXn4Gw4QD6A2wQTTGMyyJp
k6X5ros7i59H9faw/8/FWIR1ffBnmQY=
=E13T
-----END PGP SIGNATURE-----

--zsnxvdx43cvgpphl--

