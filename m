Return-Path: <linux-can+bounces-3245-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45016A745C1
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 09:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0271A7A6EF8
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 08:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362B41D63FD;
	Fri, 28 Mar 2025 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="l2DkOnrh"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-67.smtpout.orange.fr [193.252.22.67])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115714375D;
	Fri, 28 Mar 2025 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743152144; cv=none; b=IgsD//UisAutgFo/8kd3Xp0/Gz64QC1GJnmYl6BUtJuZ+LdXxhsZGP7iw1UijXOnIsqOujmCrVwE9ZxLJk70N7ylkAcSl11xyV6uhV9uNJRVOvaBmZ8knDCkAaa8J512t8xJkkGWtQv2+v+QIqLbk2buuJNfcYTm1vMAe2r3/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743152144; c=relaxed/simple;
	bh=i2UCd9CTJqdl1BvJsa74TjHe+SdFc+PagWycl5GOCfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iRtcBuMA+MHUDmZe0wDrNbXNaV/z+MF3DI7t0gPYnouFV8c3kncotpE+/BQgNr6glT/VVMnkBbhAa3i0A0omjFw+arBSOE7BrgNFN/x4Epecb4kl95m0IAxQVb/e6yNutvsVJD9ga2iaIUi8sBqkqyGBPnzFtRtUTFTdcF9ojxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=l2DkOnrh; arc=none smtp.client-ip=193.252.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id y5TptIcsRhqDwy5TttfmyL; Fri, 28 Mar 2025 09:54:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743152069;
	bh=KqC0MBA/hDJkF4hZt485kZTvkFQNygloRMOLFewr1Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=l2DkOnrhJEcMUkg4cwmJ1/1V9qk1g60nK4rugrphc+UK804HpAkSUf6x88OQajzS5
	 o65gyXqnNpTK1UvLjfNpRk5byNtwTVnT9te/I8T1R5Ul0+qQroRhDhaVvDPAp8TV8e
	 Uj0kqqcDyNMtfZQu1nVKpfkPNfh6VHkUG4niEIExebRlUQeAwzedChZQL33v3XtGp/
	 zVwawPt8U3JxoRc6iJsX5fcd2js+xZiLsi0MCNw+nnwysKHRobDy6gBiUJQckEyvwk
	 JVXSfEIiAGSvPn39wG8TWjK+4HenDH3MTmJ3LjkysGLfd9AVzjPJJJ9dWFHHfczZQh
	 Q0diFNSkahlWw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 09:54:29 +0100
X-ME-IP: 124.33.176.97
Message-ID: <7ff93ff9-f578-4be2-bdc6-5b09eab64fe6@wanadoo.fr>
Date: Fri, 28 Mar 2025 17:54:21 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/18] can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC
 macro
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-can@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-5-biju.das.jz@bp.renesas.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250326122003.122976-5-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2025 at 21:19, Biju Das wrote:
> Drop the unused macro RCANFD_GAFLCFG_GETRNC.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v6->v7:
>  * No change.
> v5->v6:
>  * Collected tag.
> v5:
>  * New patch
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 2d9569fd0e0b..565a91c2ca83 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -94,10 +94,6 @@
>  	(((x) & reg_gen4(gpriv, 0x1ff, 0xff)) << \
>  	 (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
>  
> -#define RCANFD_GAFLCFG_GETRNC(gpriv, n, x) \
> -	(((x) >> (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8))) & \
> -	 reg_gen4(gpriv, 0x1ff, 0xff))
> -
>  /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
>  #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
>  #define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & reg_gen4(gpriv, 0x7f, 0x1f))


It seems to me that there are a ton of unused macro in this module:

Why are you removing just RCANFD_GAFLCFG_GETRNC an not the others?

  $ make W=2 drivers/net/can/rcar/rcar_canfd.o
  (...)
  drivers/net/can/rcar/rcar_canfd.c: At top level:
  drivers/net/can/rcar/rcar_canfd.c:159: warning: macro
"RCANFD_CSTS_TRMSTS" is not used [-Wunused-macros]
    159 | #define RCANFD_CSTS_TRMSTS              BIT(5)
        |
  drivers/net/can/rcar/rcar_canfd.c:351: warning: macro "RCANFD_TMTASTS"
is not used [-Wunused-macros]
    351 | #define RCANFD_TMTASTS(y)               (0x0380 + (0x04 * (y)))
        |
  drivers/net/can/rcar/rcar_canfd.c:259: warning: macro
"RCANFD_CFPTR_CFPTR" is not used [-Wunused-macros]
    259 | #define RCANFD_CFPTR_CFPTR(x)           (((x) & 0xfff) << 16)
        |
  drivers/net/can/rcar/rcar_canfd.c:430: warning: macro
"RCANFD_C_RPGACC" is not used [-Wunused-macros]
    430 | #define RCANFD_C_RPGACC(r)              (0x1900 + (0x04 * (r)))
        |
  drivers/net/can/rcar/rcar_canfd.c:135: warning: macro
"RCANFD_CCTR_BOM_ISO" is not used [-Wunused-macros]
    135 | #define RCANFD_CCTR_BOM_ISO             (0x0 << 21)
        |
  drivers/net/can/rcar/rcar_canfd.c:297: warning: macro "RCANFD_GTSC" is
not used [-Wunused-macros]
    297 | #define RCANFD_GTSC                     (0x0094)
        |
  drivers/net/can/rcar/rcar_canfd.c:331: warning: macro "RCANFD_FMSTS"
is not used [-Wunused-macros]
    331 | #define RCANFD_FMSTS                    (0x0240)
        |
  drivers/net/can/rcar/rcar_canfd.c:61: warning: macro
"RCANFD_GCTR_DEIE" is not used [-Wunused-macros]
     61 | #define RCANFD_GCTR_DEIE                BIT(8)
        |
  drivers/net/can/rcar/rcar_canfd.c:249: warning: macro
"RCANFD_CFSTS_CFFLL" is not used [-Wunused-macros]
    249 | #define RCANFD_CFSTS_CFFLL              BIT(1)
        |
  drivers/net/can/rcar/rcar_canfd.c:356: warning: macro "RCANFD_TXQCC"
is not used [-Wunused-macros]
    356 | #define RCANFD_TXQCC(m)                 (0x03a0 + (0x04 * (m)))
        |
  drivers/net/can/rcar/rcar_canfd.c:154: warning: macro
"RCANFD_CCTR_CHDMC_CHLT" is not used [-Wunused-macros]
    154 | #define RCANFD_CCTR_CHDMC_CHLT          (0x2)
        |
  drivers/net/can/rcar/rcar_canfd.c:378: warning: macro "RCANFD_GLOCKK"
is not used [-Wunused-macros]
    378 | #define RCANFD_GLOCKK                   (0x047c)
        |
  drivers/net/can/rcar/rcar_canfd.c:82: warning: macro
"RCANFD_GERFL_DEF" is not used [-Wunused-macros]
     82 | #define RCANFD_GERFL_DEF                BIT(0)
        |
  drivers/net/can/rcar/rcar_canfd.c:423: warning: macro "RCANFD_C_TMPTR"
is not used [-Wunused-macros]
    423 | #define RCANFD_C_TMPTR(p)               (0x1004 + (0x10 * (p)))
        |
  drivers/net/can/rcar/rcar_canfd.c:106: warning: macro
"RCANFD_GAFLID_GAFLLB" is not used [-Wunused-macros]
    106 | #define RCANFD_GAFLID_GAFLLB            BIT(29)
        |
  drivers/net/can/rcar/rcar_canfd.c:372: warning: macro
"RCANFD_GTINTSTS1" is not used [-Wunused-macros]
    372 | #define RCANFD_GTINTSTS1                (0x0464)
        |
  drivers/net/can/rcar/rcar_canfd.c:303: warning: macro "RCANFD_RMNB" is
not used [-Wunused-macros]
    303 | #define RCANFD_RMNB                     (0x00a4)
        |
  drivers/net/can/rcar/rcar_canfd.c:305: warning: macro "RCANFD_RMND" is
not used [-Wunused-macros]
    305 | #define RCANFD_RMND(y)                  (0x00a8 + (0x04 * (y)))
        |
  drivers/net/can/rcar/rcar_canfd.c:495: warning: macro
"RCANFD_CHANNELS_MASK" is not used [-Wunused-macros]
    495 | #define RCANFD_CHANNELS_MASK
BIT((RCANFD_NUM_CHANNELS) - 1)
        |
  drivers/net/can/rcar/rcar_canfd.c:132: warning: macro
"RCANFD_CCTR_CTME" is not used [-Wunused-macros]
    132 | #define RCANFD_CCTR_CTME                BIT(24)
        |
  drivers/net/can/rcar/rcar_canfd.c:345: warning: macro "RCANFD_TMTRSTS"
is not used [-Wunused-macros]
    345 | #define RCANFD_TMTRSTS(y)               (0x0350 + (0x04 * (y)))
        |
  drivers/net/can/rcar/rcar_canfd.c:335: warning: macro "RCANFD_CFRISTS"
is not used [-Wunused-macros]
    335 | #define RCANFD_CFRISTS                  (0x0248)
        |
  drivers/net/can/rcar/rcar_canfd.c:337: warning: macro "RCANFD_CFTISTS"
is not used [-Wunused-macros]
    337 | #define RCANFD_CFTISTS                  (0x024c)
        |
  drivers/net/can/rcar/rcar_canfd.c:363: warning: macro "RCANFD_THLCC"
is not used [-Wunused-macros]
    363 | #define RCANFD_THLCC(m)                 (0x0400 + (0x04 * (m)))
        |
  drivers/net/can/rcar/rcar_canfd.c:161: warning: macro
"RCANFD_CSTS_EPSTS" is not used [-Wunused-macros]
    161 | #define RCANFD_CSTS_EPSTS               BIT(3)
        |
  drivers/net/can/rcar/rcar_canfd.c:444: warning: macro
"RCANFD_F_CFDCRC" is not used [-Wunused-macros]
    444 | #define RCANFD_F_CFDCRC(m)              (0x0510 + (0x20 * (m)))
        |
  drivers/net/can/rcar/rcar_canfd.c:399: warning: macro "RCANFD_C_RMDF0"
is not used [-Wunused-macros]
    399 | #define RCANFD_C_RMDF0(q)               (0x0608 + (0x10 * (q)))
        |
  drivers/net/can/rcar/rcar_canfd.c:400: warning: macro "RCANFD_C_RMDF1"
is not used [-Wunused-macros]
    400 | #define RCANFD_C_RMDF1(q)               (0x060c + (0x10 * (q)))
        |
  drivers/net/can/rcar/rcar_canfd.c:225: warning: macro
"RCANFD_RFPTR_RFPTR" is not used [-Wunused-macros]
    225 | #define RCANFD_RFPTR_RFPTR(x)           (((x) >> 16) & 0xfff)
        |
  drivers/net/can/rcar/rcar_canfd.c:482: warning: macro
"RCANFD_F_TMFDCTR" is not used [-Wunused-macros]
    482 | #define RCANFD_F_TMFDCTR(p)             (0x4008 + (0x20 * (p)))
        |
  drivers/net/can/rcar/rcar_canfd.c:66: warning: macro
"RCANFD_GCTR_GMDC_GTEST" is not used [-Wunused-macros]
     66 | #define RCANFD_GCTR_GMDC_GTEST          (0x2)
        |
  drivers/net/can/rcar/rcar_canfd.c:54: warning: macro
"RCANFD_GCFG_TPRI" is not used [-Wunused-macros]
     54 | #define RCANFD_GCFG_TPRI                BIT(0)
        |
  drivers/net/can/rcar/rcar_canfd.c:138: warning: macro
"RCANFD_CCTR_TDCVFIE" is not used [-Wunused-macros]
    138 | #define RCANFD_CCTR_TDCVFIE             BIT(19)
        |
  drivers/net/can/rcar/rcar_canfd.c:80: warning: macro
"RCANFD_GERFL_THLES" is not used [-Wunused-macros]
     80 | #define RCANFD_GERFL_THLES              BIT(2)
        |
  drivers/net/can/rcar/rcar_canfd.c:483: warning: macro "RCANFD_F_TMDF"
is not used [-Wunused-macros]
    483 | #define RCANFD_F_TMDF(p, b)             (0x400c + (0x20 * (p))
+ (0x04 * (b)))
        |
  drivers/net/can/rcar/rcar_canfd.c:347: warning: macro
"RCANFD_TMTARSTS" is not used [-Wunused-macros]
    347 | #define RCANFD_TMTARSTS(y)              (0x0360 + (0x04 * (y)))
        |
  drivers/net/can/rcar/rcar_canfd.c:202: warning: macro
"RCANFD_FDCFG_TDCE" is not used [-Wunused-macros]
    202 | #define RCANFD_FDCFG_TDCE               BIT(9)
        |
  drivers/net/can/rcar/rcar_canfd.c:204: warning: macro
"RCANFD_FDCFG_TDCO" is not used [-Wunused-macros]
    204 | #define RCANFD_FDCFG_TDCO(x)            (((x) & 0x7f) >> 16)
        |
  drivers/net/can/rcar/rcar_canfd.c:158: warning: macro
"RCANFD_CSTS_RECSTS" is not used [-Wunused-macros]
    158 | #define RCANFD_CSTS_RECSTS              BIT(6)
        |
  drivers/net/can/rcar/rcar_canfd.c:139: warning: macro
"RCANFD_CCTR_SOCOIE" is not used [-Wunused-macros]
    139 | #define RCANFD_CCTR_SOCOIE              BIT(18)
        |
  drivers/net/can/rcar/rcar_canfd.c:53: warning: macro "RCANFD_GCFG_DCE"
is not used [-Wunused-macros]
     53 | #define RCANFD_GCFG_DCE                 BIT(1)
        |
  drivers/net/can/rcar/rcar_canfd.c:216: warning: macro
"RCANFD_RFSTS_RFFLL" is not used [-Wunused-macros]
    216 | #define RCANFD_RFSTS_RFFLL              BIT(1)
        |
  drivers/net/can/rcar/rcar_canfd.c:358: warning: macro "RCANFD_TXQSTS"
is not used [-Wunused-macros]
    358 | #define RCANFD_TXQSTS(m)                (0x03c0 + (0x04 * (m)))
        |
  drivers/net/can/rcar/rcar_canfd.c:255: warning: macro
"RCANFD_CFID_CFID_MASK" is not used [-Wunused-macros]
    255 | #define RCANFD_CFID_CFID_MASK(x)        ((x) & 0x1fffffff)
        |
  drivers/net/can/rcar/rcar_canfd.c:376: warning: macro "RCANFD_GTSTCTR"
is not used [-Wunused-macros]
    376 | #define RCANFD_GTSTCTR                  (0x046c)
        |
  drivers/net/can/rcar/rcar_canfd.c:57: warning: macro
"RCANFD_GCTR_TSRST" is not used [-Wunused-macros]
     57 | #define RCANFD_GCTR_TSRST               BIT(16)
        |
  drivers/net/can/rcar/rcar_canfd.c:422: warning: macro "RCANFD_C_TMID"
is not used [-Wunused-macros]
    422 | #define RCANFD_C_TMID(p)                (0x1000 + (0x10 * (p)))
        |
  drivers/net/can/rcar/rcar_canfd.c:333: warning: macro "RCANFD_RFISTS"
is not used [-Wunused-macros]
    333 | #define RCANFD_RFISTS                   (0x0244)
        |
  drivers/net/can/rcar/rcar_canfd.c:140: warning: macro
"RCANFD_CCTR_EOCOIE" is not used [-Wunused-macros]
    140 | #define RCANFD_CCTR_EOCOIE              BIT(17)
        |
  drivers/net/can/rcar/rcar_canfd.c:71: warning: macro
"RCANFD_GSTS_GHLTSTS" is not used [-Wunused-macros]
     71 | #define RCANFD_GSTS_GHLTSTS             BIT(1)
        |
  drivers/net/can/rcar/rcar_canfd.c:481: warning: macro "RCANFD_F_TMPTR"
is not used [-Wunused-macros]
    481 | #define RCANFD_F_TMPTR(p)               (0x4004 + (0x20 * (p)))
        |
  drivers/net/can/rcar/rcar_canfd.c:329: warning: macro "RCANFD_FFSTS"
is not used [-Wunused-macros]
    329 | #define RCANFD_FFSTS                    (0x023c)
        |
  drivers/net/can/rcar/rcar_canfd.c:360: warning: macro "RCANFD_TXQPCTR"
is not used [-Wunused-macros]
    360 | #define RCANFD_TXQPCTR(m)               (0x03e0 + (0x04 * (m)))
        |
  drivers/net/can/rcar/rcar_canfd.c:453: warning: macro "RCANFD_F_RMDF"
is not used [-Wunused-macros]
    453 | #define RCANFD_F_RMDF(q, b)             (0x200c + (0x04 * (b))
+ (0x20 * (q)))
        |
  drivers/net/can/rcar/rcar_canfd.c:340: warning: macro "RCANFD_TMC" is
not used [-Wunused-macros]
    340 | #define RCANFD_TMC(p)                   (0x0250 + (0x01 * (p)))
        |
  drivers/net/can/rcar/rcar_canfd.c:370: warning: macro
"RCANFD_GTINTSTS0" is not used [-Wunused-macros]
    370 | #define RCANFD_GTINTSTS0                (0x0460)
        |
  drivers/net/can/rcar/rcar_canfd.c:353: warning: macro "RCANFD_TMIEC"
is not used [-Wunused-macros]
    353 | #define RCANFD_TMIEC(y)                 (0x0390 + (0x04 * (y)))
        |
  drivers/net/can/rcar/rcar_canfd.c:398: warning: macro "RCANFD_C_RMPTR"
is not used [-Wunused-macros]
    398 | #define RCANFD_C_RMPTR(q)               (0x0604 + (0x10 * (q)))
        |
  drivers/net/can/rcar/rcar_canfd.c:260: warning: macro
"RCANFD_CFPTR_CFTS" is not used [-Wunused-macros]
    260 | #define RCANFD_CFPTR_CFTS(x)            (((x) & 0xff) << 0)
        |
  drivers/net/can/rcar/rcar_canfd.c:97: warning: macro
"RCANFD_GAFLCFG_GETRNC" is not used [-Wunused-macros]
     97 | #define RCANFD_GAFLCFG_GETRNC(gpriv, n, x) \
        |
  drivers/net/can/rcar/rcar_canfd.c:367: warning: macro "RCANFD_THLPCTR"
is not used [-Wunused-macros]
    367 | #define RCANFD_THLPCTR(m)               (0x0440 + (0x04 * (m)))
        |
  drivers/net/can/rcar/rcar_canfd.c:442: warning: macro
"RCANFD_F_CFDCTR" is not used [-Wunused-macros]
    442 | #define RCANFD_F_CFDCTR(m)              (0x0508 + (0x20 * (m)))
        |
  drivers/net/can/rcar/rcar_canfd.c:203: warning: macro
"RCANFD_FDCFG_TDCOC" is not used [-Wunused-macros]
    203 | #define RCANFD_FDCFG_TDCOC              BIT(8)
        |
  drivers/net/can/rcar/rcar_canfd.c:452: warning: macro
"RCANFD_F_RMFDSTS" is not used [-Wunused-macros]
    452 | #define RCANFD_F_RMFDSTS(q)             (0x2008 + (0x20 * (q)))
        |
  drivers/net/can/rcar/rcar_canfd.c:250: warning: macro
"RCANFD_CFSTS_CFEMP" is not used [-Wunused-macros]
    250 | #define RCANFD_CFSTS_CFEMP              BIT(0)
        |
  drivers/net/can/rcar/rcar_canfd.c:180: warning: macro
"RCANFD_CERFL_BORF" is not used [-Wunused-macros]
    180 | #define RCANFD_CERFL_BORF               BIT(4)
        |
  drivers/net/can/rcar/rcar_canfd.c:365: warning: macro "RCANFD_THLSTS"
is not used [-Wunused-macros]
    365 | #define RCANFD_THLSTS(m)                (0x0420 + (0x04 * (m)))
        |
  drivers/net/can/rcar/rcar_canfd.c:160: warning: macro
"RCANFD_CSTS_BOSTS" is not used [-Wunused-macros]
    160 | #define RCANFD_CSTS_BOSTS               BIT(4)
        |
  drivers/net/can/rcar/rcar_canfd.c:451: warning: macro "RCANFD_F_RMPTR"
is not used [-Wunused-macros]
    451 | #define RCANFD_F_RMPTR(q)               (0x2004 + (0x20 * (q)))
        |
  drivers/net/can/rcar/rcar_canfd.c:424: warning: macro "RCANFD_C_TMDF0"
is not used [-Wunused-macros]
    424 | #define RCANFD_C_TMDF0(p)               (0x1008 + (0x10 * (p)))
        |
  drivers/net/can/rcar/rcar_canfd.c:425: warning: macro "RCANFD_C_TMDF1"
is not used [-Wunused-macros]
    425 | #define RCANFD_C_TMDF1(p)               (0x100c + (0x10 * (p)))
        |
  drivers/net/can/rcar/rcar_canfd.c:450: warning: macro "RCANFD_F_RMID"
is not used [-Wunused-macros]
    450 | #define RCANFD_F_RMID(q)                (0x2000 + (0x20 * (q)))
        |
  drivers/net/can/rcar/rcar_canfd.c:397: warning: macro "RCANFD_C_RMID"
is not used [-Wunused-macros]
    397 | #define RCANFD_C_RMID(q)                (0x0600 + (0x10 * (q)))
        |
  drivers/net/can/rcar/rcar_canfd.c:443: warning: macro
"RCANFD_F_CFDSTS" is not used [-Wunused-macros]
    443 | #define RCANFD_F_CFDSTS(m)              (0x050c + (0x20 * (m)))
        |
  drivers/net/can/rcar/rcar_canfd.c:70: warning: macro
"RCANFD_GSTS_GSLPSTS" is not used [-Wunused-macros]
     70 | #define RCANFD_GSTS_GSLPSTS             BIT(2)
        |
  drivers/net/can/rcar/rcar_canfd.c:349: warning: macro "RCANFD_TMTCSTS"
is not used [-Wunused-macros]
    349 | #define RCANFD_TMTCSTS(y)               (0x0370 + (0x04 * (y)))
        |
  drivers/net/can/rcar/rcar_canfd.c:441: warning: macro
"RCANFD_F_CFDCFG" is not used [-Wunused-macros]
    441 | #define RCANFD_F_CFDCFG(m)              (0x0504 + (0x20 * (m)))
        |
  drivers/net/can/rcar/rcar_canfd.c:480: warning: macro "RCANFD_F_TMID"
is not used [-Wunused-macros]
    480 | #define RCANFD_F_TMID(p)                (0x4000 + (0x20 * (p)))
        |
  drivers/net/can/rcar/rcar_canfd.c:327: warning: macro "RCANFD_FESTS"
is not used [-Wunused-macros]
    327 | #define RCANFD_FESTS                    (0x0238)
        |
  drivers/net/can/rcar/rcar_canfd.c:486: warning: macro
"RCANFD_F_THLACC" is not used [-Wunused-macros]
    486 | #define RCANFD_F_THLACC(m)              (0x6000 + (0x04 * (m)))
        |
  drivers/net/can/rcar/rcar_canfd.c:162: warning: macro
"RCANFD_CSTS_SLPSTS" is not used [-Wunused-macros]
    162 | #define RCANFD_CSTS_SLPSTS              BIT(2)
        |
  drivers/net/can/rcar/rcar_canfd.c:488: warning: macro
"RCANFD_F_RPGACC" is not used [-Wunused-macros]
    488 | #define RCANFD_F_RPGACC(r)              (0x6400 + (0x04 * (r)))
        |
  drivers/net/can/rcar/rcar_canfd.c:137: warning: macro
"RCANFD_CCTR_BOM_BEND" is not used [-Wunused-macros]
    137 | #define RCANFD_CCTR_BOM_BEND            (0x2 << 21)
        |
  drivers/net/can/rcar/rcar_canfd.c:428: warning: macro
"RCANFD_C_THLACC" is not used [-Wunused-macros]
    428 | #define RCANFD_C_THLACC(m)              (0x1800 + (0x04 * (m)))
        |
  drivers/net/can/rcar/rcar_canfd.c:374: warning: macro "RCANFD_GTSTCFG"
is not used [-Wunused-macros]
    374 | #define RCANFD_GTSTCFG                  (0x0468)
        |
  drivers/net/can/rcar/rcar_canfd.c:342: warning: macro "RCANFD_TMSTS"
is not used [-Wunused-macros]
    342 | #define RCANFD_TMSTS(p)                 (0x02d0 + (0x01 * (p)))
        |
  drivers/net/can/rcar/rcar_canfd.c:163: warning: macro
"RCANFD_CSTS_HLTSTS" is not used [-Wunused-macros]
    163 | #define RCANFD_CSTS_HLTSTS              BIT(1)
        |
  drivers/net/can/rcar/rcar_canfd.c:59: warning: macro
"RCANFD_GCTR_THLEIE" is not used [-Wunused-macros]
     59 | #define RCANFD_GCTR_THLEIE              BIT(10)
        |
  drivers/net/can/rcar/rcar_canfd.c:226: warning: macro
"RCANFD_RFPTR_RFTS" is not used [-Wunused-macros]
    226 | #define RCANFD_RFPTR_RFTS(x)            (((x) >> 0) & 0xffff)
        |


Yours sincerely,
Vincent Mailhol


