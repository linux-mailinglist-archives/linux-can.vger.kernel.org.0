Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F367D297C84
	for <lists+linux-can@lfdr.de>; Sat, 24 Oct 2020 15:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761675AbgJXNAL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 24 Oct 2020 09:00:11 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:10575 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761674AbgJXNAK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 24 Oct 2020 09:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603544408;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=jHnRf84mI/GBwMX0bWCQ8RUAl3gj91MAEsycrnN+XTs=;
        b=tRUr3DLo5Ilf3k65ySkH6k7tm5dOTX1E8MjaZ+psUiSQnoWpdinb8Bws7LZe0EQRz5
        AZdFukuN5TzNnCdghfibUYi75SvF9AnDkYt9MvyVJ7ijydUyev+6HF+cLsJyFHcpbm88
        SgTigzSPrnPu4AQJhxQf98z5oZB8anyxnGwdFIcLGHbVs3FKOnFyYpIIfiT96CU5qTwe
        zHGro8+OAhNFVHPJ5qSSaRuyv9z2nS0pVbr9SaLgCC3rWoUDzfFXcgZR/gE/Mlb8i690
        PrBmD2unSUKdrZfMwbSMQVfopkk7rq2W7pOvZ9Cpv+jocHTx69eOJtwcD4RZVY26MXkO
        rsuw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3HMbEWKN9eTSLsO"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id D0b41cw9OD050wZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 24 Oct 2020 15:00:05 +0200 (CEST)
Subject: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame
 structure
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20201023203017.3485-1-socketcan@hartkopp.net>
 <CAMZ6RqKQjD5vWeya1CEpNuaZb=vUYWtkgL1rDr1fcBvBRDdgxA@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <e23e5ebd-5bd9-dca2-5c1e-9adbd009cf99@hartkopp.net>
Date:   Sat, 24 Oct 2020 15:00:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqKQjD5vWeya1CEpNuaZb=vUYWtkgL1rDr1fcBvBRDdgxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 24.10.20 14:00, Vincent MAILHOL wrote:
> I did some tests:
> 
>    * Applied the patch
> 
>    * Modified my driver
> 
>    * Modified drivers/net/can/dev.c:can_changelink() to force the
>      CAN_CTRLMODE_CC_LEN8_DLC on (this is just me being lazy to do it
>      from userland).

Good choice for a test. Modifying the ip tool is not that tricky - but 
you need to clone that stuff, etc.

>    * Modified cansend and candump from can-utils to be able to
>      respectively send and print DLCs greater than 8.

Yes, there will be even more effort on can-utils as it also has an 
impact on logfile formats, etc.

E.g. the value between [] in candump was 'len' so far - we could probaly 
make them () when we might show the DLC values.

And the logfile format gets the length implicit from the number of 
printed data bytes, which is always the 'len'.

So we would need to discuss, where we would need command line options to 
enable the CC len8_dlc feature.

>    * Set up two channels can0 and can1 and connected those to the same
>      bus.
> 
>    * Ran 'cangen can0' and 'candump any' simultaneously.
> 
> 
> Results of candump:
>    can0  539   [8]  05 21 8C 5C F7 B0 7C 69
>    can1  539   [8]  05 21 8C 5C F7 B0 7C 69
>    can0  47E   [1]  53
>    can1  47E   [1]  53
>    can0  317   [6]  E5 00 B5 73 66 CF
>    can1  317   [6]  E5 00 B5 73 66 CF
>    can0  524   [E]  64 C3 B0 6E 55 7A D7 2E
>    can1  524   [E]  64 C3 B0 6E 55 7A D7 2E
>    can0  39C   [D]  63 18 96 69 F6 7A AB 36
>    can1  39C   [D]  63 18 96 69 F6 7A AB 36
>    can0  60D   [F]  F2 C6 B6 1D 80 FB BC 7E
>    can1  60D   [F]  F2 C6 B6 1D 80 FB BC 7E
>    can0  5DD   [9]  7E 55 56 5B C0 23 B0 53
>    can1  5DD   [9]  7E 55 56 5B C0 23 B0 53
>    can0  573   [E]  20 8E A3 31 1B 54 B2 16
>    can1  573   [E]  20 8E A3 31 1B 54 B2 16
>    can0  470   [3]  31 9C 06
>    can1  470   [3]  31 9C 06
>    can0  465   [4]  93 75 A2 08
>    can1  465   [4]  93 75 A2 08
> 
> 
> Works fine :-)

Excellent job!!

Thanks Vincent!

Best,
Oliver
