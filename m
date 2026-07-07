Return-Path: <linux-can+bounces-8024-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WLTsLVWnTGq3ngEAu9opvQ
	(envelope-from <linux-can+bounces-8024-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 09:14:29 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BE471856C
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 09:14:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DAjC4j4b;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8024-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8024-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9798D30013BC
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 07:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBF53AB5BB;
	Tue,  7 Jul 2026 07:14:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380E02F7F11
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 07:14:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408452; cv=none; b=WH1bxpx5xTgQd7i8o+3Z1mMIWbseSY4SDhZe+DSZmM8RzJH3uB5Ez/0ACf6F3qP+sSczn2sJn8gq5rhFCDHE5brAWOoltoor0wxLVBsi7E67ipx2n2Ano1Oq5oB5/5f0qUsd2sJtm7AbOIHoO1IAW4nJdH954fjDgUEmiafCA0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408452; c=relaxed/simple;
	bh=tpibC/dhgcFTndFu9hH3fT+X5JVYcqt+pHl9keKp4Ek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EAcBGFXw835LtWKjeO6h/70qZ4069PqRKwQRG+D548U9El3vz/Q/t7swUarla4nbhd2AFU41NeRRptTvL6W9vvL82/F+UlKIHT2n/ycUj9yTkDRZuNeObgteWbjaxFzPrs5j8TRb/tVeRPm2nuxQ/0liedUYte0PxA/XFh5cGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAjC4j4b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BF21F000E9;
	Tue,  7 Jul 2026 07:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783408450;
	bh=14sHTISe7QByYEWKLioWZ1xaAYuNwXDuYEVQx1wByHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DAjC4j4bttYOx1fB9gYFOkewQmj95kZbO7O3nj8gitL18DmFnjOxRjFkOtzIZeVz4
	 ymBmT/ICA2Kj+lwdSb/w1vKGKNn4qHpSzwHYPvi5OO39Ta1Rw2TFa4iX6k80UCs+CX
	 RY8DimhuCuelbyzurCS4F4J/1O3hNxYD1w0HjR4D5dvSOSKVUZ2cRFa6967459Hg/A
	 mI2rG37uRLpJHSKvPupAji69I0mOE6u4TtR3//Os8t9sPC313WZVk7YpmLTSWwhRqZ
	 5W5R+Uh0xxtBrScszC/JPlg+04cgO1qHGCVWQ/6p9kKHXu71rC0i/pKC/kpblx5DzR
	 BkkyQ/vmJwfxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] can: loongson_canfd: Add RXDMA support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <f46c0a1607cac2d8bad84f62707ef4e07fe0b2fa.1783391759.git.zhoubinbin@loongson.cn>
References: <cover.1783391759.git.zhoubinbin@loongson.cn>
 <f46c0a1607cac2d8bad84f62707ef4e07fe0b2fa.1783391759.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:14:10 +0000
Message-Id: <20260707071410.84BF21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8024-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhoubinbin@loongson.cn,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6BE471856C

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [High] The CPU reads ahead of the DMA write pointer, leading to frame cor=
ruption and ring buffer desynchronization.
- [High] A DMA status error causes an infinite NAPI polling loop, leading t=
o a soft lockup.
- [High] Failure of `loongson_canfd_rxdma_init` leads to a double free of t=
he DMA buffer and completely breaks the RX path.
- [Medium] Kconfig dependency strictly requires the Loongson DMA controller=
, breaking the driver for polling mode users.
- [Medium] The network device is leaked if `dma_request_chan()` returns `-E=
PROBE_DEFER`.
- [Low] Build failure due to undeclared variable 'cf'.
- [Low] Improper internal access of `dma_chan->cookie` field violates the D=
MA engine API.

Pre-existing issues:
- [High] An SKB allocation failure in `loongson_canfd_rx` leaves payload da=
ta in the buffer, permanently desynchronizing the RX stream.
--

--- Patch [2]: [PATCH v4 2/2] can: loongson_canfd: Add RXDMA support ---
commit 1ade4f6818d2a045c4fbf2074c44add29566cfc4
Author: Binbin Zhou <zhoubinbin@loongson.cn>
Subject: can: loongson_canfd: Add RXDMA support

This commit adds optional DMA engine support for the receive path in the
Loongson CAN-FD driver. It configures a cyclic DMA transfer to continuously
fill a ring buffer, falling back to polling if DMA is unavailable.

> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -191,7 +191,7 @@ config CAN_KVASER_PCIEFD
> =20
>  config CAN_LOONGSON_CANFD
>  	tristate "Loongson CAN-FD controller"
> -	depends on HAS_IOMEM
> +	depends on HAS_IOMEM && (LOONGSON2_APB_CMC_DMA || COMPILE_TEST)

[Severity: Medium]
The commit message notes that DMA is optional and the driver will fall back
to poll mode. Does modifying the Kconfig to strictly depend on
LOONGSON2_APB_CMC_DMA prevent users from building the driver on platforms
where they only want polling mode?

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_=
canfd.c
> --- a/drivers/net/can/loongson_canfd.c
> +++ b/drivers/net/can/loongson_canfd.c
[ ... ]
> +static bool loongson_canfd_get_rxbuf_empty_in_dma(struct loongson_canfd_=
priv *priv)
> +{
> +	struct dma_tx_state state;
> +	enum dma_status status;
> +
> +	status =3D dmaengine_tx_status(priv->rx_ch, priv->rx_ch->cookie, &state=
);

[Severity: Low]
Is it safe to directly access the internal cookie field of the dma_chan
structure? The DMA engine API typically requires clients to track the cookie
returned by dmaengine_submit() rather than dereferencing the internal
framework structures.

> +
> +	return priv->last_res =3D=3D (state.residue / DMA_SLAVE_BUSWIDTH_4_BYTE=
S) &&
> +	       (status =3D=3D DMA_IN_PROGRESS);
> +}

[Severity: High]
Could this empty check cause the CPU to read ahead of the DMA write pointer?

In loongson_canfd_rx_napi(), the buffer is considered non-empty as soon as
the DMA engine transfers a single word (since last_res will no longer equal
the residue calculation).=20

When NAPI calls loongson_canfd_rx(), it unconditionally reads multiple words
for the header and payload. Since the DMA engine might have only written one
word so far, does this consume stale data and corrupt the stream?

[Severity: High]
What happens if the DMA engine status is not DMA_IN_PROGRESS due to a
hardware error or a halted transfer?=20

This function will return false, indicating the buffer is not empty. The NA=
PI
loop in loongson_canfd_rx_napi() will continuously poll loongson_canfd_rx()=
.=20

Because the empty check evaluates to false, it skips napi_complete_done()
and the networking stack instantly reschedules NAPI. Does this lead to an
infinite loop and a CPU soft lockup?

[ ... ]
> +static int loongson_canfd_rxdma_init(struct net_device *ndev)
> +{
[ ... ]
> +	/* Push current dma transaction in the pending queue */
> +	ret =3D dma_submit_error(dmaengine_submit(desc));
> +	if (ret) {
> +		dmaengine_terminate_sync(priv->rx_ch);
> +		goto err_config;
> +	}
> +
> +	/* Issue pending DMA requests */
> +	dma_async_issue_pending(priv->rx_ch);
> +
> +	return 0;
> +
> +err_config:
> +	loongson_canfd_rxdma_free(priv, dev);
> +	return ret;
> +}

[Severity: High]
If dmaengine_slave_config or dmaengine_prep_dma_cyclic fails, this calls
loongson_canfd_rxdma_free() but leaves priv->rx_ch pointing to the freed
channel.=20

Since the probe function ignores the error to fall back to poll mode, will
loongson_canfd_chip_start() mistakenly enable the DMADI interrupt instead
of RBNEI because priv->rx_ch is not NULL?=20

Furthermore, when the driver is removed, loongson_canfd_rxdma_remove() chec=
ks
priv->rx_ch and calls loongson_canfd_rxdma_free() again. Does this result in
a fatal double-free?

[ ... ]
> @@ -1028,7 +1171,7 @@ static int loongson_canfd_rx(struct net_device *nde=
v)
[ ... ]
>  	if (is_can_fd) {
>  		skb =3D alloc_canfd_skb(ndev, &cfd);
>  	} else {
>  		skb =3D alloc_can_skb(ndev, &ccf);
>  		cfd =3D (struct canfd_frame *)ccf;
>  	}
> =20
>  	if (unlikely(!skb))
>  		return 0;

[Severity: High]
This is a pre-existing issue, but if alloc_canfd_skb() or alloc_can_skb()
fails in loongson_canfd_rx(), the function returns 0 immediately.=20

It has already consumed the meta0 and meta1 headers but skips consuming the
payload words. Since these unread words remain in the hardware FIFO or DMA
buffer, will the next RX interrupt misinterpret them as the headers of the
next frame, permanently desynchronizing the stream?

[ ... ]
>  	/* Data Length Code */
>  	dlc =3D FIELD_GET(REG_FRAME_META1_DLC, meta1);
>  	if (is_can_fd)
>  		cfd->len =3D can_fd_dlc2len(dlc);
>  	else
>  		can_frame_set_cc_len(ccf, dlc, priv->can.ctrlmode);
> =20
>  	/* Data */
>  	for (unsigned int i =3D 0; i < cfd->len; i +=3D LOONGSON_CANFD_DW_BYTE)
> -		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, (u32 *)(cfd->data + =
i));
> +		*(u32 *)(cf->data + i) =3D priv->get_rx_data(priv);

[Severity: Low]
Does this cause a build failure? The variable cf is not declared in
loongson_canfd_rx() (the available pointers are cfd and ccf). Writing to
cf->data seems to be a typo that prevents the driver from compiling.

[ ... ]
> @@ -1635,6 +1779,24 @@ static int loongson_canfd_probe(struct platform_de=
vice *pdev)
[ ... ]
>  	ndev->netdev_ops =3D &loongson_canfd_netdev_ops;
>  	ndev->ethtool_ops =3D &loongson_canfd_ethtool_ops;
>  	SET_NETDEV_DEV(ndev, dev);
> =20
> +	priv->get_rx_data =3D loongson_canfd_get_rxdata_in_poll;
> +	priv->get_rxbuf_empty =3D loongson_canfd_get_rxbuf_empty_in_poll;
> +
> +	priv->rx_ch =3D dma_request_chan(dev, "rx");
> +	if (PTR_ERR(priv->rx_ch) =3D=3D -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

[Severity: Medium]
If dma_request_chan() returns -EPROBE_DEFER, this immediately returns the
error code without jumping to the error handling path.=20

Since alloc_candev() was successfully called earlier in the probe function,
does returning directly here permanently leak the net_device and priv
structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783391759.gi=
t.zhoubinbin@loongson.cn?part=3D2

