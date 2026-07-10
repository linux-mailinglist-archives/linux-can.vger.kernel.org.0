Return-Path: <linux-can+bounces-8269-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yhUxJUKuUGp73QIAu9opvQ
	(envelope-from <linux-can+bounces-8269-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 10:33:06 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2EC738843
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 10:33:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=d1HlB4TW;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8269-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8269-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 442C23005ABB
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 08:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09F73EEAE0;
	Fri, 10 Jul 2026 08:32:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFED3D8133
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 08:32:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672379; cv=none; b=g7I+rTDO/6vpsCp9JsQrwM2xNL7jMAvQjQFRj9kCW0JprI9cNFsCVUK+4yMosHXjKdOrOGTXYCbz5YeFEYwhJxKUy9QtdQlIcaZkhCh6UQOzf3vpbWFr1evBZXLC3mA76Vvh9PkkkIe7+ExlqUP8/DfoARPyV65Lefm94BVKncY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672379; c=relaxed/simple;
	bh=OnpcFykLnFmkJFxCJMqjn5qIMndOraXdoDoaTewL4kM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UbyOHBNutC2hgREm5q7KsoZ2KE3G23s9dIEUEtb23vLRJUIllkotUG/zmcNx64FMwAgrPU0BDDIaV/+7bC35rEJx+Sautem+7i0m2JaDU/pB/MbOpv22NGr1HYLOOhTV4yjonRXmBLp9G/DB2y3CrEh5G34hqswON4Lbg8ePuYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1HlB4TW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B437C1F000E9;
	Fri, 10 Jul 2026 08:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783672378;
	bh=WBQwe/IkZBxdTF+iWnP4yabk3G5sf52/xYN5TXHpP04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d1HlB4TWKRtFf7wtYp4OSLSs5n2/7Mjt5XShxuvj6eTI6GuRuENvDmLP1sj/8au7u
	 6Z9omzQprFDo/2l9MzWtL3/Lc3FUlrJOvg+3+IVkQAiiCDj7nYXAXnnXH/8DXig2F8
	 /Dq7g3zbA+GVwK5nncOX/ZD1rpiiAHFklzE2wOn702otqlc1mEDTJYrDl1G+ig1+do
	 SZuQom1JNPD2vJn37ADx6NhbqJpSCcGTsOhGQoh43IDWlv4HcJXTMzZjdSYhDHNq6T
	 xf2Jlf9g4/wJoN7EBqXT7Boe2R4xIeccKIrCh7WtHjrb9GmDsO6QFsE9lZiZ6I1fPs
	 6sHyDCQxWyd3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] can: loongson_canfd: Add RXDMA support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <2f8810bf1a8c1114f837f27bac6b1d6bb9c1a99b.1783670733.git.zhoubinbin@loongson.cn>
References: <cover.1783670733.git.zhoubinbin@loongson.cn>
 <2f8810bf1a8c1114f837f27bac6b1d6bb9c1a99b.1783670733.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 08:32:57 +0000
Message-Id: <20260710083257.B437C1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8269-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,loongson.cn:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhoubinbin@loongson.cn,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE2EC738843

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] RX DMA ring buffer synchronization is flawed, allowing the CPU to =
read ahead of the DMA engine, causing data corruption and permanent desynch=
ronization.
- [High] An inverted DMA status check causes an infinite NAPI polling loop =
if the DMA channel encounters an error.
- [High] Direct MMIO reads during DMA mode in error handling paths steal da=
ta from the hardware FIFO and corrupt the DMA stream.
- [Medium] Improper error handling during DMA initialization causes a perma=
nent DMA channel leak and leaves the driver in a broken hybrid state.

Pre-existing issues:
- [Critical] Lack of bounds checking on the frame length allows a malicious=
 CAN frame or corrupted DMA state to overflow the SKB data buffer.
- [High] The NAPI poll routine causes a softirq infinite loop (CPU soft loc=
kup) if an SKB allocation fails.
--

--- Patch [2]: [PATCH v5 2/2] can: loongson_canfd: Add RXDMA support ---
commit b57ca3985f14b046d9875c2283806844564b67d5
Author: Binbin Zhou <zhoubinbin@loongson.cn>

can: loongson_canfd: Add RXDMA support

This commit extends the driver with optional DMA engine support for the
receive path. It maps a cyclic DMA transfer to continuously fill a ring
buffer to reduce MMIO accesses. The driver selects the read method
automatically based on DMA availability.

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_=
canfd.c
> index 0e85005a9bb12..bed64c15d22a6 100644
> --- a/drivers/net/can/loongson_canfd.c
> +++ b/drivers/net/can/loongson_canfd.c
> @@ -546,13 +566,141 @@ static void loongson_canfd_set_txbuf_cmd(struct ne=
t_device *ndev,
[ ... ]
> +static bool loongson_canfd_get_rxbuf_empty_in_dma(struct loongson_canfd_=
priv *priv)
> +{
> +	struct dma_tx_state state;
> +	enum dma_status status;
> +
> +	status =3D dmaengine_tx_status(priv->rx_ch, priv->rx_cookie, &state);
> +
> +	return priv->last_res =3D=3D (state.residue / DMA_SLAVE_BUSWIDTH_4_BYTE=
S) &&
> +	       (status =3D=3D DMA_IN_PROGRESS);
> +}

[Severity: High]
Does the strict equality check against the DMA residue prevent partial frame
reads? If the DMA engine is actively writing a frame when this is called, it
appears rxbuf_is_empty will evaluate to false, leading loongson_canfd_rx() =
to
read an entire frame. This could cause the CPU to read unwritten data and
decrement priv->last_res past the DMA write pointer, permanently
desynchronizing the CPU from the DMA engine.

[Severity: High]
Can the status check cause an infinite NAPI polling loop? If the DMA engine
enters an error state, status =3D=3D DMA_IN_PROGRESS evaluates to false, ca=
using
this function to return false (not empty). The NAPI loop would then repeate=
dly
call loongson_canfd_rx() to process non-existent data, leading to a CPU soft
lockup.

[ ... ]
> +static int loongson_canfd_rxdma_init(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +	struct dma_async_tx_descriptor *desc =3D NULL;
> +	struct device *dev =3D ndev->dev.parent;
> +	struct dma_slave_config config;
> +	int ret;
> +
> +	if (!priv->rx_ch)
> +		return -EINVAL;
> +
> +	priv->rx_buf =3D dma_alloc_coherent(dev, LOONGSON_CANFD_RXBUF_SZ,
> +					  &priv->rx_dma_buf, GFP_KERNEL);
> +	if (!priv->rx_buf)
> +		return -ENOMEM;

[Severity: Medium]
If this allocation fails, the function returns -ENOMEM but leaves priv->rx_=
ch
populated. During probe, this failure allows the driver to fall back to poll
mode, but since priv->rx_ch is non-NULL, does this incorrectly configure the
CAN interrupts for DMA (REG_INT_STAT_DMADI) instead of RBNEI, breaking the
receive path?

> +
> +	/* Configure DMA channel */
> +	memset(&config, 0, sizeof(config));
> +	config.src_addr =3D priv->res->start + LOONGSON_CANFD_RX_DATA;
> +	config.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> +
> +	ret =3D dmaengine_slave_config(priv->rx_ch, &config);
> +	if (ret < 0) {
> +		netdev_err(ndev, "Loongson canfd rxdma channel config failed\n");
> +		goto err_config;
> +	}
[ ... ]
> +err_config:
> +	loongson_canfd_rxdma_free(priv, dev);
> +	priv->rx_ch =3D NULL;
> +	return ret;
> +}

[Severity: Medium]
Does the err_config error path leak the DMA channel? It sets priv->rx_ch to
NULL without calling dma_release_channel() on it.

> @@ -980,8 +1131,8 @@ static int loongson_canfd_rx(struct net_device *ndev)
>  	struct sk_buff *skb;
>  	bool is_can_fd;
> =20
> -	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta0);
> -	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta1);
> +	meta0 =3D priv->get_rx_data(priv);
> +	meta1 =3D priv->get_rx_data(priv);
> =20
>  	/* Number of characters received */
>  	rwcnt =3D FIELD_GET(REG_FRAME_META1_RWCNT, meta1);
>  	if (!rwcnt)
>  		return -EAGAIN;
>  	dbcnt =3D (rwcnt - 2) * LOONGSON_CANFD_DW_BYTE;

[Severity: Critical]
This isn't a bug introduced by this patch, but is it possible for dbcnt to
exceed the SKB data buffer size? For classic CAN frames, alloc_can_skb()
allocates an 8-byte buffer. If rwcnt is large, such as from a corrupted DMA
stream or maliciously crafted frame, dbcnt could reach up to 116 bytes,
overflowing the SKB buffer.

[ ... ]
> @@ -1033,7 +1184,7 @@ static int loongson_canfd_rx(struct net_device *nde=
v)
> =20
>  	/* Data */
>  	for (i =3D 0; i < dbcnt; i +=3D LOONGSON_CANFD_DW_BYTE)
> -		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, (u32 *)(cfd->data + =
i));
> +		*(u32 *)(cfd->data + i) =3D priv->get_rx_data(priv);
> =20
>  	while (unlikely(i < dbcnt)) {
>  		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
>  		i +=3D LOONGSON_CANFD_DW_BYTE;
>  	}

[Severity: High]
Does this residual drain loop break the DMA stream by hardcoding regmap_rea=
d()
directly from the MMIO FIFO instead of using the priv->get_rx_data() callba=
ck?
In DMA mode, reading directly from the hardware FIFO steals words from the =
DMA
engine, corrupting the CAN frames before they reach RAM and bypassing the D=
MA
ring buffer pointer.

This same issue also appears in the SKB allocation failure path:

loongson_canfd_rx() {
	...
	if (unlikely(!skb)) {
		for (i =3D 0; i < dbcnt; i +=3D LOONGSON_CANFD_DW_BYTE)
			regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
		ndev->stats.rx_dropped++;
		return 0;
	}
	...
}

Does the error path need to be updated to use priv->get_rx_data() as well?

> @@ -1256,12 +1407,12 @@ static int loongson_canfd_rx_napi(struct napi_str=
uct *napi, int quota)
>  	bool rxbuf_is_empty;
>  	u32 sts;
> =20
> -	rxbuf_is_empty =3D loongson_canfd_rxbuf_empty(priv);
> +	rxbuf_is_empty =3D priv->get_rxbuf_empty(priv);
> =20
>  	while (!rxbuf_is_empty && work_done < quota && ret > 0) {
>  		ret =3D loongson_canfd_rx(ndev);
>  		work_done++;
> -		rxbuf_is_empty =3D loongson_canfd_rxbuf_empty(priv);
> +		rxbuf_is_empty =3D priv->get_rxbuf_empty(priv);
>  	}
> =20
>  	/* Check for RX FIFO Overflow */
[ ... ]
> @@ -1288,13 +1439,18 @@ static int loongson_canfd_rx_napi(struct napi_str=
uct *napi, int quota)
> =20
>  	if (rxbuf_is_empty && ret !=3D 0) {
>  		if (napi_complete_done(napi, work_done)) {

[Severity: High]
This isn't a bug introduced by this patch, but can this cause an infinite l=
oop
in softirq context? If an SKB allocation fails in loongson_canfd_rx(), it
returns 0. The while loop breaks, and since ret =3D=3D 0, the check here sk=
ips
napi_complete_done(). The NAPI instance remains on the active poll list,
causing the network core to repeatedly re-invoke the poll function until me=
mory
is available.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783670733.gi=
t.zhoubinbin@loongson.cn?part=3D2

