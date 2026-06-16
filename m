Return-Path: <linux-can+bounces-7842-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C8t+F2G/MGoFXAUAu9opvQ
	(envelope-from <linux-can+bounces-7842-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 05:13:37 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A6F68BA45
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 05:13:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TtYjJlIh;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7842-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7842-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5ABC23012B1A
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 03:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783A93C0A06;
	Tue, 16 Jun 2026 03:13:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F47380FCF
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 03:13:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781579613; cv=none; b=uXjI1Mhx6xRUPfMRwb0RtBQ5fbqryLZbtImtlT9VVRyIvjXDnytOAsd8XtE9mi1X+hMZg5WoWXf7FNe7LyfkFC86vs0KzghUMKt8UopbFom2MCIhDbBUoq9RLRYaQtiws6O6X3LVD7DVyfM3woH9auk/8WOwQLxNPk+P6g39CVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781579613; c=relaxed/simple;
	bh=ICnzlxF9kmvuYx9L9b4p6CP/d/o8orKvEowz1HWuzYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jk947OGPdy/hWcGo1iPR9VOjhaXSbfIQ53InFaTBlUGk59gC2WvUM6JqdC2UMSIzO4J2BP9pTkmlFPI3dXAiYpe34YzBPtsIUgoIrT0/tgBEhnNjCh98c0Fd+T7Ywlqmo4+K4qcvlCC+9EwtJ4Sa/lk6eCDz6Bj7ovpp39D7B/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtYjJlIh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F34C1F000E9;
	Tue, 16 Jun 2026 03:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781579612;
	bh=jIWSHjaMbOxEqQ/HjLQD3GSy64J9s8wAApIDhP/8aR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TtYjJlIhVHEYKqrXaB7Y0ha+zIU3/dyk2EqI32ycpZD//ID+7CvhiRP6o3/Fo7WfN
	 678ZGhtIIgFDDHQmRrT3gEkz1RzyF3Lm8ThdbTx6I5b7uPq0DtY4Mqwsa8n+t2Op8S
	 avjfVBc8ZUYkczRXWun0MEZfpefbRwZNy4+Ap4cDkfZxQykIm2nCi7YigLi4UfCu4M
	 7eoQIymNMUfYKud+NEhz18CFxb11Z0nEOp/ooy9dfXKKPOVe3tkgEtf39p4wqCPpdM
	 jsMXKwMQ8A5iezqSXzAaWBepfMzNq6HGgw+uhYvXzy6oZ1a/l4x6Nb7KxCfAqTxkhz
	 yUSdvLQXMPxJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] can: mcp251xfd: Add ACPI device ID table for
 MCP251XFD
Reply-To: sashiko-reviews@lists.linux.dev
To: guoqi0226 <guoqi0226@163.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260616030019.35845-2-guoqi0226@163.com>
References: <20260616030019.35845-2-guoqi0226@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 03:13:31 +0000
Message-Id: <20260616031332.0F34C1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:guoqi0226@163.com,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7842-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,lists.linux.dev:replyto];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2A6F68BA45

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The ACPI Hardware ID (HID) 'MCP251XFD' violates the ACPI specificat=
ion format and length requirements.
--

commit 1d6ad13eeda40da0f75db78e76e1e476fdd6965b
Author: guoqi0226 <guoqi0226@163.com>

can: mcp251xfd: Add ACPI device ID table for MCP251XFD

This patch adds an ACPI match table for the MCP251XFD CAN controller to
enable driver binding on ACPI-enumerated SPI platforms.

> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net=
/can/spi/mcp251xfd/mcp251xfd-core.c
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
[ ... ]
> @@ -2212,6 +2213,14 @@ static const struct spi_device_id mcp251xfd_id_tab=
le[] =3D {
>  };
>  MODULE_DEVICE_TABLE(spi, mcp251xfd_id_table);
> =20
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id mcp251xfd_acpi_match[] =3D {
> +	{ "MCP251XFD", (kernel_ulong_t)&mcp251xfd_devtype_data_mcp251xfd},

[Severity: Low]
Does this ACPI Hardware ID violate the ACPI specification length and format
requirements?

According to the ACPI specification, a valid ACPI HID must be exactly 8
characters long (typically 4 uppercase letters followed by 4 hexadecimal
digits) or a 7-character PNP ID. The string "MCP251XFD" is 9 characters
long and does not end in hex digits.

Could this be avoided by using the generic "PRP0001" HID in the firmware
instead?

By providing the OF compatible string ("microchip,mcp251xfd") via the ACPI
_DSD table, the existing mcp251xfd_of_match table would handle the
enumeration without requiring any ACPI-specific driver changes.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, mcp251xfd_acpi_match);
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616030019.3584=
5-1-guoqi0226@163.com?part=3D2

