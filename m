Return-Path: <linux-can+bounces-7229-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLEnLXuawWlNUAQAu9opvQ
	(envelope-from <linux-can+bounces-7229-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 20:54:35 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B472FCACB
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 20:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78D3830E9B11
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 19:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00263D5642;
	Mon, 23 Mar 2026 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBGAnOSl"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D50D3D5656;
	Mon, 23 Mar 2026 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294207; cv=none; b=C5BPPU086RNqQ22FX04r8aAJsuwS1ws9zdsx21E7YtK6/INgHJ3/5lx+JIta2pWx+1VULPd5DlLn4k++GWvNQb7Y3M8jrd5goMS50vQ2AfwsIDiTkv6d3KnHeXgFhSHZ05vCIVVO3uOwbGVLQN0d1GvQxVjg2BJRpKYmN2VO8/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294207; c=relaxed/simple;
	bh=WkOB5F/+CkWWcUQBu5DPKJSH1aWAKy81sJ22hQhZ6Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZtMIDloCyA7CnbMYBxZCrNM89kV5XicRS3mCwIgJnRzrDoErK60ku2CUVQ+c16bwpkvUTxzAk3J2tyxoYFlv425hn8U9AJAMzmlno+YylQxVUtfoib+QO28SzaqbQM0q3YPBgqXRjXFnf9nzgb2/GnOnAi89JhPmfbhLqC6/Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBGAnOSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11159C4CEF7;
	Mon, 23 Mar 2026 19:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774294206;
	bh=WkOB5F/+CkWWcUQBu5DPKJSH1aWAKy81sJ22hQhZ6Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBGAnOSl6eKvcS87RfI2bTJq8NJeM9aAimOV8ZjrPMMphdFSi+Kb58HZJXV9Qct1N
	 E5qzibHIQw9q+eRNaQeBUehZDfk1ypEZgRKTbFbhA2fcwH5oa334sClwEW1MdTSBdz
	 y+lHm+mzKSxVxnELlZQYlo8Kd/t3KqZPFm2iqUe86M9zHYNzWBJgc8Z18OexAKNyg0
	 Ux8WIetSIkRZduIui1WlrIM1wtA5jN8IVaVetC6czUvYWiPmW31IbFFXzcj0fcohiQ
	 RrKuYGsbffZPiqxYxMuhruwZn1LvV+p6O8niEqSuuaw0iPptP+JIqLux7bPhFs3Pcg
	 mfbT4s+QGnsfQ==
Date: Mon, 23 Mar 2026 19:30:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
	mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	linusw@kernel.org, brgl@kernel.org, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
	mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
Subject: Re: [PATCH v3 1/2] dt-bindings: can: mcp251xfd: add
 microchip,xstbyen property
Message-ID: <20260323-bonded-ranging-c9f9c4d0aacf@spud>
References: <20260321135031.3107408-1-viken.dadhaniya@oss.qualcomm.com>
 <20260321135031.3107408-2-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/4zXNmXsOz71EUWe"
Content-Disposition: inline
In-Reply-To: <20260321135031.3107408-2-viken.dadhaniya@oss.qualcomm.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7229-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 12B472FCACB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--/4zXNmXsOz71EUWe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 07:20:30PM +0530, Viken Dadhaniya wrote:
> Add the boolean property 'microchip,xstbyen' to enable the dedicated
> transceiver standby control function on the INT0/GPIO0/XSTBY pin of
> the MCP251xFD family.
>=20
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
> v2 -> v3:
>=20
> - No change.
>=20
> v2 Link: https://lore.kernel.org/all/20260316131950.859748-2-viken.dadhan=
iya@oss.qualcomm.com/
>=20
> v1 -> v2:
>=20
> - Drop the gpio-hog approach as suggested by Dmitry.
> - Add the microchip,xstbyen property to enable transceiver standby contro=
l.
>=20
> v1 Link: https://lore.kernel.org/all/20260108125200.2803112-2-viken.dadha=
niya@oss.qualcomm.com/
> ---
>  .../devicetree/bindings/net/can/microchip,mcp251xfd.yaml  | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251xf=
d.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
> index 2d13638ebc6a..28e494262cd9 100644
> --- a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
> @@ -44,6 +44,14 @@ properties:
>        signals a pending RX interrupt.
>      maxItems: 1
> =20
> +  microchip,xstbyen:
> +    type: boolean
> +    description:
> +      If present, configure the INT0/GPIO0/XSTBY pin as transceiver stan=
dby
> +      control. The pin is driven low when the controller is active and h=
igh
> +      when it enters Sleep mode, allowing automatic standby control of an
> +      external CAN transceiver connected to this pin.

What I don't understand from this patch is why a property for this is
required.
Why can't this mode be implied from the lack of rx-int-gpios or
interrupts?

> +
>    spi-max-frequency:
>      description:
>        Must be half or less of "clocks" frequency.
> --=20
> 2.34.1
>=20

--/4zXNmXsOz71EUWe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacGUswAKCRB4tDGHoIJi
0p+fAP9UIJ8Rhvd3J1atVa+xAvAQ31INds935ubHT1GwXQAiIwEAtqd3oDP7yasK
KvlOPEj9iAqeOfDPw/YmoAPHHyMllQI=
=s/By
-----END PGP SIGNATURE-----

--/4zXNmXsOz71EUWe--

