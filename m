Return-Path: <linux-can+bounces-6304-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qaJBLMJ9dmnyRAEAu9opvQ
	(envelope-from <linux-can+bounces-6304-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 21:32:02 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF86382626
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 21:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D9F03003EC7
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 20:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35A023EA88;
	Sun, 25 Jan 2026 20:31:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F357522D4DD
	for <linux-can@vger.kernel.org>; Sun, 25 Jan 2026 20:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769373119; cv=none; b=aM6YtjUajxSzf5QmjkpaV5cHb4ekmN7TtN8fJwHn7E4PirS9iNFgMGVFA9wWCWbaYwKVtuOYkgpfltgjC78pyuqHPnQDdxNodRNwRu7Ex1DCmVOSBaQ8qek/hyyuS7BaZNvnAFeWDo6HLQ+02MfeHDUU14yLcb+Yk4cOekaM2Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769373119; c=relaxed/simple;
	bh=YnMx0eEYzQGzmrr6b2k8FMoqXxVVo5+fLM7T8WRpSFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9MSdLtGwv+5ocSodvFjgBxDOS7oWmFwdco4/nCIYQMsJLdCCxgUWdqkxSaafQKEGPK7YfPsMx7tirvR9+X844O0WIIQqhuu93WkmN+2cGmgQQaGI7BAGIapnov04u4JPEurhHBD2aYzZM7MYmyxQ1BzCjHzTEQxu7INLfC/d4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vk6lp-0006Cb-PX; Sun, 25 Jan 2026 21:31:41 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vk6lo-002T5n-0Y;
	Sun, 25 Jan 2026 21:31:39 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E9B934D7CFD;
	Sun, 25 Jan 2026 20:31:38 +0000 (UTC)
Date: Sun, 25 Jan 2026 21:31:38 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: mailhol@kernel.org, alexandre.belloni@bootlin.com, 
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, linux-can@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] can: at91_can: fix an error handle in at91_can_probe()
Message-ID: <20260125-towering-faithful-axolotl-bebe3e-mkl@pengutronix.de>
References: <20260125120947.1997682-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ohny4f6pmfsa4ffv"
Content-Disposition: inline
In-Reply-To: <20260125120947.1997682-1-lihaoxiang@isrc.iscas.ac.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	TAGGED_FROM(0.00)[bounces-6304-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DF86382626
X-Rspamd-Action: no action


--ohny4f6pmfsa4ffv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: at91_can: fix an error handle in at91_can_probe()
MIME-Version: 1.0

On 25.01.2026 20:09:47, Haoxiang Li wrote:
> In at91_can_probe(), if devm_phy_optional_get() fails,
> the memory allocated by alloc_candev() should be freed.
> Modify the goto label to do so.
>
> Fixes: 3ecc09856afb ("can: at91_can: add CAN transceiver support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

A similar patch has just been reported, see:
https://lore.kernel.org/all/20260122114128.643752-1-zilin@seu.edu.cn/

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ohny4f6pmfsa4ffv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAml2facACgkQDHRl3/mQ
kZzVUQf/dMddQDTEMqCsbECHSaI7kMuAp/4m0wV+bzXVjfpY2wkIa7+toivtGCfz
MH2conhtvSsTpgIZVj3sxuWg4jYn65mz+XQBWD/Gi4ki8FvJzOy06/MhHt5SSV3P
uRc2/0WGHLZAqBjEPuSMF37e3gfCyoqPvIiIMRFkrZoSXG9ZkU+q7iGfveKW5XMd
jETr3IHlMkv25Iz+IaVUMQg1j/rbQNIjcqEMkdPeX8IDjbdlf7YDoI5qQ1FN2ga1
QDcJK2Cm8U3SCi25uYLv4hd9KeN1AybRaab95LV53DbF3bUAlq0CD2gq+/YQRC88
tyjY52ayT/hAnKLrDDpZqyzzZBpULQ==
=I6yb
-----END PGP SIGNATURE-----

--ohny4f6pmfsa4ffv--

