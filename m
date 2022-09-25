Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17905E92CC
	for <lists+linux-can@lfdr.de>; Sun, 25 Sep 2022 13:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiIYLpm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Sep 2022 07:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiIYLpk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Sep 2022 07:45:40 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3552220C7
        for <linux-can@vger.kernel.org>; Sun, 25 Sep 2022 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1664106331;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=JHLA3wrVGo08vpl8hW6yULpsRdKSGLZ7onSXNg2zA/k=;
    b=Dbqw+LHEgEuPnrRUvRnfaRKdB0s4zHQazq6fg/NT3JJ4HPY4Io6quApOaXMXkGZC2J
    +BKyS8elIqYu+4WE3VdpgIbbLyB1dKOOuzsW2iSwlAE+PqfacprZsmnvR/hn1BFXbqgM
    heP1PsrKsvuOlHGnWoOJTKgGNaBEvGolu5tmor2kpkgom/ASsdB87uQO82gyGr13m09U
    MHf2wxO9vRb48CW3vxir0NVxCEYzvqZ8F++4vvWILnwZ8LGqgvyDcBeoeYd2EcWC255H
    68m94Tq+h8AU9CrT0iNEoEK7nywTpJXmHbzADJEhhkbQTNUPfWFBzFSD/ptD71JABxme
    Gdvw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytISr6hZqJAw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d104::923]
    by smtp.strato.de (RZmta 48.1.1 AUTH)
    with ESMTPSA id ff3b6ay8PBjV386
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 25 Sep 2022 13:45:31 +0200 (CEST)
Message-ID: <3a7b3a29-837e-7362-50b1-72eb10e195ca@hartkopp.net>
Date:   Sun, 25 Sep 2022 13:45:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC can-next] can: remove obsolete PCH CAN driver
Content-Language: en-US
To:     Jacob Kroon <jacob.kroon@gmail.com>, linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Dario Binacchi <dariobin@libero.it>,
        Wolfgang Grandegger <wg@grandegger.com>
References: <20220924174424.86541-1-socketcan@hartkopp.net>
 <f9b37775-edd5-2a5b-18bc-b34bb69b8324@gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <f9b37775-edd5-2a5b-18bc-b34bb69b8324@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 24.09.22 22:24, Jacob Kroon wrote:
> On 9/24/22 19:44, Oliver Hartkopp wrote:
>> The PCH CAN driver is a driver for a Bosch C_CAN controller IP core which
>> is attached to the system via PCI. This code has been introduced in 2011
>> by Oki Semiconductors developers to support the Intel Atom E6xx series
>> I/O Hub (aka EG20T IOH PCH CAN). Since 2012 the driver only has been
>> maintained by the kernel community.
>>
>> As there is a well maintained and continously tested C_CAN/D_CAN driver
>> which also supports the PCI configuration from the PCH CAN EG20T setup
>> this driver became obsolete.
>>
>> Cc: Jacob Kroon <jacob.kroon@gmail.com>
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>> Cc: Dario Binacchi <dariobin@libero.it>
>> Cc: Wolfgang Grandegger <wg@grandegger.com>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   drivers/net/can/Kconfig       |    8 -
>>   drivers/net/can/Makefile      |    1 -
>>   drivers/net/can/c_can/Kconfig |    3 +-
>>   drivers/net/can/pch_can.c     | 1249 ---------------------------------
>>   4 files changed, 2 insertions(+), 1259 deletions(-)
>>   delete mode 100644 drivers/net/can/pch_can.c
>>
> 
> Given that the current PCH driver will lockup on my system I'm all for 
> removing it.

:-D

Yes, I'm very grateful that you support the discussion and that you are 
able to test the 'good' C_CAN/D_CAN driver on the EG20T until it works 
properly.

Your testing is the missing piece to remove the PCH CAN driver.

Many thanks!

Oliver
