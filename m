Return-Path: <linux-can+bounces-6910-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJqkHqKSqGkLvwAAu9opvQ
	(envelope-from <linux-can+bounces-6910-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 21:14:26 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E102077BB
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 21:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 737B43044A71
	for <lists+linux-can@lfdr.de>; Wed,  4 Mar 2026 20:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94133859D8;
	Wed,  4 Mar 2026 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOSWAYP0"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C14358D27;
	Wed,  4 Mar 2026 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772655260; cv=none; b=bkWJY/nWmbH7VVz7Ucw//x8nZsnCbM9N6cHeTB23GfS1MCZ66zXxL0nM5tv4m0E7am3Gkrx+5d5gmPpI05wIRtOGBx2L0Sr5URG1lzrm8ZYyd7uQ0YWL5ZcK8nhmm3B8lOXuWR1neg7GurB/42tblPN8otyAbgqRiYiTA1TYwtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772655260; c=relaxed/simple;
	bh=7LbZg6skQwe1JIVxe4uIFooiyh42caVjXi8zFEyCeHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZ9UDgd83iPUOtMblhlHii8wwZ8KWBZA4QRHj+dllJDtX9r8Zr2SC5e4N8aIDAiA+tN01r0soH3y++FJ5qLGIczWNHiggwpXmUOY5/bufrIhrKGCSxvJT8bkkORIKopupg1z6cje5otXM173yP7GorPTjrZWzVpJeblXN7EcyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOSWAYP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5684C4CEF7;
	Wed,  4 Mar 2026 20:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772655260;
	bh=7LbZg6skQwe1JIVxe4uIFooiyh42caVjXi8zFEyCeHA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vOSWAYP0ASIUMPrNsRctEnLesB/qOpdMCrQy6ahbi4pLYMii7O8IIBA8F63PZsyg0
	 ZcCnF1kj3cVmc84Vx9h9Kq96VZaMCMHxuCArllf1CYolj2oqppgnv3vXM3w6laZHlz
	 NOtq23rucRl5IE/Bb02Fai9gX/5ewV1hAPdziT8RA9B2ev0oqJbQtiikHUnSW5L9q5
	 Uk7uAI6xqy1wRgSUh7h36AH8oidWLE77AQilsTltHa4bvKQfckiIg6DJMG3yRydPNA
	 OvbzcQS3k3wio6bMSaigTPS0yMDQddq1Qx4b83K8C3Iv2VNsdfZAH1Ox9lzB5Wl3zL
	 iEzLjD3XL6GFw==
Message-ID: <679dbfdd-9e46-4265-a01c-faf163924ec3@kernel.org>
Date: Thu, 5 Mar 2026 05:14:14 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH phy-next 01/22] ata: add <linux/pm_runtime.h> where
 missing
To: Vladimir Oltean <vladimir.oltean@nxp.com>, linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, spacemit@lists.linux.dev,
 UNGLinuxDriver@microchip.com, Niklas Cassel <cassel@kernel.org>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-2-vladimir.oltean@nxp.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260304175735.2660419-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E2E102077BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6910-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/5/26 02:57, Vladimir Oltean wrote:
> It appears that libahci.c, ahci.c as well as the ahci_brcm, ahci_ceva
> and ahci_qoriq drivers are using runtime PM operations without including
> <linux/pm_runtime.h>. This header is somehow being indirectly provided
> by <linux/phy/phy.h>, which would like to drop it (none of the functions
> it exports need it).
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

