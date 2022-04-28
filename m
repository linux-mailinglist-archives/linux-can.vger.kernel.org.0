Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC675512C3D
	for <lists+linux-can@lfdr.de>; Thu, 28 Apr 2022 09:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbiD1HJK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 28 Apr 2022 03:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240590AbiD1HJK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Apr 2022 03:09:10 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA9319C36
        for <linux-can@vger.kernel.org>; Thu, 28 Apr 2022 00:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1651129552;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gjMVKWo8T0ZiUhXpnw4rA0T2dfqFQbh74jO+NzCJyaw=;
    b=THwm93U1YMGjkcxdxXopQsNp2OLTJB/5hOSWXi+h3nMSAMaMrmHkz+YiCc7nHXeEmQ
    EBcVWGPnBe26zdMDmNebGDl3EeG9EUmTo0/kKD3noz14/unhQkFQudjNPtYX0mKTMKoR
    kaKQXyi8yirfvhebSdVAyzbtfGAR3G0UqgmeoDs/h5Hv6GMlWJcesZ+QKqgLupGrgCPh
    GyHoY7ZY7upiBz2Hmh7dm2NZHaAs9gGMVHNVkcGaLps7T4nzKP77Dcd4ULtbumj+4UWO
    XlTgwdqI4ppBhC7JpIubDsw6VfWvK7Bx+fB6NrT20/Kbsja2SDBW/cJogBQKsziBta+p
    26Rg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdBqPeOuh2krLEWFUg=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cff:5b00::b82]
    by smtp.strato.de (RZmta 47.42.2 AUTH)
    with ESMTPSA id 4544c9y3S75qOB0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 28 Apr 2022 09:05:52 +0200 (CEST)
Message-ID: <4634b8c7-c0c8-2d8e-9d95-2d6c75b9b164@hartkopp.net>
Date:   Thu, 28 Apr 2022 09:05:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] can: isotp: remove re-binding of bound socket
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20220422082337.1676-1-socketcan@hartkopp.net>
 <20220428065441.r4vmbpr5gs3efv2e@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220428065441.r4vmbpr5gs3efv2e@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

[x] can+stable please!

Many thanks,
Oliver

On 28.04.22 08:54, Marc Kleine-Budde wrote:
> Hello Oliver,
> 
> On 22.04.2022 10:23:37, Oliver Hartkopp wrote:
>> As a carry over from the CAN_RAW socket (which allows to change the CAN
>> interface while mantaining the filter setup) the re-binding of the
>> CAN_ISOTP socket needs to take care about CAN ID address information and
>> subscriptions. It turned out that this feature is so limited (e.g. the
>> sockopts remain fix) that it finally has never been needed/used.
>>
>> In opposite to the stateless CAN_RAW socket the switching of the CAN ID
>> subscriptions might additionally lead to an interrupted ongoing PDU
>> reception. So better remove this unneeded complexity.
>>
>> Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Which branch should I apply the patch to?
> 
> [ ] can
> [ ] can+stable
> [ ] can-next
> 
> regards,
> Marc
> 
