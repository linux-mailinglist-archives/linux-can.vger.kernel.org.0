Return-Path: <linux-can+bounces-7232-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FNlMEGxwWnlUgQAu9opvQ
	(envelope-from <linux-can+bounces-7232-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 22:31:45 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF0F2FDBF1
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 22:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A1BD3049E2F
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 21:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAAF37F013;
	Mon, 23 Mar 2026 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTGWweKP"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE637C0FD;
	Mon, 23 Mar 2026 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774301430; cv=none; b=ZDSgeMyjdfOIZ5i6wtZrCHikWujKn6P/F867fIY3VLnnab2iXDGDbH6x8K12jGWoijaqiNoBABShY70aX/cbhSMpuC405LJcO9guJce5qhvQCsUk76CXFmIhzRxCIHUBOaN/CyBhAHi0XBPULmf6tnF2hJwHPFVKl/SkAEb+LrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774301430; c=relaxed/simple;
	bh=iTmW1cuviBxaYkwhZcE9S5onHqT6VVKXsVOOssf1+0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWaLzC40IpIar3w7V2AEfFx1WUk8Y+umFIy9MsJrLIHKFTHJF2OB46/uxtaknJ92UGgqWA6qRDI5Uw+mqXKbzsvzq7kbQV5B/cxgPRcV1kF0mny1AvbOpxKhrVht0/F6u8ahIEABSVLKHyWNQ85IRqQuODNz28iAIa52AYtmuvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTGWweKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52788C4CEF7;
	Mon, 23 Mar 2026 21:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774301429;
	bh=iTmW1cuviBxaYkwhZcE9S5onHqT6VVKXsVOOssf1+0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTGWweKP4MNGFhmQGl7aO64vAONh1DSNeEwrNkkc+9K1z3MMoL0dKaPouwZxBjBUW
	 MgEQHlRmQPWADLW0O3kYZGr8RHF6IV9yowBaXCVHCAfS7oG5TOEw3geVP+wsHfTZuM
	 JDTOSFey0TTOdVoVX8Uv3MDB/rLkPjxvws084tZPyYlzbsxs8CpLJocouS7X7VtT/s
	 kbcnbDTVE1odTZclXok2c7sxYD59dSwNVT2rxypaM1iEwwlVmER9HZb97y+D2A8g9w
	 XUh3ctDDlCddwwuRmyR5Ym3Ayq4Gqyxhue/ja/QgLhGggKnIwNgp0pl77k0n7ZPg5y
	 +gSsehkWQRKHQ==
Date: Mon, 23 Mar 2026 21:30:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, mani@kernel.org,
	thomas.kopp@microchip.com, mailhol@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, linusw@kernel.org, brgl@kernel.org,
	linux-can@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org, mukesh.savaliya@oss.qualcomm.com,
	anup.kulkarni@oss.qualcomm.com
Subject: Re: [PATCH v3 1/2] dt-bindings: can: mcp251xfd: add
 microchip,xstbyen property
Message-ID: <20260323-surname-osmosis-3cceca19c824@spud>
References: <20260321135031.3107408-1-viken.dadhaniya@oss.qualcomm.com>
 <20260321135031.3107408-2-viken.dadhaniya@oss.qualcomm.com>
 <20260323-bonded-ranging-c9f9c4d0aacf@spud>
 <20260323-artificial-ecstatic-collie-047169-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QEPYYfeOqUwy9qDL"
Content-Disposition: inline
In-Reply-To: <20260323-artificial-ecstatic-collie-047169-mkl@pengutronix.de>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7232-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EF0F2FDBF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--QEPYYfeOqUwy9qDL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 09:37:24PM +0100, Marc Kleine-Budde wrote:
> On 23.03.2026 19:30:00, Conor Dooley wrote:
> > > diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp2=
51xfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.=
yaml
> > > index 2d13638ebc6a..28e494262cd9 100644
> > > --- a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.y=
aml
> > > +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.y=
aml
> > > @@ -44,6 +44,14 @@ properties:
> > >        signals a pending RX interrupt.
> > >      maxItems: 1
> > >
> > > +  microchip,xstbyen:
> > > +    type: boolean
> > > +    description:
> > > +      If present, configure the INT0/GPIO0/XSTBY pin as transceiver =
standby
> > > +      control. The pin is driven low when the controller is active a=
nd high
> > > +      when it enters Sleep mode, allowing automatic standby control =
of an
> > > +      external CAN transceiver connected to this pin.
> >
> > What I don't understand from this patch is why a property for this is
> > required.
> > Why can't this mode be implied from the lack of rx-int-gpios or
> > interrupts?
>=20
> The mcp251xfd has 2 GPIO pins. "rx-int-gpios" is for the other pin:
> INT1/GPIO1. Also by default I don't want the controller to drive a pin
> in a certain direction.

Oke.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--QEPYYfeOqUwy9qDL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacGw8AAKCRB4tDGHoIJi
0gcBAP98ELYT2W6aRG3D8Z8vGbcjq+oSVk5NOkAsjsW4SfpEZQEAwEje3gpf96Ae
48njUi675zzo0FI7oh6WeD2XTkfMgAw=
=fUKn
-----END PGP SIGNATURE-----

--QEPYYfeOqUwy9qDL--

