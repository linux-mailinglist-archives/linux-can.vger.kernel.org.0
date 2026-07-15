Return-Path: <linux-can+bounces-8456-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yz2kGJVMV2poIwEAu9opvQ
	(envelope-from <linux-can+bounces-8456-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 15 Jul 2026 11:02:13 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A424875C2B5
	for <lists+linux-can@lfdr.de>; Wed, 15 Jul 2026 11:02:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8456-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8456-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F38F53033828
	for <lists+linux-can@lfdr.de>; Wed, 15 Jul 2026 09:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428473E0C4F;
	Wed, 15 Jul 2026 09:01:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786923D9DBB
	for <linux-can@vger.kernel.org>; Wed, 15 Jul 2026 09:01:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106093; cv=none; b=VYmxGI12o9UgBymL3CemWym23giyv+/bVkf4Ahbqbt9iDMCi11qgVjb9a1/MgvSyIiqh46uBSaOMcjXBTQ8b1WxvnrVdtI3gwh68C/yPqhZUYZYg2zg1O05oMAua6V+U5T4NNlDUL/JHewaQNoB3dcg++PzLWlaa1a2kh/TZAkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106093; c=relaxed/simple;
	bh=4D+d1b3Trs/CMs5Bj38QykZaXyZasuM9OpqfOKndXxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxtHpNtlkWn5azRNrBGxUzcKgLJljX9xzPltk2nPSHcw5idetcoGdml/zANowZyu+Ti09609nKAa/zTVP2We3/tOZdwfUt9QJbqP60usaV7vdH7zZOxVE9R4yQEGYRmIRbchnM4OqmtDIMfbVo5cPAJdEDfG3CgevSVv9BMEaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bf959b820cso1169760e0c.3
        for <linux-can@vger.kernel.org>; Wed, 15 Jul 2026 02:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784106088; x=1784710888;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7NaVzb/e9FWmfB5ARe3x7cY0vDrs37XFuu/XUXFp10g=;
        b=m+pDSvInn0UDOz3Qpv1G956JU74ILfhGVLu0iNUoiVhWsEVZpgNqlWi8InHsaQJXik
         acnGu3vPQyihFn4h+Cmbrl426zccpK59nXXmO6+b1IqNH1O814Z9/HW2MmxANBYG2vfy
         hyUzE1P0kJZoYdLcjIC2DFY+jzVJOQRyeqtHuvdhQ8oUDVOlgv+UxerJRV7mOFJ9vN4y
         lzyi0mhtZknlhMlfheNWPHnRQHrsBCz3Ndu2Whbm04qjqziE+NEFJV2IDqvDHGPQMllw
         OoNDhRjQj2p9ekDoNoGD8sYy5T6BZd4/dwUehhPLfrhj8EpaxxuQj0gqOGdOGClklne9
         Qp0w==
X-Forwarded-Encrypted: i=1; AHgh+RpenJnpik6zX2oNIxPnDT8h1+4zZVQvG5FAUd8p133lceLkwfHFRBRK0OjFYFghR+5Gjus/GHvO5Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUXuu3bXWwilygoD38uzc+Xn7ObBRv4zPAhV2ram6i1AOMdGXL
	lLh8D7gYG4VY8q28NuA36JELICc444Md7l9NErY/rrJfBFJW3VwtSwT4K7MqLNPHJ8U=
X-Gm-Gg: AfdE7cl8XnYt40K0th/iLQXgew8AgoJCUgiDL0hBGr90pG1darM6U0IDCPEHZT293tS
	9a04IUvxQ1AcnDfaKtgS2CXs/X/rYMkuJcMb2wg7KDViq35n35o3glTa/czaEEQp2g7TuGy4Pkd
	1U22/aCAZvdLMBImdzWd1u6hUnCM5dYjcheC3p6NI8Ojj16/XmDu0Jz37g/CO8irrDScE9YSG42
	qNvys5rwYRByMBmi+QQNxN7tR1kMw6F0vS7ZTG6dVvf4okfSuRCXKi9uzu1h0FggIkKKQPysrRU
	ZMesLaG4Ril3Tn/gLyNgR4hgRhP80+Y4kkoMBHiLYWvl3UrSlIT+GJ+px4v5YYi+PNy6uMeiVJF
	s55eLlamYI4SynJdFhoT6Nj8/KHsUIDnnoCaHAndI4soIaL4gXwxjvOFbGFE+IzyhSIbtZnjuyE
	SuSrrPzlic6SE1TnpnYMD1kxVEQYBR1mItePD/poNTgUynpAob//CPUQ==
X-Received: by 2002:a05:6122:1797:b0:5bd:a810:b090 with SMTP id 71dfb90a1353d-5bfbf1223b6mr10041802e0c.5.1784106088086;
        Wed, 15 Jul 2026 02:01:28 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bf6f5e2e70sm13678781e0c.3.2026.07.15.02.01.23
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 02:01:24 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5bf8e1edc3aso927966e0c.0
        for <linux-can@vger.kernel.org>; Wed, 15 Jul 2026 02:01:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrL2xYi4/EAOdln0/ZfyiWGW8FAZEz3xuTohvFmBS6ASk08z+R+ZwKBEsyRHGNTwjuk6rIHbGlrB5A=@vger.kernel.org
X-Received: by 2002:a05:6122:787:b0:5a5:3eea:4513 with SMTP id
 71dfb90a1353d-5bfbf34947bmr9390069e0c.12.1784106083256; Wed, 15 Jul 2026
 02:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jul 2026 11:01:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdULuz6E+zHt5W9Z9ik05ALSyMz4tkV-mGRTg3Nh=Wx_Hw@mail.gmail.com>
X-Gm-Features: AUfX_mwvtCJ6mQlGxoH1JvfSPfIrIHfInpMsp-NWrZ7U05hkN4A9x-SDsqPOads
Message-ID: <CAMuHMdULuz6E+zHt5W9Z9ik05ALSyMz4tkV-mGRTg3Nh=Wx_Hw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] can: rcar_canfd: Add support for Renesas RZ/G3S
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: mkl@pengutronix.de, mailhol@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	bmasney@redhat.com, biju.das.jz@bp.renesas.com, 
	fabrizio.castro.jz@renesas.com, claudiu.beznea@tuxon.dev, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8456-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:claudiu.beznea+renesas@tuxon.dev,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:biju.das.jz@bp.renesas.com,m:fabrizio.castro.jz@renesas.com,m:claudiu.beznea@tuxon.dev,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-clk@vger.kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:krzk@kernel.org,m:conor@kernel.org,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,glider.be,gmail.com,baylibre.com,redhat.com,bp.renesas.com,renesas.com,tuxon.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,renesas.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A424875C2B5

Hi Claudiu,

On Tue, 14 Jul 2026 at 19:33, Claudiu Beznea
<claudiu.beznea+renesas@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Hi,
>
> Series adds CAN support for the Renesas RZ/G3S SoC. Along with it a typo
> fix patch was added on the CAN driver.
>
> Thank you,
> Claudiu
>
> Changes in v3:
> - addressed sashiko review comments

FTR, this doesn't provide any real information.
Fortunately you do list the actual changes in the individual patches ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

