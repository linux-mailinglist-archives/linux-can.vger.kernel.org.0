Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE76457EECE
	for <lists+linux-can@lfdr.de>; Sat, 23 Jul 2022 12:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbiGWKdd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 23 Jul 2022 06:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237288AbiGWKdc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 23 Jul 2022 06:33:32 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46EC1A3BA
        for <linux-can@vger.kernel.org>; Sat, 23 Jul 2022 03:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658572408;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=U8pZM70YWE6rtRGZxDj+uaCVmctQvsV2p9l/O+Q3wV4=;
    b=rpVX84jQLdXt0DasGng0stTGgQVLqUpQTM0Loj92mhfU+f/SBba/FIj90NXfwX6A4q
    9agrGilqbu+I80N+9yOp0R3C0yAzOSr3j7fsDQ0Kr+6QR8DGKJoPafPXNd1w/JsKLem/
    yaWLu3ufTftFQQs5zMf0OC+28Jj+LGjAmO01eTynTROVE77SP1Mg3Qo4lumJptDufgen
    /0UMbtltznvxb9ILO4pD+UaxuXBW8m5JHHQaylUW1HApFumE16awKZjPEOU+IeqqrkL2
    lQ5TaFr2DW8TeLAmEYJqpW4x8sXc2Z2y3cCXkifRripEo6PkXIIYQFGVYnAmUUpexP8Q
    oFeQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id jdcffay6NAXS7Yp
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 23 Jul 2022 12:33:28 +0200 (CEST)
Message-ID: <d5a58f83-3aca-9d05-66d5-153909a6e389@hartkopp.net>
Date:   Sat, 23 Jul 2022 12:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
References: <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net>
 <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
 <cee555a2-2883-9dab-5740-62849e9ee3ab@hartkopp.net>
 <20220721075309.l6uusnyk7xjkqd4g@pengutronix.de>
 <CAMZ6RqJTZ4o3dsaYG2s9boJ4By7QC55-N+0RszT9LNxRp3bYuA@mail.gmail.com>
 <ea8ffea6-1065-8526-4774-16d088ec7bf1@hartkopp.net>
 <CAMZ6Rq+NWFc4KmhCCpJ2LzTt8ap1U_FLrQ1L1RQgYNT0BD3w_Q@mail.gmail.com>
 <20220722072731.s3s7bkfn33zzzeni@pengutronix.de>
 <CAMZ6RqJcUtSyYbYnqAE87hrwL1G+cxGLKAZ_E4kvSW3Mq43tYg@mail.gmail.com>
 <20220722095853.jb3ko4qsktud5uob@pengutronix.de>
 <CAMZ6Rq+GZTifSLqO6V_wErtx5U932cnTO2ktMSjnq_ybPCx91Q@mail.gmail.com>
 <0046f0e1-0bd4-0add-7759-ed459fd050fb@hartkopp.net>
 <CAMZ6RqKn7W26LwaJmdJ-1cpF7bZScHEcUiscLjtGNbAd=1_OeA@mail.gmail.com>
 <e4e74603-5db6-04bd-295e-2b20c96c39e7@hartkopp.net>
 <CAMZ6RqLD-B87LN_1a2zhuPuPX1nENiDQQi+b34V9c-KP1gwtsg@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqLD-B87LN_1a2zhuPuPX1nENiDQQi+b34V9c-KP1gwtsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 23.07.22 04:39, Vincent Mailhol wrote:

> This debate is going to a dead end. I do not see one of us fully
> convincing the other. As I stated before, the data[CANXL_MIN_DLEN] is
> not bad and has the big merit of allowing static declaration. While my
> preference definitely goes to the flexible array member, I will not
> veto your idea. I think it was important to have this debate.
> With that said, I leave the final decision to the mailing list. If
> other people prefer the data[CANXL_MIN_DLEN] over the flexible array
> member, or if no one other than the two of us care, then let's use
> your approach!

Thanks Vincent!

I really think it is the right approach to maintain the current CAN_RAW 
API patterns for all CAN flavours. It provides consistency for 
programmers and tools and really only affects the CAN_RAW socket.

When it comes to Ethernet traffic encapsulation inside CAN XL this can 
be seen as a break to the CAN stuff and I wonder if we should create 
another 'Ethernet like' network device then.

E.g. an Ethernet device, that is able to handle/convert ETH_P_CANXL 
frames and offers additional attributes (setting the prio and defining 
the CAN XL encapsulation schema etc). This will kick us into the 
Ethernet world with all the common APIs - and will definitely fuel a new 
and interesting discussion ;-)

Best regards,
Oliver



