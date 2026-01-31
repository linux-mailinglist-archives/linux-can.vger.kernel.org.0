Return-Path: <linux-can+bounces-6444-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJviM3N0fmnYZAIAu9opvQ
	(envelope-from <linux-can+bounces-6444-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 22:30:27 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFADC3FFE
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 22:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECA803027692
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 21:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4C632ABE1;
	Sat, 31 Jan 2026 21:30:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5572B378D78
	for <linux-can@vger.kernel.org>; Sat, 31 Jan 2026 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769895012; cv=none; b=FbNsJdApnYvKuRB0AOwSTedzA6DeL/Uo6k92FxcBDPZ0+q+iSk2F4EdxKV7PZYPMRUW+Qx/fS2yhpzOS9d//v+8rsppu8xqi/unOqqy1kKpkAS8r1sxEPclpX+G8QRpdS5EbIYXVFuROQK19Fvb13xcw+MmgC+VIoPplWB/jUAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769895012; c=relaxed/simple;
	bh=bVN+iVq2LVQdCnKQNtrh4bLJRpC4u0FuCf9+45b8zG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBdXJ/TjMe7y9uQ1c8c6gyWCB5YbJ27424oKTqzF/qHDdfHJhS8dvtnk2f73kk5yiVOV3R6PX3333dcL1WhespLViI3ueuZK9j7nNCpfaEcXnYgXaEFk85LesDLuGByu/1GWK8pyNS37NAZOi4hcTsRKbZ4E2H8qhYqudaj+u+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1vmIXb-0000Vp-B7; Sat, 31 Jan 2026 22:30:03 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1vmIXY-003T6i-2x;
	Sat, 31 Jan 2026 22:30:00 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1vmIXY-008Yda-0E;
	Sat, 31 Jan 2026 22:30:00 +0100
Date: Sat, 31 Jan 2026 22:30:00 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org,
	linux-wireless@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Toke =?iso-8859-15?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Thomas =?iso-8859-15?Q?M=FChlbacher?= <tmuehlbacher@posteo.net>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net-next] net: remove unnecessary module_init/exit
 functions
Message-ID: <aX50WNrI9LN0TfoC@pengutronix.de>
References: <20260131004327.18112-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ORv+QzYuE6v8IEJJ"
Content-Disposition: inline
In-Reply-To: <20260131004327.18112-1-enelsonmoore@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6444-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mgr@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email,pengutronix.de:url,pengutronix.de:mid]
X-Rspamd-Queue-Id: 4DFADC3FFE
X-Rspamd-Action: no action


--ORv+QzYuE6v8IEJJ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 04:42:56PM -0800, Ethan Nelson-Moore wrote:
>Many network drivers have unnecessary empty module_init and module_exit
>functions. Remove them (including some that just print a message). Note
>that if a module_init function exists, a module_exit function must also
>exist; otherwise, the module cannot be unloaded.
>
>Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
>---
> drivers/net/arcnet/com20020.c                 | 16 ----------

For drivers/net/arcnet:

Acked-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--ORv+QzYuE6v8IEJJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAml+dFIACgkQC+njFXoe
LGTXNg//bvb0zku2NhtssRocv3TCAmztScaj1GTWJDMPG3DloaH+QHKk0urYEF9M
1MnNzuReMBuq7jNNP0u8006plqueXvnTnqqpCfNRRar+ycegW2PPwcT1I6z3vFP2
dR/k4ICBtXr4OIMxalzATJNgj7N/YJ0+sRclt+1h2IrI//r/lq7xmDVwrmWI780+
/zE5EXLYMsY7PPRDvy1i2QMZGBdFT17tWNu1EpHEPRw57F7N+4lBu2bpJMUO6tJc
datWBEGwFnCDp0ymPQuMabKtguiT+kqEQk5rFanCFPYGrGb9X0fpSRoLU+A81qjv
4UGPzWRxgzmbA/EgHN7h8bSuyqNk8fmMEvLiKG19FRwLYcya0L0e0yMZtv4tPEXf
O03wGQvEdNYmpV36TyMv1eViHSVaa6lZjv1YfQ8BrnxVrrEEVv/FK2/4/CkragRQ
GnIHuUBijn5y1ZFYIDlsoAgOUGMbNa4JRXjBn+tR/kAp6t6OjUeFWbLbv4+7oiF/
MOOHImuAwscGA1ONwMN8xwOGwqmDivPYxX2lHJzO3pMQcVc+jKWrdbkysPxHMw8o
CihsNzmc6gJy5RrP3b8STwQ2Ns6yxL1cOUD+tNqyGwSlV9wGSXdWzMItEC0xuRUe
dZwtadcUppPIOs0oso/Qpt6susdJHWpzmYemLKzVSDuX0s79dJc=
=v+0W
-----END PGP SIGNATURE-----

--ORv+QzYuE6v8IEJJ--

