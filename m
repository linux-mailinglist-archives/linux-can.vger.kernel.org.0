Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D56346A7F
	for <lists+linux-can@lfdr.de>; Tue, 23 Mar 2021 21:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhCWUz3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Mar 2021 16:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbhCWUzB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Mar 2021 16:55:01 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46656C061763
        for <linux-can@vger.kernel.org>; Tue, 23 Mar 2021 13:55:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id bf3so25120155edb.6
        for <linux-can@vger.kernel.org>; Tue, 23 Mar 2021 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sIlhwezzW3BH4ibh6p5EOcG1PRMUgx4NenwqaMmx55s=;
        b=NhEf2QJOcj3iOZD88Yu0ZLce0jFAF2oJ0a4zOpB89R+20Dnm1wJxmHvStKsHMcXIEU
         u669BILvepA3CMjYHpxucpAG7ZNB3shoKU8iAzkFtfrzwfxVQrb0NnRf13IytDNKcwR6
         9/7irFGnst5FsQFkUYhi/hyZwUIkwPDGAQ5nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sIlhwezzW3BH4ibh6p5EOcG1PRMUgx4NenwqaMmx55s=;
        b=Pxqiu29L2h5p8l/REVdSwNz9dc5S+epHvS4n/MnMoBT9bis+SZD3drTP7Rn4yw1LS+
         Isy6sSOgeGNNTSC4jgwwNZQjAiCqphWs911q/03W2fW+ys4NTfRkmFujPq5wl/JnddP1
         2xQC348+cFyeADcH2J+o03pE2Lm6z4uykfEZyIZ1do+GUV9U7xoTDIbLiVqzJQVp0LpF
         +gHlIoTQsWP2SOAIyUfzAtdo/4y9hIYZAGbdtCd5HaLeUSAAHLJTSN1lMGG7lqk7oUSv
         3jlmLzp9e6/91/SME+RJb4zLkgOI8TVA69UCnG/j7GR/jppAsrFtH7ebzJX3QCFyr5/A
         jOMg==
X-Gm-Message-State: AOAM5307aXXbR598iVdXr2pj7nUmqtEkj98HcZFZX0jMFGJOS8PZt/eG
        SmNbBNQ24L0dZlMPgGmvm9msCQJ435LKWg==
X-Google-Smtp-Source: ABdhPJzEQWJWPosRftiYW44Z3IJtNRzghYlLC0WDM9fktlTBuiNRk6eHiX1Sk8MTnpyOK9RSo8b88A==
X-Received: by 2002:a05:6402:2695:: with SMTP id w21mr6430957edd.99.1616532899600;
        Tue, 23 Mar 2021 13:54:59 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id ym4sm3844663ejb.100.2021.03.23.13.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 13:54:59 -0700 (PDT)
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
 <a5599800-53f4-c53f-abcc-e166ea9028b9@rasmusvillemoes.dk>
 <080d9e5c-fe1f-4a64-2938-8ca6d8a98d78@hartkopp.net>
 <0a8e8e95-c1a2-ede6-9f87-1ab7a0a155e3@rasmusvillemoes.dk>
 <212c8bc3-89f9-9c33-ed1b-b50ac04e7532@hartkopp.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <1a6dd272-8bc2-57dc-5592-47a08493193a@rasmusvillemoes.dk>
Date:   Tue, 23 Mar 2021 21:54:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <212c8bc3-89f9-9c33-ed1b-b50ac04e7532@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 23/03/2021 19.59, Oliver Hartkopp wrote:
> 
> 
> On 23.03.21 15:00, Rasmus Villemoes wrote:

>> Now what CONFIG_* knobs are responsible for putting -mabi=apcs-gnu in
>> CFLAGS is left as an exercise for the reader. Regardless, it is not a
>> bug in the compiler. The error is the assumption that this language
>>
>> "Aggregates and Unions
>>
>> Structures and unions assume the alignment of their most strictly
>> aligned component.
> 
> (parse error in sentence)

It was a direct quote, but I can try to paraphrase with an example. If
you have a struct foo { T1 m1; T2 m2; T3 m3; }, then alignof(struct foo)
= max(alignof(T1), alignof(T2), alignof(T3)). Same for a "union foo".

But this is specifically for x86-64; for (some flavors of) ARM, other
rules apply - namely, alignof(T) is 4 unless T is char or short (or
(un)signed variants), ignoring bitfields which have their own rules.
Note that while

union u {char a; char b;}

has alignment 4 on ARM and 1 on x86-64, other types are less strictly
aligned on ARM; e.g. s64 aka long long is 8-byte aligned on x86-64 but
(still) just 4-byte aligned on ARM. And again, this is just for specific
-mabi= options.

>> Each member is assigned to the lowest available offset with the
>> appropriate
>> alignment. The size of any object is always a multiple of the object‘s
>> alignment."
>>
>> from the x86-64 ABI applies on all other architectures/ABIs.
>>
>>> I'm not a compiler expert but this does not seem to be consistent.
>>>
>>> Especially as we only have byte sizes (inside and outside of the union)
>>> and "A field with a char type is aligned to the next available byte."
>>
>> Yes, and that's exactly what you got before the anon union was
>> introduced.
> 
> Before(!) the union there is nothing to pad.

Just to be clear, my "before" was in the temporal sense, i.e. "prior to
commit ea7800565a128", all the u8s in struct can_frame were placed one
after the other. But after that commit, struct can_frame has a new
member replacing can_dlc which happens to occupy 4 bytes (for some
ABIs), pushing the subsequent members __pad, __res0 and len8_dlc
(formerly known as __res1) ahead.

>>> The union is indeed aligned to the word boundary - but the following
>>> byte is not aligned to the next available byte.
>>
>> Yes it is, because the union occupies 4 bytes. The first byte is shared
>> by the two char members, the remaining three bytes are padding.
> 
> But why is the union 4 bytes long here and adds a padding of three bytes
> at the end?

Essentially, because arrays. It's true for _any_ type T that sizeof(T)
must be a multiple of alignof(T). Take an array "T x[9]". If x[0] is
4-byte aligned, then in order for x[1] to be 4-byte aligned as well,
x[0] must occupy a multiple of 4 bytes.

It doesn't matter at all that this happens to be an anonymous union.
Layout-wise, you could as well have a definition

union uuu { __u8 len; __u8 can_dlc; }

and made struct can_frame

struct can_frame {
   canid_t can_id;
   union uuu u;
   __u8 __pad;
   ...
};

(you lose the anonymity trick so you'd have to do frame->u.can_dlc
instead of just frame->can_dlc). You have a member with alignof()==4 and
 sizeof()==4; that sizeof() cannot magically become 1 just because that
particular instance of the type is not part of an array. Imagine what
would happen if the compiler pulled subsequent char members into
trailing padding of a previous compound member. E.g. consider

struct a { int x; char y; } // alignof==4, sizeof==8, offsetof(y)==4
struct b { struct a a; char z; }

If I have a "struct b *b", I'm allowed to do "&b->a" and get a "pointer
to struct a". Then I can do memset(&b->a, 0, sizeof(struct a)). Clearly,
z must not have been placed inside the trailing padding of struct a.

Rasmus
