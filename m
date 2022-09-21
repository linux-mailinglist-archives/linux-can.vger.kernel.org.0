Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDC65BFCB4
	for <lists+linux-can@lfdr.de>; Wed, 21 Sep 2022 13:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIULA4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Sep 2022 07:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIULA4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Sep 2022 07:00:56 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76BD95685
        for <linux-can@vger.kernel.org>; Wed, 21 Sep 2022 04:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1663758052;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5S4Nhou4IOvEiNXSHWQw7c14gLWAG+ZA0BeW2TCXNMI=;
    b=O2HeNX49WcIkNX7zHohPB2UAn1DW3YLF/A2Fu0CaU40SJBq665TzMhRPTScgxnUjqI
    iipI++obCNtJhkhA0kt9PxHwZPYPmBdhRupUf/ubySluL7kmkdvRPn22zC8Wl74EMDcW
    3RXaeVSJjO8Db+8iyLGnqOSB9b7Q4+OkWJiF48g/iYrdg+e0cKrY1fyP2wcxQHknlTpr
    a0IygLObqpPSCWKkn799hNZgXdtJWu8zrtCX787j7e/CPRtD5Nbjoy9Oz1f14U4MHThc
    UlllaGszWVVB45sb3iGE9Z8q+cnZ+E+Abg4acXfoN8+EhbYdR7UvcqAspjOUef7CpKIl
    1m4w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr6hfz3Vg=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::923]
    by smtp.strato.de (RZmta 48.1.1 AUTH)
    with ESMTPSA id 0e791ay8LB0q3g6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 21 Sep 2022 13:00:52 +0200 (CEST)
Message-ID: <2ff63f6f-a952-9ead-91a4-a98ad4c3a7ca@hartkopp.net>
Date:   Wed, 21 Sep 2022 13:00:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     dariobin@libero.it, Jacob Kroon <jacob.kroon@gmail.com>,
        linux-can@vger.kernel.org, wg@grandegger.com
References: <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
 <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
 <02aeeca7-5958-60f1-3011-fa3aae4ef6b5@gmail.com>
 <541998938.482927.1663745141832@mail1.libero.it>
 <20220921074741.admuodnlv4yexfwr@pengutronix.de>
 <fb1f38e6-c95c-5847-2ebf-16fd8bc2db94@hartkopp.net>
 <20220921103259.5x5zf5fwxqnm56nd@pengutronix.de>
 <f44c183a-f5f4-abe8-2dd9-47f6abb223e2@hartkopp.net>
 <20220921105351.peoyk2a64ayd27gj@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220921105351.peoyk2a64ayd27gj@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 21.09.22 12:53, Marc Kleine-Budde wrote:
> On 21.09.2022 12:39:06, Oliver Hartkopp wrote:
>>
>>
>> On 21.09.22 12:32, Marc Kleine-Budde wrote:
>>> On 21.09.2022 11:55:59, Oliver Hartkopp wrote:
>>>> Btw. I uploaded the 'latest' C_CAN manuals on
>>>>
>>>> https://github.com/linux-can/can-doc
>>>>
>>>> ... as it could only be found on archive.org :-/
>>>>
>>>> Unfortunately I was not able to find any (latest?) D_CAN manual anymore,
>>>> which was originally hosted at http://www.semiconductors.bosch.de/media/en/pdf/ipmodules_1/can/d_can_users_manual_111.pdf
>>>>
>>>> Archive.org did not crawl this PDF ;-(
>>>>
>>>> If someone still has this D_CAN PDF please send a URL or the PDF itself to
>>>> me, so that I can put it there too.
>>>
>>> I've found some old stuff on https://www.yumpu.com/user/bosch.semiconductors.de
>>>
>>> You've got PR:
>>> https://github.com/linux-can/can-doc/pull/1
>>
>> Pulled.
>>
>> Excellent contribution! Thanks Marc!
> 
> Doh! I accidentally committed the readme of your M_CAN history repo.
> I'll force push the master to get rid of it. OK?

NP. Just go for it ;-)
