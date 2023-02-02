Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC55687F13
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 14:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjBBNsJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 08:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjBBNsG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 08:48:06 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295417D97
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 05:48:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675345680; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oqogDyYdlNKeOPwwrNxKKiivP153Cvsg0knBfP0xAer/XaMGmwSJzDl2MwLYv7umPg
    Ekxit4XeZnQ07aPy6iNFq3y0zns/+n8E2E284bMrybic0TSnMivii4fqZMptDrrdwT8q
    kH5Jq+RQJwVl2OwzW++GAX355Jnr+j4QLvvpe03bwvCgAiKUYpxQDRzfH/X5+i6E8Orj
    ioGw13+grhvF7Ir2z3wPkVyvuY49HQ7lJuJU4N2TrOlgcbR0jSgpmFFOuLInQFSBWIA8
    bLYLsBtq8rCdjnTNEjLupMa90kEz5Gg2uvv73apnF9DXSaslHPXi3zjjZFVl3jszZsAc
    /5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675345680;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=X7h30E9CHMlZ3V7GrP00yrwNNmjyVNFHaDS1gPcUrDc=;
    b=hZuu1b/XT8n+vanU2nBA6fd5tgts5cDELOgUR4iPODyau9IcQVm2XTxscuLp1YfnFW
    /Pa75TD924IIKw2O1HvJ6Dz9byr6XS0i2hMkYMSAnPrEzj35l8Iln50zN/qcSFlI68ui
    4DcxHN4Qmp4K0Ap+IhX4V89Kh3wJnP65c6gbMu+5ngsV0VwDDcSYlBPsxCqyIEQ0Ap2g
    /T+g3P61pJXh7CMG8O4XbqvGdymg/EWFpjkdopFYE+W7neLibUT7k5gMCbT0lKFfOOi2
    7VUzp9sDjyBBLYAhlm4eFzbHqJq6tRzEOUEPy/Y7WTpqEYd08s8ZobRb+N9Q/UDrkoLi
    ey1Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675345680;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=X7h30E9CHMlZ3V7GrP00yrwNNmjyVNFHaDS1gPcUrDc=;
    b=gqt1NCLHp1pk8M6+uHxFcfMjXEW/DA2E0mySxHYoCPqrAOLLp0NZludy0Zu/Htetc9
    +rGDNbk3gKyQ+G5ao7rKaxIgSEAg922NHshQjhBvbFrGqothUzIw0ifcAzDlLxt2Ujol
    EvpWbtAnskCqwVQq/c2L159xbEEoV3pOwD1fMaLPHPcBqKtIjq1Q418+8SO039jkHFF4
    tOoRLOYyMZDMPBzPmjKUVF8L7imD4zl1ob9QpjuVw7QZkEHIUZ3Sp+Gc/fzjZx9pwJkA
    4CEDYaChltiOXEXe6qB/ot/NZtkUvG2cmkMkABFttcn6YUvbm8i089/C394B0Q4Tbhlf
    gnPA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1q3jXdVqE32oRVrGn+Gi68g=="
Received: from [100.82.11.11]
    by smtp.strato.de (RZmta 49.2.2 AUTH)
    with ESMTPSA id qa71b9z12Dm0RvP
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 2 Feb 2023 14:48:00 +0100 (CET)
Message-ID: <bd2949e7-59d9-dc95-9010-3c304824d6dc@hartkopp.net>
Date:   Thu, 2 Feb 2023 14:47:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH net 2/5] can: raw: fix CAN FD frame transmissions over CAN
 XL devices
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20230202094135.2293939-1-mkl@pengutronix.de>
 <20230202094135.2293939-3-mkl@pengutronix.de>
 <b71b8544-7e55-b86e-a32c-7ebdc0e4ea78@hartkopp.net>
 <20230202131021.4xffrriiggebuzqf@pengutronix.de>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230202131021.4xffrriiggebuzqf@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 02.02.23 14:10, Marc Kleine-Budde wrote:
> On 02.02.2023 13:43:07, Oliver Hartkopp wrote:
>> you asked me to introduce a new variable instead of rolling back the
>> ro->fd_frames setting in setsockopt.
>>
>> I just wondered why you didn't pick the V4 patch then:
> 
> Doh - that was not intentional!
> 

No problem ;-)

>> https://lore.kernel.org/linux-can/20230131112657.59247-1-socketcan@hartkopp.net/T/#u
>>
>> It has no functional drawback but I was able to add an error return code in
>> V4. I just wanted to know.
> 
> Please send a follow up patch against net-next/main once the net/main
> has been merged in net-next/main.
> 

Ok, will do!

Thanks!

Oliver
