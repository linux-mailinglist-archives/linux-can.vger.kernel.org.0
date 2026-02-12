Return-Path: <linux-can+bounces-6542-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGWPHmjBjWlt6gAAu9opvQ
	(envelope-from <linux-can+bounces-6542-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 12 Feb 2026 13:02:48 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5224B12D3DE
	for <lists+linux-can@lfdr.de>; Thu, 12 Feb 2026 13:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6738305848A
	for <lists+linux-can@lfdr.de>; Thu, 12 Feb 2026 12:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A9A346E64;
	Thu, 12 Feb 2026 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjAxqzD7"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C01FF1AE;
	Thu, 12 Feb 2026 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770897760; cv=none; b=ENfU8cQhkeuvEcN4vI2XdQvlsHaRoqeOy/xWz13WMZB2HGKQqCJqdqavf6jrfqMwx50vQylc6zQx4ExHh7lgr4WatYHfcJIS5C01np3pWaTj1sktRGg4NT4UdTo9FniXHcNOy1yNAXMUA/sKaj+MQd731zYx18i656HzTZOeEAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770897760; c=relaxed/simple;
	bh=QN+y41JEJ8Hdm3J4p6xmXaQjbXH+tj35FLd+7s+Aob0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eptI3Hz4QLBPPGozyFebx5C9327RxfC7NwB4zAAOZmR/ADxBmMov+Hzm0RPgumLkAHQk4JZu+xsGCGNAMymRoRmKU1piopT8tThegYlDe2rryNvLgxX1b2XoM8Gq+lDyWxzModrQluh8NZFHO34ZFbmmAZggLuuk/Abt0qbMvmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjAxqzD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEC4C4CEF7;
	Thu, 12 Feb 2026 12:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770897759;
	bh=QN+y41JEJ8Hdm3J4p6xmXaQjbXH+tj35FLd+7s+Aob0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjAxqzD7U7YfawpCA3dHQlrvfsUQQ+Ni/vl6KzpH0q50Zm9f24e/W6789dXFbzvdh
	 yaincLOpex+uRKludyIxKrDJgc2lYRaXMCE/0thy7t8JvD3bgtA9QO5WHDncGFBsmI
	 QcAYcXDwQnEvaZ9SbxobVios1BbOBjHCSLf8m6bBg6jEP7Volhi5fFeNzqBXnMm1Xb
	 WdspHk0B4k7DzK0tTrg1mG8YMQojW7XDaDDGf48E9J274w3TkMFoag/k8wS61PXohT
	 lOiBFoLeCSKj/0ZhdlifyjSnSd+FRLV45sKyah0jCdtCB05mo4xR4pkARG2nyW+z2r
	 WyhZ57RpeHteg==
Date: Thu, 12 Feb 2026 13:02:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfgang Grandegger <wg@grandegger.com>, "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: can: nxp,sja1000: add reference to
 fsl,imx-weim-peripherals.yaml
Message-ID: <20260212-peach-pudu-of-mastery-b09bf5@quoll>
References: <20260211230705.3824184-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260211230705.3824184-1-Frank.Li@nxp.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6542-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url,0.0.0.4:email]
X-Rspamd-Queue-Id: 5224B12D3DE
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 06:07:05PM -0500, Frank Li wrote:
> Add a reference to fsl,imx-weim-peripherals.yaml to allow vendor-specific
> properties for memory access timings.
> 
> Memory-mapped devices are less common today, with most peripherals using
> SPI or I2C. Since there is no generic YAML schema for memory-mapped
> peripherals, reference the i.MX WEIM schema here.

Theer is - mc-peripheral-props.yaml - and should be used, unless this
device cannot be used on any other SoCs.

> 
> Fix below CHECK_DTBS warings:
> arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-rdk.dtb: can@4,0 (nxp,sja1000): Unevaluated properties are not allowed ('fsl,weim-cs-timing' was unexpected)
>         from schema $id: http://devicetree.org/schemas/net/can/nxp,sja1000.yaml

Best regards,
Krzysztof


