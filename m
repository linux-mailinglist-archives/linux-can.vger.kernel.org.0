Return-Path: <linux-can+bounces-7948-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aossIMwYRmqEJwsAu9opvQ
	(envelope-from <linux-can+bounces-7948-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 09:52:44 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B666F46D2
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 09:52:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QeKndD1j;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7948-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7948-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DB7A308669C
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 07:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645323AE1BD;
	Thu,  2 Jul 2026 07:43:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F963B2FC6;
	Thu,  2 Jul 2026 07:43:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978202; cv=none; b=T/8qOKewRESyN+vrE9oCE3pHkyYJ0SUiFKbZ5M+WbBpIGuFvxpwlr+ix/ERuHdPLYt5x7qnQ/H7DGBpm96dJ3LDPu/4ABk7mQ7mGZKlnKBPzs5Zz4REycy1w8QEytPCLCbBcOgV2APs7ICX0R8Zl104CaDRHAV7RoXFJ3YTkFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978202; c=relaxed/simple;
	bh=rH+ajfe+rvPAYT5XzS1B7rNemJQPhlX6gUWSzcWbgLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APYWS5JNxGALjXA7VpVvlze8Jg1Ebp10e3/qock3vkzDI/W50ufmQJltRG+GCQ6Do49uGlhVsk7wlPbtR5N24M1YRYsAg/SSLGKKa6ifYiioPVXJ/yO67Uy03+sya9xWEv52ww4P5nQ7SYTUPkiFeIfhpIS54lXDt3IyhYAU3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeKndD1j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82C71F000E9;
	Thu,  2 Jul 2026 07:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782978199;
	bh=wB9kFnvBOQDELA0/LuNhygIBNyEdZSej8PAkRHVCjqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QeKndD1jWyB9gTZ81Av+/zXi5j2zbSXhrQTXLFHordVsRkH4deRZX8bPKCSyl5Yj4
	 zBuTuWtKj2W1PTTrMQnzTRDh9y5zGH71nfyvQ7nGQ5+nM/exM/LK38s8hyQWiv4ZC/
	 w/lF0KgRbM4gOY1skAcLSafV1hgRkGWzIGSqK+PhTkauzSJOossHdTODh5+8nvpaiv
	 JbSj9OpdmcuSDkyWwc/zVQOGFZkcq8gmhRR348rR+JfMt3FRBcDVi0J+1pYT3ukc6L
	 kBOuaVQ6gndpeZ9j97DHSiKtQQTwGugnc1XWqVJtA6PdGwKV+vUDapDJiO1XTCRzg4
	 vzS2Ftt0JJ7Tg==
Date: Thu, 2 Jul 2026 09:43:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: 1579567540@qq.com
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, 
	Vincent Mailhol <mailhol@kernel.org>, kernel@pengutronix.de, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: can: rockchip: add rk3588v2 CAN-FD
 compatible
Message-ID: <20260702-quantum-hairy-quail-e3eee4@quoll>
References: <20260701070128.2096267-1-1579567540@qq.com>
 <tencent_83A61C9A79199D04CC118A8026C435BFB907@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_83A61C9A79199D04CC118A8026C435BFB907@qq.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:1579567540@qq.com,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:kernel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[krzk@kernel.org,linux-can@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-7948-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,qq.com:email,quoll:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4B666F46D2

On Wed, Jul 01, 2026 at 03:01:26PM +0800, 1579567540@qq.com wrote:
> From: luch00 <1579567540@qq.com>
> 
> The RK3588 CAN-FD controller uses the same DT properties as the
> existing Rockchip CAN-FD blocks, so extend the current schema with a

DT properties have nothing to do here. Are you saying it is fully
compatible? Then express it properly with fallback.

> SoC-specific rockchip,rk3588v2-canfd compatible instead of creating a
> new binding file.
> 
> Keep RK3588v2 as its own compatible rather than an rk3568v2 fallback.

Do not explain what you did. Explain WHY.

> Driver support uses separate match data and the RX FIFO count field

Driver is irrelevant here.

> layout differs from rk3568v2, so a dedicated compatible is the safer
> description.
> 
> Signed-off-by: luch00 <1579567540@qq.com>

We do not take anonymous contributions.

> ---
>  .../devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
> index a077c0330..aa31ec78e 100644
> --- a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      oneOf:
>        - const: rockchip,rk3568v2-canfd
> +      - const: rockchip,rk3588v2-canfd

So that's just enum with previous entry

And why is this different from rk3588?


>        - items:
>            - const: rockchip,rk3568v3-canfd
>            - const: rockchip,rk3568v2-canfd
> -- 
> 2.34.1
> 

