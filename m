Return-Path: <linux-can+bounces-6966-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAUrAzalqml6UwEAu9opvQ
	(envelope-from <linux-can+bounces-6966-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 10:58:14 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A4421E4C2
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 10:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8782B3028E8C
	for <lists+linux-can@lfdr.de>; Fri,  6 Mar 2026 09:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12AC3537CF;
	Fri,  6 Mar 2026 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zKN16av/"
X-Original-To: linux-can@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE0734D915;
	Fri,  6 Mar 2026 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791007; cv=none; b=V9QSwx5EPstEGFXJb3PgZ3Ol+T3rY9qusyFA1CbKcriN/uoCsdaDzA4bP+LvJS+RaOjNzN8MM/F6HdXARZ4Ej+0cQeYh/p4RdXekk7+fOBTvi8cs12pJmI4O7r/oXXeTFaDwgbW1KBued60E9H7fxqVfzBpA6X1NND6N1pLzTG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791007; c=relaxed/simple;
	bh=M0XofkcuBdV1zkdsuj7RJ1maZEJbks9g3VqYv60iJnU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ea1+hzL+QxNHhc4NtkXjce7NRYEPUt7SEScJMnDDVSgt1WO7VwDxTfQZ6lC+uKKm7Mapo8x3lUsbLwvvFmKw+/+ksx5Ntnsb66twL7erxoY5VVCbkSx3L/C64b1yDTIUUFY5Y5asIiMHZ5I1Xlj6vhhvqoLzq3Gw6Om8WSMTLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zKN16av/; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772791005; x=1804327005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M0XofkcuBdV1zkdsuj7RJ1maZEJbks9g3VqYv60iJnU=;
  b=zKN16av/YcO/gYHjYaU16mSlJXQ6p8l1+9SLEVylGTpIj/UUfrvtXmdU
   tIDzYrUw2kzuJQUrZxG6H0zx3Tu7WgCu/QWT4ns5+NNhGFoN66mZrPBow
   I3/Siw34DF23sIXntNqI43ZmqpI9T4ZM5TvEyZ6ZwfhOdkwyZCHAlm93t
   ARqOmyQnDoje5m8zxU4ltfRHWqOaZDj1KEdIMcrBCIGjSQted+Gbb3M7w
   2rpcnbqrQMG9iLcisYRqkaXdNT+KC5bI8IUNnH2pLhTDa4oYgycdBWYO1
   5COuiQr+77VAHpvbv09JIVJiBN9H+vkuVmRzCfa97IrV9/qGKW3hr2WEf
   Q==;
X-CSE-ConnectionGUID: kkklftjzTt+tmC5CjQykRw==
X-CSE-MsgGUID: y9hzzWGpTbWY5hyCt1eJ5w==
X-IronPort-AV: E=Sophos;i="6.23,104,1770620400"; 
   d="scan'208";a="54313383"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2026 02:56:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 6 Mar 2026 02:56:27 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 6 Mar 2026 02:56:22 -0700
Date: Fri, 6 Mar 2026 10:56:22 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: <linux-phy@lists.infradead.org>, Vinod Koul <vkoul@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, <dri-devel@lists.freedesktop.org>,
	<freedreno@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-can@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-ide@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<netdev@vger.kernel.org>, <spacemit@lists.linux.dev>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>
Subject: Re: [PATCH phy-next 07/22] net: lan969x: include missing <linux/of.h>
Message-ID: <20260306095622.rh3sje3wnexbdsqb@DEN-DL-M70577>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-8-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260304175735.2660419-8-vladimir.oltean@nxp.com>
X-Rspamd-Queue-Id: 78A4421E4C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6966-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

> This file is calling of_property_read_u32() without including the proper
> header for it. It is provided by <linux/phy/phy.h>, which wants to get
> rid of it.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Cc: Daniel Machon <daniel.machon@microchip.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Steen Hegelund <Steen.Hegelund@microchip.com>
> ---
>  drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
> index 4e422ca50828..249114b40c42 100644
> --- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
> +++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2024 Microchip Technology Inc. and its subsidiaries.
>   */
> 
> +#include <linux/of.h>
>  #include "lan969x.h"
> 
>  /* Tx clock selectors */
> --
> 2.43.0
>

Acked-by: Daniel Machon <daniel.machon@microchip.com>

