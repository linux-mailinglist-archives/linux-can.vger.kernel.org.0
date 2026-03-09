Return-Path: <linux-can+bounces-7025-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEm+JyzjrmmeJwIAu9opvQ
	(envelope-from <linux-can+bounces-7025-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 16:11:40 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF6223B646
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 16:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB6563064DA4
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 15:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFEE3D75BB;
	Mon,  9 Mar 2026 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDCKAWzT"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B4A3D413B
	for <linux-can@vger.kernel.org>; Mon,  9 Mar 2026 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068821; cv=pass; b=BvsX+VeNyK2xlfcdqQUJvXyQcQYoMap/0NU4l1pYxecRbxB5oB7k7i86BYKLh7VFpr0TcRl79Xd/rgFPe3wt/jkkciGaTQAWMhM3thpOng4HF5kZYyBj68Or6AV4B8QAsfbQoMJDwRGKiN2BNEYmzQa7G/+3L22zW/nxSbyJSJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068821; c=relaxed/simple;
	bh=JKN2J4kHq0yD8TjxvyPjjgMMFAS3NaA1mJTCXgnPsRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGpDjzEStbG3VcBlzx6ZSd30GMYl5jYK/6wLL73+AnIki56113v2C+yJ/bbTlv6nG+YZ1ibYBKkNNwQvYFD1F8h6f4F+ZBzUL7GBX5VXQT8oGHUWREbNqBeUuy7Http7F6bAKRAep/32iaisMGxM/RQtJvhhzOxfn75EmNOSrGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YDCKAWzT; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a107b387a5so6891833e87.2
        for <linux-can@vger.kernel.org>; Mon, 09 Mar 2026 08:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773068818; cv=none;
        d=google.com; s=arc-20240605;
        b=RZ892jdQn3QtFkVXP+2KZ5KS3OwKSUTEXNAJD0L+NNXyVVL9cPUnkyiCCDal+uTuna
         NONwMjMbxao+BSM/WCHBXuJco8jNt2TW2QpDa657cUPojhCmMqg6sHTSKs6covXVeR39
         x42X8p9K+JPFTRCSo1uauzEYMcufsO0H/edFIVMiOtA/JX9eCC8ZM5rqtanwBEx5O2BN
         tPvf5sDCBWCWzRRZwfRw9qr9XbRMLClLu7yURE3OcO/DnkVzVVO2Xr6Nd3Uuq9EunWty
         TgfmjYUL1rqObvjF7CJEDEMhoGrjTPnrfkmkhXJ811tb5jF6l+N5pjygIEA9VyEDQQ+J
         Em+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5tCYLBqDfvBtAEmrKe/1f8U+n/JTrn4BGEWGrJUqdlY=;
        fh=kWNIFogwmuzPUcZrjayKkUnc3U3gDgp19cba+CfZJBI=;
        b=AgD7THkkKOYB6c6fL38nTa5LesBv58L3JU7JEZq3z7S5J/CFH+mkFzLclzLA501TG+
         jW+qeHvPZZtHM5/TfNFnTeVpwSBl+FoBdvQeqBzleNAsxSd+JLwp+iPLMZU/AHYWeqjE
         z0DZJIQX1e6rLT0J60zNIyDRgQ9i2YjaBJ50UOI2TNtOqmWcXoCuqDP495+thgbhlcFt
         vr3lqBWO0BBvLUyL+LBuZT0JE2h98tcKQ4MfLgxAJCkkubkVU1AnSxrRUzqV1qFwIccm
         klRy60rrYvLWp0/cIs7AyF+cAq4+Z9vc8c1M5EqjoRelc1MT9EeVBJKdmL4ticbFF0jt
         spjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773068818; x=1773673618; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5tCYLBqDfvBtAEmrKe/1f8U+n/JTrn4BGEWGrJUqdlY=;
        b=YDCKAWzTSjoyOKxywxX/89IU//SMk/64iocZQqSPHMm+RZyOKO61dyNWFH8+fDrUSH
         BhsrZMeW8TAfJqMdaAyEkf3OFDA63mDRaFuayeHDpbmqxS6dFezk9eEnH002tQ2OpMEt
         tv4B6QfA+/uuB001aM95V6PbaZdpSB6LnvAC5az3zDD7/Jeo503Erl50y/Z/OQoTmfUB
         gsrXxHQWndpKSnkqBf/TQThoIOiQSSpNSmwWdGp8MIQZC9wRKuXaD5KsunxTNwISM3pU
         +z078T8q/N7b+1nsIPv2gGu4cwBm7Lir78sm8SKWJd+vbaQ/R1qNAs6hWZ9EdoUy7rDb
         S6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068818; x=1773673618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tCYLBqDfvBtAEmrKe/1f8U+n/JTrn4BGEWGrJUqdlY=;
        b=V9i0x9+VLse1wH84fJA9P9M9Cs7nDUDLlSOIE3V4I/5beJf6yci+9l0etWqSfPEE77
         095zy9ruGc8glj9UMvPAK7v+C6qsfBDvO2q2MoMIq9ACfVTStTMqBG1i4z0JIaWdatvR
         dS0IyLz5fw70NvPLi0IjPFbHwZWPnLd3OetEK5DHXNXx60oRFMZ72lJPSTj2eC7DasHI
         bNijmIAbbmff45c/5nfc/NMhQFd8snXhNyWyKYwT1h4Nqn8unzWyeR2B1PeLcLB62IM3
         MTdArcH0c4Ugd9vcnQnZCmE5nkrxdlZI/wVV5Yid2WnfP9G9+FWAe0vRE9ADj9U9qgTk
         trHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkriFD45zoa/dzIzIzWdqqEUAAV2QbcnDS6/AXBi821HK/mke9iqINf93rKKV5OSuV7FbII0vfHaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXkKCcCSmIHW78PXVIKdm6p71HOFigNtvTUEw7NNfXXkPiuw+Q
	YRdBxRRlukhEYduSqcWTZHfws2oOuLP+H/FNYAUXwzsZTJBAYTyyuABiG6uSJ6mUHn6Cr/ecqiE
	hM6l5rbtPucPWfiAG2mT1fU0HivWOwL93cPknTMtz/Q==
X-Gm-Gg: ATEYQzwrdZjfcvIRsfChvnK1qXtoGkrl/QlMnJRUYaN979/qbQRSMP7KwJRUSa+JjnJ
	WhWfBOtQmbQlcdetD8ScHWQQZGE2mfKplJUH9HcqO0MOOS8vWYhS+PmiTUMSucj+0ieJTLtajM6
	s6Hp1skHnl5On139+FxqVQRasaDiCy3F1HuaybHded1rdPWbCDfQs/g7VuDDPrIeOv4/+Gt9KPn
	VBArABUSFxplguYthmZhywhYfY3eIKimk0VhttvUPcpH0I0sMMK9YYCHuljs9x2WCkFcehzsCQN
	Q5TWMBGW
X-Received: by 2002:ac2:4644:0:b0:5a1:3ab6:6de2 with SMTP id
 2adb3069b0e04-5a13cce183dmr2793114e87.37.1773068817703; Mon, 09 Mar 2026
 08:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com> <CAPDyKFr5NZKEKpV2+GXGnzH9pyyj_TLmMCc3rac8h248srX_dw@mail.gmail.com>
In-Reply-To: <CAPDyKFr5NZKEKpV2+GXGnzH9pyyj_TLmMCc3rac8h248srX_dw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Mar 2026 16:06:20 +0100
X-Gm-Features: AaiRm51gPNstmfmPCbGsevKfnVyHAve3znxWrnZO7sNkn4-s9OVpM21rgVmHXjc
Message-ID: <CAPDyKFqyUsKbp9pgKHsMoOd5Qe_0f9rxsX6C61adQC344eA9Lw@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Josua Mayer <josua@solid-run.com>, Peter Rosin <peda@axentia.se>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1DF6223B646
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7025-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:email,linux-m68k.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,linaro.org:dkim,linaro.org:email]
X-Rspamd-Action: no action

On Thu, 5 Mar 2026 at 17:19, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 26 Feb 2026 at 14:21, Josua Mayer <josua@solid-run.com> wrote:
> >
> > This series has evolved over time from adding generic mux support for
> > renesas sdhi driver, to partial rewrite of the mux framework.
> >
> > Several drivers have started implementing driver-local managed and
> > unmanaged helper functions for getting and selecting a mux-state object.
> >
> > mmc maintainers have requested that new code shall intreoduce and use
> > generic helper functions that can be shared by all drivers, avoiding
> > code duplication.
> >
> > This series is structured in 5 parts, each of which is self-sufficient
> > depending only on the previous patches. This shall allow the first N
> > patches to be applied even if the last ones need further discussion.
> >
> > 1. Rename driver-local helper functions to avoid name collision with
> >    global version to be introduced later.
> >
> > 2. Implement generic device-managed helper functions in mux core.
> >
> > 3. Convert driver local code from similar patterns to use the newly
> >    added global helpers.
> >
> > 4. Change mux-core Kconfig so that it can be enabled through menuconfig,
> >    without an explicit "select" dependency from other drivers.
> >
> > 5. add dt bindings and driver support for mux in renesas sdhi driver.
> >
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > ---
> > Changes in v11:
> > - changed approach to Kconfig making MULTIPLEXER a bool, and adding a
> >   user-visible wrapper for menuconfig.
> >   (Reported-by: Ulf Hansson <ulf.hansson@linaro.org>)
> > - dropped the "default m if COMPILE_TEST".
> >   (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
> > - improved kerneldoc line wrapping.
> > - removed unnecessary changes to original devm_mux_control-get.
> > - fix "reference preceded by free" in mux_state_get function
> > - Link to v10: https://lore.kernel.org/r/20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com
> >
>
> [...]
>
> To me, this looks ready for a new try. Unless I hear some objections,
> I intend to apply this as material for v7.1 via my mmc tree on Monday.
>
> The complete series will be available on an immutable branch, for
> other subsystem maintainers to pull in if that turns out to be needed.
> I let you know of more details on Monday.

I have now queued up this series for v7.1 via my next branch.

The series is also available at the immutable "mux" branch (based on
v7.0-rc1) via my mmc tree, which other subsystem maintainers can pull
in if needed.

Kind regards
Uffe

