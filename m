Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC92A345D14
	for <lists+linux-can@lfdr.de>; Tue, 23 Mar 2021 12:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhCWLhP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Mar 2021 07:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhCWLg6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Mar 2021 07:36:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59858C061756
        for <linux-can@vger.kernel.org>; Tue, 23 Mar 2021 04:36:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u21so8554109ejo.13
        for <linux-can@vger.kernel.org>; Tue, 23 Mar 2021 04:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eYXwdWJpGgPlbF+IMjlnRK89MycJ6XGBFq/8nML6pC0=;
        b=clFInBkeeScHTmHOP7pOfOTtYcMCWJWsiDjZLLVa3tz9WfsZFCU2Xjz4Rn/Xtgqmf1
         9ni/sA01AyG+pIzAWtzgOP6oyrRg0E4DHIrU5noHCJmgoRl9vqPAvZFKhxMkGyt9Q+GH
         pgmQ1u/7DFmwUyGGCQfEx63QP4keEpp7eyKq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eYXwdWJpGgPlbF+IMjlnRK89MycJ6XGBFq/8nML6pC0=;
        b=TNOQuG45MOnZmg+Cdzxav0RODRTPZnQ7F2VygjGnhVkvpXzzr70tzeUv4i+fQDD6UN
         3is81hWkZeIyanyTvbA6oySka8/E7AN1T5JVcdQvCIqqV2S+J0MnxunJkjo+f9qlB75V
         LpDdfD7MeLZM6ducRC8Ud3Vp5CTAYA6BrQ+bSBkrTEoAA89c7xWCYXyIKPgwomaHRR4V
         wPtUFO7r2z8DX4nxWpwadROWW8fr0xG2QAZTnwpPkumaa5z3gMG9JEIyAupGwmX+5Eza
         4+Nq7Ts7sDM7wFps0Bynlew+JOEJPQGvWZWctoASqa6iuAiLyebMuznk70KRs3+Ng7+z
         3bXw==
X-Gm-Message-State: AOAM532UT1HtJpVivPQWHOoU1p7WH0m4SF68u3P18QepsLSu5a+KsDiv
        4/5RIa3E9pZ4eSqUE8mlt9Mag+/z5YQaGw==
X-Google-Smtp-Source: ABdhPJx3nhkdvqAOxYrDrs1W4d9yEi6lYOlC66pKdx/nfTmq3D74GivKZdkEOzM6bDKovjQpw3O0ng==
X-Received: by 2002:a17:906:b297:: with SMTP id q23mr4498095ejz.315.1616499416873;
        Tue, 23 Mar 2021 04:36:56 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id p3sm11014906ejd.7.2021.03.23.04.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 04:36:56 -0700 (PDT)
Subject: Re: [kbuild-all] Re: include/linux/compiler_types.h:315:38: error:
 call to '__compiletime_assert_536' declared with attribute error:
 BUILD_BUG_ON failed: offsetof(struct can_frame, len) != offsetof(struct
 canfd_frame, len) || offsetof(struct can_frame, data) != offsetof(struc...
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rong Chen <rong.a.chen@intel.com>,
        Patrick Menschel <menschel.p@posteo.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
References: <202103210435.I0fiBGAC-lkp@intel.com>
 <dad98ebd-77a4-3305-e681-278cabe38793@hartkopp.net>
 <7f4f7e1c-194b-a903-d474-e3b742556a55@intel.com>
 <f8075a19-10e1-abf9-6d59-1a46454b74b1@hartkopp.net>
 <b10903ca-c424-b305-d981-fe0004500190@intel.com>
 <20210323073437.yo63wreqnubbeqby@pengutronix.de>
 <7ff6bfd3-6b4b-045a-abb7-485927909587@hartkopp.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a5599800-53f4-c53f-abcc-e166ea9028b9@rasmusvillemoes.dk>
Date:   Tue, 23 Mar 2021 12:36:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7ff6bfd3-6b4b-045a-abb7-485927909587@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 23/03/2021 08.45, Oliver Hartkopp wrote:

> IMO we facing a compiler problem here - and we should be very happy that
> the BUILD_BUG_ON() triggered an issue after years of silence.
> 
> I do not have a good feeling about what kind of strange effects this
> compiler issue might have in other code of other projects.
> 
> So I would explicitly suggest NOT to change the af_can.c code to work
> around this compiler issue.
> 
> Let the gcc people fix their product and let them thank all of us for
> detecting it.

I'm sure you'd be eligible for a full refund in case this was a bug in
gcc. It is not. It's a pretty clear ABI requirement for (at least some
flavors of) ARM:

https://stackoverflow.com/questions/43786747/struct-layout-in-apcs-gnu-abi

and more directly from the horse's mouth:

https://developer.arm.com/documentation/dui0067/d/arm-compiler-reference/c-and-c---implementation-details/structures--unions--enumerations--and-bitfields

Field alignment

    Structures are arranged with the first-named component at the lowest
address. Fields are aligned as follows:

        A field with a char type is aligned to the next available byte.

        A field with a short type is aligned to the next even-addressed
byte.

        Bitfield alignment depends on how the bitfield is declared. See
Bitfields in packed structures for more information.

        All other types are aligned on word boundaries.

That anonymous union falls into the "All other types" bullet.

__packed is the documented and standard way to overrule the
compiler's/ABI's layout decisions.

Rasmus
