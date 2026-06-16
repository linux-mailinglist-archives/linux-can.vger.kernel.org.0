Return-Path: <linux-can+bounces-7857-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ehFPHqIpMWrlcwUAu9opvQ
	(envelope-from <linux-can+bounces-7857-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 12:46:58 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC59968E6F7
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 12:46:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ffII+9Rf;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7857-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7857-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC97A313A468
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 10:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312BC42EED1;
	Tue, 16 Jun 2026 10:45:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E3A436355
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 10:45:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606714; cv=none; b=mvEQysSGWA40auiaEZAgsPRtpIyZ8GGPwYKVySkbLJn8Aa6qL8DJH/PEKnkZ8zv7XrCBD9CUlUSKhcWTk2AbkZ7BqxiqUuU7jECm2iTgas34IF/OpUpVukhIkCUEgnLvI7V0Ji6lAwJ/PzHOh70Ns4nU0dkPfzN4MpdKM8UDfuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606714; c=relaxed/simple;
	bh=HbW/qKvcdJKFpTvsPemnC3kIBCto7kYcyRbwG+4WS/c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o3zsHUuaKy823bnqG80kYNrd5MHBh1lgeJGKhR8BJxf6dNEu3J0FjkGrzA0MrolSuG3PgFxU/xcdYwC7ERRuggS43fxm/spCFuLwHcwtyBtYkTp3G4nX4wuWWhjQ7AqB33G69kzKRnrx7smcl1uhCEBF+l7uqRMxijpJW+rOA9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffII+9Rf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9CC1F000E9;
	Tue, 16 Jun 2026 10:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781606712;
	bh=s/NR1/fjjUagXpC9XjYkgwsoAANXNtKJG3eP+Uv1XVE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ffII+9Rf1L9oGxCJ9aGk6l+PXgnm2HoPC79pJmy9Y3L78IQmStKHk7aUP++zt2urJ
	 RasHSVbBHB+mE4bl3R0EYxGbl7Z+5CI1qeXAD0R1NL8BsZSujvA7eVx/6/oMKVhE6q
	 2m3gOowGLPX+vmI3nOq6WapWF/ZuJkBU5Y9sVcrXuf4mWvgaE4p/Sh967hYuJQxWK7
	 t6xlOxG+Aua1FuoLHdkMXLxJaPWzak9ZnpHWeBoSTIhBOFcIeEoyqeLo6aP65gGCOK
	 JcgQYE0ko2bDlafvjrfVMSYOZcseBDmrgCCUq4EUc/rvn0JucqJDLpMmvi9QZTRn0r
	 Ue5zIAmLtrolA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] spi: Add NULL check for spi_get_device_id() in
 spi_get_device_match_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: guoqi0226 <guoqi0226@163.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260616103018.105612-3-guoqi0226@163.com>
References: <20260616103018.105612-3-guoqi0226@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 10:45:11 +0000
Message-Id: <20260616104511.DD9CC1F000E9@smtp.kernel.org>
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
	FORGED_RECIPIENTS(0.00)[m:guoqi0226@163.com,m:mkl@pengutronix.de,m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7857-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto];
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
X-Rspamd-Queue-Id: EC59968E6F7

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] spi_get_device_id() unconditionally dereferences a potentially NUL=
L id_table pointer
- [High] Direct callers of spi_get_device_id() unconditionally dereference =
its result
- [High] Callers of the patched spi_get_device_match_data() unconditionally=
 dereference its NULL return value
--

commit 7e155f379f89eda6ab91795ac56410fd02c722be
Author: guoqi0226 <guoqi0226@163.com>

spi: Add NULL check for spi_get_device_id() in spi_get_device_match_data()

Prevent NULL pointer dereference when spi_get_device_id() returns NULL,
which can happen when using driver_override without matching SPI ID entry.

> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 104279858f567..079ac01a2229d 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -355,12 +355,16 @@ EXPORT_SYMBOL_GPL(spi_get_device_id);
>  const void *spi_get_device_match_data(const struct spi_device *sdev)
>  {
>  	const void *match;
> +	const struct spi_device_id *id;
> =20
>  	match =3D device_get_match_data(&sdev->dev);
>  	if (match)
>  		return match;
> =20
> -	return (const void *)spi_get_device_id(sdev)->driver_data;
> +	id =3D spi_get_device_id(sdev);

[Severity: High]
This is a pre-existing issue, but can spi_get_device_id() itself crash
if sdrv->id_table is NULL?

If a spi driver only provides a device tree or acpi match table and lacks
an id_table, sdrv->id_table will evaluate to NULL. When spi_get_device_id()
is called, it passes this NULL pointer to spi_match_id():

drivers/spi/spi.c:spi_get_device_id() {
    ...
    return spi_match_id(sdrv->id_table, sdev->modalias);
}

spi_match_id() then unconditionally evaluates id->name[0] in its while loop:

drivers/spi/spi.c:spi_match_id() {
    ...
    while (id->name[0]) {
    ...
}

Would this result in a NULL pointer dereference when driver_override is use=
d?

[Severity: High]
This is also a pre-existing issue, but do many direct callers of
spi_get_device_id() unconditionally dereference its result?

For example, in drivers/iio/adc/max1118.c:max1118_probe():

    indio_dev->name =3D spi_get_device_id(spi)->name;

If driver_override is used to force a bind to a device whose modalias
does not match the driver's id_table, spi_get_device_id() can return NULL.
Does this mean individual spi drivers might immediately crash if they
don't check the return value?

> +	if (!id)
> +		return NULL;

[Severity: High]
This isn't a bug introduced by this patch, but will returning NULL here just
shift the crash to callers that don't check the return value?

For example, in drivers/gpu/drm/tiny/sharp-memory.c:sharp_memory_probe():

    smd->mode =3D spi_get_device_match_data(spi);
    ...
    smd->pitch =3D (SHARP_ADDR_PERIOD + smd->mode->hdisplay + ...) / 8;

If spi_get_device_match_data() returns NULL when driver_override is used,
will callers unconditionally dereference it and still cause a kernel panic?

> +	return (const void *)id->driver_data;
>  }
>  EXPORT_SYMBOL_GPL(spi_get_device_match_data);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616103018.1056=
12-1-guoqi0226@163.com?part=3D2

