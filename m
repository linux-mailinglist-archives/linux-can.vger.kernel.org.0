Return-Path: <linux-can+bounces-6660-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MdOAApmpWmx+wUAu9opvQ
	(envelope-from <linux-can+bounces-6660-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 11:27:22 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0C21D6753
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 11:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D47D3072FE7
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 10:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4A3B3C15;
	Mon,  2 Mar 2026 10:19:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ECA3A1A22
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446750; cv=none; b=oRsn2IxDZ4WL2Vr9hqhUIjQqAHJbZ2XfV4GcEoGKxspSlQFj9hVS8JdsPqt1tn3xre+e7Y4UclVwEMrGtXKv4MVBoAzlUmseHwjSvtupWPkEKoUE6VzULK3cCZsrN5BVFoQp2k8TqqFcj9TWtlY84ECo7rjeIMtf9Co4/y1N614=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446750; c=relaxed/simple;
	bh=5oALrE1t1NWnAPp3ozkihb0HRYV1j46MwdRwQV+RY+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SexiV71WWySpG6mw5o+yB22X1XTBA2i4MB6Q2z3TJyCJZhHCey2YOHytfk/mTiNYJfAdaOiwiFTAq8GnjyWq0/qa78f2J4bPv+3DsObOnrytnoI+5KoseZ00rTRSnOms0BymyE5fZ9NmejhdmRt8bI22Dxp1dKTsTX/T8iAtaUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx0Md-0002WP-0b; Mon, 02 Mar 2026 11:18:59 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx0Mb-003MYi-1M;
	Mon, 02 Mar 2026 11:18:58 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7A5314F505B;
	Mon, 02 Mar 2026 10:18:58 +0000 (UTC)
Date: Mon, 2 Mar 2026 11:18:58 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vincent Mailhol <mailhol@kernel.org>, stable <stable@kernel.org>
Subject: Re: [PATCH] can: ems_usb: ems_usb_read_bulk_callback(): check the
 proper length of a message
Message-ID: <20260302-slick-important-polecat-41d2b6-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <2026022316-answering-strainer-a5db@gregkh>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g55szxuaeovmdfoz"
Content-Disposition: inline
In-Reply-To: <2026022316-answering-strainer-a5db@gregkh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6660-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.818];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linux.dev:url,pengutronix.de:url,pengutronix.de:mid]
X-Rspamd-Queue-Id: 5B0C21D6753
X-Rspamd-Action: no action


--g55szxuaeovmdfoz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: ems_usb: ems_usb_read_bulk_callback(): check the
 proper length of a message
MIME-Version: 1.0

Hello,

I've applied the patch, but the nipa/ai-review bot found some more problem:

| https://netdev-ai.bots.linux.dev/ai-review.html?id=3D8aebbd0a-af1c-4caf-8=
659-03fcf827f060

commit 0b9cf350a2d2eab647de28210e8eaf2a56d5d624
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

can: ems_usb: ems_usb_read_bulk_callback(): check the proper length of a me=
ssage

When looking at the data in a USB urb, the actual_length is the size of
the buffer passed to the driver, not the transfer_buffer_length which is
set by the driver as the max size of the buffer.  This commit adds
validation at the beginning of message parsing and corrects the
validation after incrementing the start pointer to use actual_length
instead of transfer_buffer_length.

> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
> index 4c219a5b139b..9b25dda7c183 100644
> --- a/drivers/net/can/usb/ems_usb.c
> +++ b/drivers/net/can/usb/ems_usb.c
> @@ -445,6 +445,11 @@ static void ems_usb_read_bulk_callback(struct urb *u=
rb)
>  		start =3D CPC_HEADER_SIZE;
>
>  		while (msg_count) {
> +			if (start + CPC_MSG_HEADER_LEN > urb->actual_length) {
> +				netdev_err(netdev, "format error\n");
> +				break;
> +			}
> +

The new bounds check here validates that CPC_MSG_HEADER_LEN (11 bytes)
fits within the buffer, but does this protect against reading beyond the
buffer when accessing the message payload?

Looking at the structure usage:

    msg =3D (struct ems_cpc_msg *)&ibuf[start];

The ems_cpc_msg structure has a variable-length payload indicated by
msg->length.  After this line, the code calls ems_usb_rx_can_msg() or
ems_usb_rx_err() which access fields in the payload region.

In ems_usb_rx_can_msg(), the code reads:

    msg->msg.can_msg.msg[i]

for up to cf->len bytes from the payload.

In ems_usb_rx_err(), the code reads:

    msg->msg.error.cc.regs.sja1000.ecc

and other union members from the payload.

Since only the header length is validated here, can a malicious USB
device send a packet with a large msg->length value that causes
out-of-bounds reads when these functions access the payload data?

Would it be more complete to validate the full message size before the
switch statement:

    if (start + CPC_MSG_HEADER_LEN + msg->length > urb->actual_length)

The commit message mentions checking "the size both at the beginning of
parsing the message to make sure it is big enough for the expected
structure," but the current check only validates the header size, not
the complete structure including the payload that will be accessed by
the processing functions.

>  			msg =3D (struct ems_cpc_msg *)&ibuf[start];
>
>  			switch (msg->type) {

[ ... ]

> @@ -474,7 +479,7 @@ static void ems_usb_read_bulk_callback(struct urb *ur=
b)
>  			start +=3D CPC_MSG_HEADER_LEN + msg->length;
>  			msg_count--;
>
> -			if (start > urb->transfer_buffer_length) {
> +			if (start > urb->actual_length) {
>  				netdev_err(netdev, "format error\n");
>  				break;
>  			}

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--g55szxuaeovmdfoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaaVkDwAKCRDMOmT6rpmt
0mtaAQDv/Ez/WmwnBGLnDqSZ3ZPlVgF+6kXKDLPh+GznbXT6qQD+JxnQp9x49vWd
KnvB8EYecBN1g85F2taaqWgc+H6cVQo=
=XM59
-----END PGP SIGNATURE-----

--g55szxuaeovmdfoz--

