Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDDB591120
	for <lists+linux-can@lfdr.de>; Fri, 12 Aug 2022 15:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiHLNBR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Aug 2022 09:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237763AbiHLNBK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Aug 2022 09:01:10 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B03EBF6E
        for <linux-can@vger.kernel.org>; Fri, 12 Aug 2022 06:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1660309264;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=pv/04JOHmnnt9Fz5gqeA8XzdCFIbtEMvbrlKlT516O0=;
    b=Qnlnn3Ev/dQL2O7XfrfzUs3UIuZ1s1aYCzNNn9roujI14WAUzw1DFkNRE7e+CYfDH4
    xIasHkgL8K+4DOGWtL/MhEYEWpIK8EcZA5ftCK7NDbcH+Rp41ipbWV6WfGNVyk27DX2a
    IscZL0PooH4yWwdkZxRdntLHzDP1eSrW/GGsEijpP78VvkvSZMI4lBfBL52EcTqb9rR4
    OtwYSvwsCk/vDWjJSZq4YI39GqkI3uqwTXkFJ6p2ph50LleLRaEuSuUvpSophq7gNv5J
    SQEaOb7rQQn+3X2fKIygaIsCFP7+7025CMWKs27CSMpsr059SGNcY85PsSO3cG9SiWYl
    D2Kw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id Icb1b0y7CD14j9c
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 12 Aug 2022 15:01:04 +0200 (CEST)
Message-ID: <86dffcf2-e79d-e32a-bdcf-404ee8f7dd22@hartkopp.net>
Date:   Fri, 12 Aug 2022 15:00:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: PCAN and SocketCAN Questions
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        David Boles <me@davidbol.es>
Cc:     Tom Evans <thomasaevans@optusnet.com.au>,
        linux-can@vger.kernel.org, s.grosjean@peak-system.com
References: <CAMgOUGpGEUQgLgAQmYbn-UdWXCkC7kRqdhW-mfg=e2gq9QfqRQ@mail.gmail.com>
 <20220810074530.or6oecnm7obmm7rh@pengutronix.de>
 <CAMgOUGoKHJnA5KLBE5_txgEBnC6LU3zNKkok7QEiMcrwQc0TvA@mail.gmail.com>
 <20220812123749.zqqn4kico5zai5ql@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220812123749.zqqn4kico5zai5ql@pengutronix.de>
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

Hello David,

On 12.08.22 14:37, Marc Kleine-Budde wrote:
> On 11.08.2022 13:17:47, David Boles wrote:

>> Unfortunately it seems like this is happening at the layer of
>> individual sockets. Candump was already printing out messages that I
>> was "losing", and adding the -d flag doesn't affect its printout
>> (presumably since from its perspective, they haven't been dropped).
> 
> See the code that the "-d" command line options activates :)
> 
> | https://github.com/linux-can/can-utils/blob/master/candump.c#L650
> 
> ... and add this to your app.
> 
>>> Run your program at a lower NICE value
> 
> You can try to receive several CAN frames with recvmmsg().
> 
>> Good idea!
>>
>>> Make the queue as big as you can.
> 
> I the socket drops CAN frames, this means there's not enough CPU time
> for your app to receive them all. You should look at your system and
> find out where the CPU time is lost.

All these measures seem to be the last solution when nothing else helped.

Can you probably tell me more about your use-case?

1. e.g. when you are using the CAN_RAW socket: Do you set CAN filters to 
pass only needed content into userspace?

When you drop 50% of the CAN IDs in userspace you still have to transfer 
them from kernelspace to userspace and check if you should drop them.

2. when you need to filter for updates in specific content in the CAN 
frames data[] section the CAN_BCM socket is your friend. Especially for 
cyclic sent CAN messages e.g. in automotive use-cases.

3. When you need to forward and/or modify CAN frames between CAN 
interfaces there is a special netlink-based in-kernel CAN-Gateway which 
can be controlled by the 'cangw' tool.

The last time I had your described issues, I was routing CAN frames via 
userspace - which finally led to the implementation of the can-gw module ;-)

Best regards,
Oliver


