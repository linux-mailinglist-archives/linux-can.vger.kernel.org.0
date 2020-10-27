Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F300A29AC96
	for <lists+linux-can@lfdr.de>; Tue, 27 Oct 2020 13:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900375AbgJ0M6o (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 27 Oct 2020 08:58:44 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:29832 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900374AbgJ0M6o (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 27 Oct 2020 08:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603803519;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=2UfvJlkdhDvRs9ZMBTlwdxhyOAVC61VAD51FfngPtUI=;
        b=eTLDCRK+bf9ZZs0IqUmwrhL1ucMLDNjjlH8KYwJKFhGh8aShCjoPDItQD4LEgV8jbh
        7cpks7qqyx+vePeQL8r8M8nqjoxylhPFOm6zEzr2AH2Uat7XKAp0h5z6wkbT9vZNLnfO
        5/vu2gRl8Faf2nxgFQMgfv0PAV/sWU0vK9J4C7fHFsJAPyzwTWNKRlgl+OOEd/AAGDgI
        Wu5VzUZ8fZ8Hy0MqWAkD/nZKD6fiIkWgKlv08Aij/lovMz9MtEaDsIbX/wA5qkZnLHCe
        +Kljp1HwHCHp2gHoK0RYhAGb5wsgxeihTOmjw0Y6Pbiow8lit2gz2YLZZBQdjVH95Ok5
        UGJg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR+J8xvyl0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.2.2 SBL|AUTH)
        with ESMTPSA id j075f4w9RCwa2uY
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 27 Oct 2020 13:58:36 +0100 (CET)
Subject: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame
 structure
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
References: <20201023203017.3485-1-socketcan@hartkopp.net>
 <CAMZ6RqKQjD5vWeya1CEpNuaZb=vUYWtkgL1rDr1fcBvBRDdgxA@mail.gmail.com>
 <e23e5ebd-5bd9-dca2-5c1e-9adbd009cf99@hartkopp.net>
Message-ID: <ef880524-5322-7bb4-a0ed-76d678e87b78@hartkopp.net>
Date:   Tue, 27 Oct 2020 13:58:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e23e5ebd-5bd9-dca2-5c1e-9adbd009cf99@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

@Marc, all,

are you fine with that patch and the naming too?

If so, I would go further and provide a patch with the complete netlink 
code in can-dev - and maybe a first driver adaption to support len8_dlc 
for Classical CAN.

Best regards,
Oliver

On 24.10.20 15:00, Oliver Hartkopp wrote:
> 
> 
> On 24.10.20 14:00, Vincent MAILHOL wrote:
>> I did some tests:
>>
>>    * Applied the patch
>>
>>    * Modified my driver
>>
>>    * Modified drivers/net/can/dev.c:can_changelink() to force the
>>      CAN_CTRLMODE_CC_LEN8_DLC on (this is just me being lazy to do it
>>      from userland).
> 
> Good choice for a test. Modifying the ip tool is not that tricky - but 
> you need to clone that stuff, etc.
> 
>>    * Modified cansend and candump from can-utils to be able to
>>      respectively send and print DLCs greater than 8.
> 
> Yes, there will be even more effort on can-utils as it also has an 
> impact on logfile formats, etc.
> 
> E.g. the value between [] in candump was 'len' so far - we could probaly 
> make them () when we might show the DLC values.
> 
> And the logfile format gets the length implicit from the number of 
> printed data bytes, which is always the 'len'.
> 
> So we would need to discuss, where we would need command line options to 
> enable the CC len8_dlc feature.
> 
>>    * Set up two channels can0 and can1 and connected those to the same
>>      bus.
>>
>>    * Ran 'cangen can0' and 'candump any' simultaneously.
>>
>>
>> Results of candump:
>>    can0  539   [8]  05 21 8C 5C F7 B0 7C 69
>>    can1  539   [8]  05 21 8C 5C F7 B0 7C 69
>>    can0  47E   [1]  53
>>    can1  47E   [1]  53
>>    can0  317   [6]  E5 00 B5 73 66 CF
>>    can1  317   [6]  E5 00 B5 73 66 CF
>>    can0  524   [E]  64 C3 B0 6E 55 7A D7 2E
>>    can1  524   [E]  64 C3 B0 6E 55 7A D7 2E
>>    can0  39C   [D]  63 18 96 69 F6 7A AB 36
>>    can1  39C   [D]  63 18 96 69 F6 7A AB 36
>>    can0  60D   [F]  F2 C6 B6 1D 80 FB BC 7E
>>    can1  60D   [F]  F2 C6 B6 1D 80 FB BC 7E
>>    can0  5DD   [9]  7E 55 56 5B C0 23 B0 53
>>    can1  5DD   [9]  7E 55 56 5B C0 23 B0 53
>>    can0  573   [E]  20 8E A3 31 1B 54 B2 16
>>    can1  573   [E]  20 8E A3 31 1B 54 B2 16
>>    can0  470   [3]  31 9C 06
>>    can1  470   [3]  31 9C 06
>>    can0  465   [4]  93 75 A2 08
>>    can1  465   [4]  93 75 A2 08
>>
>>
>> Works fine :-)
> 
> Excellent job!!
> 
> Thanks Vincent!
> 
> Best,
> Oliver
