Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E1652DD9C
	for <lists+linux-can@lfdr.de>; Thu, 19 May 2022 21:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242811AbiESTRX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 May 2022 15:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiESTRW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 May 2022 15:17:22 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA70887A00
        for <linux-can@vger.kernel.org>; Thu, 19 May 2022 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1652987727;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=V4pYoa0R6VOMWu04EbyMKXhgcxYqllXavCuCHqVcp+A=;
    b=jSewXsui7r0XZcGmEOj6pIxTb6gd6LkUQAdTAGZkmuN+R3emsTokb1PpyqGceS8RiG
    4szTnnF5okIJy2SdsVJoctTw6G0BzlIJz+fmQN4enma+QyNSf8H3A42y6V9bz7bh09is
    H6/4e1P3mD5BqIm17k6XOWW1/2uq5aFdXGs7f9vKqD4BFONDYZdNWyYsfS7RiLeF6Wqj
    hUDjobulbnke5S7Hty6q6kHxty7igtm9htnqgY9ztP0X2doA5skBE5bq/iRXgTwuFc7w
    rBP/iNmc/NrWMz68R/eZNCPSqg4fXeIhWaExPEVaavF0JM8Dt3au1is23pJ3zL2TaX0k
    xfRg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdBqPeOug2krLFRKxw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cff:5b04::b82]
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id R0691fy4JJFNMK0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 19 May 2022 21:15:23 +0200 (CEST)
Message-ID: <03e3db49-1e56-1e34-ba8d-72ca06019287@hartkopp.net>
Date:   Thu, 19 May 2022 21:15:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: PCH_CAN removal?
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
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <2637cf42-b7da-a862-c599-ce418645629b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Jarkko,

I'm very happy to see that you are cleaning up some custom M_CAN stuff 
which turns out to be already supported ;-)

In fact there is a pch_can (PCI) driver which was used in an Intel 
embedded setup "Topcliff PCH" ~11 years ago. The driver was originally 
contributed by OKI.

And I was pretty sure that this driver implements a C_CAN IP core with a 
PCI binding which is now implemented in the C_CAN_PCI driver.

As I do not have that hardware anymore it would be interesting to see if 
you could bring the PCH board to life with the C_CAN_PCI driver?!?

That would allow us to remove the (then definitely) obsolete pch_can driver.

Thanks & best regards,
Oliver
