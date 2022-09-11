Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511AF5B4EB4
	for <lists+linux-can@lfdr.de>; Sun, 11 Sep 2022 14:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiIKML3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 11 Sep 2022 08:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiIKML2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 11 Sep 2022 08:11:28 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBBD2EF2E
        for <linux-can@vger.kernel.org>; Sun, 11 Sep 2022 05:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1662898284;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rtYXCG42N4WXTBkX6/ivH/nEbkYumBcsykg87Dd/gP4=;
    b=hwe9wDx6v/ieNzD1TwpDdCB6SVICJrHTNTjFz39q51akwOpkVEjNhV3rqq6Q5/hbi8
    zggUEZslVBPXSr5WvHJR7XwOsXO1wTcDeNL7bhZCrJtcUNZ9k5yvUG7HwpRN0Escny6o
    8M06i/KDPI1sk/jC2KuOA/OwP8e5imzTolUbpq/1pQI413DggbiM3iO2sYeL8AVUmzNb
    e9UsZ3RovJA6zrmYEwUKI0Ztd0BftQF9HleTqj4uLXyHf3/JEhcJchMKIG7Qyg0QsyZX
    X2wgnuyrasz5SVSoR6+gXgpigPZk3Et49gt6FYm3Qt0gMCMgPVGT4KEgiaEMlMa5VyM5
    0tSA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytISr6hZqJAw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d104::923]
    by smtp.strato.de (RZmta 48.0.2 AUTH)
    with ESMTPSA id wfa541y8BCBOCoS
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 11 Sep 2022 14:11:24 +0200 (CEST)
Message-ID: <1d8be592-5f4c-8036-8050-22aec73a3eb4@hartkopp.net>
Date:   Sun, 11 Sep 2022 14:11:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v8 4/7] can: canxl: introduce CAN XL data structure
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20220801190010.3344-1-socketcan@hartkopp.net>
 <20220801190010.3344-5-socketcan@hartkopp.net>
 <CAMZ6RqKFNY1y9XpsLU6cjs_TmnYBjjDin6LHn5TRpm5m4w2ewg@mail.gmail.com>
 <414e2a33-0091-11fc-70db-a87331addff8@hartkopp.net>
 <f79f729c-01eb-2121-e315-a240357d2eb0@hartkopp.net>
 <CAMZ6RqL=ZqBUSA8xGQW1jMU8fwduz11_HJcFjerPtO8ZUAVdiw@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqL=ZqBUSA8xGQW1jMU8fwduz11_HJcFjerPtO8ZUAVdiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vincent,

On 11.09.22 09:50, Vincent Mailhol wrote:
> On Thu. 8 Sep. 2022 at 16:24, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
(..)

>>> The CAN-ID was (due to its arbitration nature) always also a priority
>>> field.
> 
> The CAN-(FD) ID holds two roles: priority and ID. For CAN XL, it is
> only ID.

Typo? It is only the priority ;-)

> While I agree that both have the priority attributes, my
> concerns are on the semantics. The type is canid_t, not canprio_t. I
> just want to point that it is weird to had ID in the type when that
> field doesn't have an ID property anymore.

CAN XL moves away from the two roles combined in the CAN(FD) Identifier. 
The main focus is on arbitration now (CAN XL is like CAN arbitration 
with Ethernet data).

But in the end the CAN bitstream at the beginning of the frame including 
the arbitration is completely identical for all CAN variants.

Even when this arbitration field is now named priority for CAN XL it is 
still the exact mechanism of the CAN identifier (what we introduces 
canid_t for).

Therefore having canid_t for can_id and prio seems appropriate.

>>> So nothing changed here. There is no RTR and no 29-bit priority anymore
>>> now. The RTR flag has already been disabled for CAN FD (see presentation
>>> at the end of this mail).
>>>
>>> Therefore it makes sense to handle the SFF 11-bit prio analogue to the
>>> former CAN-ID - and also use canid_t to simply keep the entire CAN
>>> filter handling in af_can.c !
> 
> This is a good argument to keep using the canid_t. If we make it a
> u16, we lose the alignment (unless we add dirty endianness
> preprocessing macros).

Yep.

(..)

>>> Btw. I uploaded a presentation which shows the way from classical CAN to
>>> CAN XL which might depict some relations of the bits in a clearer way:
>>>
>>> https://github.com/linux-can/can-doc/blob/master/presentations/CAN-XL-Intro.pdf
> 
> Thanks. With the Bosch PDF now returning error 404, I suggest
> replacing the link in the cover letter with your link (or the CIA
> knowledge page).

Ok, will do.

Best regards,
Oliver

