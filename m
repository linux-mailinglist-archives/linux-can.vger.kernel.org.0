Return-Path: <linux-can+bounces-7238-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFPqClhJwmnvbAQAu9opvQ
	(envelope-from <linux-can+bounces-7238-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 09:20:40 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C893047E1
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 09:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97C763033BFD
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679E136AB7C;
	Tue, 24 Mar 2026 08:20:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1382636A01E
	for <linux-can@vger.kernel.org>; Tue, 24 Mar 2026 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340418; cv=none; b=GfcKyS8fjtWp9thRBxYs8j5eKgzjZRx8mvMSsR9mdSIMOW0uUZWUcZ9X1O9sr2NWiIs5e6A8nhc8rFj9fccfoo4Tsv1lN15SW8L9GZZp5Z3zRPF1+Ej2suw+uyqNT+3U2cpCcS95Fxlstm3daevfy8Azb7bbwsf6V1PqNjAkN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340418; c=relaxed/simple;
	bh=TJERX4ivS7CdaVazGj7SdWkh7bGayePzUg4wDjVorVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8ld4arZE3qOfLqfj9wZSN71Sz3G23xuXCAahZj+oGj89R4o61KwNViQ9FE6iHNBwhkTjSD4Ed8xrOzrcCLyls7AkeOCqTQQcUBuVcvQziBd2AnguPxvMWux65K3cb0Nai+0vknFhGX24t+tIa2pJimPrAdhlo8mD5QUfsWaVho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4wzh-0002MD-18; Tue, 24 Mar 2026 09:20:09 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4wzg-001rhc-2e;
	Tue, 24 Mar 2026 09:20:08 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6811B50B6A3;
	Tue, 24 Mar 2026 08:20:08 +0000 (UTC)
Date: Tue, 24 Mar 2026 09:20:08 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?6ZKx5LiA6ZOt?= <yimingqian591@gmail.com>
Cc: security@kernel.org, linux-can@vger.kernel.org
Subject: Re: [REPORT] net/can: can-gw: UBSAN OOB write in cgw_csum_crc8_rel()
 via negative result_idx (uid=1000)
Message-ID: <20260324-sambar-of-imminent-kindness-a52869-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <CAL_bE8LVpMAoSjCzRiNU76mJ1SSZaBUhEsAURpcgMxg5E7y63A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nqywpzxuqhg6an7k"
Content-Disposition: inline
In-Reply-To: <CAL_bE8LVpMAoSjCzRiNU76mJ1SSZaBUhEsAURpcgMxg5E7y63A@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-7238-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2C893047E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--nqywpzxuqhg6an7k
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [REPORT] net/can: can-gw: UBSAN OOB write in cgw_csum_crc8_rel()
 via negative result_idx (uid=1000)
MIME-Version: 1.0

On 24.03.2026 11:51:15, =E9=92=B1=E4=B8=80=E9=93=AD wrote:
> Hello,
>
> I would like to report a reproducible out-of-bounds write in the CAN netl=
ink
> gateway (`can-gw`) checksum handling code.
>
> ## Summary
>
> In `net/can/gw.c`, the CRC8 "relative index" fast-path (`cgw_csum_crc8_re=
l()`)
> computes absolute indices (`from/to/res`) using `calc_idx()`, but mistake=
nly
> uses the original potentially-negative indices (`crc8->from_idx`, `crc8->=
to_idx`
> and especially `crc8->result_idx`) for array accesses.
>
> When a CAN gateway job is configured with `CGW_CS_CRC8` and a negative
> `result_idx` (e.g. `-64`) and processes a CAN FD frame with `len =3D=3D 6=
4`,
> the function passes its sanity check and then writes using a negative ind=
ex:
>
> - `cf->data[crc8->result_idx] =3D ...` (negative indexing into `__u8 data=
[64]`)
>
> With UBSAN bounds enabled and `panic_on_warn=3D1`, this triggers a fatal =
panic.
>
> ## Affected Tree / Version
>
> - Tree: upstream Linux `v7.0-rc5`
> - Commit: `c369299895a591d96745d6492d4888259b004a9e`
> - Arch: x86_64

Can you please re-check with b9c310d72783 ("can: gw: fix OOB heap access
in cgw_csum_crc8_rel()") applied. It's included in

| https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/tag/?h=
=3Dlinux-can-fixes-for-7.0-20260323

or:

| https://lore.kernel.org/all/20260319-fix-can-gw-and-can-isotp-v2-1-c45d52=
c6d2d8@pengutronix.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nqywpzxuqhg6an7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCacJJNAAKCRDMOmT6rpmt
0siLAQC7+nGKuN63yoB6EoAMpQXZv2WUqtmiLpipFmzoFFX8vQD9E/H6VJ0Px3f2
N1FbKPvopcOrURg/pKJKy0OT3pZg9AY=
=lpKB
-----END PGP SIGNATURE-----

--nqywpzxuqhg6an7k--

