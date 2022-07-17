Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9605A57767B
	for <lists+linux-can@lfdr.de>; Sun, 17 Jul 2022 15:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiGQN6a (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 17 Jul 2022 09:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGQN6a (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 17 Jul 2022 09:58:30 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93BB13E10
        for <linux-can@vger.kernel.org>; Sun, 17 Jul 2022 06:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658066306;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=YYF00X6cHgKX/M/hCWScFyeiUOGaLRLam0CKzbZ9Y10=;
    b=LCIkAZTuKRngy/ZBVmukx4GjN0q2h8TMnYvLhDTwkYDDJIAhPnSKfDJl0ZA1LxEAWO
    52BYzk+VdfJ8rQe2E35UrWpYA6joUkmUfDIFotw0Wj1GMDB+OY2W5UHyNpueTpwMhwan
    2Q8Xpz7oOW6qeR4V1umeRGiSbRmSqFCT+qEBoc3wE6546s+JghNjF8JcGhzZG1/Zt5m9
    bTmgiUmsQaHFutYw64KGEnH7801YIXnYzK8Otd5vb9q7+pzb0xlZfori6qMAkaDbca3G
    ztY4eXMcNy0174KTgpPE24owf+lQV9regiKI9c5SReTvqIVqxhNP5g70m3Rq2LBhUIWx
    xapA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6HDwQB9E
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 17 Jul 2022 15:58:26 +0200 (CEST)
Message-ID: <2d6d9627-bc98-07e9-dbcb-5f317913f5aa@hartkopp.net>
Date:   Sun, 17 Jul 2022 15:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [linux-next:master] BUILD REGRESSION
 4662b7adea50bb62e993a67f611f3be625d3df0d
Content-Language: en-US
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-can <linux-can@vger.kernel.org>
References: <62cf77c3.3T/sxYUjJq0ImGp4%lkp@intel.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <62cf77c3.3T/sxYUjJq0ImGp4%lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Dario,

did you see this build regression too?

On 14.07.22 03:56, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: 4662b7adea50bb62e993a67f611f3be625d3df0d  Add linux-next specific files for 20220713
> 
> Error/Warning reports:

(..)

> drivers/net/can/slcan/slcan-core.c:601:14: sparse:    void *
> drivers/net/can/slcan/slcan-core.c:601:14: sparse:    void [noderef] __rcu *
> drivers/net/can/slcan/slcan-core.c:601:14: sparse: sparse: incompatible types in comparison expression (different address spaces):

Do you take care on this one?

https://lore.kernel.org/linux-can/20220717025703.pcrf6bseaigsq22r@revolver/T/#m54028de8868a0f653294f6a272a9094378a1cdd7

Best regards,
Oliver
