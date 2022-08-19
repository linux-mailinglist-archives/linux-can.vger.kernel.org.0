Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD905599B1C
	for <lists+linux-can@lfdr.de>; Fri, 19 Aug 2022 13:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348394AbiHSLmR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Aug 2022 07:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347621AbiHSLmQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Aug 2022 07:42:16 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FFEFF23F
        for <linux-can@vger.kernel.org>; Fri, 19 Aug 2022 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1660909333;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fal5acGpwOpl7CwjMjKb9Ud6aSPkIXSqryL888rMT2o=;
    b=gFoZ6HMD1BOuIoRlVaQlrnw+IkJT70V7Ra9z4PnLn5F//B2rnDd/ObqwqGgV4o0U7b
    V9t7X03HSNC+VVoMQNE184+Ng/KG0Sser7rBkvjOwGHmsmhJDLOUny3NNBkajZ1dzK6j
    U71F8INuq/ca7NJsr35yFx9a/n3FIxDZreL3aGsLZoBhxXIV9p9JS7ruyVDiCDkvNO2P
    /mjD+revJ/OlQt9GthrqQ9LdCSaAGoAKtISWUNRiNI8jOkX/i6aQj8esuvLf6gvcJ7St
    2PzAd6jVCXdBXbUULPR8tA5KxPUthiQDa6kqujzbaXjJJx9rcR1dCc9P4NWvIaKwQ80j
    hh7Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr6jW1T+A=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::1e4]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id Icb1b0y7JBgDz8X
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 19 Aug 2022 13:42:13 +0200 (CEST)
Message-ID: <247226f6-b9b5-ec47-2234-d1cc70ee6954@hartkopp.net>
Date:   Fri, 19 Aug 2022 13:42:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4 6/6] can: sja1000: Add support for RZ/N1 SJA1000 CAN
 Controller
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20220710115248.190280-1-biju.das.jz@bp.renesas.com>
 <20220710115248.190280-7-biju.das.jz@bp.renesas.com>
 <20220819084532.ywtziogd7ycuozxx@pengutronix.de>
 <04b05aa5-e926-1050-b1ed-e5ad99a23722@hartkopp.net>
 <20220819113023.xk2yz6qqbq74albs@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220819113023.xk2yz6qqbq74albs@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 8/19/22 13:30, Marc Kleine-Budde wrote:
> On 19.08.2022 13:23:22, Oliver Hartkopp wrote:
>> net-next has been rebased to 6.0-rc1 some house ago.
>>
>> Do you have any plans for the CAN XL support for linux-can-next?
>>
>> So far there has been no new feedback for a while.
> 
> I want to have Vincent's Ack for the series, but he's on vacation. I'll
> be on vacation the next 2 weeks... I think I'll merge it when I'm back
> to give Vincent time to look at the series.

Hm, I think he was done with the review and his last remark was a simple 
typo (and my rebase) which lead to V8.

But there should be no big hurry on this to catch the current merge 
window. Two additional weeks for reviews should be ok.

Are there any additional remarks from your side?

Best,
Oliver
