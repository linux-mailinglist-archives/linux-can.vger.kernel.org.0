Return-Path: <linux-can+bounces-6925-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGbzI0JAqWkP3gAAu9opvQ
	(envelope-from <linux-can+bounces-6925-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 09:35:14 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E18A020D82B
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 09:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DC0A30107C2
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 08:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA6C2874FA;
	Thu,  5 Mar 2026 08:34:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EB93358B8
	for <linux-can@vger.kernel.org>; Thu,  5 Mar 2026 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699684; cv=none; b=kN9Hsp+1klfn8a/w91MU0VRFxnV4CTI53k2B2KfHq2Was68n9Rtz/To3Yy3YH6OvvhxpZgqrVCXulkp4sANU0kbdviLusLgphljdYi90YbV/6AC54rdEF+XPw+lr+PGbkmG0CZPLyFSygomXsGvhTYiP2zT/UYSTTUkQlUHopmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699684; c=relaxed/simple;
	bh=hefLtFvtSppGuVWRD/xSsfWMjnGgnQggEUG9Y7OFLDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gV4duCMvEyrX56DI915TF17xUX1kHQebBIJlfrj/HOLLD8LjpZyOELEcOjx/3a4EGzoa5vz9s9iNNqcPHvSQ3oGRS0zIuQDIlu1Ixlpzpe1TjuJe1HCGwngvl/OSgheh+7U5gnqZF/gF5CuKTbMms/ZWAVm68F3VX5dG2CR9SHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-679efb9eb0dso5960091eaf.2
        for <linux-can@vger.kernel.org>; Thu, 05 Mar 2026 00:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772699682; x=1773304482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlLnToI6SbxsSn7ypnmaqq1RX+miw2VMTyDHKi+gwbk=;
        b=cxU9afgPFV1OJ0vuiCHMW41BXKq8EFVsus+I15nq6vehez1eC3Juu+n3Uty1nV2rMP
         xyYaXZKOLTL2CYGOfDMzjXPXk1W+hmigOeNTO/SUilQqtqzwz8pIWAWDR7a6oXkrd3vB
         Gi3mozvQRDrIqVvAYHhW86RwON/jYgJAvS9+LdAaHQCxZtBK92XP24WilCcOL8RjYqNu
         N2eIDz5VhBdJ3CPq7Ivd1iNW3jefaW1U1xpn07iv6t9GblqnN6DUTn1D9qr2Tjpm/Bwd
         L3bedwWce9cAVe0InGD16JODEmBdw2ZxjsmF8WKfWxL8qsN1cIh1KaRUqgnPdC+tV1fT
         yNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgXgn0p4xeIewaN4fyMkoYouj+PuU7GMHrFU7oBRZVbC+bF2dUQBnv6Bf9ca/AT4W2so/P9Pa/dAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfRl935D2fBDKllPNEGu5FLUCh/i3KEKdg+zb0n9t+AQM3zN2a
	8efsKpzeNqKDYOOEmBA6ybIRBNmXt9dZPLI30QdJ6ipdpucDQUyZRS630pzbo7aN
X-Gm-Gg: ATEYQzzdJ146pW71Pz5ij33UGMePJCXxrUENYpKOT1vL2zr3aY7Fuwaaa6+MWGJorAv
	66bSyBJLTAb+9CTBgsAHMsIJa9zQZOOb3rPySCfFJs1QYKDanZDWzv5qCnARJW5KVDXxBc7EobE
	ITtWTlCucd3zm0cBQgJK+TXPIsTTjhweEN+2IGEC4LlSQkSBuhsugQs7kkMpci6zn5e5gGFANVf
	YV2p8dlc6K8cZ976PdXttrMOh4Uao4kGKacT1fv3nyyYuRsdUwuo8yrtgWPDrZrH/CDANHp4xtY
	m8QDB9qvf5Hae2QjEUJww/jhCyhDu7K851RbpQiqrCcY88bQqdLvsN0MGhzz15SncMI1LIkYuZm
	pemhl6vjY9H0G8fK/IFBVh754JTGWrN5bmCDUzqz4tjfxTe5SgqIGnLULlcou6HawO0YNj8UAM8
	gl5CDAnUSuy3dPecfF6URsU8jHyEverdlrDc66JX4bEW6F5f6RJkvwa/jYFTdasxTgSCRuoFE=
X-Received: by 2002:a05:6820:3101:b0:679:dcb5:b843 with SMTP id 006d021491bc7-67b177663aamr3152267eaf.55.1772699681773;
        Thu, 05 Mar 2026 00:34:41 -0800 (PST)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com. [209.85.160.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2a17bfbsm14627440eaf.0.2026.03.05.00.34.41
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 00:34:41 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so1905283fac.2
        for <linux-can@vger.kernel.org>; Thu, 05 Mar 2026 00:34:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXchdQfptYP9vDBqzTf1rwoXccYKnzPPx3xbS2CnZngfqdVEfZiCgZNvIWBAWZ/6Fg6ATSR6ki3kfI=@vger.kernel.org
X-Received: by 2002:a05:6102:1607:b0:5ff:c64d:228c with SMTP id
 ada2fe7eead31-5ffc64d2600mr724913137.22.1772699340961; Thu, 05 Mar 2026
 00:29:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com> <20260304175735.2660419-13-vladimir.oltean@nxp.com>
In-Reply-To: <20260304175735.2660419-13-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Mar 2026 09:28:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV+7n==crPmitH-JCwtJiH+7LaPKZQYU4ZqX_duo3_7Eg@mail.gmail.com>
X-Gm-Features: AaiRm50Kgxrt1IEt_9GEmeNyCIrylErpUd7qkh7D4FIoK_FYituUB8DTITetq4c
Message-ID: <CAMuHMdV+7n==crPmitH-JCwtJiH+7LaPKZQYU4ZqX_duo3_7Eg@mail.gmail.com>
Subject: Re: [PATCH phy-next 12/22] phy: move provider API out of public <linux/phy/phy.h>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, spacemit@lists.linux.dev, 
	UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E18A020D82B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6925-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-m68k.org:email,nxp.com:email,ti.com:url,ti.com:email]
X-Rspamd-Action: no action

Hi Vladimir,

On Wed, 4 Mar 2026 at 19:03, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> The major goal is to hide the contents of struct phy from consumer
> drivers.
>
> The idea with "phy-props.h" is that both consumers and providers make
> use of some data types. So both headers include "phy-props.h".
>
> Two slight points of contention.
>
> 1. phy_set_bus_width(): Vinod explains that despite the current caller
>    situation (9 providers, 1 consumer), it is a consumer API function.
>
>    The use case is that the controller (for example UFS) may have
>    limitations and should set the expected lanes to be used and width on
>    those lanes. A number of Generic PHYs can support multiple lanes and
>    multiple width so this is way for controller telling I am using this
>    configuration.
>
> 2. phy-provider.h should go to include/linux/phy/ or to drivers/phy/?
>    We do have 3 PHY providers outside of drivers/phy/:
>
>    drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
>    drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>    drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
>
>    but the practice is not encouraged, and with time, these should be
>    moved to the subsystem. This is not something that I can do now.
>
> For temporary compatibility, keep including the provider header. This
> will be removed when abuses are all gotten rid of.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/phy/phy-provider.h

> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -1,246 +1,38 @@
>  /* SPDX-License-Identifier: GPL-2.0-or-later */
>  /*
> - * phy.h -- generic phy header file
> + * phy.h -- Generic PHY consumer API
>   *
>   * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
>   *
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>
> -#ifndef __DRIVERS_PHY_H
> -#define __DRIVERS_PHY_H
> +#ifndef __PHY_CONSUMER_H
> +#define __PHY_CONSUMER_H
>
> -#include <linux/err.h>
> -#include <linux/of.h>
> -#include <linux/device.h>
> -#include <linux/pm_runtime.h>
> -#include <linux/regulator/consumer.h>
> +#include <linux/phy/phy-props.h>
>
> -#include <linux/phy/phy-dp.h>
> -#include <linux/phy/phy-hdmi.h>
> -#include <linux/phy/phy-lvds.h>
> -#include <linux/phy/phy-mipi-dphy.h>
> +#include "../../drivers/phy/phy-provider.h"

Shouldn't there be one more "../"?
Interestingly, it compiles with/without.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

