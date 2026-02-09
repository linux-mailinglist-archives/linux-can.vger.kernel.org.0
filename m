Return-Path: <linux-can+bounces-6518-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLbIE2XAiWk/BgUAu9opvQ
	(envelope-from <linux-can+bounces-6518-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 12:09:25 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C35E510E845
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 12:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F5D5300B042
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 11:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8EF36C0D6;
	Mon,  9 Feb 2026 11:09:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0436C0C0
	for <linux-can@vger.kernel.org>; Mon,  9 Feb 2026 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770635363; cv=none; b=f2HvBVl47IlMumkv7RulmFL27pZ5uGY+uO//sPedRLoTHRZEhNSRdVej6s10r83Wwngr4qSiCpbj+5VrFAM8M8h2pBORe+DGhRpRasrEVMSb1QgNS4BQcuBf8uLERSzQ8ZFX732ffjsdW++QNJIqhfHbdSfjKjSPkQQY1WGMF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770635363; c=relaxed/simple;
	bh=sC1KLy2SPQ43D9OQaLHsL9GAH/uPG9wpQURfezxkw+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=at7OGQoKl70bJ3SLoLIyELlUbBg/0s6yKkJ68aXVBYHC7IoSpp5hKkKz+bEYVE/xU15uKVEXnmHz/n1BfPWIsHZo1M3QqbaLQga6PQWIPNQLfVhqBNNZDbOeD4rn0Bhs5TwNBoLi4qiX0EdH+Ky6ZDaBFVrd3Qm1utuXLtbtcTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5fae34a2163so2254858137.0
        for <linux-can@vger.kernel.org>; Mon, 09 Feb 2026 03:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770635362; x=1771240162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CFhQGFBF0i+66a0TJna2Rm6FRsUIJ3sMEDyWqu3+t6g=;
        b=UBcA037lLF/u9VQhIeY+zIdio00QGdR939GhPOgnOLqOMcVQc3HiK8uOTdTxDBxLXm
         J5jgSx2Y3oGti/Kd/XYSwKYR9/YDTf1UiFEPsfRFkqSZQJHB5HlR9A80kDRk9tH0HArO
         fgzA5Hosx32XnQRWYseuQ5qLlyn50oHUKEqy//reYtIi2yskP3n5OUNLi/R7hMMJetMo
         15PHb8t6JiXXYJhhSDa7DAu58EejYzf/6LkwEY1TW412Jef329rIFvRbY12EdcnYzUqy
         hE+UA/XvyKcTp4a9HyHkZb+4UQvpmM/IfthqQbQ8jcciwqTP+Sx3NZqC/tpHBRpyucrC
         qeoA==
X-Forwarded-Encrypted: i=1; AJvYcCUGinoc1RngFSK7Z2t+u2AzdaSq2epuoOt31zxoUcv7CWhzyVhhsNNtupKJU7DRFsirprBh+7Uoy+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOu/gxUN5r9enqWXkoJyrwMpaRd6P6eemAnJHQi8BWn/TijQsE
	npGjaSMu7J/m0NDTjdXkubkQvDOu6OOphYIqiyw9SdIUHcy5Jy5twjba87rJ5Igp
X-Gm-Gg: AZuq6aJXAj9eIGGR0a0zh9lAycCf+BkJnF5nT2EVC6uJN1vQOCv/A9JI640nJxA2wNQ
	OdpCr62SocIwtkg+g5Bz/C8J/fypWEHpUTVLDEYo1vwvrr0II8hMweZ7wuJIQcyuGaNiBr6vSrf
	28UwetlJnI84eeSOPGmM64o/M1pxA9FMYVvGiwkJ9B90JCcWe2Mg5DX44wTLNucuccsuhuFOAtX
	jdivEwAx1EoXfuQ7UsWk3wTwd8ecQitnZ2WRLWUcolx29Wi+joUtcKJHqs3WJ7TcsHviwhsFvk4
	5S1jL7MX+v+mEPuwR/+QzHd2sy09haC2/BuXYh2OPkMHFR/5YWmNFeY/ZL6DlwjifRQOhm2V801
	6APYmfBhNxV04g+i67BArZwRlkDItgrxLEq3q4yYQ+jOOp7rYLUzcaTSxiGiANhUXhIjg0z0H6F
	rHGch8oDq358Oz2BEu5V9Z2o87uOXcEAGn0ziav5veCUepPHyNZGx3
X-Received: by 2002:a05:6102:942:b0:5ee:a494:1747 with SMTP id ada2fe7eead31-5fae8c4641fmr2781116137.36.1770635361877;
        Mon, 09 Feb 2026 03:09:21 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-949016c6851sm2977787241.9.2026.02.09.03.09.21
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 03:09:21 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-566360cab02so3139093e0c.2
        for <linux-can@vger.kernel.org>; Mon, 09 Feb 2026 03:09:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvJaEPhhopAeuApedHiOBv2OpIa9Qg9tZSwE5up00YevaBuiTA8hQhipL6l7PZv8z2wIXN9qj0GVg=@vger.kernel.org
X-Received: by 2002:a05:6102:f10:b0:5ef:ac78:3c77 with SMTP id
 ada2fe7eead31-5fae8aafb2dmr2699695137.18.1770635026255; Mon, 09 Feb 2026
 03:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-3-024ea405863e@solid-run.com> <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
 <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com>
 <39f3891c-c05a-4e10-9ad4-ab3cbc6fa70e@solid-run.com> <CAMuHMdVbi=2puhk84k+FCDXqkQ9jFsy0rsseQiFCF8i=KsR1OQ@mail.gmail.com>
 <1a4288f2-ee5c-494f-9fbe-ea3a90a16014@solid-run.com>
In-Reply-To: <1a4288f2-ee5c-494f-9fbe-ea3a90a16014@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Feb 2026 12:03:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWa6o19+oX=-Hkpx+tEsnJ39vyi91FwbU+YHJqv=QsPkA@mail.gmail.com>
X-Gm-Features: AZwV_QiXoAPXWcsFJ5cXmi5LxanLCRJoL8Hmi_xM0cWtiaFZbVoUaSfpkEx2uEE
Message-ID: <CAMuHMdWa6o19+oX=-Hkpx+tEsnJ39vyi91FwbU+YHJqv=QsPkA@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] mux: add help text for MULTIPLEXER config option
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	DMARC_NA(0.00)[linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6518-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.925];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solid-run.com:email,mail.gmail.com:mid,linux-m68k.org:email]
X-Rspamd-Queue-Id: C35E510E845
X-Rspamd-Action: no action

Hi Josua,

On Mon, 9 Feb 2026 at 11:47, Josua Mayer <josua@solid-run.com> wrote:
> On 09/02/2026 12:17, Geert Uytterhoeven wrote:
> > On Mon, 9 Feb 2026 at 11:12, Josua Mayer <josua@solid-run.com> wrote:
> >> On 09/02/2026 10:06, Geert Uytterhoeven wrote:
> >>> On Sun, 8 Feb 2026 at 16:16, Josua Mayer <josua@solid-run.com> wrote:
> >>>> On 03/02/2026 15:01, Josua Mayer wrote:
> >>>>> Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling t=
his
> >>>>> option thorugh the kernel configuration without explicit "select" d=
river
> >>>>> dependencies.
> >>>>>
> >>>>> Select it by default when COMPILE_TEST is set for better coverage.
> >>>>>
> >>>>> Signed-off-by: Josua Mayer <josua@solid-run.com>
> >>>>> ---
> >>>>>     drivers/mux/Kconfig | 8 +++++++-
> >>>>>     1 file changed, 7 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> >>>>> index c68132e38138..e31c46820bdf 100644
> >>>>> --- a/drivers/mux/Kconfig
> >>>>> +++ b/drivers/mux/Kconfig
> >>>>> @@ -4,7 +4,13 @@
> >>>>>     #
> >>>>>
> >>>>>     config MULTIPLEXER
> >>>>> -     tristate
> >>>>> +     tristate "Generic Multiplexer Support" if COMPILE_TEST
> >>>> This didn't do what I thought it would.
> >>>> It was my intention to allow enabling this through menuconfig / .con=
fig.
> >>>>
> >>>> With the syntax above menuconfig shows:
> >>>>
> >>>> =E2=94=82 Symbol: MULTIPLEXER [=3Dn]
> >>>> =E2=94=82 Type  : tristate
> >>>> =E2=94=82 Defined at drivers/mux/Kconfig:6
> >>>> =E2=94=82   Prompt: Generic Multiplexer Support
> >>>> =E2=94=82   Visible if: COMPILE_TEST [=3Dn]
> >>>>
> >>>> This means it cannot be selected.
> >>> Looks like you haven't enabled COMPILE_TEST first?
> >> Correct.
> >> But CONFIG_MULTIPLEXER should be visible always,
> >> not just when COMPILE_TEST is set.
> > Why should it always be visible? All users select it?
>
> This is not relevant for v7 now and can be handled later.
>
> It was discussed previously that drivers supporting optional muxes
> do not need to "select" MULTIPLEXER through Kconfig,
> E.g. the renesas sdhi driver.
>
> However other drivers are already selecting it even though the mux
> is optional, see e.g. phy-can-transceiver.
>
> In order to support muxes in renesas sdhi driver e.g., users must choose =
to
> enable both the renesas driver, and multiplexer subsystem via the
> configuration.
>
> The mux core standalone also supports a limited use-case without other
> driver
> interactions, setting idle-state e.g.:
>
> mux-controller {
>      compatible =3D "gpio-mux";
>      #mux-control-cells =3D <0>;
>      mux-gpios =3D <&tca6416_u20 0 GPIO_ACTIVE_HIGH>;
>      idle-state =3D <0>;
> };
>
> So it can be generally useful for a user to enable CONFIG_MULTIPLEXER.

Then please say so in the patch description.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

