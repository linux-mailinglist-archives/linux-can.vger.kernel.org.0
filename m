Return-Path: <linux-can+bounces-8129-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GylZHMRPTmpUKgIAu9opvQ
	(envelope-from <linux-can+bounces-8129-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 15:25:24 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE8F726C7E
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 15:25:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Pb2+9c02;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8129-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8129-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA07630AB612
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 13:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB2F2F49FD;
	Wed,  8 Jul 2026 13:15:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545182DEA9D
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 13:15:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516544; cv=none; b=gb1NuhGEqqxfXwMbLcCDpHaixrUe0Tmhq0TCIymEBlJv0mfvld7Ib+dURq6OOurwloHB7QbwhVaI1fRaee/EEkZlxvXlA/KWOwKpUSGjyK2NVc4JjCymRCmAh6nyPJlBpKa3l7UinCn0QlZtkasBtY2lVO/G1i5eDQ3L+Vlp9JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516544; c=relaxed/simple;
	bh=0LtuE7BhVdUFcLnT5/lMyclW1pW3Ad6XJx2Lest/7oo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YSI6tZF4KF4f7+664CkEislec95xSwXahsjVlklWknffsAEa4iEKXV92THsKfGxll3W6uZhM+D9v2eZpy9EcgUL38rtAuXCq3qmMtBUufxA9C0pnbU8oy33LUdEFhurIss69a78R1AifFGe95laG+TMkQgljmlQcPYzHseYYPko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb2+9c02; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0A81F000E9;
	Wed,  8 Jul 2026 13:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783516539;
	bh=CP66ZP0BVS43N/qazsx+ApYjPAa869jI+J3pTtAcNCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pb2+9c02JoXCveBdw0lmqvy5jll+6QtrCQZaQC6Yn3zsebuXvuPrln0X+xSKRPyPo
	 wULNaLrReU1LgaRPp04u2pjtkEXfwv5hRYnj8ynr+YyeRC02F1GVxYZXxBxNLvSWsY
	 ofF78Tv5LZe6FBk3614BnG23SxPN7bUx+AlH0O74CiDFlmctBwPOjD1o6MkgsiKXs+
	 MaVaflOkRsphjo2eekjhk2pyXZ4rC/SGeRk3UfAkPw2gC07SDJDhbvHj+pNiaIkUFg
	 vk6c95B338dLe47s/v7wblIEcM+tvhJKmQ5Q1Sh/WLPv+qyJ0AKH9eKMNlLOasJRSk
	 75ytoPN/WIa6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: ems_usb: validate received CAN message payloads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260708125949.765815-1-lgs201920130244@gmail.com>
References: <20260708125949.765815-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 13:15:37 +0000
Message-Id: <20260708131538.8F0A81F000E9@smtp.kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8129-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDE8F726C7E

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The driver double-frees coherent DMA buffers when the USB devi=
ce is disconnected after the interface was brought down.
- [High] The patch introduces `ems_usb_msg_valid()` to validate message pay=
load lengths, but fails to validate `CPC_MSG_TYPE_CAN_STATE` and `CPC_MSG_T=
YPE_CAN_FRAME_ERROR` types. This leaves a slab out-of-bounds read vulnerabi=
lity where unvalidated payload fields are accessed.
- [High] Failed interface initialization in `ems_usb_start()` causes a seve=
re memory and URB leak because it returns without cleaning up successfully =
submitted RX URBs and DMA buffers.
- [High] Uninitialized kernel memory is leaked to the USB device during CAN=
 frame transmission in `ems_usb_start_xmit`.
--

--- Patch [1]: [PATCH] can: ems_usb: validate received CAN message payloads=
 ---
commit 22fc83024cb899592c1db5423c95e678cb8a9b23
Author: Guangshuo Li <lgs201920130244@gmail.com>

can: ems_usb: validate received CAN message payloads

This patch adds payload length validation for received CAN messages in the
ems_usb driver to prevent out-of-bounds reads. It introduces a validation
function to check the length of variable-length payloads before processing
them.

> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
> index 9b25dda7c1838..f72e36fdf788c 100644
> --- a/drivers/net/can/usb/ems_usb.c
> +++ b/drivers/net/can/usb/ems_usb.c

[ ... ]

> @@ -409,6 +409,28 @@ static void ems_usb_rx_err(struct ems_usb *dev, stru=
ct ems_cpc_msg *msg)
> +static bool ems_usb_msg_valid(struct ems_cpc_msg *msg)
> +{
> +	u8 can_len;
> +
> +	switch (msg->type) {
> +	case CPC_MSG_TYPE_CAN_FRAME:
> +	case CPC_MSG_TYPE_EXT_CAN_FRAME:
> +		if (msg->length < CPC_CAN_MSG_MIN_SIZE)
> +			return false;
> +
> +		can_len =3D can_cc_dlc2len(msg->msg.can_msg.length & 0xf);
> +		return msg->length >=3D CPC_CAN_MSG_MIN_SIZE + can_len;
> +
> +	case CPC_MSG_TYPE_RTR_FRAME:
> +	case CPC_MSG_TYPE_EXT_RTR_FRAME:
> +		return msg->length >=3D CPC_CAN_MSG_MIN_SIZE;
> +
> +	default:
> +		return true;

[Severity: High]
This isn't a bug introduced by this patch, but does this leave the driver
vulnerable to out-of-bounds reads for CAN state and error messages?

If a malicious USB device crafts a CPC_MSG_TYPE_CAN_STATE or
CPC_MSG_TYPE_CAN_FRAME_ERROR message with a truncated length positioned at
the end of the 64-byte RX_BUFFER_SIZE transfer buffer, this default case
returns true without validating the length. When the message is dispatched =
to
ems_usb_rx_err(), it unconditionally reads fields like msg->msg.can_state
or msg->msg.error.cc.regs.sja1000.ecc. Could these reads fall outside the
allocated slab buffer and leak adjacent kernel memory to userspace?

> +	}
> +}

[Severity: High]
This is a pre-existing issue, but does ems_usb_start() leak URB and DMA
memory on error paths?

If submitting the interrupt URB fails or if subsequent control commands fai=
l,
ems_usb_start() returns an error without cleaning up the successfully
submitted MAX_RX_URBS bulk RX URBs or freeing their associated DMA buffers =
in
dev->rxbuf. Since the calling function ems_usb_open() does not call
unlink_all_urbs() on this failure, do the RX URBs remain active in the
system? If the user attempts to bring the interface up again, would the new
allocations permanently leak the old DMA buffers and leave ghost URBs
running?

[Severity: Critical]
This is a pre-existing issue, but can unlink_all_urbs() cause a double-free
during device disconnect?

When the interface is brought down, ems_usb_close() calls unlink_all_urbs(),
which frees the dev->rxbuf[i] DMA buffers using usb_free_coherent() but does
not set the pointers to NULL. If the device is subsequently disconnected,
ems_usb_disconnect() calls unlink_all_urbs() again. Since the pointers are
not NULL, won't usb_free_coherent() be called again on the same addresses?

[Severity: High]
This is a pre-existing issue, but does ems_usb_start_xmit() leak
uninitialized kernel memory to the USB device?

The function allocates a 28-byte coherent DMA buffer via usb_alloc_coherent=
()
with GFP_ATOMIC, which does not zero the memory because __GFP_ZERO is
missing. The driver initializes specific payload fields but leaves up to 21
bytes (such as the 4-byte CPC header padding, msgid, ts_sec, ts_nsec, and
unused CAN payload bytes) uninitialized. When the full 28-byte buffer is
transmitted via bulk URB, does this expose uninitialized kernel slab memory
to the USB device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708125949.7658=
15-1-lgs201920130244@gmail.com?part=3D1

