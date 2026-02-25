Return-Path: <linux-can+bounces-6632-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOlMIxPrnmk/XwQAu9opvQ
	(envelope-from <linux-can+bounces-6632-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 13:29:07 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B556C197564
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 13:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3AE033025983
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C7F3AE705;
	Wed, 25 Feb 2026 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sDSkUWOS"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA543AE6E6
	for <linux-can@vger.kernel.org>; Wed, 25 Feb 2026 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022338; cv=pass; b=pwpG4OUbYEGTpSyzrN3KPykgNck0usR/GrA/CYnDFNBAJPkoKUzXwgHKx8uaJv7joPj4JR63hXqSV9wY0DB3cKDiodz4JCCUIBlVdhJLZKp2BpVjpg3nWDw2lb6Q/VcIO4zJVSc8K5AI4jKDdFGjKLhLIVuzjJ2Vhc5y2imm6mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022338; c=relaxed/simple;
	bh=jXjctxlX2mOd4kESSuh+dmt6ufaPRbeKlSyIRNOCp10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fpm1+s8gjcmMDJiEwivF5Gcf+8pLsUwew8xTUgfQjQpc7q4oV+/YIFg05N8zmRjhOZ5kSYRH7JXuD4ltXn4Qn5P4n1CxrPdlml0C3xYvihdehZ7HwcSDCbwRrrZSU+fsO/msReqqdUufiWBhiwyURSEmWM96dkNjJvzaquDa22g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sDSkUWOS; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59e5eaa491cso8350605e87.0
        for <linux-can@vger.kernel.org>; Wed, 25 Feb 2026 04:25:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772022336; cv=none;
        d=google.com; s=arc-20240605;
        b=aG19ezycUE2Thj2MKiEJIzoyQGd7a5Se+GIsROEejeahn8yOvYWXjODKG7oPrYHy5O
         BchyFVnD2m1/ZDtPBo425DMA22IfgCJYnnFDxrhXYlzkE+/Twoda4y9I8S3wrM6y2K/L
         EVVF6Ku7L7waWs4Xtz98eeLJthXM4XM5iNNsS23dInw+yRko74Y9UAROWSp6pTjTrxsz
         OrnWPhUw9a3lKbJaUSSfC0SJA7+Gjgw5cgBh5I7aia0Lft3gQA2aEsvVZzj1GTl64Svc
         P8EJCj1QtBt5wG4ea5392tGRcaT66gJyhdK75glYqiVjtyPA0Grf9wA0ONEF8TbWSndy
         GHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ySl6ydztfTvafF7H4MeeeCO8Ou666oUNAgwfiGo+Y6c=;
        fh=n2XXIuqw08lRJowAE10oFowHQzwfylviNlABp211TzA=;
        b=A5lSmG3xlN69sJLP/AOApiv8xduINS4BpCYgVkDhYWF3Vd8R8UVdj1dEjTuSf/T2dZ
         BvTVh/X3OmZx3oNl/KvA8TzN/Cpdi2qyT5SvkgHX1OWTxJmPM+/5N5sqPHVIuTpPksBQ
         EiXcno0M+WhChztxyOQgokN+5Kncx7Eu//vBjAL2A+bTTBTnLb0B/xpAGOKattf3Pcty
         0fItn9aXhySiH6xi15fjM3l5LoeEdrXNvPgd7UyT0lDrwquOgokkiIlVon2nmBD8cUng
         KfKCR9kzWMVeuXBVA7wA8Ch/Lob+OyToDN+srmf77eL8DUooHPb1In/HaNa5Pbm0aSg0
         2/Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772022336; x=1772627136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ySl6ydztfTvafF7H4MeeeCO8Ou666oUNAgwfiGo+Y6c=;
        b=sDSkUWOSKvxKxjfBRCLCeRWRlaT6myxGf91d+cFmFgdZeVpuujfiENdVsDX7udA6j9
         pq1oYL0Z44XH1uBM1U0j5o6vT/g0VHsuPW7VKOlAh3vAFVAvv4LSR+zBB1m/xA4aZuQP
         i5b4HPUHtjrCPeOGTsRUIZ53UfjBprittrXK7qS+s2NnOcfPo7honzsfS27MXC/InZGi
         RL8Qld4kNmEEetpOF6OzFZMCoqxqAhGutWICH0o8TsfxY/Nn5QlMLG1KV2qjgaR2HxkK
         675I+ZHxJ5EURxmjfCPiXQ6IFhuz/eZzLTmEdkYhokM8Xaw40D5sfnIjoz4pNhP09wFU
         Qwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772022336; x=1772627136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySl6ydztfTvafF7H4MeeeCO8Ou666oUNAgwfiGo+Y6c=;
        b=NVeBJaF5vIjIrkxHriuID8fLtAI/2i0wG6gDl5RsdYQQft66MgbQvNuzGTQoUuzpHX
         mfNudxTqw/niiETCch+N+XXhGl0G27OU54zBim3X6xJWXeofDGdJ5oshLcTe3nA9igab
         wQeg441TYyRG3obettd3fQkimI/jLA8H8n25HtQuWj3BD6aDhiSSiyGlNBg12IfIrnQC
         cNv+MdbclqKimlcRgg5PnHfnNm+HhAFOMdH+Uh57brdmX7MknQpYa5b2wcWxOEb624qV
         omLIsoleWRbqlaOyEnhTEkTUhYtHSwEaYxhc4QfhkLtF92c9beTyp4UOd+nc708XaTED
         Krvg==
X-Forwarded-Encrypted: i=1; AJvYcCXBLoyg1imgoxjELK1OnzR97y8UPJrTdJb3hqg2top91RzvFxLyKf9ZqAua4hyD0vl5f8BGuVGUoNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYP25VDhu7Ck3ja2cBlawpH1qiv2SaQW/kV3/5MdEcXMq/H+TT
	xsVH/CWLGa4KGriK+C4gk35Eev/hphXElXUqGjd9pExoJroow8CdJ93XAdbqBrb5GECyM93v8PA
	N/xJ+xOIV4cDuig8GOkcZFKRJ48ch3w6X5BWf2JaZoA==
X-Gm-Gg: ATEYQzyTRWT1HsM+EH5lPDMe8ETXMTt/tCDxzXaqjQpAP/xOf6MGYm2wgIjOh+x0YKW
	tcg97FYidXAHiOEzM9McoG2blwj6nqUI5QNdQAtaauk+xXeu3P7r/SHsp7xjT7indZ8n1ob/t12
	YLDeMmxnK63by943219yjhGV3GEOELu4IVjpAIoNOBCiK0siBD5xYoOj4WBeUeyrTMJwSF1I9MZ
	g31Dz7zO6yBCbwG7DKWVW9+lSDg+9PASPdTc+88QDeUPjZlW2/BcI/bgk43UMRDZ6Jvp/a9rJ7n
	jA+FqhcU
X-Received: by 2002:a05:6512:32c7:b0:59f:8e98:5dc4 with SMTP id
 2adb3069b0e04-5a0ed8a5ef7mr5479022e87.23.1772022335501; Wed, 25 Feb 2026
 04:25:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com> <20260225-rz-sdio-mux-v10-8-1ee44f2ea112@solid-run.com>
In-Reply-To: <20260225-rz-sdio-mux-v10-8-1ee44f2ea112@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 25 Feb 2026 13:24:59 +0100
X-Gm-Features: AaiRm51lt-nfdrgge9ulVu4LPr2JQVPo_YLU5CXuzn9PVqh2A9E2AaS4fZriRp8
Message-ID: <CAPDyKFoDZr33tQXofsZzPrJbZM=3VhpeeOk1GqvRA1UK=LO5Ww@mail.gmail.com>
Subject: Re: [PATCH v10 8/9] mux: add prompt and help text to
 CONFIG_MULTIPLEXER making it visible
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6632-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,solid-run.com:email,linaro.org:dkim]
X-Rspamd-Queue-Id: B556C197564
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 at 12:35, Josua Mayer <josua@solid-run.com> wrote:
>
> The multiplexer subsystem was initially designed only for use by drivers
> that require muxes, and did in particular not consider optional muxes or
> to compile as a module.
>
> Over time several drivers have added a "select MULTIPLEXER" dependency,
> some of which require a mux and some consider it optional. v7.0-rc1
> shows 15 such occurrences in Kconfig files, in a variety of subsystems.
>
> Further some drivers such as gpio-mux are useful on their own (e.g.
> through device-tree idle-state property), but can not currently be
> selected through menuconfig unless another driver selecting MULTIPLEXER
> symbol was enabled first.
>
> The natural step forward to allow enabling mux core and drivers would be
> adding prompt and help text to the existing symbol.
>
> This violates the general kbuild advice to avoid selecting visible
> symbols.
>
> Alternatively addition of a wrapper symbol MUX_CORE was considered,
> which in turn would "select MULTIPLEXER". This however creates new
> issues and confusion as MULTIPLEXER and MUX_CORE need to share the same
> state, i.e. MUX_CORE in menuconfig must not be set to m while
> MULTIPLEXER was selected builtin. Further confusion occurs with Kconfig
> "depends on" relationships that could reference either MUX_CORE or
> MULTIPLEXER.
>
> It is common across the tree for subsystem symbols to be both visible
> and selected, e.g. I2C & SPI. In the same spirit multiplexer needs to
> ignore this particular kbuild rule.
>
> Add prompt and help text to the existing MULTIPLEXER symbol, making it
> visible in (menu)config without breaking existing "select MULTIPLEXER"
> occurrences in the tree.
>
> Select it by default when COMPILE_TEST is set for better coverage.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  drivers/mux/Kconfig | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index c68132e38138..4f7c6bb86fc6 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -4,7 +4,14 @@
>  #
>
>  config MULTIPLEXER
> -       tristate
> +       tristate "Generic Multiplexer Support"
> +       default m if COMPILE_TEST

Allowing the core being a module makes things/code a bit unnecessarily
complicated, I think.

Similar to other subsystems (like regulators/clk/etc), the core is a
bool and the menu below it for its provider drivers depends on it to
be configurable, allowing them to be tristate.

> +       help
> +         This framework is designed to abstract multiplexer handling for
> +         devices via various GPIO-, MMIO/Regmap or specific multiplexer
> +         controller chips.
> +
> +         If unsure, say no.
>

continuing from the above comment, this would instead be:

if MULTIPLEXER

menu "Multiplexer drivers"


>  menu "Multiplexer drivers"
>         depends on MULTIPLEXER
>
> --
> 2.43.0
>

Kind regards
Uffe

