Return-Path: <linux-can+bounces-7982-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kuw6MhdZR2pSWgAAu9opvQ
	(envelope-from <linux-can+bounces-7982-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 08:39:19 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4596A6FF20C
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 08:39:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DXA1EWj8;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7982-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7982-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC027300751C
	for <lists+linux-can@lfdr.de>; Fri,  3 Jul 2026 06:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3643806C4;
	Fri,  3 Jul 2026 06:39:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6421D32AAAB;
	Fri,  3 Jul 2026 06:39:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060756; cv=none; b=h7rHzaoiDeN960/8YQs/iyFXStYy75YFPVg3YzoZny9Qq3rVfCGNDpM64BWa2caU7CHORlNNQLXqe6dnid7FsfpgdepMktTLodqjLLmGGPOZQPOLfQJ8p2afvUevFr3rkPO7wv5F++pydXnp0ACT2g0h5yy0KYizHkejofpl7ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060756; c=relaxed/simple;
	bh=6BxbcMdOIcZsfnhqpZbwKAM6k2MH606Q9Oi22O3Jxpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev0gerzOIyCrUm6UXcYucH3MaQiOx9UIc31GtaIn39M2SbVJRrQTBbfAp62XXXflA5hY8yROInMOK/qg9+5PFBkOFy+bXJtfDsUPquNVKDOepq3+DNxZ/ZuvniFrkGByUN8P/XUNlZx6vmx18VFoHxtOdUnGBX9OYVQ+WQ7jlF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXA1EWj8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174F01F000E9;
	Fri,  3 Jul 2026 06:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783060755;
	bh=D3QWF9QEhp1MYt6N9b3KeNj8xni59MRNrkc85etaxMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DXA1EWj8RozS1lVUZfUQ23DjASd/q3OBgJzO5YP2g4jyXPNQCs2o6DbpQW/QPcp5p
	 oX/s40PFzy+bCCx+bhYnj4pJqp/dpRESOObhZWyuVu2gM3D4vtIpg7b9QjUZIO5zxk
	 1Fr6yQ7Z4LBDHHnP6hu3jGySPxnj/ldwDQRU7450Q6AUmlJPE0OdNE8BcknEv1fJx+
	 MlVyumgmQvVzDCerFheHXCqJHXblkynw5hbXXvPnP+yOOnok0xcKArkv4sZU9hZMSn
	 HL3o2SARmYIJ9/8YDk4Tjz7crpUW7oWgNCqnMhVEtv0ZY/vxfrfGN5sXs2dc+aVmGp
	 WPspsgTGVzUDw==
Date: Fri, 3 Jul 2026 08:39:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: can: rockchip: add rk3588 CAN-FD
 compatible
Message-ID: <20260703-truthful-aardwolf-of-spirit-b6bafc@quoll>
References: <20260703-master-v3-0-6d56de6fd2f3@qq.com>
 <tencent_3E31CBEFAE0986665A26322171642BC00B05@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_3E31CBEFAE0986665A26322171642BC00B05@qq.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:1579567540@qq.com,m:mkl@pengutronix.de,m:kernel@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	TAGGED_FROM(0.00)[bounces-7982-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qq.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4596A6FF20C

On Fri, Jul 03, 2026 at 10:35:40AM +0800, Cunhao Lu wrote:
> RK3588 integrates a Rockchip CAN-FD controller variant that is not
> fully compatible with RK3568v2. The RX FIFO count register field is
> encoded in bits 7:5 on RK3588, while RK3568v2 uses bits 6:4.
> 
> Add a dedicated rockchip,rk3588-canfd compatible to describe this
> variant. Do not use rockchip,rk3568v2-canfd as a fallback, because that
> would describe a register layout that does not match the hardware.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


