Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB8C55B130
	for <lists+linux-can@lfdr.de>; Sun, 26 Jun 2022 12:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiFZKcM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 26 Jun 2022 06:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiFZKcM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Jun 2022 06:32:12 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE47511C2F
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 03:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1656239525;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CmID4ccbgRg69ACSmp645gUPfpshAZhyir/i3+IukZI=;
    b=ldXTy6u6f4ujQ/NCs5c9bga1LTqG4cBB/0yhECtSOC+4ifTFkDy95V4haJV/Dwja1o
    zPTIlYAIkClLZ7kZlxn1oXhfxPaoSoItpuzxZfonsFjY8B/TiWFx55IShaVdzC4hGy0Z
    qmnNInHIIA57CypEd1wOWFHWlEhB33TQVj85eLRr8QOYSpFs+vCAEME6/4YyMElyxW/t
    HlF/vKk4ZSUvTxGi6PunZcgJuKDk29RCc5lB9nKB+REDN6ksIfw6nQjENbVbg4TgQZRH
    nDRIVSruQ2xtU3z/TBIdDyMTBXRRXrgqIB/bbKz9qvmPkKHiJnWEATFWTKcgaRvG2dmF
    GSbA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdBqPeOuh2krLEWFUg=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cff:5b00::b82]
    by smtp.strato.de (RZmta 47.46.0 AUTH)
    with ESMTPSA id e45609y5QAW54cN
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 26 Jun 2022 12:32:05 +0200 (CEST)
Message-ID: <7640a651-80c8-cfe8-c6bd-0b0d60ee3c2a@hartkopp.net>
Date:   Sun, 26 Jun 2022 12:31:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH] can-roundtrip-stats: a tool to benchmark transmission
 time
Content-Language: en-US
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Rhett Aultman <rhett.aultman@samsara.com>
References: <20220626075317.746535-1-mailhol.vincent@wanadoo.fr>
 <20220626090744.pycu3katdt6vir2l@pengutronix.de>
 <CAMZ6RqLVKMznm_n4j079rcYLjhj8QjmeM3=bYUeXm_rozmQNVg@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqLVKMznm_n4j079rcYLjhj8QjmeM3=bYUeXm_rozmQNVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 26.06.22 11:54, Vincent MAILHOL wrote:
> On Sun. 26 juin 2022 à 18:10, Marc Kleine-Budde <mkl@pengutronix.de> wrote:

>>> My ultimate goal was to add the TX timestamp feature to candump from
>>> can-utils [3], however, I faced a blocker: the TX timestamps are sent
>>> to the error queue of the sender's socket meaning that a listener
>>> (such as candump) will not see those TX timestamp on his error queue
>>> because this is a different socket as the sender. If anyone knows a
>>> method to access the error queue of another process's socket, let me
>>> know (I guess that you need to be root, but did not find how to do
>>> it).
>>
>> I don't think there's an official way to read the TX timestamps (i.e.
>> error queue) of a socket that's outside of your process.
> 
> What I was thinking is that tools such as tcpdump are able to get TX
> packets of ethernet interfaces even if not normally visible (because
> contrary to CAN, there is no default loopback). I was wondering if the
> same could be done with error queues, but as you can guess my research
> did lead anywhere. I also guess there is no official support but then,
> I am wondering how hard it would be to hack the error queues to expose
> them to the privileged processes.

I wonder whether error queues are the right mechanism or if control 
messages needed to be extended here - like for (hardware) rx timestamps.

E.g. the packet socket can access the vlan tag with a control message. 
And when there would be a such a message for tx timetamps we could 
create an identical cmesg API that could be used by CAN and PACKET sockets.

>>> Because I did not manage to add the feature to candump, I am sharing
>>> instead this standalone tool, hoping someone might find it useful.
>>
>> I'm not sure which is the best tool to add this to...cangen,
>> cansequence. Maybe evolve these tools into some kind of CAN ping
>> command.

cansend and canplayer would be candidates for such a feature too.

Best regards,
Oliver
