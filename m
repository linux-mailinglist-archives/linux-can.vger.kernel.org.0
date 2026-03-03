Return-Path: <linux-can+bounces-6855-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ByMI47ypmkzawAAu9opvQ
	(envelope-from <linux-can+bounces-6855-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Mar 2026 15:39:10 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0971F1A36
	for <lists+linux-can@lfdr.de>; Tue, 03 Mar 2026 15:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 719863013034
	for <lists+linux-can@lfdr.de>; Tue,  3 Mar 2026 14:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0BB3DEAEA;
	Tue,  3 Mar 2026 14:34:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA7A3B3BE4
	for <linux-can@vger.kernel.org>; Tue,  3 Mar 2026 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548457; cv=none; b=fJ1GHE1GRIis3x+XI0Nh48EOV/LPWh8FHg63hTF3LkZ+o4xJ/ioocokvzY3J0Bvd0yWQ94WYoYxFoyvorgQhdvQUJ05EySu5KF5vLjUE+td9wjW9DkhzSfY6F3e53mtYBZZb0vu2BjqPemcSDroYUEQ2efw657N4LKjC68MMP5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548457; c=relaxed/simple;
	bh=FUhXqTSNIMEp8iaYn8OBWSOCIM/X7x4hwk5d9Rx1uCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKxoYU+pqMO2ZHzIOwchQvhN+wDloVDQH3PvmszuzVcTvlewkG795isB5iryOXaE+8UTbmYKu76/8XfOLTjOrKAYePPtnRBSd7+/BzahgXPiAvkB5JqmB4uvnEYgnFxw6ki4tLR4U6wj/g2bCCvje3YUHvHF+Unf7u8NTfnVn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vxQoz-0000xn-LC; Tue, 03 Mar 2026 15:34:01 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vxQox-003YuD-0E;
	Tue, 03 Mar 2026 15:34:00 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 213AD4F696F;
	Tue, 03 Mar 2026 14:34:00 +0000 (UTC)
Date: Tue, 3 Mar 2026 15:33:59 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Mailhol <mailhol@kernel.org>, stable@kernel.org
Subject: Re: [PATCH net 05/12] can: ems_usb: ems_usb_read_bulk_callback():
 check the proper length of a message
Message-ID: <20260303-independent-fair-bullmastiff-d8a994-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260302152755.1700177-1-mkl@pengutronix.de>
 <20260302152755.1700177-6-mkl@pengutronix.de>
 <7c39c1dd-dd49-4847-9238-d6cf147598da@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dcotyxahcferzui3"
Content-Disposition: inline
In-Reply-To: <7c39c1dd-dd49-4847-9238-d6cf147598da@redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Queue-Id: 0E0971F1A36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[pengutronix.de];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6855-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.852];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


--dcotyxahcferzui3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 05/12] can: ems_usb: ems_usb_read_bulk_callback():
 check the proper length of a message
MIME-Version: 1.0

On 03.03.2026 15:20:01, Paolo Abeni wrote:
> AI noticed the following:
> ---
> Does the check validate enough of the message? The code checks that the
> 11-byte header (CPC_MSG_HEADER_LEN) fits in the buffer, but
> ems_usb_rx_can_msg() and ems_usb_rx_err() both access fields in the
> msg->msg union payload starting at offset 11.
>
> For example, ems_usb_rx_can_msg() reads:
> - msg->msg.can_msg.id (4 bytes at offset 11)
> - msg->msg.can_msg.length (1 byte at offset 15)
> - msg->msg.can_msg.msg[i] (up to 8 bytes at offset 16)
>
> Similarly, ems_usb_rx_err() reads:
> - msg->msg.can_state (1 byte at offset 11)
> - msg->msg.error.cc.regs.sja1000.{ecc,txerr,rxerr} (3 bytes at offset 11+)
>
> A malicious USB device could send a packet where actual_length equals
> CPC_HEADER_SIZE + CPC_MSG_HEADER_LEN (15 bytes total), which would pass
> this check but provide zero payload bytes. The callees would then read
> beyond the received buffer before reaching the second check at the end
> of the loop.
>
> Should the validation check that both the header and payload
> (msg->length bytes) fit within actual_length before calling the
> processing functions?
> ---
> I guess this patch could need a follow-up? Not blocking the PR, as
> AFAICS worst case this patch still improves the current situation.

Yes, Greg said he'll look into this

| https://lore.kernel.org/all/2026030253-lather-pulse-3bb5@gregkh/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dcotyxahcferzui3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaabxVQAKCRDMOmT6rpmt
0nhJAP9HVgQ5h+hdpOg4OLZ+pCb6wosQZm+cqIlVtwwjBktXegEAzH6QhssQ7+lu
y4eZx9nPL+PPtGe7/uYimKWiO+Ft8As=
=S/L9
-----END PGP SIGNATURE-----

--dcotyxahcferzui3--

