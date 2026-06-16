Return-Path: <linux-can+bounces-7850-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CWWkBGIXMWoAbgUAu9opvQ
	(envelope-from <linux-can+bounces-7850-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 11:29:06 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B67268D89B
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 11:29:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Z3eIHQLm;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7850-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7850-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 010E7313F522
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 09:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04274421F00;
	Tue, 16 Jun 2026 09:26:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA2E397699
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 09:26:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601975; cv=none; b=Q32WFzyJ5qgLm1V5JPseMte2aEOgHU5HAVCp+PEyyLtZNTQOfy3yKnORkZ6at6x9Jb3E9srJ6cfPfTt5M3krF5IhxMhn8WGT/L0xAOgpafJQ0bk8oxqIBh0N6Kn5nbMELNrQLZI66n4+l0fc3Lw5b0DZP85suse/MuycOwwb8N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601975; c=relaxed/simple;
	bh=LqrFuxXHlYIcCWir4U4yxfn9Z8slio4rZXibbWFCZOA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ue2nrJ04oSy3qjy091TgBvb1D1X5Bq0DivMSCfq38HowHl+n+ZJr9LfSydtViz4aU7K6F3uBgD0syxtJHrOqhqO5fbEU3+tclzd4FDMoLnYj15tNi0bCvVBnWMUHki62UyO2MjaTCEZ74hsP8/6zG/ddEmDa79dgx42Y1pXvSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3eIHQLm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00ED51F00A3D;
	Tue, 16 Jun 2026 09:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781601974;
	bh=9teeQKzEq2TN5flqcWGxhg5LcfAEMGyv44ajh3qp56Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z3eIHQLml3yrI2sx1aoxOORuoxzQTIi7Kkd/zF4dQ/rTr5aWKV09tWatZLL51TziV
	 IPa09cWbYlg4eSMIOOSxuEhdZFrIjU1nWDwQvM5kpYXh+LMKbOM5pk31oyx13+TLnJ
	 zumyjxy9jG0vw3VB1iiJxL559upEpfy7dp4ilyCU05qySOoJr+Cry5pNXzwX4gtB0n
	 O8Y280tWPJQBsuDHwo8djIgHl0L5mqAIxagYIDR/g23UEWIqc8Pomq0F9DmIeuCdTl
	 LrLbDcCgFXn7e1cOexVErPGO4eQXmsKDt7K+eeUSR+kqjeLCpufWV6KQIndArZNKIU
	 QYbC/cFkLZ07Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/1] can: mcp251xfd: Add ACPI device ID table for
 MCP251XFD
Reply-To: sashiko-reviews@lists.linux.dev
To: guoqi0226 <guoqi0226@163.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260616091640.93275-2-guoqi0226@163.com>
References: <20260616091640.93275-2-guoqi0226@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 09:26:13 +0000
Message-Id: <20260616092614.00ED51F00A3D@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:guoqi0226@163.com,m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7850-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,smtp.kernel.org:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B67268D89B

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional dereference of the pointer returned by spi_get_devic=
e_match_data() can cause a NULL pointer dereference.
--

commit 984f1d631588f571112e2f97f02bc97fcb1d8ec1
Author: guoqi0226 <guoqi0226@163.com>

can: mcp251xfd: Add ACPI device ID table for MCP251XFD

This patch adds an ACPI match table for the MCP251XFD CAN controller,
enabling driver binding on ACPI-enumerated SPI platforms.

> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net=
/can/spi/mcp251xfd/mcp251xfd-core.c
> index 92a86083c8962..0cde98f51f797 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
[ ... ]
> @@ -2442,6 +2451,7 @@ static struct spi_driver mcp251xfd_driver =3D {
>  		.name =3D DEVICE_NAME,
>  		.pm =3D &mcp251xfd_pm_ops,
>  		.of_match_table =3D mcp251xfd_of_match,
> +		.acpi_match_table =3D ACPI_PTR(mcp251xfd_acpi_match),
>  	},
>  	.probe =3D mcp251xfd_probe,

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing issue
in mcp251xfd_probe() that might cause a kernel panic.

If the SPI device is bound to the driver manually via sysfs (for example, by
writing to the driver_override and bind files), spi_get_device_match_data()
can return NULL.

In mcp251xfd_probe(), the return value is dereferenced unconditionally:

static int mcp251xfd_probe(struct spi_device *spi)
{
        ...
        priv->devtype_data =3D *(struct mcp251xfd_devtype_data *)spi_get_de=
vice_match_data(spi);
        ...
}

Could we add a NULL check here that returns -ENODEV or falls back to a
default configuration to prevent the dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616091640.9327=
5-1-guoqi0226@163.com?part=3D1

