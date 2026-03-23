Return-Path: <linux-can+bounces-7230-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOLVIH+bwWmFUAQAu9opvQ
	(envelope-from <linux-can+bounces-7230-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 20:58:55 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FA22FCBD4
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 20:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80C4930DE401
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 19:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3DD3DC4C2;
	Mon, 23 Mar 2026 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mw723Ji8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82EA3AD508;
	Mon, 23 Mar 2026 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294522; cv=none; b=rkVU5lFtqhBvHYOOcsK3FwekzKWbR7vJe/apXFaZHxo21dD9ZlsbW4UQtaZtdJC8AFbtGsBjkpZN1T1Rp9EgxBFFGItUDBAPHX0TugIQeVKjmz3Ch6+HuopdcSGb1azXpBu9Ii4n93wdu+PGJCBBBtDBMFS4FGEzUA0YouzPEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294522; c=relaxed/simple;
	bh=/AltQxVMRaDiZn/otYACU056eFGHpp8ohsXtQFKkbMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9UF2gzMIFxYv0osGNh+3GVz1ZheUpiHdqqoXuFAJeU1AGZId+tComWY40wkyZv7RejzrKQkkZ6+7X3iy/xJWXxqo7CtN+mrFxTnHx+F8AEHNTg8dvdOTRem2JbIkwOVcHYXyujbmbDzsDv+fpBWzdKMHRbsbPnrRqZfhQp1w3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mw723Ji8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB6FC4CEF7;
	Mon, 23 Mar 2026 19:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774294522;
	bh=/AltQxVMRaDiZn/otYACU056eFGHpp8ohsXtQFKkbMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mw723Ji8ItqQwUkwxJcN/Lz9ZCPbLplRhgd+/HWLjYYhaaJLwqAchXAPVB8RAhCA2
	 RJQ4xB1wv9PE8mYmtagQpq6CD2sp5GucDxge8kwOFo7DLsxOwa3Ol/DUDgI+3GpH2W
	 UryNApEJlAgmW9xEL6N/ptwGGPL/omQbNMntwtTeXGBJt5lnc4AxwrpWBdYQOAm7DU
	 KUWKu/LxUSCOfgJvc/8yCR9S4R2sQermq2LugTuYmsGfIFXpKjUpoZFLUwx8IVUC/h
	 9DwUAdT4XaHKI21LeFuhUCfdYjrgLaj4We1bDNeGvs+jL1zvmNsRKC7YWtP8uOmqyj
	 WbtjNoqX0a+xA==
Date: Mon, 23 Mar 2026 19:35:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-can@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC
 support
Message-ID: <20260323-treadmill-enactment-2aa03aaf785d@spud>
References: <20260323135827.2129371-1-ciprianmarian.costea@oss.nxp.com>
 <20260323135827.2129371-3-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8gizptVAuJfhu7Yo"
Content-Disposition: inline
In-Reply-To: <20260323135827.2129371-3-ciprianmarian.costea@oss.nxp.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7230-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6FA22FCBD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--8gizptVAuJfhu7Yo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--8gizptVAuJfhu7Yo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacGV8wAKCRB4tDGHoIJi
0vsFAP0btJesQ6LLyqyvxF+cJfSUf05z8QVlm4W0g7uyZH6qDQD/QhkoMM9OvPji
TI2/IY8edpfBbuYsdSQVYhOjy7CapgI=
=rX6j
-----END PGP SIGNATURE-----

--8gizptVAuJfhu7Yo--

