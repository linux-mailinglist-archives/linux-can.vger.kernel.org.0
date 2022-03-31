Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2504B4ED3EE
	for <lists+linux-can@lfdr.de>; Thu, 31 Mar 2022 08:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiCaGa6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 31 Mar 2022 02:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiCaGav (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 31 Mar 2022 02:30:51 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57C4BB
        for <linux-can@vger.kernel.org>; Wed, 30 Mar 2022 23:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1648708139;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=T0L4VYVZLaFFemH3RgNU6etfgsudo2bq6wzlKRV0gXU=;
    b=bbI6vTKBMXPSw94S9YEtpOoW/HnpoZuLZYoaHtThPtwbNhl4IgXzVhlHX1XiCNuLHP
    EaNHtlXooI5V3rz1mRhAk98/RIZQlGyczMLrJRzjXr4EiQFf2SOeGRPZkycfoLbghc7b
    EzLQIY6tSjbEMrLOA1xN9K2OXSQZCeFK9CWsIsXnAsLxDa5yoAd0t6PY4ZTMz0d7kcz3
    kT08fPDage29/BvRE8VPX3tG2Ny6ozHv77ZQG3IRiQgXNaQV+oMFR7FmButb3Q72lW0B
    gYkVOTXc86XqENS0qDAiy6FcrDpO//NpGwi1xe2HgocSYrxqRgSOaZNSwf8/HFJGwCU2
    XAUQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdd0DIgVuBOfXW6v7w=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfa:f900::b82]
    by smtp.strato.de (RZmta 47.42.2 AUTH)
    with ESMTPSA id 4544c9y2V6Sx5YY
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 31 Mar 2022 08:28:59 +0200 (CEST)
Message-ID: <769900da-73e9-759e-345c-6f29483f5a3d@hartkopp.net>
Date:   Thu, 31 Mar 2022 08:28:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] can: isotp: restore accidentally removed MSG_PEEK feature
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Derek Will <derekrobertwill@gmail.com>
Cc:     linux-can@vger.kernel.org
References: <20220328113611.3691-1-socketcan@hartkopp.net>
 <20220328122239.sbp7k4pjydrld3qv@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220328122239.sbp7k4pjydrld3qv@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On 28.03.22 14:22, Marc Kleine-Budde wrote:
> On 28.03.2022 13:36:11, Oliver Hartkopp wrote:
>> In commit 42bf50a1795a ("can: isotp: support MSG_TRUNC flag when reading
>> from socket") a new check for recvmsg flags has been introduced that
>> only checked for the flags that are handled in isotp_recvmsg() itself.
>>
>> This accidentally removed the MSG_PEEK feature flag which is processed
>> later in the call chain in __skb_try_recv_from_queue().
>>
>> Add MSG_PEEK to the set of valid flags to restore the feature.
>>
>> Fixes: 42bf50a1795a ("can: isotp: support MSG_TRUNC flag when reading from socket")
>> Link: https://github.com/linux-can/can-utils/issues/347#issuecomment-1079554254
>> From: Derek Will <derekrobertwill@gmail.com>
> 
> If this patch is from Derek Will, we need Derek's Signed-off-by [1] and
> change to author information accordingly.
> 
> [1] https://elixir.bootlin.com/linux/v5.12/source/Documentation/process/submitting-patches.rst#L356
> 
>> Tested-by: Derek Will <derekrobertwill@gmail.com>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> If Derek replies to this mail with his S-o-b line, I'll fix the author
> while applying the patch.

Although I would have liked Derek to show up as author of the patch 
(because of he found the issue) he has not been reacting for some time now.

Therefore I would suggest to take the authorship (I wrote the commit 
message anyway) and tag Derek with
Reported/Suggested?/Tested-by if you do not want to wait to push the 
other pending patches to Jakub.

Best regards,
Oliver
