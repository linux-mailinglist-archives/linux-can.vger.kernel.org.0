Return-Path: <linux-can+bounces-7847-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eQfPOWISMWqxbAUAu9opvQ
	(envelope-from <linux-can+bounces-7847-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 11:07:46 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB4F68D603
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 11:07:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TtCRDCO1;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7847-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7847-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDCEF300A48A
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 09:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C2A30E84F;
	Tue, 16 Jun 2026 09:07:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A058A40B6E0
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 09:07:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781600864; cv=none; b=i+ahORfCzNLL/NfpXKgeWB7BBVNALckq/XAiX19g2IOJf1FE6cHjgRGE/Nzp5t7tpPtqMP7qUSxMyhna09guEejmOIG4tBhBsaOH/mZqNezPrvxyoEooNMYn9SfxwkBxBYJY/5/bT0AOCJ284ebJJvvn1jdXUMAoQ2GxrWw+flo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781600864; c=relaxed/simple;
	bh=khNONeL1JU6u26ub/RMJZpgdgupFFV8nzcTh2Igxlok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pl84dNRZlnuZAsim/YDZ0P/W18SzyQByDfwPsKOixDzufva5fD7o/hRJY9zfTIodU0ymEEmXXnx3bYa40+eTIzcbEHrT3BY/4eBydxGlZIhFL4iJ8Ztmpqfg1/eI2TIsZJcUPh8J+cFLA68act+CS3cwjcWxMlu9nyJH4uniIhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtCRDCO1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80BE1F000E9;
	Tue, 16 Jun 2026 09:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781600863;
	bh=zCJsAHngxISKSVO/nQSAjTsYde3BRpPcyuCiT7FLUlA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TtCRDCO1a7w4dOW6hJ8pFknv1U2q26rMybtVAguF1xwgoCm5ecXPtr3tfIxq0R/OV
	 BNnrNlZzowyDtdn19Bw/bIdyl4CBWowLD/7dIi3pIsik1MdxlhFtETzTwJ78drjK7I
	 chzWd3kQ9S8YX2q4Ne5en5tj2yUNfo4oVSJuEDX96+/EmE5pP6vmj00lX4UThmQBaM
	 fbsm4YPS+VBOQ/aOUtL+T3L9kloyGx7KJ7D5Zx7lVVigUalk+QGPVrukMYCTYn8atR
	 LUTmifJswB2U9mLCrw1C3ucKVkifNK/RAWF6Jj9YKRra/lNOYazMqu0BzKY+Z0IwLZ
	 8D9v1NpWIDQCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] can: mcp251xfd: Add ACPI device ID table for
 MCP251XFD
Reply-To: sashiko-reviews@lists.linux.dev
To: guoqi0226 <guoqi0226@163.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260616085359.89406-2-guoqi0226@163.com>
References: <20260616085359.89406-2-guoqi0226@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 09:07:42 +0000
Message-Id: <20260616090742.E80BE1F000E9@smtp.kernel.org>
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:guoqi0226@163.com,m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7847-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
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
X-Rspamd-Queue-Id: 7FB4F68D603

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Undocumented removal of `netdev_info` print in `mcp251xfd_handle=
_txatif`.

Pre-existing issues:
- [High] Infinite loop / interrupt storm in `mcp251xfd_irq` due to unhandle=
d `TXATIF` interrupt flag.
- [High] NULL pointer dereference when retrieving match data if the device =
is bound manually via sysfs `driver_override`.
--

commit ac99a03d44f8633aff78ad69c67bdd4c8da1aa29
Author: guoqi0226 <guoqi0226@163.com>

can: mcp251xfd: Add ACPI device ID table for MCP251XFD

This patch adds an ACPI match table for the MCP251XFD CAN controller,
enabling driver binding on ACPI-enumerated SPI platforms.

> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net=
/can/spi/mcp251xfd/mcp251xfd-core.c
> index 92a86083c8962..0319673707289 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c

[ ... ]

> @@ -982,7 +983,6 @@ static int mcp251xfd_handle_rxovif(struct mcp251xfd_p=
riv *priv)
> =20
>  static int mcp251xfd_handle_txatif(struct mcp251xfd_priv *priv)
>  {
> -	netdev_info(priv->ndev, "%s\n", __func__);
> =20
>  	return 0;
>  }

[Severity: Medium]
Is this removal intentional? The commit message only mentions adding an
ACPI match table, but this modifies the interrupt handler by removing
a debug print. If it is intentional, should it be mentioned in the
commit message?

[Severity: High]
This is a pre-existing issue, but does this empty function cause an
infinite interrupt loop?

Because TXATIF is not part of MCP251XFD_REG_INT_IF_CLEARABLE_MASK, the
hardware flag must be manually cleared in the FIFOSTA register. Since
mcp251xfd_handle_txatif() returns 0 without clearing the flag, won't
the do-while loop in mcp251xfd_irq() continually read TXATIF as pending
and loop infinitely?

[ ... ]

> @@ -2212,6 +2212,14 @@ static const struct spi_device_id mcp251xfd_id_tab=
le[] =3D {
>  };
>  MODULE_DEVICE_TABLE(spi, mcp251xfd_id_table);
> =20
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id mcp251xfd_acpi_match[] =3D {
> +	{ "MCHP15FD", (kernel_ulong_t)&mcp251xfd_devtype_data_mcp251xfd},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, mcp251xfd_acpi_match);
> +#endif
> +
>  static int mcp251xfd_probe(struct spi_device *spi)
>  {
>  	struct net_device *ndev;

[Severity: High]
This is a pre-existing issue, but is it safe to unconditionally
dereference the match data retrieved in this function?

Later in mcp251xfd_probe(), the driver does:

priv->devtype_data =3D *(struct mcp251xfd_devtype_data *)spi_get_device_mat=
ch_data(spi);

If the driver is bound manually via the sysfs driver_override attribute
without matching any table entries, spi_get_device_match_data() will
return NULL, which would cause a panic when dereferenced. Should there
be a check for NULL before dereferencing it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616085359.8940=
6-1-guoqi0226@163.com?part=3D1

