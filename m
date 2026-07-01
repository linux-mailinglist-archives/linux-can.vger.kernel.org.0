Return-Path: <linux-can+bounces-7933-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hw86K7qRRGo8xAoAu9opvQ
	(envelope-from <linux-can+bounces-7933-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 06:04:10 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4523D6E99C9
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 06:04:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=En1Qet40;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7933-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7933-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA47030AFEE1
	for <lists+linux-can@lfdr.de>; Wed,  1 Jul 2026 03:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC40369D5C;
	Wed,  1 Jul 2026 03:56:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBBB36604B;
	Wed,  1 Jul 2026 03:56:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878171; cv=none; b=oXNAeiNm66QvJfwupl6FuAHW2O+A1V9brPL/82kZW0a35xI1SvPWnyc2wt0IynUMEi7rlmHmsBvYZtVVX2iOMFT3kZobkPZm4y6eiidp7bPqTAXtkhn2qAxeh1JxnnGsSpXhVjECoTWg57KBvgzhdcGD8+ZSK1PZVdKZ5Bo3sdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878171; c=relaxed/simple;
	bh=V42AFfF45yW7Jm7jlo/qFOfzYwrYr3Gz33RednS3Il0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P7cWEBLGWpbNF7BR/RlVxpec/9zrt+BPGOnp7YXTwvZwVEuA6H/AMVP+Sq2n1Z5dwuVaFsuDOnrSFfDBAbvfZTyrhu7Bu/r4s5aIX3GZRCJc6TOHDECxM3+dM7lpR8v1roa/o8iLFCuqPYgmaPEVvkI7Eida7QUgUd18UALV/Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=En1Qet40; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388941F000E9;
	Wed,  1 Jul 2026 03:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782878167;
	bh=V42AFfF45yW7Jm7jlo/qFOfzYwrYr3Gz33RednS3Il0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=En1Qet40doNOOqEFLxyMsNua1dtr3129A/21xhuq/V5smNix47YnQNP/ChJECtKhv
	 y+GZLNz86v1mgIpVbNd6M3kWPrTztBmvldiysmRiDrySDb+U9AiKPcW2eCv9Z9adds
	 Gtdd9DfeB7X3mq1DiHW5iCynfgMyqIgM7jQwfrmje8XpV3Q3AG3O2Dtuzwds39XJ9h
	 YkWtKMt0N6ZACX86Jv2cfvpVR1aRDVMxXnvpVf0h2GO0bh/rBQS/Y2aSEKn7Hxl8AZ
	 pL6gh6k+XK7wgyyaVLebmjwf3LmhTuI3MBikA9yKLuCC+Jk1UDIGZrN1l5enjnqDfR
	 rcgsCMzaeV1wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/7] mfd: nct6694: Move module type macros to shared
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: a0282524688@gmail.com
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-hwmon@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, linux-watchdog@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260701035025.3082927-2-a0282524688@gmail.com>
References: <20260701035025.3082927-1-a0282524688@gmail.com>
 <20260701035025.3082927-2-a0282524688@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 03:56:06 +0000
Message-Id: <20260701035607.388941F000E9@smtp.kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-7933-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:a0282524688@gmail.com,m:mailhol@kernel.org,m:socketcan@hartkopp.net,m:linux-rtc@vger.kernel.org,m:alexandre.belloni@bootlin.com,m:linux-hwmon@vger.kernel.org,m:mkl@pengutronix.de,m:linux-watchdog@vger.kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4523D6E99C9

> From: Ming Yu <a0282524688@gmail.com>
>=20
> Move NCT6694_XXX_MOD macro definitions from individual sub-device
> drivers into the shared header include/linux/mfd/nct6694.h.
>=20
> This is a prerequisite for supporting multiple transport interfaces
> (USB, HIF) without duplicating these definitions.
>=20
> No functional change.
>=20
> Signed-off-by: Ming Yu <a0282524688@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035025.3082=
927-1-a0282524688@gmail.com?part=3D1


