Return-Path: <linux-can+bounces-3740-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AC5ACA9DC
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 09:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88455189CB0B
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 07:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C7C19DFA7;
	Mon,  2 Jun 2025 07:23:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CFD143736;
	Mon,  2 Jun 2025 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748849017; cv=none; b=g12pq+zklsHnjsdECv1Y9dn9pdFguTd50hWyRqqihTIOt+hlii+YDREesVj43GMdIJpIlFYwQnYePliAgdTt6QZsDmdRxeVOEaRHe9fzeGQFE4gy74jHkusHsxH+QrNocmeKERRrSbs61YzRHpBTQUdyXM7vdYWsDb2//V8x67I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748849017; c=relaxed/simple;
	bh=aMkjYDfS4hKBq4E8F8Ko1Lj7bLsFOrFanKHtkT5UWGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PaxfJbixe0ve1Q/JyW6aAZpZTKgj85ZqUZrr2+4PgnV+GIjMgRs3ivbFD0Yop0UZx/YUmETW4P9BspxNJumKoFr4R6BTC4wrpB8hpLUqix8FWtpWH+FRIOvKurk40NrhFHlwqyvkkLPtqk2FtKY4ni08gN/gzCzrAqikBrwMQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4c9cea30173so1278247137.3;
        Mon, 02 Jun 2025 00:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748849013; x=1749453813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9BTeLSuqq/rx8xkHWscFhlPkXYJse76ozXbRV6bBME=;
        b=chPOQRKEMuHCdy1kjMnddTxbJ10SBJwVeocgmT6w+xfk08uFgppGUUw74JGkkU6QdD
         NbRfjR/Dvhjmo8JMaUbpssNEkIC0afX4yx4whhj9PJA9XqXQKnNXeN7sQWBPXMrDXqoH
         pwbNeQRS/yW3+Gj5NMRZ0YVFIU/7g/TvWJGbjfYlzzY5tN1N62zsKU7361AUIdW4djm2
         yVKuZjF95pi1iZJyRY0KafhqnBETE9u3+71Ccs1UgNbHRhwzTK3pqpOrdZo7Jg0wY28u
         vQl5uenYWV0YRCnVLSr8u0JJmj4tatClOAgNwqdYMJD/YcDHt4wCOXXOOGnA3dgJc9EI
         hkDw==
X-Forwarded-Encrypted: i=1; AJvYcCUl6UB+uXWvvozlidGxfBmn2tGgGd9AJuwKXGmtRM6PlTnBcvGCLY7ABw8+5W9JBp5V7ER+7A1Srz3mFyBs@vger.kernel.org, AJvYcCWFqYvj6b9O3ciMK2jQvPe7fpYkF150WWCMVq93aTBE8k2fyPYNYTrBWiCfsj6ORa7cLa4A+YwZnH4=@vger.kernel.org, AJvYcCXDe8RRphmnwHxGYkoCYcFO/qKXLIYbdjWSygnaKkNcvQ6P5gGTAmYD8mTdEaXqgKQh2i7R6H5g@vger.kernel.org
X-Gm-Message-State: AOJu0YwzIoyT9sDu+7rZCBnhDx31CeW2G+zrdXQimCPyv+qWyyc9bIh9
	nnXspw/Dtnlyuz7FJaiZskbLdup4TTFiT+RlUO4x8u5YPVTBYBJN3/35j3QNSGaC
X-Gm-Gg: ASbGncuEcel6X/paADAiThUyym8dt1kGgdulDtn8L85HX+BNcwQYozilV/pudzJSSJo
	9PA30LDTqZQQqwe5G++xbSkQWn7h9PsinoouIaZhMega4rGKnmY8twYCaljkdrn8Psa5SQ8PGae
	316dsp6GDh7sslBJOvSlx4GvWq0q5TrBUcQKxSpp0akJj2gGbKxQy/X93GMzaclc5KuV2Ame7c+
	fRIybXDsSaPKSpbf0hyXirOs2DxONJi9NC2ehVWFq/WO7Zt0c0VsaVJKDDb26NwPtKaRY0VnUFJ
	cslQ9dkcuOllLYWI+A9ZN9Qq+HARt4fVELMIJ7ogLQPhbOSJj4QcdQ0MIr89gSz59BOOu3MlrC4
	V59L0cnsl3l/ncA==
X-Google-Smtp-Source: AGHT+IGlxGHtSFHEPHPgyRPGRqlkW4+lRzlOdAz8TDWmyfbTUfAQFa3z8EH8IkORSAFAzeFHY0dtcw==
X-Received: by 2002:a05:6102:3751:b0:4e5:a67d:92a6 with SMTP id ada2fe7eead31-4e6e410d895mr8750020137.14.1748849012988;
        Mon, 02 Jun 2025 00:23:32 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e64e9f7ff2sm6621922137.27.2025.06.02.00.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 00:23:31 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4e2b5ffb932so1454662137.0;
        Mon, 02 Jun 2025 00:23:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVioNEWTaAC7CwrtFkSTgW3IfGAzJc4etHmT5Kdz9TaAPEhIGEmmAPXM9mweSTQjN715PUoLtKtfhMZfhRC@vger.kernel.org, AJvYcCWf8YGxgVniegxAFvksF39WRZwoova57o8v7LwaoeGdk5yRUI26Na9juvahr7AYuysMH8vtH9jU+ZY=@vger.kernel.org, AJvYcCX6piSUVfc1UeVYqzf97s53Lv/pWPN7V+9btlVbK1Hp58AeFV/LN84Lpf5LlidCVjgNwlrfKHKF@vger.kernel.org
X-Received: by 2002:a05:6102:949:b0:4e2:955a:b12f with SMTP id
 ada2fe7eead31-4e6e40d8cc2mr10526652137.3.1748849011142; Mon, 02 Jun 2025
 00:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210918095637.20108-1-mailhol.vincent@wanadoo.fr>
 <20210918095637.20108-5-mailhol.vincent@wanadoo.fr> <CAMuHMdVEBLoG084rhBtELcFO+3cA9_UrZrUfspOeLNo80zyb9g@mail.gmail.com>
 <10ed3ec2-ac66-494a-9d3f-bf2df459ebc0@wanadoo.fr>
In-Reply-To: <10ed3ec2-ac66-494a-9d3f-bf2df459ebc0@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Jun 2025 09:23:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWDUpkwPVCm2Dha04F59MES4QvKFUVfvg70x5GPZHsxDA@mail.gmail.com>
X-Gm-Features: AX0GCFvuHoKAt7ecSBaNwjIw6CAOIDvkHYg2PitGrYaCrTuLaODgZOujsJnxogU
Message-ID: <CAMuHMdWDUpkwPVCm2Dha04F59MES4QvKFUVfvg70x5GPZHsxDA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] can: netlink: add interface for CAN-FD Transmitter
 Delay Compensation (TDC)
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Stefan_M=C3=A4tje?= <Stefan.Maetje@esd.eu>
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Sat, 31 May 2025 at 10:25, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> On 30/05/2025 at 20:44, Geert Uytterhoeven wrote:
> > Thanks for your patch, which is now commit d99755f71a80df33
> > ("can: netlink: add interface for CAN-FD Transmitter Delay
> > Compensation (TDC)") in v5.16.
> >
> > On Sat, 18 Sept 2021 at 20:23, Vincent Mailhol
> > <mailhol.vincent@wanadoo.fr> wrote:
> >> Add the netlink interface for TDC parameters of struct can_tdc_const
> >> and can_tdc.
> >>
> >> Contrary to the can_bittiming(_const) structures for which there is
> >> just a single IFLA_CAN(_DATA)_BITTMING(_CONST) entry per structure,
> >> here, we create a nested entry IFLA_CAN_TDC. Within this nested entry,
> >> additional IFLA_CAN_TDC_TDC* entries are added for each of the TDC
> >> parameters of the newly introduced struct can_tdc_const and struct
> >> can_tdc.
> >>
> >> For struct can_tdc_const, these are:
> >>         IFLA_CAN_TDC_TDCV_MIN
> >>         IFLA_CAN_TDC_TDCV_MAX
> >>         IFLA_CAN_TDC_TDCO_MIN
> >>         IFLA_CAN_TDC_TDCO_MAX
> >>         IFLA_CAN_TDC_TDCF_MIN
> >>         IFLA_CAN_TDC_TDCF_MAX
> >>
> >> For struct can_tdc, these are:
> >>         IFLA_CAN_TDC_TDCV
> >>         IFLA_CAN_TDC_TDCO
> >>         IFLA_CAN_TDC_TDCF
> >>
> >> This is done so that changes can be applied in the future to the
> >> structures without breaking the netlink interface.
> >>
> >> The TDC netlink logic works as follow:
> >>
> >>  * CAN_CTRLMODE_FD is not provided:
> >>     - if any TDC parameters are provided: error.
> >>
> >>     - TDC parameters not provided: TDC parameters unchanged.
> >>
> >>  * CAN_CTRLMODE_FD is provided and is false:
> >>      - TDC is deactivated: both the structure and the
> >>        CAN_CTRLMODE_TDC_{AUTO,MANUAL} flags are flushed.
> >>
> >>  * CAN_CTRLMODE_FD provided and is true:
> >>     - CAN_CTRLMODE_TDC_{AUTO,MANUAL} and tdc{v,o,f} not provided: call
> >>       can_calc_tdco() to automatically decide whether TDC should be
> >>       activated and, if so, set CAN_CTRLMODE_TDC_AUTO and uses the
> >>       calculated tdco value.
> >
> > This is not reflected in the code (see below).
>
> Let me first repost what I wrote but this time using numerals and letters
> instead of the bullet points:
>
>   The TDC netlink logic works as follow:
>
>    1. CAN_CTRLMODE_FD is not provided:
>       a) if any TDC parameters are provided: error.
>
>       b) TDC parameters not provided: TDC parameters unchanged.
>
>    2. CAN_CTRLMODE_FD is provided and is false:
>       a) TDC is deactivated: both the structure and the
>          CAN_CTRLMODE_TDC_{AUTO,MANUAL} flags are flushed.
>
>    3. CAN_CTRLMODE_FD provided and is true:
>       a) CAN_CTRLMODE_TDC_{AUTO,MANUAL} and tdc{v,o,f} not provided: call
>          can_calc_tdco() to automatically decide whether TDC should be
>          activated and, if so, set CAN_CTRLMODE_TDC_AUTO and uses the
>          calculated tdco value.
>
>       b) CAN_CTRLMODE_TDC_AUTO and tdco provided: set
>          CAN_CTRLMODE_TDC_AUTO and use the provided tdco value. Here,
>          tdcv is illegal and tdcf is optional.
>
>       c) CAN_CTRLMODE_TDC_MANUAL and both of tdcv and tdco provided: set
>          CAN_CTRLMODE_TDC_MANUAL and use the provided tdcv and tdco
>          value. Here, tdcf is optional.
>
>       d) CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually exclusive. Whenever
>          one flag is turned on, the other will automatically be turned
>          off. Providing both returns an error.
>
>       e) Combination other than the one listed above are illegal and will
>          return an error.
>
> You can double check that it is the exact same as before.
>
> > By default, a CAN-FD interface comes up in TDC-AUTO mode (if supported),
> > using a calculated tdco value.  However, enabling "tdc-mode auto"
> > explicitly from userland requires also specifying an explicit tdco
> > value.  I.e.
> >
> >     ip link set can0 type can bitrate 500000 dbitrate 8000000 fd on
>                                                                 ^^^^^
> Here:
>
>   - CAN_CTRLMODE_FD provided and is true: so we are in close 3.
>
>   - CAN_CTRLMODE_TDC_{AUTO,MANUAL} and tdc{v,o,f} not provided: so we *are* in
>     sub-clause a)
>
> 3.a) tells that the framework will decide whether or not TDC should be
> activated, and if activated, will set the TDCO.
>
> > gives "can <FD,TDC-AUTO>" and "tdcv 0 tdco 3", while
>
> Looks perfectly coherent with 3.a)
>
> Note that with lower data bitrate, the framework might have decided to set TDC off.

Yes, that case is fine for sure.

> >     ip link set can0 type can bitrate 500000 dbitrate 8000000 fd on
> > tdc-mode auto
>
> This time:
>
>   - CAN_CTRLMODE_FD provided and is true: so we are in close 3.
>
>   - CAN_CTRLMODE_TDC_AUTO is provided, we are *not* in sub-clause a)
>
>   - tdco is not provided.
>
> No explicit clauses matches this pattern so it defaults to the last
> sub-clause: e), which means an error.
>
> > gives:
> >
> >     tdc-mode auto: RTNETLINK answers: Operation not supported
>
> Looks perfectly coherent with 3.e)

Thanks, I misread this as clause 3.a being applicable (hasn't NOT a
higher precedence than AND? ;-)

> > unless I add an explicit "tdco 3".
>
> Yes, if you provide tcdo 3, then you are under 3.b).
>
> > According to your commit description, this is not the expected behavior?
> > Thanks!
>
> Looking back to my commit, I admit that the explanation is convoluted and could
> be hard to digest, but I do not see a mismatch between the description and the
> behaviour.

OK, so the description and the behaviour do match.

However, I still find it a bit counter-intuitive that
CAN_CTRLMODE_TDC_AUTO is not fully automatic, but automatic-with-one-
manual-knob.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

