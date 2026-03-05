Return-Path: <linux-can+bounces-6926-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFTDIBlBqWkZ3gAAu9opvQ
	(envelope-from <linux-can+bounces-6926-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 09:38:49 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE3220D8D0
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 09:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BAF930B7709
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E50372B30;
	Thu,  5 Mar 2026 08:36:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC834374E63
	for <linux-can@vger.kernel.org>; Thu,  5 Mar 2026 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699789; cv=none; b=sm11OzuLyObpkf0mQhSrF8dFwR2kY75bALR5zs1jVJDw0wbyh6oOBPKCot6YCip9ZLlsXbVGHZ6+I5TxVJIyTmA0vauEgcZCEgb8pWltHvOkATdWL+naFQkI88Ikcst8Exh0dm8JFSbezkDOhZv17qdrpVq0d3LiJ6yCCup38aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699789; c=relaxed/simple;
	bh=CSh/OPgCewZMrxAGotXGAjNREHTmD2ri4RotS2E+6yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rgq/nfacnxcVXbGFB9N09zLuilR5RrtABi+smSTof0/DmPH3vP2f9kKLI497h50z9AXx7VX7AQO/qPByPv2XfEwsyNPuhbw60g2sXLqRY4dGd6CcQINsaqmrn4hYK+bbP/wLXwtifxqVh77C3L6SHWGTacWbMH/VE1tJOT2nltU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45effa36240so5793618b6e.1
        for <linux-can@vger.kernel.org>; Thu, 05 Mar 2026 00:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772699787; x=1773304587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ymdw+XC/6Jy9fN+NX35+E/o8bLZmtxZBZ4e3pQeTxE=;
        b=tZE3M6lnQF9AumDXKBTkDJYElVay5P1NiI6o+Xd6zstOeKsYHi2Awa8nBWcTNMAGmZ
         nZcn5DF0xGGpq5icL3eoEUc+B4pzvjlHnqArFq7u+4D0lYrC8SSpQ7LMZvdAG4WiPljA
         2STvYdzCOFuBAWFVAKGsnlXVjpEpjQ+5tL1oI47kzImNhUrDWTrqSgms4EhZTp3k7UU9
         UBMhtXg53XXJiNaENodXFRIRFriXohCxG66Vr8HQ8/QH+eUdZpANrKs/CCP76I7Mznjs
         bbRfwmjGDK+wDkfyqUGqAS02ZomVMAIM2fpD4Ya1aEv0cFmyUDuSGUi5YEE/Vb3rmxwB
         nV3w==
X-Forwarded-Encrypted: i=1; AJvYcCWEm/oFJ0YReAB9bBvZhnksV8tr9iUMbkO68I47a0Zhkl4JO526h/CjawAFOqn5AtgoEMn92exdwGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo94//ZCYjlOqLcnYSzX+on4Pk4RDidRY80tq34KFXd9902tS8
	D0UJGm2MEmhCSli8TQekF7y6uOZB0c0KEJeF2KJ2DXnZmRvOSVZ13GIp2IWgpqqM
X-Gm-Gg: ATEYQzy33fqu74Q86Vd3BoXkA2HfolN4cJ9bfTEZHvRA4vZf8zWjfuhceSfdxc3xyrJ
	HIRuccNp9GNC/snEIY3heAN1bi/FVOE7Yk+RrtMmIFvrPE9+ZC9zqpveom53TzbkmbHkgzXhgrz
	VbBp1vJmjCW6tIGi9K4SZB2jqCWOIsDOggnm5ocDqxww+bG+rJcY7t1mfoAhzNR0J8PEZJNmX/l
	5f3dlByLNBiju7dgrKmESQSotrRNeJvp1bSE36nC/TjH5isT7UTYixYqEOjGwA5g3A6ARNXaHtF
	VSCWvtSSAhrwB3UVCUjwCTxwaBuwgwgPqPOJROC9hBe0hRk6PqDVKryFlb3qWiPjzTIzTi2njrQ
	iBqdQYKiMRT1Fwy2i9xRJwZOn4zzcq/+LJ66evkXcBiSFgvQtRlXkZj0n0MjxBxM5l3BS9/EweU
	TEc7DPOfsJRnBe7BCzTaOlSBBBpdXdSbAV61EfETvZvVX0zxUyfbeSFv/8Dr4h
X-Received: by 2002:a05:6808:6f91:b0:450:a9d0:b790 with SMTP id 5614622812f47-4651ad287e4mr2961153b6e.46.1772699786604;
        Thu, 05 Mar 2026 00:36:26 -0800 (PST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59b66fsm13158406b6e.10.2026.03.05.00.36.25
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 00:36:26 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d55b97f358so6130497a34.3
        for <linux-can@vger.kernel.org>; Thu, 05 Mar 2026 00:36:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVs+2hKI660wEMSoVdJcYpdan9Yt+IJqNXBxqXaMq6gSm0NyD1wGZ15PHaJeD36PwIlbGesHukEhcI=@vger.kernel.org
X-Received: by 2002:a05:6102:2ac9:b0:5f7:24dc:3ac3 with SMTP id
 ada2fe7eead31-5ffaaa86250mr1899404137.7.1772699399463; Thu, 05 Mar 2026
 00:29:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com> <20260304175735.2660419-18-vladimir.oltean@nxp.com>
In-Reply-To: <20260304175735.2660419-18-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Mar 2026 09:29:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXUBhpnFEnnTfyPdECWqNmKLweupX=FY2SedYA3bapG2g@mail.gmail.com>
X-Gm-Features: AaiRm53mHozL13yvxji6rv0MKzaGvWxuhr7SWHD2SjBJ0VWNhqppZZeXezGpDhg
Message-ID: <CAMuHMdXUBhpnFEnnTfyPdECWqNmKLweupX=FY2SedYA3bapG2g@mail.gmail.com>
Subject: Re: [PATCH phy-next 17/22] net: renesas: rswitch: include PHY
 provider header
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
	UNGLinuxDriver@microchip.com, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Michael Dege <michael.dege@renesas.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DBE3220D8D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-6926-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.929];
	TAGGED_RCPT(0.00)[linux-can,netdev,kernel];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,glider.be:email,mail.gmail.com:mid,linux-m68k.org:email]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 at 19:00, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> As a PHY consumer driver, the Renesas rswitch dereferences internal
> fields of struct phy, something which shouldn't be done, as that is
> going to be made an opaque pointer.
>
> It is quite clearly visible that the driver is tightly coupled with the
> drivers/phy/renesas/r8a779f0-ether-serdes.c, which puts heavy pressure
> on the Generic PHY subsystem.
>
> This was discussed before here:
> https://lore.kernel.org/linux-phy/20260211194541.cdmibrpfn6ej6e74@skbuf/
>
> but to summarize, it is generally expected that when a Generic PHY
> function is called, it takes effect immediately. When this doesn't
> happen, the PHY provider driver must change its implementation rather
> than the consumer be made to work around it. PHY providers which rely on
> a hardcoded call sequence in the consumer are just lazy and wrong.
>
> The most obvious example is commit 5cb630925b49 ("net: renesas: rswitch:
> Add phy_power_{on,off}() calling"). Problem description:
> - Ethernet PHYs may change phydev->interface. When this happens, the
>   SerDes must learn of the new phydev->interface using phy_set_mode_ext().
> - drivers/phy/renesas/r8a779f0-ether-serdes.c implements phy_set_mode_ext(),
>   but this only caches the mode and submode into channel->phy_interface
>   and applies this to hardware during phy_power_on().
>
> The commit author decided to work around this at the consumer site, by
> power cycling the PHY for the configuration to take effect.
>
> This had a worse implication from an API perspective in subsequent
> commit 053f13f67be6 ("rswitch: Fix imbalance phy_power_off() calling").
> It was observed that phy_power_on() and phy_power_off() calls need to be
> balanced, and so, the consumer decided to start looking at the struct
> phy :: power_count (the technical reason why I'm making this change).
>
> This is also wrong from an API perspective because
> - a consumer should only care about its own vote on the PHY power state.
>   If this is a multi-port submode like QSGMII, a single phy_power_off()
>   call will not actually turn the PHY off (nor should it).
> - the power_count is written under the &phy->mutex, but read unlocked
>   here.
>
> The rswitch and r8a779f0-ether-serdes drivers both need to be completely
> rethought in terms of Generic PHY API call sequence. There is no quick
> fix to apply. Just include the PHY provider API along with the consumer
> one, to keep working as before when struct phy will be made an opaque
> pointer to normal PHY consumers. But this is a bad offender (and it's
> not even a provider) so add a FIXME.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

