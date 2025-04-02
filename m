Return-Path: <linux-can+bounces-3351-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53EFA78C85
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 12:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6593D170B9A
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 10:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BA3236429;
	Wed,  2 Apr 2025 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl4h6yil"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566D120DD4B;
	Wed,  2 Apr 2025 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743590486; cv=none; b=MBWg/uI0lTI1kEQODgovY49EDhXd8BdzwsT0eLiXqyp5Rh+g2fbwi9WgdmyZFS+2aNqyH2UspgQlvD9zGp5dqgC2cs8QeKDmFm8UAGS5Bbq8yamPemTHtpkfXKw18/8kcdHgh+qLUAjmQiYGGHmtWnbqCHBcOAfeKezAu3gS0ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743590486; c=relaxed/simple;
	bh=FJfKujFbcI8B3O/MyZ+4g/TwgAq9qFqvlCv7ikOTTUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVLpvnyh9Jwq0Wqh7YWh1NRfSAOumFfSmo+x+h0bU7mdYilRv8hJX8Kd/zeFtxedAlyDWrhZ3cfe1vk1i5cWW3cQ3SCYAffT7pV1o14taZMdVfbeAzEpAQ/u2zfZsC1zBjC+12H8I1wVKZCMcz5Ug0tjBzSCy2Sp3FL3CyidAnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cl4h6yil; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so1152821966b.2;
        Wed, 02 Apr 2025 03:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743590482; x=1744195282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y31q7Tc+B7wh48Ep7uS/SoP+BuGYGiDfJGtJZD4zAow=;
        b=cl4h6yilW6W+6EKz0KlLJsl4HhA7JF8M9fNwDmIoy1queIpRVz8I1btSapZ1Sq1hjO
         zPDN9umqUwRVVVighbI0YwuU/DXMWtwReS5uJr9bwjAZy25BLJJ0EuATvuBjYqfFbWDj
         VR4iRBLd474zmXxtMGiWDELlNSbjSuCZhj+qV1GYwB9AIMnQlfXRb0D1t3GxAt1oKm5C
         Kn4G/w6lb6Ba3ZeUf0vMM+cRE3oUTHa+eSSuZelZ7DQJ+Dc8rzyFVJ3vMkyoU3ZUiJAR
         tlNeSRZb05T4RGYIc/rCWt8LvRi71CGTYs32NexmMF4FrqG3mPOzwo6CLY3qvP++O4f4
         t8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743590482; x=1744195282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y31q7Tc+B7wh48Ep7uS/SoP+BuGYGiDfJGtJZD4zAow=;
        b=DeInxLxUt/ujIKbT1U+2wZ3bq7q1mPaRIHL8LtVCvOzzTD4zHdojlW4J27P6q85AY3
         pMTBBaITW4FgTdjloeydnucRVkuH6R8ZXqUnRO4t5eDPH1fpbsGz9lNGMwQSQcXvQTVk
         y2769lG92WMiGO6HykVUNMIGaY0pGMuGQF//RxLouNXgGINitu8YKtvrwbL87siAIuqy
         jcXHO/UAdIfsEu+Iu8aqBWrFTK9szK+nJcbjGs3jbQlHckChP3meWO3xX+JU4QjOPQXp
         aJxksvUc6kFIEnnvp4eUrSN8uupHocDZtqB2vjcidX3c+Vr1mFJ93KwwAxqPSYPxSbu0
         WVlA==
X-Forwarded-Encrypted: i=1; AJvYcCUYZLbZeqiuMFQsGgBV7kDOZr7fcDIeynyVKhwXgXUQbipWJLLg45WY9fPkGogBkY67Q2CsXL5zTeeH@vger.kernel.org, AJvYcCVVJ0tKcRbqEBfO/cxiBd1u9+M4LV6+pw4yEj1bT8Wj7UI3j33SW61heBFneJNZLFnNm3eWv9sgwQkXB1AB39GQrTM=@vger.kernel.org, AJvYcCVgsDdvmGdKW+rmUHhh6pJlIVRF/TztcshZUUm0toPCC1RsbeHyyQ6E9wnGRsVfnL11064+QKIrk2R9@vger.kernel.org, AJvYcCWismZ+GG3PTgJj8sIvsmCaM+A+xHH1/slfkUCBopIT6+1bQ39AOytkKEGS3wAZxJfCv2q0GONmJtSf@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9pAiPtpSrraT5lNRTLRqWpHPKOg1u2CPrfWxn3/N1yJNQmUu
	UJYvGfPG0tpkgtj9zp5hC6akSvCMIGNRnPOeHr8W2cZuOD5najjLZv8ivYCX3PoTOIGtUZYoB3m
	v+nDIz6Gq+MVfwPoEcLSi50pMtaEyqFpEQ3k=
X-Gm-Gg: ASbGnctQG8tWXK3xromAt/KffpfS9AAwpQQeyDJwrM2YIbAPUKY5DZ49uqTE7BsiP6h
	IG+H7KRz1YLXyrqiQTvws9rUPilXHhhCQBFkhAzjBycpwUPtKxdXamEC1Z4cCpC+j6xFUtveL2k
	R11KvoCPKrLq8f6J9hxD8HNMtA8uI=
X-Google-Smtp-Source: AGHT+IGUfNYPXygPyV43FQAniAw7atdsQ+OHBp+fScFponjuVZJM5C7d8zQe0+sMXPesdIzxD1GgrylIVsCc5n8ZpeQ=
X-Received: by 2002:a17:907:7eaa:b0:abf:425d:5d3 with SMTP id
 a640c23a62f3a-ac782e3dfcdmr485274066b.40.1743590482314; Wed, 02 Apr 2025
 03:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402102047.27943-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250402102047.27943-1-biju.das.jz@bp.renesas.com>
From: Biju Das <biju.das.au@gmail.com>
Date: Wed, 2 Apr 2025 11:41:10 +0100
X-Gm-Features: AQ5f1JqWlq0iRuIn5xgnsQg1IjFlZVo3jLYOyJ3iQmPakCPyDmee8Ahs23eDG3E
Message-ID: <CADT+UeCk1t4YmQqT-V55FOfZpF7Bar+7ShBVmKK47LzKCFgzqQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/19] Add support for RZ/G3E CANFD
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi  All,
Please ignore this series, as I posted a new one[1] as I missed the
address field in patch#7 and aborted the git send-email command

[1] https://lore.kernel.org/all/20250402102226.28032-1-biju.das.jz@bp.renes=
as.com/

Cheers,
Biju

On Wed, Apr 2, 2025 at 11:20=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> The CAN-FD module on RZ/G3E is very similar to the one on both R-Car V4H
> and RZ/G2L, but differs in some hardware parameters:
>  * No external clock, but instead has ram clock.
>  * Support up to 6 channels.
>  * 20 interrupts.
>
> v7->v8:
>  * Collected tags.
>  * Updated commit description for patch#{5,9,15,16,17}.
>  * Replaced the macro RCANFD_GERFL_EEF0_7->RCANFD_GERFL_EEF.
>  * Dropped the redundant macro RCANFD_GERFL_EEF(ch).
>  * Added patch for dropping the mask operation in RCANFD_GAFLCFG_SETRNC
>    macro.
>  * Converted RCANFD_GAFLCFG_SETRNC->rcar_canfd_setrnc().
>  * Updated RCANFD_GAFLCFG macro by replacing the parameter ch->w, where w
>    is the GAFLCFG index used in the hardware manual.
>  * Renamed the parameter x->page_num in RCANFD_GAFLECTR_AFLPN macro to
>    make it clear.
>  * Renamed the parameter x->cftml in RCANFD_CFCC_CFTML macro to make it
>    clear.
>  * Updated {rzg2l,car_gen3_hw_info} with ch_interface_mode =3D 0.
>  * Updated {rzg2l,rcar_gen3}_hw_info with shared_can_regs =3D 0.
>  * Started using struct rcanfd_regs instead of LUT for reg offsets.
>  * Started using struct rcar_canfd_shift_data instead of LUT for shift
>    data.
>  * Renamed only_internal_clks->external_clk to avoid negation.
>  * Updated rcar_canfd_hw_info tables with external_clk entries.
>  * Replaced 10->sizeof(name) in scnprintf().
> v6->v7:
>  * Collected tags
>  * Replaced 'aswell'->'as well' in patch#11 commit description.
> v5->v6:
>  * Replaced RCANFD_RNC_PER_REG macro with rnc_stride variable.
>  * Updated commit description for patch#7 and #8
>  * Dropped mask_table:
>      AFLPN_MASK is replaced by max_aflpn variable.
>      CFTML_MASK is replaced by max_cftml variable.
>      BITTIMING MASK's are replaced by {nom,data}_bittiming variables.
>  * Collected tag from Geert.
> v4->v5:
>  * Collected tag from Geert.
>  * The rules for R-Car Gen3/4 could be kept together, reducing the number
>    of lines. Similar change for rzg2l-canfd aswell.
>  * Keeping interrupts and resets together allows to keep a clear
>    separation between RZ/G2L and RZ/G3E, at the expense of only
>    a single line.
>  * Retained the tags for binding patches as it is trivial changes.
>  * Dropped the unused macro RCANFD_GAFLCFG_GETRNC.
>  * Updated macro RCANFD_GERFL_ERR by using gpriv->channels_mask and
>    dropped unused macro RCANFD_GERFL_EEF0_7.
>  * Replaced RNC mask in RCANFD_GAFLCFG_SETRNC macro by using
>    info->num_supported_rules variable.
>  * Updated the macro RCANFD_GAFLCFG by using info->rnc_field_width
>    variable.
>  * Updated shift value in RCANFD_GAFLCFG_SETRNC macro by using a formula
>    (32 - (n % rnc_per_reg + 1) * field_width).
>  * Replaced the variable name shared_can_reg->shared_can_regs.
>  * Improved commit description for patch{#11,#12}by replacing has->have.
>  * Dropped RCANFD_EEF_MASK and RCANFD_RNC_MASK as it is taken
>    care by gpriv->channels_mask and info->num_supported_rules.
>  * Dropped RCANFD_FIRST_RNC_SH and RCANFD_SECOND_RNC_SH by using a
>    formula (32 - (n % rnc_per_reg + 1) * rnc_field_width.
>  * Improved commit description by "All SoCs supports extenal clock"->
>    "All existing SoCs support an external clock".
>  * Updated error description in probe as "cannot get enabled ram clock"
>  * Updated r9a09g047_hw_info table.
> v3->v4:
>  * Added Rb tag from Rob for patch#2.
>  * Added prefix RCANFD_* to enum rcar_canfd_reg_offset_id.
>  * Added prefix RCANFD_* to enum rcar_canfd_mask_id.
>  * Added prefix RCANFD_* to enum rcar_canfd_shift_id.
> v2->v3:
>  * Collected tags.
>  * Dropped reg_gen4() and is_gen4() by adding mask_table, shift_table,
>    regs, ch_interface_mode and shared_can_reg variables to
>    struct rcar_canfd_hw_info.
> v1->v2:
>  * Split the series with fixes patch separately.
>  * Added patch for Simplify rcar_canfd_probe() using
>    of_get_available_child_by_name() as dependency patch hit on can-next.
>  * Added Rb tag from Vincent Mailhol.
>  * Dropped redundant comment from commit description for patch#3.
>
> Biju Das (19):
>   dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
>   dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
>   can: rcar_canfd: Use of_get_available_child_by_name()
>   can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC macro
>   can: rcar_canfd: Update RCANFD_GERFL_ERR macro
>   can: rcar_canfd: Drop the mask operation in RCANFD_GAFLCFG_SETRNC
>     macro
>   can: rcar_canfd: Add rcar_canfd_setrnc()
>   can: rcar_canfd: Update RCANFD_GAFLCFG macro
>   can: rcar_canfd: Add rnc_field_width variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add max_aflpn variable to struct rcar_canfd_hw_info
>   can: rcar_canfd: Add max_cftml variable to struct rcar_canfd_hw_info
>   can: rcar_canfd: Add {nom,data}_bittiming variables to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add ch_interface_mode variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add shared_can_regs variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add struct rcanfd_regs variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add sh variable to struct rcar_canfd_hw_info
>   can: rcar_canfd: Add external_clk variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Enhance multi_channel_irqs handling
>   can: rcar_canfd: Add RZ/G3E support
>
>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 171 ++++++++---
>  drivers/net/can/rcar/rcar_canfd.c             | 277 +++++++++++++-----
>  2 files changed, 339 insertions(+), 109 deletions(-)
>
> --
> 2.43.0
>

