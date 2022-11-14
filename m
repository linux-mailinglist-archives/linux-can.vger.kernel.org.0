Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662D6628823
	for <lists+linux-can@lfdr.de>; Mon, 14 Nov 2022 19:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbiKNSRu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Nov 2022 13:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbiKNSRc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Nov 2022 13:17:32 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000F84E422
        for <linux-can@vger.kernel.org>; Mon, 14 Nov 2022 10:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1668449745;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yQYoyyZ9wr/PHCTFVacEvDGJiMv21d/b6N8NKikBY8c=;
    b=HUH9b8FCTARP4nlzHzRm2Tjlt/975h90MLqlGhN41rtmBhBjwUDAlEPMS12qp2xQu1
    b4kNt+VVRyn/KQHOm0/YF1NI5oVLfUlumdblWmPMB/zR7AWQFDLamE9kUGPI/Qw9AiVB
    6XIbzwA3kPTjhMu7APAHSY9lgBfGQYaX0aARr2MW7Q96TIO65uJPSb34kY5Py+Q2Oyay
    /94YMb+oLKqeiLIYxwChpTx7o0AIzNt7hjGggVdvicGQmOwBiK9wyf3OG838Y1c+yrrb
    ZqaqX/eBD6gSaSacdzTRoS1Xx2F6UqoLBh41S7yQ9nIupyTfPnQTEdT80cjC336Ei4HV
    adMw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytISr6hZqJAw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d104::923]
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id Dde783yAEIFjqIg
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 14 Nov 2022 19:15:45 +0100 (CET)
Message-ID: <029a36e3-10de-ff85-21fb-fb9c1e93e740@hartkopp.net>
Date:   Mon, 14 Nov 2022 19:15:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH can-utils-dev v3 0/6] can-utils-dev: a set of update and
 cleanup patches
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
 <20221114163848.3398-1-mailhol.vincent@wanadoo.fr>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20221114163848.3398-1-mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 14.11.22 17:38, Vincent Mailhol wrote:
> This series contain cleanup patches and update of header files. There
> is no real relation between each patch (aside of 2/6 and 3/6 which
> form a pair) so I will end the cover letter here and let you refer to
> the short description.

Nice cleanups.

Thanks Vincent!

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

> 
> * Changelog *
> 
> v2 -> v3:
> 
>    * reorder the patches so that related changes are next to each
>      other (especially patch 2/6 and 3/6).
> 
>    * patch 2/6: new patch to update include/linux/can/error.h with the
>      latest hearder from Linux 6.0.0.
> 
>    * patch 3/6: do not use an #ifdef anymore and make sure that the
>      code still work if run on old kernel version lower than 6.0.0.
> 
>    * patch 6/6: rewrite commit description to point out that there is a
>      local copy of the linux headers under include/linux/.
> 
> v1 -> v2:
> 
>    * patch 2/5: add a note in commit message to explain that slcanpty.c
>      debug is deactivated by default.
> 
>    * patch 2/5: make the compiler check the pr_debug() syntax even if
>      debug is off.
> 
>    * reorder the patches so that the lib.c and the candump.c patches
>      are next to each other in the series.
> 
> Vincent Mailhol (6):
>    slcanpty: remove redundant asc2nibble()
>    include: update linux/can/error.h
>    lib: snprintf_can_error_frame: print counter errors if CAN_ERR_CNT is
>      set
>    lib: add pr_debug() macro
>    candump: add global variable progname
>    candump: use linux/net_tstamp.h instead of redefining values ourselves
> 
>   Makefile                           |  2 ++
>   canbusload.c                       |  9 ++---
>   candump.c                          | 58 +++++++++++++-----------------
>   canlogserver.c                     | 12 +++----
>   include/linux/can/error.h          | 20 ++++++++++-
>   lib.c                              |  2 +-
>   lib.h                              |  7 ++++
>   mcp251xfd/mcp251xfd-dev-coredump.c | 10 +-----
>   slcanpty.c                         | 27 +++-----------
>   9 files changed, 67 insertions(+), 80 deletions(-)
> 
