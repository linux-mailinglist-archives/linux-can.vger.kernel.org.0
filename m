Return-Path: <linux-can+bounces-3738-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3708AC8D10
	for <lists+linux-can@lfdr.de>; Fri, 30 May 2025 13:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7585F7A9135
	for <lists+linux-can@lfdr.de>; Fri, 30 May 2025 11:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB272222C0;
	Fri, 30 May 2025 11:44:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBEE15E97;
	Fri, 30 May 2025 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748605491; cv=none; b=RJUFk6d+D0mB2m241n/ilsBQ63RFcKBdyvKS8HXI/3t8shYWYGBdbn5XdmgLcaT0mhqSikuUFtrs874DYeB565hC1jEeplmY1acAO81lRdt51QskJAP6KzIcg4W684cykvyIUq4WsbFzTwlmfiJK8+HH0E9JldUGKrV0ZAGHH+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748605491; c=relaxed/simple;
	bh=3KZT6EuKeuDfW7cLfZy5fE/Lzu0QMbUr0cevKUAXE5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9yf9whsbSUkXa3rezIIrdC10nwTxqmbvBY1/li36xZBMxdmrNlF/2BtJbcgvgYmi5B0fAGb/5xBus3vPwsdQrduoPAzXRTkKZZU8pjSkMTfjy3gmqtc/2DSF3afJSRbvDJdlXke1CFFj+zZU5HoKJD5dcBoikKdHG5sx3lw2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4e6d911daeaso481977137.1;
        Fri, 30 May 2025 04:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748605487; x=1749210287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jurH4uEOoGm6SgCAAR3znTp1A0aowVKifdiPl5JtH/E=;
        b=WrxKyFVRCXNM3rzCkiS8Vsdx2Oo9t4bX0uwGpSLK3f11tSjAEtgSVV08DleIHTdkVL
         HzWPLWDm7Uq0yiE0r9Urr47DEuAhgrgYsqTcth3iYQSTf0I4tBceoIdz03kKoRtuiTsW
         5669ADAi2ixWWNgskk1cCqqLOsV3l7FeCnQoD+MFj3GMlfU/9frDD13sxZWywxZ2RPZR
         CHuiWzpr3MaRe9gMROwTC+Xuihk6OsFq8HxA1RlIKcN4ffJrWpVDxp5zL0DoRB7o6hXv
         aacgiBZyNrNZKQ5svNbffy/tN35EmBtH4u2iHEgi9SWwIft72tlkgk6dYjkXLmExOp6Y
         cUiQ==
X-Forwarded-Encrypted: i=1; AJvYcCULDNCnA9wWAJ7fYb/ee87tIf+NE8R1jd81Ru/XsflA1uaSGnd85TvXZIUEg4VKZAy+B64gRscCgn85e/vk@vger.kernel.org, AJvYcCWfFwOUAu8btUPUVozhNSZ/6Sy2Vl4ON/T6ra3fm751+NvqIq+G+BlSlecqnqFolaKKB9VkIi09ym4=@vger.kernel.org, AJvYcCWp76nL5hgcnYYRJ5uusEayRijM8RxMHG9npFjx/espKWx7dTbPTpKw+yNr8HoN1QUy9RyJC3n8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ziQYUoFPablibPlkKWDM/WMiNzdj/WLfFnT3EnEgG8Mm6BAP
	RnVtn4kLC0F4zl/oPXQLR1DbIJ+b2GI+Vo5/ihGD6akQrtEbKoAHlcy3LJMcJqMc
X-Gm-Gg: ASbGncvKbUWg1KGE6A14C5lWHLn6fvvbTh/8iFpq/8OzyK0zPxEMqVcGgp4Pb5KbgD/
	SuxlPk3wPI93Fd2iSzCFflkoK/t2p8zbDByMh+pbdNHfi2kJso9d968/CnsAkX8pTB1Snf51K7z
	frxj/Q/4d2nCr8PRNfQxsO3bLV7fP19lLpwaRE2dSLjibNH7l43WMVDyzX2VcVvp0Ja2R3TZsbZ
	dr3+2LDnFxStMoprvcVcR5KuPLlhY3A+eAXwuGGTrcEY4B1A6MONl3pvW/J4uPI7HrdYT0Awd1f
	hj5pOSTe0GNVMPd34nAb6MQyutolgX3tsojGTTEsLOLvFnLVjyz0H/M0KUpXqZndZ0cIEBHAYEJ
	dMDPns8G3AP/wFiV0PNp/Vwfv
X-Google-Smtp-Source: AGHT+IHntCHsWMbq6L1uH4dOIgVxLDH6k8m+RoyqnWuPiE/wDrOeTlhA59KgtQ/iOTalsxfsoc6ppw==
X-Received: by 2002:a05:6102:509f:b0:4e6:d9f2:957c with SMTP id ada2fe7eead31-4e6e41b3a02mr2823155137.23.1748605486891;
        Fri, 30 May 2025 04:44:46 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e6444be9b5sm2651218137.18.2025.05.30.04.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 04:44:44 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4e6d911daeaso481954137.1;
        Fri, 30 May 2025 04:44:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgGCWWqQwLUr6sItyhKeyFA0eBPuOgt7RieBOn0v0QyA/9816jce80NWsCT2o2l7PS9PYNDOALft7iPpGz@vger.kernel.org, AJvYcCWYG+vLBGFasXKaZxfcimNplTT83qs1Aup+SdcLc8HoPqOx+v7ROwu6HWX0oSi0OsN5hgxhDRML@vger.kernel.org, AJvYcCWkgDsv+P6lHx5j4MIcpJ1lNJgtcam700lM7W2oJQ4BIk5OGSTa/IRkGMKD2YdzOu+ZFYwXj5HmAaY=@vger.kernel.org
X-Received: by 2002:a05:6102:4194:b0:4da:fc9d:efc with SMTP id
 ada2fe7eead31-4e6e40faaefmr2758272137.11.1748605483371; Fri, 30 May 2025
 04:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210918095637.20108-1-mailhol.vincent@wanadoo.fr> <20210918095637.20108-5-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20210918095637.20108-5-mailhol.vincent@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 May 2025 13:44:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVEBLoG084rhBtELcFO+3cA9_UrZrUfspOeLNo80zyb9g@mail.gmail.com>
X-Gm-Features: AX0GCFvGT51bFh809Rtads-Nhj4H7apb8FFVpNZoBSShAwHBH29ORnrUKKAIiRk
Message-ID: <CAMuHMdVEBLoG084rhBtELcFO+3cA9_UrZrUfspOeLNo80zyb9g@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] can: netlink: add interface for CAN-FD Transmitter
 Delay Compensation (TDC)
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Stefan_M=C3=A4tje?= <Stefan.Maetje@esd.eu>
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

Thanks for your patch, which is now commit d99755f71a80df33
("can: netlink: add interface for CAN-FD Transmitter Delay
Compensation (TDC)") in v5.16.

On Sat, 18 Sept 2021 at 20:23, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> Add the netlink interface for TDC parameters of struct can_tdc_const
> and can_tdc.
>
> Contrary to the can_bittiming(_const) structures for which there is
> just a single IFLA_CAN(_DATA)_BITTMING(_CONST) entry per structure,
> here, we create a nested entry IFLA_CAN_TDC. Within this nested entry,
> additional IFLA_CAN_TDC_TDC* entries are added for each of the TDC
> parameters of the newly introduced struct can_tdc_const and struct
> can_tdc.
>
> For struct can_tdc_const, these are:
>         IFLA_CAN_TDC_TDCV_MIN
>         IFLA_CAN_TDC_TDCV_MAX
>         IFLA_CAN_TDC_TDCO_MIN
>         IFLA_CAN_TDC_TDCO_MAX
>         IFLA_CAN_TDC_TDCF_MIN
>         IFLA_CAN_TDC_TDCF_MAX
>
> For struct can_tdc, these are:
>         IFLA_CAN_TDC_TDCV
>         IFLA_CAN_TDC_TDCO
>         IFLA_CAN_TDC_TDCF
>
> This is done so that changes can be applied in the future to the
> structures without breaking the netlink interface.
>
> The TDC netlink logic works as follow:
>
>  * CAN_CTRLMODE_FD is not provided:
>     - if any TDC parameters are provided: error.
>
>     - TDC parameters not provided: TDC parameters unchanged.
>
>  * CAN_CTRLMODE_FD is provided and is false:
>      - TDC is deactivated: both the structure and the
>        CAN_CTRLMODE_TDC_{AUTO,MANUAL} flags are flushed.
>
>  * CAN_CTRLMODE_FD provided and is true:
>     - CAN_CTRLMODE_TDC_{AUTO,MANUAL} and tdc{v,o,f} not provided: call
>       can_calc_tdco() to automatically decide whether TDC should be
>       activated and, if so, set CAN_CTRLMODE_TDC_AUTO and uses the
>       calculated tdco value.

This is not reflected in the code (see below).

By default, a CAN-FD interface comes up in TDC-AUTO mode (if supported),
using a calculated tdco value.  However, enabling "tdc-mode auto"
explicitly from userland requires also specifying an explicit tdco
value.  I.e.

    ip link set can0 type can bitrate 500000 dbitrate 8000000 fd on

gives "can <FD,TDC-AUTO>" and "tdcv 0 tdco 3", while

    ip link set can0 type can bitrate 500000 dbitrate 8000000 fd on
tdc-mode auto

gives:

    tdc-mode auto: RTNETLINK answers: Operation not supported

unless I add an explicit "tdco 3".

According to your commit description, this is not the expected behavior?
Thanks!

>
>     - CAN_CTRLMODE_TDC_AUTO and tdco provided: set
>       CAN_CTRLMODE_TDC_AUTO and use the provided tdco value. Here,
>       tdcv is illegal and tdcf is optional.
>
>     - CAN_CTRLMODE_TDC_MANUAL and both of tdcv and tdco provided: set
>       CAN_CTRLMODE_TDC_MANUAL and use the provided tdcv and tdco
>       value. Here, tdcf is optional.
>
>     - CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually exclusive. Whenever
>       one flag is turned on, the other will automatically be turned
>       off. Providing both returns an error.
>
>     - Combination other than the one listed above are illegal and will
>       return an error.
>
> N.B. above rules mean that whenever CAN_CTRLMODE_FD is provided, the
> previous TDC values will be overwritten. The only option to reuse
> previous TDC value is to not provide CAN_CTRLMODE_FD.
>
>
> All the new parameters are defined as u32. This arbitrary choice is
> done to mimic the other bittiming values with are also all of type
> u32. An u16 would have been sufficient to hold the TDC values.
>
> This patch completes below series (c.f. [1]):
>   - commit 289ea9e4ae59 ("can: add new CAN FD bittiming parameters:
>     Transmitter Delay Compensation (TDC)")
>   - commit c25cc7993243 ("can: bittiming: add calculation for CAN FD
>     Transmitter Delay Compensation (TDC)")
>
> [1] https://lore.kernel.org/linux-can/20210224002008.4158-1-mailhol.vincent@wanadoo.fr/T/#t
>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c

> @@ -37,8 +52,43 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
>
>         if (data[IFLA_CAN_CTRLMODE]) {
>                 struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
> +               u32 tdc_flags = cm->flags & CAN_CTRLMODE_TDC_MASK;
>
>                 is_can_fd = cm->flags & cm->mask & CAN_CTRLMODE_FD;
> +
> +               /* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually exclusive */
> +               if (tdc_flags == CAN_CTRLMODE_TDC_MASK)
> +                       return -EOPNOTSUPP;
> +               /* If one of the CAN_CTRLMODE_TDC_* flag is set then
> +                * TDC must be set and vice-versa
> +                */
> +               if (!!tdc_flags != !!data[IFLA_CAN_TDC])
> +                       return -EOPNOTSUPP;

CAN_CTRLMODE_TDC_{AUTO,MANUAL} and none of tdc{v,o,f} provided is
rejected.

> +               /* If providing TDC parameters, at least TDCO is
> +                * needed. TDCV is needed if and only if
> +                * CAN_CTRLMODE_TDC_MANUAL is set
> +                */
> +               if (data[IFLA_CAN_TDC]) {
> +                       struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
> +                       int err;
> +
> +                       err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX,
> +                                              data[IFLA_CAN_TDC],
> +                                              can_tdc_policy, extack);
> +                       if (err)
> +                               return err;
> +
> +                       if (tb_tdc[IFLA_CAN_TDC_TDCV]) {
> +                               if (tdc_flags & CAN_CTRLMODE_TDC_AUTO)
> +                                       return -EOPNOTSUPP;
> +                       } else {
> +                               if (tdc_flags & CAN_CTRLMODE_TDC_MANUAL)
> +                                       return -EOPNOTSUPP;
> +                       }
> +
> +                       if (!tb_tdc[IFLA_CAN_TDC_TDCO])
> +                               return -EOPNOTSUPP;

CAN_CTRLMODE_TDC_AUTO and tdco not provided is rejected.

> +               }
>         }
>
>         if (is_can_fd) {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

