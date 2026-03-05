Return-Path: <linux-can+bounces-6923-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBWlL6Y0qWk73AAAu9opvQ
	(envelope-from <linux-can+bounces-6923-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 08:45:42 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAFE20CD88
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 08:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36A93300A10E
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 07:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4634727E05E;
	Thu,  5 Mar 2026 07:45:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BC9326D4A
	for <linux-can@vger.kernel.org>; Thu,  5 Mar 2026 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696738; cv=none; b=teIVVOz7bLczrg1IHLAPvPr8oMiJJTnDzOhvHZVLGFJWDpcNVXwYWE3NZRd6tZBPeXB7GegSeAyZV9vDpKHyfe4EEDlxxpAFg5D/BfoGmyZNo2iSEh/RBJdJlrfYoyFkYXU/5By6QSYVjbcT1fDQaPBuSS8VQR7muIeYu/om31A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696738; c=relaxed/simple;
	bh=1VrdyW7eBzn3eIzcJ/qwIsXSzypVzRQDxfUgekinKYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OX94XmptZoSnuM1oDnLJNQAFLiwUu4vgCO7tX+8P4sSSa/etfxj3pV4IG+1ZzvKkuOyYu1Kd9R1c3qNAQhE9V4F1t1gA7FWyy+R2gof3Oz503j6AiWc9e2QxGc9Eo+e/YUyCH7OfFPGoOrVAIn1hNbTy3gwiX+GHsO8ygzw/TJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-94dda16ff9fso2323260241.1
        for <linux-can@vger.kernel.org>; Wed, 04 Mar 2026 23:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772696735; x=1773301535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLWXJFRzKXYfvRWexgs1gCb/dTgnevi1M5AetCjur0g=;
        b=GyoMZSqhzUUIAKdTpK2lVqKQ6z3GPpTjUj7MQGcISETTR2RZc/4Jg/hFHP1V9URxQK
         dmE3OH+eo9cdPLMQdw9lbhZhsSAW2T1WlHf8QbAvq+tsqRTJYyWthrcysp2212PLwcLH
         HipS7099slxrMyYMhnX6B7HZWz+IH1xpmd5sWRwZl5IHIhnd5uvZNSurrjEXgVExK3LL
         27dM8p9pqlJBQuqJKInuMzGqML5wX4kTy4ISnOM8oj2QMnS0RhFHfAWJ5tznvekj9wH8
         QnFVk9D/1RBjvRA+7NKiTJftCO34YW1nGFrdMkxsGLa5Ec4KcpWPgamnRZUptGrJFp9G
         8eHg==
X-Forwarded-Encrypted: i=1; AJvYcCX7M619WF5z8Q3WL6PUMyoTbq9beCW+XPF0wlsodoPzjMM/CJZ3O7IimktfE23uJ6+W2RRdHAJbZQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq+j5uatr8zGhdKJPGomhvtuiRx+GDp6rmtMA18nZQ4rdUP2Z1
	csVtjrIah2Iz611+lg4kRZTTteX9wqo2KHlEgfQ+tGGernt0J28+ZQ0FoBpTPSx3
X-Gm-Gg: ATEYQzzEbJ+/lY5B0AVm25h1GWbo2AfCFtUYGoHHBkDGmj0/Tv4BvPvBgeZol3xo26E
	xJVEFcneFDR2O3BSkApOf8yqfAOVJ76yfAcqmWgZehiRtfJ88ctWS/rX5mXwTnQc2XsdTTn+RQq
	nPQxQKVDqUVzjkydIfpj3QsKfE7qhWlPFa766qDiXlAaF92WVK0vh/Q/CEYPMc3z6HkZmJ18Hu7
	xmlGif04aw8GEHonppbNGdZYB+kjk6665gWcYFtEnTShTw5qcMS63mxN6r2Q3wdEhnZkmk8c6xR
	yUcjpzAoTucECuXQsiWqtEKAeIjfHvq1E+xyKYSs21Wl/JqyTAwE5vcBdce4znJCKGt65bE9PiT
	44LEgK0OPZoRSrEOVZKupTVeFIZAZXuErlAAM3Mdfs6DYtugu1En0/22rADPKxTA9M3L4Mo3Z2X
	IaSt3n2rydAeqjgKWiR5YLFTq7M+edp4IND8HchbzEoHRzyeX2+5Ww6AprPr/0LJherKdVxVA=
X-Received: by 2002:a05:6102:6106:20b0:5ff:b684:f796 with SMTP id ada2fe7eead31-5ffb684fcb5mr1096788137.13.1772696734898;
        Wed, 04 Mar 2026 23:45:34 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df645b877sm20365896241.8.2026.03.04.23.45.34
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 23:45:34 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5ffd57b6fc6so1136137.1
        for <linux-can@vger.kernel.org>; Wed, 04 Mar 2026 23:45:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXfhPtwNmnTew1pJFb/Kt88JOneK/uoKogo3gEnagZ8IxcDy06W/qC29eOwye2atkvWyPUg7TkuXk=@vger.kernel.org
X-Received: by 2002:a05:6102:441c:b0:5f9:3a22:85a2 with SMTP id
 ada2fe7eead31-5ffaac72675mr2059267137.12.1772696734612; Wed, 04 Mar 2026
 23:45:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com> <20260304175735.2660419-6-vladimir.oltean@nxp.com>
In-Reply-To: <20260304175735.2660419-6-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Mar 2026 08:45:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXA67BO8Umz8-4jRg1SLvtZUSEzK0p7WxSvomnBk+WiyA@mail.gmail.com>
X-Gm-Features: AaiRm52ziEM93YxO07h7pOV0rTYZnULijxTOwLRm9EW_k_lOxLulmwK4PITV2jw
Message-ID: <CAMuHMdXA67BO8Umz8-4jRg1SLvtZUSEzK0p7WxSvomnBk+WiyA@mail.gmail.com>
Subject: Re: [PATCH phy-next 05/22] phy: add <linux/pm_runtime.h> where missing
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
	UNGLinuxDriver@microchip.com, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4EAFE20CD88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,kernel.org,linaro.org,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,microchip.com,glider.be,gmail.com,sntech.de];
	TAGGED_FROM(0.00)[bounces-6923-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.959];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 at 19:00, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> It appears that the phy-mapphone-mdm6600, phy-qcom-snps-femto-v2,
> phy-rcar-gen3-pcie, r8a779f0-ether-serdes and phy-rockchip-typec drivers
> call runtime PM operations without including the proper header.
>
> This was provided by <linux/phy/phy.h> but no function exported by this
> header directly needs it. So we need to drop it from there, and fix up
> drivers that used to depend on that.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

>  drivers/phy/renesas/phy-rcar-gen3-pcie.c       | 1 +
>  drivers/phy/renesas/r8a779f0-ether-serdes.c    | 1 +

For the Renesas parts:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

