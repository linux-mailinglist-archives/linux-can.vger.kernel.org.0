Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2A952EE23
	for <lists+linux-can@lfdr.de>; Fri, 20 May 2022 16:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbiETO0k (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 May 2022 10:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236974AbiETO0i (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 May 2022 10:26:38 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53274B847
        for <linux-can@vger.kernel.org>; Fri, 20 May 2022 07:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1653056689;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=DZGIQf736ZmBsPVa/n8ZV5IaWIYcV3C2yX9IOtZsTIs=;
    b=Cioo7DyvfmWdzqkv7oYr6NlBiRKR35+CHQay2q8kXX5bi+RXt1Il1//VKlgCUWZZ71
    mrls0N5M/uClXPKfz6rMi5E69UTJ5cqAfhiiFEntxFuiRtQdlv0d3LxRo7HYH7Jy1b3q
    ySATJeeDeXWz+nCsXr29RjnoUJIQsMI3t6CE4sHTwinBEIjHUB+zUlIEnW1rFxO6GITt
    PQNK+jbYy5zMw6UXnHRg0i1zT/2t/mqdkslvOKJhBWHQ/HehfmDsEB70oZ9Oich7ZKrP
    iMPmxL5B2fypZBpPKOtgJmQwdVBqVNqbyfWhb7yfjfx0nS5Xlg9/OJ0Iy/G39XAS9+r0
    8Pdg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdBqPeOug2krLFRKxw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cff:5b04::b82]
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id R0691fy4KEOjPBD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 20 May 2022 16:24:45 +0200 (CEST)
Message-ID: <0cb33596-dd1d-4536-a0c3-50f3592ca8c7@hartkopp.net>
Date:   Fri, 20 May 2022 16:24:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: PCH_CAN removal?
Content-Language: en-US
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-can@vger.kernel.org, Chee Hou Ong <chee.houx.ong@intel.com>,
        Aman Kumar <aman.kumar@intel.com>,
        Pallavi Kumari <kumari.pallavi@intel.com>,
        Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>,
        Masayuki Ohtake <masa-korg@dsn.okisemi.com>
References: <20220513130819.386012-1-mkl@pengutronix.de>
 <20220513130819.386012-2-mkl@pengutronix.de>
 <20220513102145.748db22c@kernel.org>
 <2637cf42-b7da-a862-c599-ce418645629b@linux.intel.com>
 <03e3db49-1e56-1e34-ba8d-72ca06019287@hartkopp.net>
 <29930b66-d02e-411a-d6f5-4f09119f3f1e@linux.intel.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <29930b66-d02e-411a-d6f5-4f09119f3f1e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Jarkko,

thanks for your fast reply!

On 20.05.22 14:48, Jarkko Nikula wrote:

> On 5/19/22 22:15, Oliver Hartkopp wrote:

>> As I do not have that hardware anymore it would be interesting to see 
>> if you could bring the PCH board to life with the C_CAN_PCI driver?!?
>>
>> That would allow us to remove the (then definitely) obsolete pch_can 
>> driver.
>>
> I'm afraid we don't have that HW either here locally :-(

Hm, sad. At least it was a try to get the pch_can removed ;-)

Many thanks & best regards,
Oliver

ps. to whom it may concern: the two mail addresses from the OKISEMI 
employees bounced at sending :-[
