Return-Path: <linux-can+bounces-7134-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAxzGPqCumnrXQIAu9opvQ
	(envelope-from <linux-can+bounces-7134-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 11:48:26 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CCF2BA2BB
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 11:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A830E301FD64
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 10:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD8B35A927;
	Wed, 18 Mar 2026 10:48:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E7521018A
	for <linux-can@vger.kernel.org>; Wed, 18 Mar 2026 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773830880; cv=none; b=ZtDv6PTM3s5FQWFalb0lljuxyfz/7YziQiujzRaS6U9y3WHstzpNC4JvhGePWhEq02F+Bdo/42bXTiDbDRo9X+QTOLs4YahwmFuCpr+KXkmzEGO4RtN2z7YaBAtiffIiMmwfmQPfJLxw3rmnegHu/+g6BlxmmMLix1bUmsncmAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773830880; c=relaxed/simple;
	bh=NhDWu1uSYMeu/wJdr0UMk0OhyL7ekfdpPTmVvoI9oxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAlWlx+AKVhH4YJuBAIiiQnAmi7GUAfbL4JSDprtZoK7u/AsH1x6ZF6sswoDVLWOfBgqDF4sdBJFFX637AgTCnPjh58FH9yKqsEST8bEKcrzEWvsLgf/PIGih1T6PrZ5to9cddipbJgph81bNtVA7Ga1YpRxWHkjt86SZ+pUFiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w2oR8-0000uP-Um; Wed, 18 Mar 2026 11:47:38 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w2oR8-000tRu-0h;
	Wed, 18 Mar 2026 11:47:38 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D08255075A6;
	Wed, 18 Mar 2026 10:47:37 +0000 (UTC)
Date: Wed, 18 Mar 2026 11:47:37 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	NXP S32 Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>, 
	Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
	Eric Chanudet <echanude@redhat.com>, Andra-Teodora Ilie <andra.ilie@nxp.com>, 
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH 1/5] dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC
 support
Message-ID: <20260318-unyielding-piquant-buzzard-ec69fb-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260318092215.23505-1-ciprianmarian.costea@oss.nxp.com>
 <20260318092215.23505-2-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c4r44oj5kuxqnonw"
Content-Disposition: inline
In-Reply-To: <20260318092215.23505-2-ciprianmarian.costea@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7134-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.949];
	TAGGED_RCPT(0.00)[linux-can,dt];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: B2CCF2BA2BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--c4r44oj5kuxqnonw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC
 support
MIME-Version: 1.0

On 18.03.2026 10:22:11, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>
> Add NXP S32N79 SoC compatible string and interrupt properties.
>
> On S32N79, FlexCAN IP is integrated with two interrupt lines:
> one for the mailbox interrupts (0-127) and one for signaling
> errors and bus state changes.

Comment from patch#2 applies here, too:

Usually it's "bus error" and "state changes", as the errors happen
visible for everyone on the bus, while the state change is local to the
controller (every controller has it's own state).

> Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
> Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  .../bindings/net/can/fsl,flexcan.yaml         | 30 ++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b=
/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> index f81d56f7c12a..131fae2739fa 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> @@ -26,6 +26,7 @@ properties:
>            - fsl,ls1021ar2-flexcan
>            - fsl,lx2160ar1-flexcan
>            - nxp,s32g2-flexcan
> +          - nxp,s32n79-flexcan
>        - items:
>            - enum:
>                - fsl,imx53-flexcan
> @@ -173,11 +174,38 @@ allOf:
>              - const: mb-1
>        required:
>          - interrupt-names
> -    else:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,s32n79-flexcan
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: Message Buffer interrupt for mailboxes 0-127
> +            - description: Bus Error interrupt

It's a combined Device state change and Bus Error detection interrupt?

> +        interrupt-names:
> +          items:
> +            - const: mb-0
> +            - const: berr
> +      required:
> +        - interrupt-names
> +
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - nxp,s32g2-flexcan
> +                - nxp,s32n79-flexcan

Is there else if or something like that in YAML?

> +    then:
>        properties:
>          interrupts:
>            maxItems: 1
>          interrupt-names: false
> +
>    - if:
>        required:
>          - xceiver-supply
> --
> 2.43.0
>
>
>

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--c4r44oj5kuxqnonw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabqCxwAKCRDMOmT6rpmt
0goDAQC4zBBJXrqWNZFGX0yN+fKMo0Uhw5gc0I3NPrvVsHmwhAD+NzhvCVUvwLGT
lzJd5GVgLN8P2YOc9feguf39D6UungM=
=ReYa
-----END PGP SIGNATURE-----

--c4r44oj5kuxqnonw--

