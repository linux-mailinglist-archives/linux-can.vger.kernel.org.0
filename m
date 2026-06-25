Return-Path: <linux-can+bounces-7896-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sfs0OZ3BPGqSrQgAu9opvQ
	(envelope-from <linux-can+bounces-7896-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 07:50:21 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 573426C2D96
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 07:50:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X0yP1rgA;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7896-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-7896-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B57B5300D149
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 05:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89763BCD37;
	Thu, 25 Jun 2026 05:50:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DF53BBA1D
	for <linux-can@vger.kernel.org>; Thu, 25 Jun 2026 05:50:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782366616; cv=none; b=Mtli3Be0EbBLcjlFFocI6OxVLrFAqx1GeA7VWK9oPOMOCr3levX58ocKBKfnpgiE8Roc07+RzpqUNRw0vdtbp6fXv+G/rdox6Y4iCkVYCga6vwbapoOVFNkOvjk9+lk+z07WVr+jRcrNJGgsKuXu8GjSYOTqBx4CL/Dqb8XsVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782366616; c=relaxed/simple;
	bh=+dWZzlo7ahWKuX5SL0m1hF/+WXPjUU0s/FcnemCSwRg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PtAUQ64MEZ8tn0+JiqI+C4RG0EYBSm5KMwHd7dJWFkQjdvTaHhq09yvaRyU9oryjKhUXPDvj3tSSj74tdK6iuBvVfTAMvHIY6Zt1oAwT0+UrxYyC6aBVKm2DEM2kUt5Bv/3LLAykzMNrMKrefZpIcZVymqmiLhDkhsi5SdOoscw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0yP1rgA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37F31F00A3A;
	Thu, 25 Jun 2026 05:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782366615;
	bh=f9mBSANLpRyo+g9+iykpEo2KDASZDR0YdZShZwEc5SY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X0yP1rgA4NDFQSs2oDGE1+GleOsqkMaVPBbR4XYGwCoVu5meAIUU3E3m1aEdfWjrP
	 xbXx/7xWKSZKxZYsYiyj7rN5mLCOelIqTFwt6xZ2yAjpcaR4a+633N1oDK8OevFDcP
	 HPppVfU/1JU2rhAqrvyv/tKrmUqJZqpOBEJTyHaQBYMWu4nFuwhjzJE/gXWzf3P7Cg
	 xRYwvy1hrE0NDgVfw/qUuj04k3AuqdxzWKQSjgY3doHnlPaFJ11582E1Ww3aiTeILV
	 6BraxFChrflexuqJbzGllfBVkeXHdkfhMEUmXyKQIEM7mfDRU27iKIRXMsetYx/FGY
	 61ZSSiKD3Igrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] can: c_can: Use platform id data when OF data is
 absent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260625054152.68413-1-pengpeng@iscas.ac.cn>
References: <20260624054927.22851-1-pengpeng@iscas.ac.cn>
 <20260625054152.68413-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 05:50:14 +0000
Message-Id: <20260625055014.F37F31F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7896-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:socketcan@hartkopp.net,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 573426C2D96

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the regression f=
ixed by this patch in `c_can_platform.c` is also present in `flexcan-core.c=
`, which was modified by the same original commit but remains unfixed. Comm=
it 5e6c3454b405 incorrectly replaced `of_match_device()` and `platform_get_=
device_id()` checks with a single call to `device_get_match_data()`. Becaus=
e `device_get_match_data()` does not fall back to `platform_device_id` tabl=
es, any driver matching via platform ID will receive a NULL pointer. In `fl=
excan-core.c`, the legacy non-DT platform "flexcan-mcf5441x" is matched via=
 `flexcan_id_table`. When probed, `device_get_match_data()` returns NULL, w=
hich `flexcan_probe()` immediately dereferences (`devtype_data->quirks`), r=
esulting in a kernel panic.
--

commit c16eef82e68ac57940a1f18250576d39cf8e239b
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

can: c_can: Use platform id data when OF data is absent
   =20
The platform driver keeps controller metadata in both the OF match table
and the platform id table. Probe reads the metadata with
device_get_match_data(), which does not fall back to platform id-table
driver_data.

When the device is matched through the platform id table, drvdata can
therefore be NULL before it is dereferenced for msg_obj_num and the
controller type. Fall back to platform_get_device_id() when firmware
match data is not available.

> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_c=
an/c_can_platform.c
> index 19c86b94a40e4..d3529b4cc856e 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -266,6 +266,14 @@ static int c_can_plat_probe(struct platform_device *=
pdev)
>  	struct device_node *np =3D pdev->dev.of_node;
> =20
>  	drvdata =3D device_get_match_data(&pdev->dev);
> +	if (!drvdata) {
> +		const struct platform_device_id *id;
> +
> +		id =3D platform_get_device_id(pdev);
> +		if (!id)
> +			return -ENODEV;
> +		drvdata =3D (const struct c_can_driver_data *)id->driver_data;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but this patch fixes a regression
that seems to also be present in another driver modified by the same origin=
al
commit (5e6c3454b405).

In drivers/net/can/flexcan/flexcan-core.c in flexcan_probe(), the driver
matches via flexcan_id_table for the legacy non-DT platform flexcan-mcf5441=
x:

    devtype_data =3D device_get_match_data(&pdev->dev);

    if ((devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) && ...

When probed on a non-DT platform device, device_get_match_data() returns
NULL, which is immediately dereferenced.

Should a similar fallback to platform_get_device_id() be added to
flexcan_probe() to prevent a NULL pointer dereference on these platforms?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625054152.6841=
3-1-pengpeng@iscas.ac.cn?part=3D1

