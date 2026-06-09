Return-Path: <linux-can+bounces-7793-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NR/VORNkKGrCDAMAu9opvQ
	(envelope-from <linux-can+bounces-7793-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 21:05:55 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 367C6663839
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 21:05:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hbsqf6Z9;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7793-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7793-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E539330F622C
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 18:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEF834BA5A;
	Tue,  9 Jun 2026 18:59:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF454C77CE
	for <linux-can@vger.kernel.org>; Tue,  9 Jun 2026 18:59:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031552; cv=none; b=QENeOtNhjGOd7mRTNbHz/7O8ssZMiAw+dp8cUaZ8XgLMr5G46XyVAwClS9UaXFK6EEY+EEs8piU1JmpuEiu5iHTFujbTcGCh0zWzMjdpZm818li///qUpFl4EFXC0aCBxrgtuYn896OfaJh7eAYmeNrCOXqoXCC+M0ObYIkR/V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031552; c=relaxed/simple;
	bh=9m+4yymzAtwod/DGQzam7iodWmVbxrnDtqje6d9gUuI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kziryn83D0hj57zKSNo3eI0otB4LrZErGf3ELfQDzGB3wV9LHuW1ubF1pUf3g5cgwzboQNPc1q7Cd90aFssaWVagJW7nw2czxkNiodBqyDMv0z1g7KxdNMbiVMPGB8rIKN206TG2kWo1QEyoSg9UJSEhPnbMkSRfGjourFd1sww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbsqf6Z9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27E61F00893;
	Tue,  9 Jun 2026 18:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781031550;
	bh=S+lCzXs/qrwbznBXTztGFrTgfmYFa46toB2Z0Olk5hs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hbsqf6Z96vo69UFa98RiU69ESbwun3oQIU17X7dy2Xt2G9P8rA9pzxJsI6X25MdK9
	 RMUt7ZV+T/rRMgydVkyrSGo3VsOGveso2TDH1IcAFk8fLObmBApWbNNHi/acLons9R
	 lDUj53yu56Rx4zuGe+VnwLJdL4ZuAcYVurVYDgCGoADPecvZH27UHyEoqwASdeCXuo
	 STfWgebMo3Im7xFZ3MezqDynSPaTqPCT04EkTnsFc2YXKDel6p+TybaxspH9awTSjL
	 veNVpm8Y7j1Ioh9lf2/gBhAq/mee43m+0+32qV4h8Ox8y1F6Jah6HMuibdVSZbqC2B
	 iRIkyrvHfGvjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] can: loongson_canfd: Add RXDMA support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <9af2c912e0afd439ea9562ea8aa72ee0af3f2ed3.1780908445.git.zhoubinbin@loongson.cn>
References: <9af2c912e0afd439ea9562ea8aa72ee0af3f2ed3.1780908445.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:59:10 +0000
Message-Id: <20260609185910.A27E61F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7793-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,vger.kernel.org:from_smtp,loongson.cn:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhoubinbin@loongson.cn,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 367C6663839

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [Critical] Incorrect teardown order causes Use-After-Free and DMA memory =
corruption.
- [Critical] Flawed DMA synchronization logic leads to data corruption and =
complete pointer desynchronization.
- [High] Uninitialized variable `ret` returned on probe failure leads to ra=
ndom probe status.
- [High] Memory leak of DMA buffer and unterminated cyclic transfer on prob=
e failure.
- [Medium] Probe incorrectly aborted on DMA initialization failure instead =
of falling back to PIO.
- [Medium] Artificial Kconfig dependency arbitrarily breaks driver function=
ality on systems without the Loongson DMA driver.

Pre-existing issues:
- [High] Memory allocation failure causes a permanent NAPI hang.
- [High] Missing bounds check on frame payload length allows heap buffer ov=
erflow.
--

commit 33782565e156b12b3812d0b21ca4a945e50adf11
Author: Bingxiong Li <libingxiong@loongson.cn>

Add optional DMA support for RX path using the Loongson APB CMC DMA engine

This patch adds optional DMA support for the RX path in the Loongson CAN-FD
driver. It requests a DMA channel and uses cyclic transfers to directly wri=
te
incoming frames to a coherent buffer, falling back to PIO mode if unavailab=
le.

> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -191,7 +191,7 @@ config CAN_KVASER_PCIEFD
> =20
>  config CAN_LOONGSON_CANFD
>  	tristate "Loongson CAN-FD controller"
> -	depends on HAS_IOMEM || COMPILE_TEST
> +	depends on HAS_IOMEM && (LOONGSON2_APB_CMC_DMA || COMPILE_TEST)

[Severity: Medium]
Does this introduce a hard dependency that unnecessarily breaks compilation
for systems that only want to use PIO mode? Because the driver uses the
generic dmaengine framework, there shouldn't be a strict compile-time
requirement on the specific LOONGSON2_APB_CMC_DMA module.

[ ... ]

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_=
canfd.c
> --- a/drivers/net/can/loongson_canfd.c
> +++ b/drivers/net/can/loongson_canfd.c
> @@ -614,6 +632,125 @@ static int loongson_canfd_reset(struct net_device *=
ndev)
[ ... ]
> +static bool loongson_canfd_rxfrc_in_dma(struct loongson_canfd_priv *priv)
> +{
> +	struct dma_tx_state state;
> +	enum dma_status status;
> +
> +	status =3D dmaengine_tx_status(priv->rx_ch, priv->rx_ch->cookie, &state=
);
> +
> +	return priv->rx_frc !=3D (state.residue / DMA_SLAVE_BUSWIDTH_4_BYTES) &&
> +	       (status =3D=3D DMA_IN_PROGRESS);
> +}

[Severity: Critical]
Does this cause data corruption by triggering reads for partial DMA transfe=
rs?

If the DMA engine writes just a single word, this condition evaluates to tr=
ue,
but loongson_canfd_rx() will unconditionally read an entire frame consisting
of multiple words. If the CPU outpaces the DMA transfer, could it read stale
unwritten memory and permanently desynchronize the pointers?

Also, when residue reaches 0, does rx_frc !=3D 0 evaluate to true indefinit=
ely
because rx_frc wraps from 1 to LOONGSON_CANFD_RXDMA_NUM, potentially causing
an infinite NAPI loop reading garbage?

[ ... ]

> @@ -1074,12 +1211,12 @@ static void loongson_canfd_read_rx_frame(struct l=
oongson_canfd_priv *priv, struc
[ ... ]
>  	/* Data */
>  	for (i =3D 0; i < len; i +=3D LOONGSON_CANFD_DW_BYTE) {
> -		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
> +		data =3D priv->get_rx_data(priv);
>  		*(__le32 *)(cf->data + i) =3D cpu_to_le32(data);
>  	}

[Severity: High]
This is a pre-existing issue, but does the lack of bounds checking on len
allow a heap buffer overflow?

The len is calculated from the word count in the frame metadata. Without
validation ensuring it is bounded by CANFD_MAX_DLEN, could a corrupted word
count cause this loop to write out-of-bounds into the skb data buffer?

[ ... ]

> @@ -1328,16 +1465,16 @@ static int loongson_canfd_rx_napi(struct napi_str=
uct *napi, int quota)
[ ... ]
>  	while (rx_frc && work_done < quota && ret > 0) {
>  		ret =3D loongson_canfd_rx(ndev);
>  		work_done++;
> -		regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &rx_sts);
> -		rx_frc =3D FIELD_GET(REG_RX_STAT_RXFRC, rx_sts);
> +		rx_frc =3D priv->get_rx_frc(priv);
>  	}
[ ... ]
> @@ -1367,13 +1504,11 @@ static int loongson_canfd_rx_napi(struct napi_str=
uct *napi, int quota)
[ ... ]
>  	if (!rx_frc && ret !=3D 0) {
>  		if (napi_complete_done(napi, work_done)) {

[Severity: High]
This is a pre-existing issue, but does a memory allocation failure cause a
permanent NAPI hang here?

If loongson_canfd_rx() fails to allocate an skb, it returns -ENOMEM. The
loop breaks while rx_frc remains true, which makes the check
"if (!rx_frc && ret !=3D 0)" evaluate to false. Doesn't this bypass
napi_complete_done() and leave NAPI permanently in the SCHED state without
re-enabling interrupts?

[ ... ]

> @@ -1663,6 +1799,7 @@ static int loongson_canfd_probe(struct platform_dev=
ice *pdev)
[ ... ]
>  	/* Create a CAN device instance */
>  	ndev =3D alloc_candev(sizeof(*priv), LOONGSON_CANFD_TXBUF_NUM);
>  	if (!ndev)
> -		return -ENOMEM;
> +		goto err_dma_rx;

[Severity: High]
Does this return an uninitialized variable on probe failure?

The variable ret is declared at the top of the function but not initialized.
If alloc_candev() fails, jumping to err_dma_rx will return the uninitialized
ret, potentially signaling a false success to the device core.

[ ... ]

> @@ -1720,6 +1867,19 @@ static int loongson_canfd_probe(struct platform_de=
vice *pdev)
[ ... ]
> +	if (priv->rx_ch) {
[ ... ]
> +		ret =3D loongson_canfd_rxdma_init(ndev);
> +		if (ret) {
> +			dev_err(dev, "interrupt mode used for rx (no dma)\n");
> +			goto err_candev_free;
> +		}

[Severity: Medium]
Is it intentional to abort the probe entirely here?

The error message indicates an intent to fall back to interrupt (PIO) mode
if DMA setup fails, but jumping to err_candev_free will cause the probe to
fail and leave the driver unusable instead of gracefully falling back.

[ ... ]

> @@ -1732,6 +1892,9 @@ static int loongson_canfd_probe(struct platform_dev=
ice *pdev)
> =20
>  err_candev_free:
>  	free_candev(ndev);
> +err_dma_rx:
> +	if (rx_ch)
> +		dma_release_channel(rx_ch);
>  	return ret;
>  }

[Severity: High]
Does this error path leak memory and leave a cyclic DMA transfer active?

If register_candev() fails, this path frees the device and releases the
channel, but it does not call loongson_canfd_rxdma_remove() to free the
coherent DMA memory.

Also, isn't a dmaengine_terminate_sync() call needed to stop the hardware
from actively writing to the leaked memory?

[ ... ]

> @@ -1740,6 +1903,11 @@ static void loongson_canfd_remove(struct platform_=
device *pdev)
>  	struct net_device *ndev =3D platform_get_drvdata(pdev);
>  	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> =20
> +	if (priv->rx_ch) {
> +		loongson_canfd_rxdma_remove(priv, &pdev->dev);
> +		dma_release_channel(priv->rx_ch);
> +	}
> +
>  	unregister_candev(ndev);
>  	netif_napi_del(&priv->napi);
>  	free_candev(ndev);

[Severity: Critical]
Does freeing the DMA memory before unregistering the device cause a
use-after-free and memory corruption?

While unregister_candev() is executing, the network device and NAPI are
still active. If a CAN interrupt fires, couldn't the NAPI poll loop
(loongson_canfd_rx_napi) read from the freed priv->rx_buf?

Additionally, since the cyclic DMA transfer is never stopped via
dmaengine_terminate_sync() before releasing the channel, could the hardware
continue writing network frames into freed system memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780908445.gi=
t.zhoubinbin@loongson.cn?part=3D2

