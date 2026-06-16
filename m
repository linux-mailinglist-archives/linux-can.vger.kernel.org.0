Return-Path: <linux-can+bounces-7856-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8suHKlInMWpdcwUAu9opvQ
	(envelope-from <linux-can+bounces-7856-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 12:37:06 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CCF68E60A
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 12:37:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gZKvuAqm;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7856-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7856-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8DFF304A6AA
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 10:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CDE42E009;
	Tue, 16 Jun 2026 10:35:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B5C42B74A;
	Tue, 16 Jun 2026 10:35:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606148; cv=none; b=uRYZmykZJ/zQPI94sSc9S3sZEQAGASmwG4g1UnU16HMn0Ct/en4IxUbvG2XxvQT/tjWyNlehB9aQXjkd+6h5x0l2T07NHKe1VP33h2V/qGbfrlAdSIxpyfPbTAUThvRjYGv09UHRUUh1MHrcD53HgyWeo9AopGaomraMTRFi+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606148; c=relaxed/simple;
	bh=q6GMZ8l6dmAW9qA/mMYBaPem5kkLiWzFwyAP7rClnxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQTfO9MhJg9ygkJTWW4ppg2KAGZ8NjDKcG3XlCEyuO7hm273L8529U0l0RRW4aDWHpM2vSxPnKixg2kaDWO4jSSH0d1/+xcC8iGhJYEUtyb7hmdJ/+Hbuqwe+vxGN5IWCxI4Of/66ZLy+KhC8shEtG7QYBwGAmdEcnsWvYtg7QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZKvuAqm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295AB1F000E9;
	Tue, 16 Jun 2026 10:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781606146;
	bh=XJRIemPytV1aguctNVZZ7Efd5w5Kogtqo/i30RRjt0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gZKvuAqmubQT8pWMQdfmuJz4HqNW46GbKO74ppRYG1KaAyHsYESgJkp+o7Lt81Dk5
	 +0BIplzvolOB85QK49K9ssXVvKuw58FJdV4nVX+0bVj8zBeJwL6pNmvd1czu8SFTgc
	 5mE9eu7fqqdcIBtA5qLVJ++3ywCKFnDkNikUSXIEcfIsYrSVoyWUNol18qik7xmIRQ
	 m57AWP8eLozyWm5SSQ/CaNkLL+Qr+VtZZEh8tGPQIxCKnb+1+I2rEs/v/Zi4f9prOn
	 6HOIpCcb730w/dH52JS6ZbP5qdDYp4iOJ7cWYIwVz9cb8W73F2uPn+X1h77fl5SXOk
	 uXE/umqtZ96bA==
Date: Tue, 16 Jun 2026 11:35:42 +0100
From: Mark Brown <broonie@kernel.org>
To: guoqi0226 <guoqi0226@163.com>
Cc: sashiko-bot@kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org,
	mailhol@kernel.org, o.rempel@pengutronix.de,
	sashiko-reviews@lists.linux.dev, socketcan@hartkopp.net,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 0/2] can: mcp251xfd: Add ACPI device ID table for
 MCP251XFD
Message-ID: <997991e6-0e09-47eb-a6ac-5f455ddc250a@sirena.org.uk>
References: <20260616092614.00ED51F00A3D@smtp.kernel.org>
 <20260616103018.105612-1-guoqi0226@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yFb1XlutYJnaVOoW"
Content-Disposition: inline
In-Reply-To: <20260616103018.105612-1-guoqi0226@163.com>
X-Cookie: Password:
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:guoqi0226@163.com,m:sashiko-bot@kernel.org,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:sashiko-reviews@lists.linux.dev,m:socketcan@hartkopp.net,m:linux-spi@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[broonie@kernel.org,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-7856-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sirena.org.uk:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12CCF68E60A


--yFb1XlutYJnaVOoW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2026 at 06:30:16PM +0800, guoqi0226 wrote:
> hanges in v4:
> - Split into two separate patches:
>   1. SPI core: add internal NULL guard for spi_get_device_match_data()
>   2. mcp251xfd driver: cache and validate match data pointer in probe
> - Remove duplicate spi_get_device_match_data() invocation and unsafe dereference

Why is this a series, are there any dependencies between these two
patches?

--yFb1XlutYJnaVOoW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoxJv0ACgkQJNaLcl1U
h9BVAQf+LlIoxb9QviU7zuSrpS6s2Qar3R7TbO12N2S/XcjwYnU7kEYRqBCgYaxh
2SGHOFcfkUu7pmIVDHXFA0K2DX0BDHDoah3LPH5CtfCHU8XJfWoqu5YMlk5P5eni
wSyc/IlDO02PzXAIwFXN2i3fcqtmtBLD1Gn1UHtyrmtT5fcN+VNXK+dczDuOxH6g
fpT+WZfpz/Zq0E/FOmTgk2Ntf27kyzHuHWSd3/AdFYCPrZ01RQJVIOtuvJVCaoF8
NTViKsVfgcm9KNAloZlXuM5ZiaDTEAkwjrj50w+VQOuwCxCIBcTDGnxSLN2Uk20m
gR1vF+4R+QjFa7fmWiXoKub3WThYRQ==
=nd1y
-----END PGP SIGNATURE-----

--yFb1XlutYJnaVOoW--

