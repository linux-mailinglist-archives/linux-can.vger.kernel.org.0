Return-Path: <linux-can+bounces-7457-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AXXD69G82kMzAEAu9opvQ
	(envelope-from <linux-can+bounces-7457-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 14:10:23 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0C84A29B9
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 14:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B5383018D49
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 12:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCC837C938;
	Thu, 30 Apr 2026 12:08:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6276C3FD129
	for <linux-can@vger.kernel.org>; Thu, 30 Apr 2026 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550903; cv=none; b=nROmdDR/sMf8Hv/UAiAWvN45lpxF0p6k0NlRRTLxQP58OG7SOH/bOnIezJ2eXJbji4n9iaXiqKXqOxWVTTkZ3ZYtS1W9RR/R9WsDlCLT6yF/IWxoP5G4c/PkUyIFS7n/p2bl/NmM1bNBNLXgC0SgzGlR58Kxz03tmf9OpV0IvcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550903; c=relaxed/simple;
	bh=EZZ2E4Hk4P3ioWVMaervDcnw6ADW65oM1zGar71sbpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K27I4Xq+de+5wZVTN+d0amYzHBer69UoqPAjWJ8wsX+WkqWofDzIWe7gG4sjKJcNIWBIyRQXo35Efm60FiW99KQzYb9rTzjaOgCKLU68oxBgFb7k/FUh/NuU0Oi5AtQWGr+wZ3TN2lkvUMT8okkzXaqJ4vAcZFv1pMw6wukHZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6948da50eb5so444196eaf.1
        for <linux-can@vger.kernel.org>; Thu, 30 Apr 2026 05:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777550901; x=1778155701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksIL4rip+tLI1Yx6QhQXSN6krUTnsd9SRkVzjQXrZjA=;
        b=Opa8QeSmTc9ED7+V0f0hIhQbT8xjqLURaedHVVANaMsYotV/QcQuT2Wo+5c07FmcWb
         SGHKYwfh/rGbg9kpNcMO39Pyxp7/MPntrB3hmNeC7toqLs3FT59+xPEyU1NQiKwv9uYW
         lFcQG0FU2WEDAf98t7gNLC82fx2LHfUUuy8kIdSG+db2IMCMR7hh1jt3GlQCojJ2D6m/
         N7Z8ERNkjl0r9S33zXsb7oShmV36uQsbXQijGq39uktuA49LXkFr5RlWnI+Gsxi/L9IU
         fhOpqV21+4D3McUBMTzsgkRVX4quMLd/iBWArKxjNwVOZlfXQ7O2d1vSeOi4dsv5U76E
         DzHg==
X-Forwarded-Encrypted: i=1; AFNElJ85IK+DLTNFyUGYESCECJIAxsNH8T3dCZh+TiUTfOcVNi41PMRb9qzBql+PRB/Ei4w2DsiQ+PkyMW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/syF5HNQ5uAHpH21eTm8QHqM4FXnhZEvdN7A3h0eLyLMwSYc
	kLINT4ff/G//gPNdro3OVA6h6btOJCML5ibtdDQecNMmQoydX3FyrFbuucg5wTLIzzI=
X-Gm-Gg: AeBDieszES2FhhBYL996TyVkKyiT+ttZBbFuewFtHPRP66PW5nvbHWcpIUH6KQZuOav
	cs7DtSVNQkBnmNbzVuMMPYkJtsSJ8ay/eOa7MuXpbHnhfTT06EWGoE191v/H0dxN412rlLfpjc4
	U4fKhzlBC0g4CHbV0TfgoAnXdmVdVRAoivI33PGWH8nmSxfufe5wG5cpchI64DnigPUCvKKk0mK
	GrFD9SduqN9i+ve7iIjkLGPhuoOPkrhYy4fcWcpp5HiVEXnnAMNQGWN0Yt4LjnMEyI6beBjp5mT
	nNqjJQ98aIaM1BTc0fWyIxXl80/6WvA9uThIOBW5C801k/2cF3gUSW5+rHuhmQfT/l7iU98llQ0
	NM5snURawOxOfxpI/fbfnqHGeb1mrtjdmW1nCuSgEMO3Ythpl+DOBZvOjSzLqi5cbM4OQNN2mtW
	KNXgc6/3jj+nkcq4BPdwqd9TkhaOb9NldPk33EYu6pDigb/EISHhetfvGf8V6fAjaSNaUP5oYfH
	XQ=
X-Received: by 2002:a05:6820:1c9f:b0:694:a30c:24fc with SMTP id 006d021491bc7-6967bd030d1mr775901eaf.7.1777550901300;
        Thu, 30 Apr 2026 05:08:21 -0700 (PDT)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43437231ca6sm1403215fac.11.2026.04.30.05.08.21
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 05:08:21 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-479d593a0c3so678046b6e.0
        for <linux-can@vger.kernel.org>; Thu, 30 Apr 2026 05:08:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/LMaIThBlatYYCaeTPiaKVQWjgpJSH4WbVn++zVJt0SM4m1b5Ktm6gf6dF5X+IMldQplyMfLiw7VM=@vger.kernel.org
X-Received: by 2002:a67:e708:0:b0:610:347f:9f3b with SMTP id
 ada2fe7eead31-62afc506100mr613209137.3.1777550404889; Thu, 30 Apr 2026
 05:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430110652.558622-1-vladimir.oltean@nxp.com> <20260430110652.558622-18-vladimir.oltean@nxp.com>
In-Reply-To: <20260430110652.558622-18-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Apr 2026 13:59:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWbeeRmLf6Ae0Fr0un=-z7z5ONc_hDdjebP=KVkXHPbhw@mail.gmail.com>
X-Gm-Features: AVHnY4K0yYb6vTu9KdtDciwvAziqboYRX_ITZ386sa6ttixZ1EP_Mzy9gi4Pi0E
Message-ID: <CAMuHMdWbeeRmLf6Ae0Fr0un=-z7z5ONc_hDdjebP=KVkXHPbhw@mail.gmail.com>
Subject: Re: [PATCH v7 phy-next 17/27] phy: introduce phy_get_max_link_rate()
 helper for consumers
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, spacemit@lists.linux.dev, 
	UNGLinuxDriver@microchip.com, Markus Schneider-Pargmann <msp@baylibre.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andy Yan <andy.yan@rock-chips.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: CA0C84A29B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,kernel.org,linaro.org,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,microchip.com,baylibre.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,rock-chips.com,pengutronix.de,bootlin.com,tuxon.dev,glider.be];
	TAGGED_FROM(0.00)[bounces-7457-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,nxp.com:email,linux-m68k.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:email]

Hi Vladimir,

On Thu, 30 Apr 2026 at 13:07, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> Consumer drivers shouldn't dereference struct phy, not even to get to
> its attributes.
>
> We have phy_get_bus_width() as a precedent for getting the bus_width
> attribute, so let's add phy_get_max_link_rate() and use it in DRM and
> CAN drivers.
>
> In CAN drivers, the transceiver is acquired through devm_phy_optional_get()
> and NULL is given by the API as a non-error case, so the PHY API should
> also tolerate NULL coming back to it. This means we can further simplify
> the call sites that test for the NULL quality of the transceiver.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Acked-by: Markus Schneider-Pargmann <msp@baylibre.com> # m_can

Thanks for your patch!

>  drivers/net/can/rcar/rcar_canfd.c                   | 3 +--

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be> # rcar_canfd

> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -57,6 +57,7 @@ int phy_notify_disconnect(struct phy *phy, int port);
>  int phy_notify_state(struct phy *phy, union phy_notify state);
>  int phy_get_bus_width(struct phy *phy);
>  void phy_set_bus_width(struct phy *phy, int bus_width);
> +u32 phy_get_max_link_rate(struct phy *phy);

This (and all the existing getters) should take a "const struct phy *".

>  #else
>  static inline struct phy *phy_get(struct device *dev, const char *string)
>  {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

