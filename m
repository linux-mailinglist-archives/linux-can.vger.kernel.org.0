Return-Path: <linux-can+bounces-6946-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA31HZd7qWkg8gAAu9opvQ
	(envelope-from <linux-can+bounces-6946-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 13:48:23 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D57D2120C2
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 13:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A42530B9998
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 12:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D7B39FCAB;
	Thu,  5 Mar 2026 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb0jG97e"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090C039F167
	for <linux-can@vger.kernel.org>; Thu,  5 Mar 2026 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714632; cv=none; b=Su/WWY2y+Zd2YudEgbImG5kkJcvhtPWK9O+eyqBNt6H5CSasWgPp8rglYPTaHrwWoha2KrlR26BRC7364R4YsDa8VvYjzQIbawNbXaAJuiAECIACS/N+m0BIfLluCy500nosJWrV+zXE7C6/Sx62XmNQ8uZy+CxLB6OHX1CI0JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714632; c=relaxed/simple;
	bh=+1Soi4u0zOToM+4cvb9M54dFFqUFlTLNETgvWAKHxCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HExmy5/k6kSpGKmEAyAankDr29C6Eu7Nwi/1ZcCvkaqn9N5LKCJkA8pjfhkD24PudyFnz9QSJ/V+QiabQv1tuNRXw3+HoP35YGk1pOVQhnOGpQWDiGGU7T9sDKOCYjTHlf58jt1nOX9nK1xzwqBu9jWspfA0e87DNgqjS5JqRNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb0jG97e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06F2C2BCC6
	for <linux-can@vger.kernel.org>; Thu,  5 Mar 2026 12:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772714631;
	bh=+1Soi4u0zOToM+4cvb9M54dFFqUFlTLNETgvWAKHxCU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qb0jG97edmb3U2qfJOZ8W4namHJQLjHdyLa/yO8Shzxok1cow1oGiOPDZPwW1C2aX
	 qfpAXVF5aCFXZLxPSzvgKeKSxO9o5XsLWHV8Z2J8C79wGhUQOpuNdTpOU9Dzdkkz3p
	 TWGjcAKnefLsljHAnEj5fjLLXkP0UfERnPvGWuc0ZQekEOQjNXH5K1HWRbh9ma16qv
	 6TkLXMUEkXlMirlttkcaQYFOEfMZ+oBljrNq1F3YIMePzlnhhwMurIVZGke7gCj1z9
	 cdj00Q5OZUBdizfbKPYLlLKP8RyJI5QMF03gjMx1z3TalYyUwSwiQn9mCL6ZfAo7SC
	 0i9QiFLq3vXMw==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79860421382so77340107b3.0
        for <linux-can@vger.kernel.org>; Thu, 05 Mar 2026 04:43:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWI84CeqaVUXj5RcKkinySwMMBw4vCvMglfvMJ/4AcanaN2kVozM4xTA1fn9pb5kx3s+RtpXVMtESs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNYTEByb1tUMh8aAd4kl5qKizWwuGBWinJHp5vs62xrNFcZpgP
	BI3os4FCzMvA6BlncDFoU2L8QluaU7VgntIMPSgaoQPdoCvVe2o5un2APWbWSX+7MCmsvVvHiR/
	Du2OVGTPfI00d3mFyDTRH2P+DtIKbP8w=
X-Received: by 2002:a05:690e:448d:b0:64c:ac70:9420 with SMTP id
 956f58d0204a3-64cf9bdb391mr3524893d50.76.1772714630723; Thu, 05 Mar 2026
 04:43:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com> <20260304175735.2660419-19-vladimir.oltean@nxp.com>
In-Reply-To: <20260304175735.2660419-19-vladimir.oltean@nxp.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Mar 2026 13:43:38 +0100
X-Gmail-Original-Message-ID: <CAD++jLnCtu20rXcg7sMVLBi24EohscJoz0kN46XJaKPJt00O2w@mail.gmail.com>
X-Gm-Features: AaiRm53Fhg5bHrVPoZ7KkxLKre-rHWPjFXtzmvz74i7G3hPs_-fZQdYeAKMF5Bw
Message-ID: <CAD++jLnCtu20rXcg7sMVLBi24EohscJoz0kN46XJaKPJt00O2w@mail.gmail.com>
Subject: Re: [PATCH phy-next 18/22] pinctrl: tegra-xusb: include PHY provider header
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
	UNGLinuxDriver@microchip.com, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2D57D2120C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6946-lists,linux-can=lfdr.de];
	FREEMAIL_CC(0.00)[lists.infradead.org,kernel.org,linaro.org,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,microchip.com,gmail.com,nvidia.com,oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 7:00=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:

> The tegra-xusb pinctrl driver is also a PHY provider (calls
> devm_phy_create() for PCIe and SATA). However, according to Vinod Koul,
> having PHY provider drivers outside of drivers/phy/ is discouraged,
> although it would be difficult for me to address a proper movement here.
>
> Include the private provider API header from drivers/phy/, but leave a
> FIXME in place. It will have to be moved, eventually.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Fair enough, is this a regression so I should merge it for fixes
or just a nonurgent fix that I can apply for next?

Long term a custom device can be created from the pin
control driver so that the Linux device model can be
used to move the driver over to phy.

Yours,
Linus Walleij

