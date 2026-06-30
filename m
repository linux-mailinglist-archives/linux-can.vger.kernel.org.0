Return-Path: <linux-can+bounces-7911-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9A9OJt0zQ2roUgoAu9opvQ
	(envelope-from <linux-can+bounces-7911-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 05:11:25 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3258C6DFFAD
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 05:11:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nyZYuVpN;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7911-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7911-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2D9B300AC96
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 03:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3372DB7B9;
	Tue, 30 Jun 2026 03:11:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D921228643A
	for <linux-can@vger.kernel.org>; Tue, 30 Jun 2026 03:11:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789082; cv=none; b=uJ0nQNAQORNXRc5+QlkbGxrQYzHacAY2WczHnzrAUThSHXG43jB8mu6PXsgS1v5/CptJzHQl67GWc0HjNJubcO2SKCrAffwZCQJ2AL+HVHoHODUQB8OxH/upwvjMdFNXREJBRujYeb73nSczEXRfMKTzJSGIWA2zmTzdJyInn/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789082; c=relaxed/simple;
	bh=Gd5BlD/Mg9b4Uze8UzOqAaZ7HTnMzho45n1aZuYpblI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sYieeaXq9uNmS2KgA/rSvHqV2rL3AUwHQXix7/6TLivLvvg9xqBcf4HtoUGOwd+yA67MdX7DIZBUtbdo4NZgY6KpWs6mjefjo9m5kR7g4vWRaHmoqAsAPpq3ryZkmCBn+Ze5lEmvF8MrHLlReBnJXEM7QaUOUXmTGYB2cDTE2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyZYuVpN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4DB1F000E9;
	Tue, 30 Jun 2026 03:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782789080;
	bh=GQM5Rk2jKgKX3Hrx4xyIzKXhdOk9C5s9cY9/9C3ljqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nyZYuVpNBC0EovNWnwsFierksoP1mo/Z4LXaGL51e8E91tuZGVL7l1VDUdxjj0soW
	 N3mxcwAJ4n8X1KtOQC11V0rQEM9n9spQD+Fea1DkdoeoTVF9DBMpZjh5Mdn3c5w9Pe
	 bP5rRcfFm5qAZZpzn9dM1uLkqF+MQKt5dshU7KLcDJeOkiuDzSV9zLMlIQz7/kN7Cn
	 2DpcAt9R5iM8NBQJ7KNzJrcrHPAHDgFCXTuSDmydy5Bg3A7wXnw7t5nBp0lJ+1iFmW
	 ND/6I7mdhReSDrZvPMqE4G9rCayf0t0kl6emOc9RDMKOo8+SYkTKIH8ifkFD5UIL1a
	 D1Ub/mxbmbrZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] can: loongson_canfd: Add RXDMA support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <ef3b5ae775bbdb739e70da51d6189b7f2eeef654.1782787997.git.zhoubinbin@loongson.cn>
References: <cover.1782787997.git.zhoubinbin@loongson.cn>
 <ef3b5ae775bbdb739e70da51d6189b7f2eeef654.1782787997.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 03:11:19 +0000
Message-Id: <20260630031120.3D4DB1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-7911-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,smtp.kernel.org:mid,loongson.cn:email,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhoubinbin@loongson.cn,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 3258C6DFFAD

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] NAPI polling loop reads incomplete CAN frames ahead of the DMA eng=
ine, corrupting the ring buffer read pointer.
- [High] DMA initialization failure breaks PIO fallback (hanging RX) and ca=
uses double-free on driver removal.

Pre-existing issues:
- [High] Missing bounds check on CAN frame data length allows a heap buffer=
 overflow.
- [High] SKB allocation failure causes permanent NAPI deadlock and RX strea=
m desynchronization.
--

commit 60c5f9dce521c51839cd00b85f3676b903c1d307
Author: Binbin Zhou <zhoubinbin@loongson.cn>

    can: loongson_canfd: Add RXDMA support

    Add optional DMA support for RX path using the Loongson APB CMC DMA
    engine. When a DMA channel is successfully requested, the driver:
    - Uses DMA cyclic transfers to write incoming CAN frames directly to
      a coherent DMA buffer

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_=
canfd.c
> index 1c7381129c2b6..a4b5d9e506765 100644
> --- a/drivers/net/can/loongson_canfd.c
> +++ b/drivers/net/can/loongson_canfd.c
[ ... ]
> +static void loongson_canfd_rxdma_remove(struct loongson_canfd_priv *priv=
, struct device *dev)
> +{
> +	if (!priv->rx_ch)
> +		return;
> +
> +	dmaengine_terminate_sync(priv->rx_ch);
> +	loongson_canfd_rxdma_free(priv, dev);
> +	dma_release_channel(priv->rx_ch);
> +}
[ ... ]
> +static bool loongson_canfd_get_rxbuf_empty_in_dma(struct loongson_canfd_=
priv *priv)
> +{
> +	struct dma_tx_state state;
> +	enum dma_status status;
> +
> +	status =3D dmaengine_tx_status(priv->rx_ch, priv->rx_ch->cookie, &state=
);
> +	if (status !=3D DMA_IN_PROGRESS)
> +		return true;
> +
> +	return priv->last_res =3D=3D (state.residue / DMA_SLAVE_BUSWIDTH_4_BYTE=
S);
> +}

[Severity: High]
Could this implementation cause the CPU to read incomplete frames ahead of =
the=20
DMA engine?

The cyclic DMA engine writes to memory word-by-word. As soon as the DMA=20
transfers a single word (like meta0), the residue changes and this function=
=20
returns false.

Because the NAPI loop executing on the CPU is faster than the DMA engine, i=
t=20
appears loongson_canfd_rx() will unconditionally read the entire frame=20
(including meta1 and data words) before the DMA engine has actually transfe=
rred=20
them.=20

Does this structurally guarantee stream desynchronization and data corrupti=
on=20
under load?

[ ... ]
> @@ -999,10 +1143,10 @@ static void loongson_canfd_read_rx_frame(struct lo=
ongson_canfd_priv *priv, struc
> =20
>  	/* Data */
>  	for (i =3D 0; i < len; i +=3D LOONGSON_CANFD_DW_BYTE)
> -		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, (u32 *)(cf->data + i=
));
> +		*(u32 *)(cf->data + i) =3D priv->get_rx_data(priv);
> =20
>  	while (unlikely(i < wc * LOONGSON_CANFD_DW_BYTE)) {
> -		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
> +		priv->get_rx_data(priv);
>  		i +=3D LOONGSON_CANFD_DW_BYTE;
>  	}
>  }

[Severity: High]
This is a pre-existing issue, but is it possible for `len` to exceed the si=
ze=20
of `cf->data` and cause a heap buffer overflow?

The `cf->data` buffer is a fixed 64-byte array. `len` is calculated based o=
n=20
the RWCNT field from meta1, but there appears to be no bounds check verifyi=
ng=20
that `len <=3D CANFD_MAX_DLEN`.=20

If the hardware provides a malformed RWCNT, or if the CPU reads garbage dat=
a=20
as meta1 (due to the DMA race mentioned above), won't this write past the e=
nd=20
of the allocated SKB and corrupt the `skb_shared_info` and adjacent heap me=
mory?

[ ... ]
> @@ -1291,12 +1436,11 @@ static int loongson_canfd_rx_napi(struct napi_str=
uct *napi, int quota)
>  	if (rxbuf_is_empty && ret !=3D 0) {
>  		if (napi_complete_done(napi, work_done)) {

[Severity: High]
This isn't a bug introduced by this patch, but what happens if SKB allocati=
on=20
fails inside loongson_canfd_rx()?

Looking at loongson_canfd_rx(), if alloc_can_skb() or alloc_canfd_skb() fai=
ls=20
due to memory exhaustion, it returns 0 immediately without consuming the re=
st=20
of the frame's words:

	if (unlikely(!skb))
		return 0;

This seems to cause two separate issues:
1. It desynchronizes the data stream, as subsequent polls will misinterpret=
=20
   remaining payload words as the headers of the next frame.
2. It breaks the NAPI loop because `ret =3D=3D 0` causes this completion co=
ndition=20
   (`rxbuf_is_empty && ret !=3D 0`) to evaluate to false.=20

By skipping napi_complete_done() and returning a value less than the quota,=
 the=20
NAPI state bit NAPIF_STATE_SCHED remains permanently set but removed from t=
he=20
poll list. Doesn't this permanently deadlock the receiver until a module re=
load?

[ ... ]
> @@ -1646,6 +1791,24 @@ static int loongson_canfd_probe(struct platform_de=
vice *pdev)
>  	ndev->ethtool_ops =3D &loongson_canfd_ethtool_ops;
>  	SET_NETDEV_DEV(ndev, dev);
> =20
> +	priv->get_rx_data =3D loongson_canfd_get_rxdata_in_poll;
> +	priv->get_rxbuf_empty =3D loongson_canfd_get_rxbuf_empty_in_poll;
> +
> +	priv->rx_ch =3D dma_request_chan(dev, "rx");
> +	if (PTR_ERR(priv->rx_ch) =3D=3D -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
> +	if (IS_ERR(priv->rx_ch)) {
> +		dev_warn(dev, "Fall back in poll mode for any non-deferral error.\n");
> +		priv->rx_ch =3D NULL;
> +	}
> +
> +	ret =3D loongson_canfd_rxdma_init(ndev);
> +	if (!ret) {
> +		priv->get_rx_data =3D loongson_canfd_get_rxdata_in_dma;
> +		priv->get_rxbuf_empty =3D loongson_canfd_get_rxbuf_empty_in_dma;
> +		priv->last_res =3D LOONGSON_CANFD_RXDMA_NUM;
> +	}
>  	netif_napi_add(ndev, &priv->napi, loongson_canfd_rx_napi);

[Severity: High]
What happens if loongson_canfd_rxdma_init() fails?

If loongson_canfd_rxdma_init() returns an error (e.g., dma_alloc_coherent f=
ails),=20
it frees the buffer but does not clear priv->rx_ch or release the channel. =
The=20
probe function ignores the error and proceeds with the intent to fall back =
to PIO.

However, since priv->rx_ch remains non-NULL, loongson_canfd_chip_start() wi=
ll=20
incorrectly configure the controller to use the DMADI interrupt instead of =
the=20
RBNEI PIO interrupt, permanently breaking reception.

Additionally, upon module removal, loongson_canfd_rxdma_remove() checks=20
priv->rx_ch and calls loongson_canfd_rxdma_free() again. Since the buffer w=
as=20
already freed during the failed init, won't this trigger a double-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782787997.gi=
t.zhoubinbin@loongson.cn?part=3D2

