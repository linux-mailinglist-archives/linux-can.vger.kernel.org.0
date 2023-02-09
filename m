Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71788690F95
	for <lists+linux-can@lfdr.de>; Thu,  9 Feb 2023 18:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBIRxz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 Feb 2023 12:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBIRxy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Feb 2023 12:53:54 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1442823C
        for <linux-can@vger.kernel.org>; Thu,  9 Feb 2023 09:53:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675965223; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=H9UvHLgVgVqkN1mF8iwiYrQk8k2TEE/6EnH7gY4+6v9w85/jgkhKs+ITvefZjycWKT
    FDa32anGZ0B/2qUiYfm9Uwlgh1l9Soywqk8dYNFuVkzhUKS1597Z1SlYZ+8xrCfOLRWc
    wGiKcYWKUFRGjBpQhLexaF8xNLY4sReDZxxjGTBXqIEZGhkPgDYlJhzdHPv6bIdi4fDo
    Xck3e7C1lk0dZoUpN41a8O+iUOHCrX9XGnK4PFBgNMLFJmA4wwU7MhtOlr5hWzJ5Z/oo
    vWYPJzQAxhoovFsL7iBN7t74ssnFtntRWEV/hroRN6ESeerdPWveTeWvSdW2KOZ4gOrx
    /7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675965223;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=PKaIWHIXEoMvioFYX+JCKtiVBpCRElshAzmZx2SGw+g=;
    b=fSRmb0Hz0ZaqEti868oYbK7tEgqR/1rNnxwM0TH87YLStsMb858LlyMwq1KIn65rUD
    XtzRXT4WebEvKWQHzWOLIwMKRtN2/cY6pDusV96kvv3InDdWk0oCriBbNH2mRwHJUp0h
    ede6VDGtSBQ3oALuYkZ/8rLOaRndBqoXZfwzJGfwJWCS25S8dvQO4sUp9LJCH3/zZiOl
    HHLVmhZU5p6GqYRfHuDDljfscxtkrHdRaclo+1xWH/RjDybf3tzhyyppXwdlqFoHydmI
    T38is0oP3nwOAFVY3kbCp5Ke1x3s4QGKhMTMTax8yKDWPPElRza8xQCkagP5ECEAxAOU
    WinA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675965223;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=PKaIWHIXEoMvioFYX+JCKtiVBpCRElshAzmZx2SGw+g=;
    b=jU37Ay8D/1EOfxgkipPb/DKY0f/DxV3t7A1dz04byckq02NVRX8hsx92HNGDmzhx8P
    aTBREWjr8A0ftgztUT5PsNYD7ewoP07cFCnpsZARha/eCOXYH1f08cmn9811Fs/GeyRN
    ZYN9othhR4hOTFuTH5W/TfZC4LEtsgf2ogBj8IdllZ3QhtNl7N/0/QwhKZftpjBDWBed
    X6wqGAJlIAPFSEzWrJMk5Sxb7GU2QskTUNsGUWqKGe6nwfp/pyOvhed/wrhsgFHgoApC
    4Fxpe28hAj84ULCvLAVBKawMs2VzKavkcE+RwVxUajOyoz422kdnsT6BZi8x7HfzROyJ
    A7QA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbVLYqA=="
Received: from [IPV6:2a00:6020:4a8e:5000::83c]
    by smtp.strato.de (RZmta 49.3.0 AUTH)
    with ESMTPSA id x84a76z19Hrh8At
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 9 Feb 2023 18:53:43 +0100 (CET)
Message-ID: <a2256c85-4253-dff5-fa8e-00fc02916095@hartkopp.net>
Date:   Thu, 9 Feb 2023 18:53:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: xlinix_can: bug when sending two RTR frames
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        hsweeten@visionengravers.com
References: <94e3c5bc-6af9-f240-86fa-2b780a58533f@hartkopp.net>
Content-Language: en-US
In-Reply-To: <94e3c5bc-6af9-f240-86fa-2b780a58533f@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

+ Michael Simek

Missed Michael when checking the responsible people with 
scripts/get_maintainer.pl

Best regards,
Oliver

On 2/7/23 21:45, Oliver Hartkopp wrote:
> Hi xilinx_can maintainers,
> 
> Hartley Sweeten reported a bug when sending RTR frames with the 
> xilinx_can driver here:
> 
> https://github.com/linux-can/can-utils/issues/405#
> 
> The problem: When sending a single RTR frame (e.g. with 'cansend can0 
> 001#R') nothing happens.
> 
> Only after sending a *second* RTR frame with 'cansend can0 001#R' the 
> two (pending) RTR-frames are sent directly after each other.
> 
> This faulty behavior of RTR frame sending is independent of the time gap 
> between the two cansend attempts.
> 
> Best regards,
> Oliver
