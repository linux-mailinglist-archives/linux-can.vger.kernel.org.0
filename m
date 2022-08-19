Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B8E599AF7
	for <lists+linux-can@lfdr.de>; Fri, 19 Aug 2022 13:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348492AbiHSLXg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Aug 2022 07:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348684AbiHSLXf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Aug 2022 07:23:35 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA422C654
        for <linux-can@vger.kernel.org>; Fri, 19 Aug 2022 04:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1660908209;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=JIAO0JBtaDIRSqDY6VNP7bDNvJXbC6Tx/2Ki0WWcYU4=;
    b=RyJS1Xamy9JSbKiwXXiAFIkYOFUb6AaMGBg7BUqzt1qgcZeMcw+zyAwq67rPULJ/Sg
    oWKlMi42ZXY99YkXrMYrCFMRdmw9zJjFd1lMHn6ixN3tOXrqTIj1/DDak+qoh4mQGt5b
    EvahwXC0hztQHwq8OkDrI8czFzGYbx6HoZv/aAcRQ0B/eIECTphsJ7XdnvcPKMlP63kw
    I06pLcvR37Y8xV2oom3tj7CF2y53HG4WqGAz1qS9rp5koG6Z/bi45PvZJ5jPbc0i1UP5
    wV/1pAxVy7YZN9XGjiiwc9g9PumAq1c9qRXG2jfjOkgZjKJ038gSvGph1l3ySi/iBlmF
    8qvQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr6jW1T+A=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::1e4]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id Icb1b0y7JBNTz5O
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 19 Aug 2022 13:23:29 +0200 (CEST)
Message-ID: <04b05aa5-e926-1050-b1ed-e5ad99a23722@hartkopp.net>
Date:   Fri, 19 Aug 2022 13:23:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4 6/6] can: sja1000: Add support for RZ/N1 SJA1000 CAN
 Controller
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20220710115248.190280-1-biju.das.jz@bp.renesas.com>
 <20220710115248.190280-7-biju.das.jz@bp.renesas.com>
 <20220819084532.ywtziogd7ycuozxx@pengutronix.de>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220819084532.ywtziogd7ycuozxx@pengutronix.de>
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

Hi Marc,

On 8/19/22 10:45, Marc Kleine-Budde wrote:

> 
> Applied to linux-can-next.

net-next has been rebased to 6.0-rc1 some house ago.

Do you have any plans for the CAN XL support for linux-can-next?

So far there has been no new feedback for a while.

https://lore.kernel.org/linux-can/20220801190010.3344-1-socketcan@hartkopp.net/T/#t

Best,
Oliver
