Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A06689332
	for <lists+linux-can@lfdr.de>; Fri,  3 Feb 2023 10:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjBCJNL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 3 Feb 2023 04:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjBCJNJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Feb 2023 04:13:09 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42E961A7
        for <linux-can@vger.kernel.org>; Fri,  3 Feb 2023 01:13:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675415581; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hyy4vA0qz84dZstnBeDL5RTscd8ZPEH6qnYVDbfc5+RqtJsAd5B0ISS6BWRj1AqSwk
    aB0YhUI3ljweWg0Iwvte4FgckYGQ2e5HnwbFXSfW4ClL4bIB2dlLblX8Besvi955TZxc
    5KtAuHM63CCxZz6PxaNvX5POi0mGkYNbIR7WleO5H3p0S5I39iVe0ioUEzOBB9ahsv0A
    Jn+zInfERV1PhYOODvq+dReqI8T74i+eVjwZDwdF3K2pFBZSInYe7O1zjLkHEdnHv5H1
    Ev+qYSRzHuAiWal4QBeQb/NWHiElbOMNaU8+rVZyoqNagkgxCTor/MobvYbw9CteDK24
    mVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675415581;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=DKcYM7SwajJeTqYTK4yNNjK7+E/os2YNKpzQvvJ6cyA=;
    b=DP9hbPRjqE/Yd6cfLf8Ira11LPHrKeHXCq5vZX56+3PjQzAWt/Q8xGP1nCghB+zdne
    eoJI32dVPq86pCQcs+unkkrqR6pphHzYH0BrzDUuzhmdh3bR/KtT2fm+4IX6RcT4PUkf
    01VxZfQ/6YNRajB6uuMHX0S3iQFiJHl01nLIApAptMXjKQZyXlxmCdcRH5sXUpJtu3Yh
    BKRDcD2VEPkCzu5EveYbBm+NF1EV41+5GdUJPdQASwS5oMfTdSaZJirHRJ1VjNdyeY74
    eXLbvgFruLLJ2ckkvbN4KGPW7V1XZH8ELpSmNRGTfRbdCVktJ909a9alW5dx90xWSFHA
    Dgeg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675415581;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=DKcYM7SwajJeTqYTK4yNNjK7+E/os2YNKpzQvvJ6cyA=;
    b=DNJAq65wvtEHHG8KcPH2lc/U/7EvwRNtJo2KZznoCVZlaI5Go9MsYUOMk/KydtkuLP
    5Z/GvAGt68LSI8NDaRWpaSOo7CLSB3devq3PqIMTk5r3yULNYuFW6HLjedX50k+/tdpr
    g4Pbk7MyiBxliPFYuFM0JkQ7AFVJwnxtromW8rb2ogAd25fgqjcYSfxSMjkS2M3Jz76B
    s03ndUEXiJXlOdcXMi+FZFt5oqBEFIUoutJOtApHLHg2Em8gTju1aeea5j4313Hhz+VT
    /cb/CewhcXrzQb3/9/KsTSMTQD1Do1r6v73rlQrre41rsQFzN+eRm8uamWCpgSjQ6/m6
    cHMA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbVLYqA=="
Received: from [IPV6:2a00:6020:4a8e:5000::83c]
    by smtp.strato.de (RZmta 49.2.2 AUTH)
    with ESMTPSA id qa71b9z139D1UCm
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 3 Feb 2023 10:13:01 +0100 (CET)
Message-ID: <05c5621a-598b-b9b3-7eec-18d107ee2066@hartkopp.net>
Date:   Fri, 3 Feb 2023 10:12:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH net 2/5] can: raw: fix CAN FD frame transmissions over CAN
 XL devices
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20230202094135.2293939-1-mkl@pengutronix.de>
 <20230202094135.2293939-3-mkl@pengutronix.de>
 <b71b8544-7e55-b86e-a32c-7ebdc0e4ea78@hartkopp.net>
 <20230202131021.4xffrriiggebuzqf@pengutronix.de>
 <bd2949e7-59d9-dc95-9010-3c304824d6dc@hartkopp.net>
Content-Language: en-US
In-Reply-To: <bd2949e7-59d9-dc95-9010-3c304824d6dc@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> On 02.02.23 14:10, Marc Kleine-Budde wrote:

>>
>> Please send a follow up patch against net-next/main once the net/main
>> has been merged in net-next/main.
>>
Done!

https://lore.kernel.org/linux-can/20230203090807.97100-1-socketcan@hartkopp.net/T/#u

Thanks,
Oliver
