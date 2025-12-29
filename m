Return-Path: <linux-can+bounces-5959-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0D1CE71E6
	for <lists+linux-can@lfdr.de>; Mon, 29 Dec 2025 15:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1282301B4A3
	for <lists+linux-can@lfdr.de>; Mon, 29 Dec 2025 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAABE329E43;
	Mon, 29 Dec 2025 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gZK/XVsC"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984FB329C5B
	for <linux-can@vger.kernel.org>; Mon, 29 Dec 2025 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767019633; cv=none; b=C5jX3NcP3t768D+/yhxW5MbNLoC4LYb7Xm8rpeyAsxRH32+2DHYz3o4waWioyR+uM1ywMVGj9NCuUu8mE/L7ks+YYnSUWibWHpOT42JL7ua6Y4qj7f+BFRPl4d+yZxA9TrYTCAkgsFhHaWIWJqpGixL+Vi0T1n3CdV6AH3TQDcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767019633; c=relaxed/simple;
	bh=0fdYin/a1kGKTO0aBJq/0xsRm45K7iupOY7iUNqRRJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeT2YWYc6RvvJyGVlHUl5Iahk+7WdqXRsyFYJnHIiot7EzYaF0nGrzTbJhL80D8NPCW1PvTNaMY1Ux0aIrKKk/CJjtspoMP3o+wcJuchAG1eXe49obWCczto9siAZVj5Dk+T30Oc2sIVZSA7Iv5Q37IBneaBUVeZQUC3Kqsxip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gZK/XVsC; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6420c08f886so11087917d50.3
        for <linux-can@vger.kernel.org>; Mon, 29 Dec 2025 06:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767019629; x=1767624429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hiFIGGOCel6e4RtTn/5DW6H0+gmbweG5rl/mIaIEv30=;
        b=gZK/XVsCELIw+kf+fegZRFaWFH8spENIhMsxFJA+BlEMdUeN7lmgs9xjk+xjOMu8r9
         LuMgJ12OEOjhLQCbXsljPAEAL95CE9jsH0C59xbNv5GR4wyoZrx+saA1yhMQgr+mA5SM
         ECNv+N6QlgdCRCP52QCHyZIi3QpkwWubtYi2JnIreHqCTEWYa3Mz8fHipWe+jojkeeqO
         t98ky7n+6/H/F17HzZsX5AwyKI63KX2fiCenajVFCiVpQIHnt5Kyq06SXY+gr+vH0OAK
         srIthZ7RGMnHpSLjAWxQALybXyadnZ63Iej55QQm3efWV8MyC1877OC2VyC6YRi6oEB/
         7K6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767019629; x=1767624429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiFIGGOCel6e4RtTn/5DW6H0+gmbweG5rl/mIaIEv30=;
        b=vAXCPyrm+J4Q4EdZhLlRmWxT+QdqwH1AqMr2KOlKhACkpbwzCMX3xZixe0qZgaHsKv
         a6J3pRF+V8odZNI3tCDqwIDa0ZKC2CbWuCE8bGLv9P2A8Lsd/rb4/kK4jk+vaZaGqUMh
         lFpOmnDOYhGsZBtQLZKLv1m9AnnJhqGzUiz00d5uQ17GB9h3++mIVWaEtMoKTdD8WWjV
         VkUD3UiEuJ5Xb6lr4029B0F1myk2boX4ysCENJ3qMedNbj20swn00uSqrETN3gC7OpEW
         LMh+Y4Mp/UMSyQZuAA7uWC9h7WkZ3fL2nKkJgJkRbfDKNvVkvMCJQroVm1j/wIZmSOJ3
         bIPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbdaNMo278AEZcdo+CZdey97KdCY2wTttRR19ylDjHwY1Ji22SnEBdvgXjjPwInELtJwgsOJ14DoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiYb+ciMdmeYlf1p/5s6RnNbNkP9DMzBachUH2DvoXm2vYPzDW
	3j7JX8dm55mt6t1a93/A7VHjCKLK/QKapNxG2RqDWcV0FGJ0nB+j3aSMwJxXW6ar3InKQUyPCqQ
	ZPMeZtPf5bqPkcwFYCLflq9AHcCCmk7Beefvi69jz+g==
X-Gm-Gg: AY/fxX47h+U3pMya662OIDth+gzdoY7C7/9Lv7XG/zDeC/wIQ0hKNTN0E/2rt9gW36Z
	wli9qYHf0oFwyz0qB75Q3OzEBmfyYdoXuqfoRpI1a6H+9Y752RSCp1jwcqrmxCu/M2s0RAZlFEJ
	F+/acHKiGfl1CKJCcyzvucnm9f24+ahbVkSe/IPfetv6OlBotQzWnnNGXcd6qDig64gHiDfpJ7h
	w5Vqgn2Yyki/C9dJNw0X6JttKV1qXqjdHsoN26LbE04RPutmBBEgUJCt+PeCSJrToNW8YF+
X-Google-Smtp-Source: AGHT+IGO4whynDnDczZe5aUSFNc6rZ7ClmyTEypWHVE9Jxyg/qzrfMWaETUGVpcInjLrsVhW/aWOBEshOk4ENImI9iE=
X-Received: by 2002:a05:690e:1881:b0:646:7a21:f05c with SMTP id
 956f58d0204a3-6467a21f232mr21185393d50.50.1767019629379; Mon, 29 Dec 2025
 06:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com>
 <20251210-rz-sdio-mux-v3-2-ca628db56d60@solid-run.com> <CAPDyKFoYd3WKGrjD3DEzZH8EfgZPmRkrqL=rdoKNuAADrvz3Eg@mail.gmail.com>
 <20f2128c-c6cb-4b13-aa08-b93e540f5bd9@solid-run.com> <CAPDyKFo2jsV02qSDBSZTewJjV09AMO8iETU5Uxqz+GBnd0JY6g@mail.gmail.com>
 <e8b0579d-21b9-4072-857b-5afab92c42e6@solid-run.com>
In-Reply-To: <e8b0579d-21b9-4072-857b-5afab92c42e6@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 29 Dec 2025 15:46:32 +0100
X-Gm-Features: AQt7F2qjavw22v0M0v4JRnBk0tlNXPSxJSyNw5ogCiPk3Bm42fj5er9DVY64ELg
Message-ID: <CAPDyKFqN1Yq0atE6YaeigzR75n1Q1BSU8JjLno=ioUBwN8=FSQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] mux: Add helper functions for getting optional and
 selected mux-state
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Peter Rosin <peda@axentia.se>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, Yazan Shhady <yazan.shhady@solid-run.com>, 
	Jon Nettleton <jon@solid-run.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Dec 2025 at 12:30, Josua Mayer <josua@solid-run.com> wrote:
>
> Am 22.12.25 um 15:47 schrieb Ulf Hansson:
> > On Sun, 21 Dec 2025 at 11:38, Josua Mayer <josua@solid-run.com> wrote:
> >> Hi Ulf,
> >>
> >> Am 17.12.25 um 14:38 schrieb Ulf Hansson:
> >>> On Wed, 10 Dec 2025 at 18:39, Josua Mayer <josua@solid-run.com> wrote:
> >> cut
> >>
> >>>>  /*
> >>>>   * Using subsys_initcall instead of module_init here to try to ensure - for
> >>>>   * the non-modular case - that the subsystem is initialized when mux consumers
> >>>> diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
> >>>> index 2e25c838f8312..a5da2e33a45c0 100644
> >>>> --- a/include/linux/mux/consumer.h
> >>>> +++ b/include/linux/mux/consumer.h
> >>>> @@ -60,5 +60,9 @@ struct mux_control *devm_mux_control_get(struct device *dev,
> >>>>                                          const char *mux_name);
> >>>>  struct mux_state *devm_mux_state_get(struct device *dev,
> >>>>                                      const char *mux_name);
> >>>> +struct mux_state *devm_mux_state_get_optional(struct device *dev,
> >>>> +                                             const char *mux_name);
> >>>> +struct mux_state *devm_mux_state_get_optional_selected(struct device *dev,
> >>>> +                                                      const char *mux_name);
> >>> Seems like we need stub-functions of these too. Otherwise
> >>> subsystems/drivers need to have a "depends on MULTIPLEXER" in their
> >>> Kconfigs.
> >> Currently the drivers that can use a mux select MULTIPLEXER in Kconfig.
> > Yes, but that's not generally how we do this. The driver may not need
> > MULTIPLEXER for all platforms that driver is being used on.
> >
> >> There already exist a few mux helpers both for mux-state and for mux-control,
> >> and they might all need stubs.
> > Correct. I think we should add subs for all of them.
> >
> >> I'd prefer the restructuring of kconfig dependencies being independent from
> >> adding mux-state functionality to renesas sdhi driver.
> > I understand your point, but adding the stubs isn't really a big thing
> > - unless someone has some good arguments not to!?
> >
> > Moreover, since the series changes the mux-core anyways - and
> > subsequent changes depend on it, I don't see an issue to fold in yet
> > another patch to add the stubs.
> Would this also cause changing all the Kconfig "select MULTIPLEXER"?
> If it is only the stubs - sure.
>
> And then in the renesas sdhi patch I can drop my change to kconfig.

Correct!

Typically, it's better to do a "select MULTIPLEXER" in the platform's
Kconfig for those platforms that really need it.

Kind regards
Uffe

