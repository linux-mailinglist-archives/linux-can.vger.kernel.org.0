Return-Path: <linux-can+bounces-8009-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xh23JMSIS2r1UwEAu9opvQ
	(envelope-from <linux-can+bounces-8009-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 06 Jul 2026 12:51:48 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DF770F7D6
	for <lists+linux-can@lfdr.de>; Mon, 06 Jul 2026 12:51:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nlFV1iwf;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8009-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8009-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D7F3306C9A3
	for <lists+linux-can@lfdr.de>; Mon,  6 Jul 2026 10:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C5F480336;
	Mon,  6 Jul 2026 09:41:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE6838B15B
	for <linux-can@vger.kernel.org>; Mon,  6 Jul 2026 09:41:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330916; cv=none; b=p0+77WhbAgqGvTBU1W5n/em5cZW9f9cQw6GC6QYsgW6l/V/UhmjcVw1LeuXGsDzQImmgQGbtBThf4fxw0fOnDf0jtUI4sb6Y+kXphzJ731xRPp7EIuHQN3pnM64DfDVhS9Dr1pEWHvHsGzAsbkUBMT93hFXL/9Bl3z64U+Pcww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330916; c=relaxed/simple;
	bh=ocfHom/ozHyTYD1Jxu9NQi3Yh5sJ1PDwNaOnmFaWXn8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jcDWACP2ijpl3IdRUfYh3gf8vdWma/jVOmfSxKUjltskZgimp/H8y6pgr4cFCI1nE47qb9Stcr+GbKHFoHesZwpMCGfs0j7C7iPd9PacASVyCA0aL9o+/ndXBrgw6yOoT7RpplKqI7FVmIXQmmN58YTKIO76kmfmPyfbVpF1WTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlFV1iwf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC191F000E9;
	Mon,  6 Jul 2026 09:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783330913;
	bh=hy0KzDuGZZB37C9qGXdnTBXykPtlqGs6v4uFu1fqdj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nlFV1iwf+SGbZUfv1VpehILjvwvXumTvGgD8vnU/lQXzgCYDC0nqRJovPaXDymhMN
	 uEDmbDPjW6yI68fkoSwksD9y7Tluo++3TJw91WmBomJdJkvwjsbxZaM46cB4YdFqZh
	 npQP1GiiCrLWRgi8r2ICsgDfW73Mm3x7HyzUuoccimhdxhTYLV4MjVN1YVoNhTvXRj
	 rtlJraOY9Nzn3uloG7hPKxIM3tz3bB7MhmLIDlmhbsuPHBAqw16pzWhEfh0pRNr8H1
	 4beqM//2kxpOouZCXsGCaUTkZdsRuaslHp57XKo90BHKPAqDqcQHNl/SF/Q5QzZmgg
	 6Pj70+C/ijyMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: peak_usb: validate uCAN receive record lengths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260706092836.79754-1-pengpeng@iscas.ac.cn>
References: <20260706092836.79754-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:41:51 +0000
Message-Id: <20260706094152.7FC191F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8009-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,iscas.ac.cn:email,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6DF770F7D6

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The decoders blindly trust the device-provided channel index to re=
trieve the device pointer, leading to a NULL pointer dereference if the cha=
nnel is within array bounds but uninitialized.
--

commit 35cea41238e6f7cd42684d301dadde24023e663a
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

can: peak_usb: validate uCAN receive record lengths

pcan_usb_fd_decode_buf() walks uCAN records packed in one USB
receive buffer. Require each record to contain the fixed header for its
type, and verify CAN payload bytes before copying them into the skb.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can=
/usb/peak_usb/pcan_usb_fd.c
> index eb4f5884ad735..45ae4611ae4c3 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -566,6 +566,13 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb=
_fd_if *usb_if,
>  				     dev->can.ctrlmode);
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but I noticed a potential NULL pointer
dereference just above this hunk in pcan_usb_fd_decode_canmsg().

The function currently checks the channel index against the array size:

	if (pucan_msg_get_channel(rm) >=3D ARRAY_SIZE(usb_if->dev))
		return -ENOMEM;

	dev =3D usb_if->dev[pucan_msg_get_channel(rm)];
	netdev =3D dev->netdev;

Does this bounds check properly validate against the number of initialized
channels? If the adapter only has 1 channel (like the PCAN-USB FD), channel=
 0
is initialized but channel 1 is NULL. Since ARRAY_SIZE(usb_if->dev) is 2, a
malicious USB device could send a message with a channel index of 1, which
passes the bounds check but results in a crash when dev->netdev is accessed.

It appears this same pattern exists in pcan_usb_fd_decode_status(),
pcan_usb_fd_decode_error(), and pcan_usb_fd_decode_overrun() in this file.
Should we verify if dev is NULL before dereferencing it in these decoders?

> +	if (!(rx_msg_flags & PUCAN_MSG_RTR) &&
> +	    le16_to_cpu(rx_msg->size) - offsetof(struct pucan_rx_msg, d) <
> +	    cfd->len) {
> +		kfree_skb(skb);
> +		return -EBADMSG;
> +	}
> +
>  	cfd->can_id =3D le32_to_cpu(rm->can_id);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706092836.7975=
4-1-pengpeng@iscas.ac.cn?part=3D1

