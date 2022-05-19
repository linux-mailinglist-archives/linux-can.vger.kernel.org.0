Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35DA52DA26
	for <lists+linux-can@lfdr.de>; Thu, 19 May 2022 18:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241988AbiESQ0q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 May 2022 12:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241992AbiESQ0p (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 May 2022 12:26:45 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A01E61610
        for <linux-can@vger.kernel.org>; Thu, 19 May 2022 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1652977600;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=2b9fJeor/92XTDkqacRX6ZE32I2zvCcoXpfD7tSzKwY=;
    b=YeKmC948++wvcPqzaklBsZ8NI4cUUu370zSwC37pSMNZ1cqFnM6FnYQsEG00pllIN/
    fJ53EdLm+BAZdL9uRWuw2GXJJkfnX94La9qLcu8L85ijymyYmioFciA55wfEsLoHipHg
    +fFpsH4/WKd1UZfEWS4pyCOgZiPeEfewdOX8nW8a1qU53WCyZ+Kx9E1qYay387i5EPXW
    Erv4AAP2E+wwz0v+g1qd18MMTWczpnSMDtd5uQGdYCR6YJmn31P4P726NrCZpfDUG9NL
    gzFNGfh6LAIa5PufCjoBj+03k/uIPOIQGdU5vdGerfpTb+HRoZ4fG9YFzrm7Me3GzWXc
    Q+aA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdBqPeOug2krLFRKxw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cff:5b04::b82]
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id R0691fy4JGQeM8X
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 19 May 2022 18:26:40 +0200 (CEST)
Message-ID: <f6d6522e-e63c-ea0f-e554-ea1cfc1b27a4@hartkopp.net>
Date:   Thu, 19 May 2022 18:26:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: can, m_can, tcan4x5x : big jitter between the packets by sending
Content-Language: en-US
To:     anochin@photo-meter.com, linux-can@vger.kernel.org
References: <9e431f19-897e-7bff-68bb-7ac7bb9fd757@photo-meter.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <9e431f19-897e-7bff-68bb-7ac7bb9fd757@photo-meter.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Michael,

On 19.05.22 17:52, Michael Anochin wrote:

> my application continuously sends 64 bytes CANFD packets with 1MBit/s at 
> the 10ms interval.

How does this application implement this 10ms interval?

Can you check whether

     cangen -g 10 -f -I 123 -L 64 can0

has the same problems?

With

     candump -td can0

you should be able to see some timestamp gaps around 10ms.

> I use tcan4450 on the RPI4 with 5.10.103 Kernel and 
> raspbian. No other significant processes load the CPU.
> 
> When I monitor the traffic with a PCAN adapter on a Windows PC, I notice 
> that the packets sometimes arrive with a delay of 5-9ms. But the next 
> following packet arrive faster as 10ms. My desired interval of 10ms is 
> kept at the jitter of +/- 9ms.
> 
> Running the App on only one CPU core using tasksel improve the jitter 
> somewhat.

What is the use-case for this 10ms cyclic transmission? Maybe the 
CAN_BCM (which uses in-kernel highres timers) could bring an improvement 
for you.

> Am I the only one who observes such large jitter or is the m_can 
> implementation at Perepherie (spi) not so fast from the throughput and 
> is completely normal.
> 
> Maybe I should switch to 5.17 kernel? On 5.17 there are bulk read/write 
> function for spi regmap.

I don't answer to this as I don't have the required SPI knowledge ... 
but if you could upgrade to a newer kernel this is always a good 
approach ;-)

Best regards,
Oliver
