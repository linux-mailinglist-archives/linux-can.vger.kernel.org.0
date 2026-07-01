Return-Path: <linux-can+bounces-7938-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f2EXItLCRGq90QoAu9opvQ
	(envelope-from <linux-can+bounces-7938-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 09:33:38 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 206FC6EAABF
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 09:33:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UVyGlBp0;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7938-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7938-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E2F73024EA8
	for <lists+linux-can@lfdr.de>; Wed,  1 Jul 2026 07:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC9133FE0D;
	Wed,  1 Jul 2026 07:33:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AE91AA1D5;
	Wed,  1 Jul 2026 07:33:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891216; cv=none; b=YqFpGnoth3TjUy+8g18RfAXpQ+iP+EGcd07lCGZp6kzIV48Wj8y5ZVJWymrPpELgv1l4lxukNSjcR9P8h8ps7LUtVq52nZISJRJU/L5NqAwyP+AA012jOdoxib+6J5i0SusVK15Npfed7EMYdTTwvbrHGzF9aDR++QW9oY9ovdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891216; c=relaxed/simple;
	bh=JyuRzzCXBZoasmM7QEjHt6x3BUnV6ef7SVB+Z6VSvFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik052uCSiTyg9hToE3rt8eDZaIk0iQnlX1vGXuA+k3Q80s3dL44okUFFl8woEBzA5X6vfgvqCT/0gAzlFOCBbI7wLxk/hDqMC4pAThqv8j0fyt98AVzRdJ3yVfn/9WvNhousC0A+pL9hbohnO6vcFyAf0ANJgRdIP2xMnJrt8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVyGlBp0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0885E1F000E9;
	Wed,  1 Jul 2026 07:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782891215;
	bh=k/K9hBM1ahbCox43xtF1LZVqi9LX5rDK4epEjlbtsY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UVyGlBp0oHITYtLgXPffpOmwMSWfODSRCnpN4fuVUdT2CiJQhIKDTXTwovisFiENs
	 YwaxyAG9g8q4wIbS2D3cAIOaXYnkgRuGehymbiHWtkRzFwVpHi/H3WxLil8gM9rJ7n
	 qDie/7vFFKeWoqFsqfJvUn1yjWPeKWLjXjNykwZfAblPW3FuqfZ7N4DmNCYnFGS5AC
	 EOpkGt7B8/2MlCDZzmkprgEPzEjRdaqvvSqSGzHFEblf4IZpapyWEQr8gHsx9z5ZrW
	 vyRiiaMls6fjmZOG0ugsO7Ps99PmAmdISxVRPOh5m001F9rEKgA9LHuImf2jsnMPJr
	 zIYWM03F5TNeA==
Date: Wed, 1 Jul 2026 09:33:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: mkl@pengutronix.de, mailhol@kernel.org, kernel@pengutronix.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawn.lin@rock-chips.com, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	quentin.schulz@cherry.de, zhangqing@rock-chips.com, 
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 1/6] dt-bindings: can: rockchip_canfd: add compatible for
 the RK3588 variant
Message-ID: <20260701-sensible-cryptic-ocelot-58035b@quoll>
References: <20260630164336.3444550-1-heiko@sntech.de>
 <20260630164336.3444550-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630164336.3444550-2-heiko@sntech.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:heiko@sntech.de,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:kernel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:shawn.lin@rock-chips.com,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:quentin.schulz@cherry.de,m:zhangqing@rock-chips.com,m:heiko.stuebner@cherry.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[krzk@kernel.org,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7938-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,quoll:mid,cherry.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 206FC6EAABF

On Tue, Jun 30, 2026 at 06:43:31PM +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The RK3588 uses a variant of the CAN(-FD) controller introduced at first
> with the RK3568 SoC.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>  .../devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
> index a077c0330013..02211ea3ec41 100644
> --- a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
> @@ -20,6 +20,7 @@ properties:
>        - items:
>            - const: rockchip,rk3568v3-canfd
>            - const: rockchip,rk3568v2-canfd
> +      - const: rockchip,rk3588-canfd

So this is just an enum with the first entry.

Best regards,
Krzysztof


