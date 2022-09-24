Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054C75E8F9F
	for <lists+linux-can@lfdr.de>; Sat, 24 Sep 2022 22:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiIXUYO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 24 Sep 2022 16:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiIXUYM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 24 Sep 2022 16:24:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78B740BDB
        for <linux-can@vger.kernel.org>; Sat, 24 Sep 2022 13:24:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bu25so3321649lfb.3
        for <linux-can@vger.kernel.org>; Sat, 24 Sep 2022 13:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hyNaeJ0Q2iIDpniYglzBo4MF1IykMOPbqMdAcOJFl8E=;
        b=o9izSxkpeX/1tIub1Zo5BVFKrKbJX+yOTolJzNKuxgBL5sWJnKqJItg3hxiPwug35y
         +QXRzkInKYOCyL8MO8TWRvUR1YA5CvBlpozgIQ5TOr8zTus3yoY6zzk4lCd4IZBHqx5j
         XsRNV6pAfgLLqgpJ93EzaI8yGmQ4ZPvFDYn78zhAUyg2GqfJPiZKYfi+SYDwZ0s3XLyP
         F3twoev8pHhJ69xJauzVCT3MsnrnJuABGNHctqxcUxBqoTFKi2LaANJiTgptEiCeKt1R
         1sQDhBNNcB/fLvl/OKzSmCmUkDHC9M3HB1kyM5bxAt5z/QgXnT1tWmcgTjGBSpGcLrnh
         6O8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hyNaeJ0Q2iIDpniYglzBo4MF1IykMOPbqMdAcOJFl8E=;
        b=GFOCIyY4nmkE/vtCc2DmZKYWvLaTV5sBtNowMhdDxHxM8ik/p9cPBm+eM8n2qqx0L/
         nJj0lVBxA1+Fe/8KxVJypNyeLA1T7mR4PtPBcwD4y5TPapO3Ctv68BuKEwoglI8rzWir
         v+cYuXGPR2gxrB6wHXkuBxq3cMIZS9+bL9SDBCYzIgjW4J2T7VJFuLtgBBsNbgoSZvh4
         G63r3PBmaI7rnN9zBkuphTkguwBQy6xqHEMekTo3ZtmLGxAU6cMIbLryvmShb3B+vL5+
         GJR7TTSvefU0hToxu/gE/NJGdOcXG3vyG1bGTTdc/uHbhiv1DTWsMUWdNxAflWCIKcnK
         aU3w==
X-Gm-Message-State: ACrzQf0fZdQ1Q5Ahe2H0kgq835xLOKBwkUlFQuA2of8jWyZ+cov2fjzS
        QvO/fuC7wtMru5qoI37TKX/+F3/02Fz2s3Fu
X-Google-Smtp-Source: AMsMyM6aEpus971GnlvdTbaYADI7K+HFMWCJKZjIA6qJKOyT6HNI05o8uf/hMGp1HzjcEzJzYfolRw==
X-Received: by 2002:a19:490b:0:b0:49f:52cf:aeaf with SMTP id w11-20020a19490b000000b0049f52cfaeafmr5525252lfa.46.1664051049775;
        Sat, 24 Sep 2022 13:24:09 -0700 (PDT)
Received: from [192.168.10.124] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id b15-20020a19644f000000b00499fe9ce5f2sm1984045lfj.175.2022.09.24.13.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 13:24:09 -0700 (PDT)
Message-ID: <f9b37775-edd5-2a5b-18bc-b34bb69b8324@gmail.com>
Date:   Sat, 24 Sep 2022 22:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC can-next] can: remove obsolete PCH CAN driver
To:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Dario Binacchi <dariobin@libero.it>,
        Wolfgang Grandegger <wg@grandegger.com>
References: <20220924174424.86541-1-socketcan@hartkopp.net>
Content-Language: en-US
From:   Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <20220924174424.86541-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 9/24/22 19:44, Oliver Hartkopp wrote:
> The PCH CAN driver is a driver for a Bosch C_CAN controller IP core which
> is attached to the system via PCI. This code has been introduced in 2011
> by Oki Semiconductors developers to support the Intel Atom E6xx series
> I/O Hub (aka EG20T IOH PCH CAN). Since 2012 the driver only has been
> maintained by the kernel community.
> 
> As there is a well maintained and continously tested C_CAN/D_CAN driver
> which also supports the PCI configuration from the PCH CAN EG20T setup
> this driver became obsolete.
> 
> Cc: Jacob Kroon <jacob.kroon@gmail.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Dario Binacchi <dariobin@libero.it>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   drivers/net/can/Kconfig       |    8 -
>   drivers/net/can/Makefile      |    1 -
>   drivers/net/can/c_can/Kconfig |    3 +-
>   drivers/net/can/pch_can.c     | 1249 ---------------------------------
>   4 files changed, 2 insertions(+), 1259 deletions(-)
>   delete mode 100644 drivers/net/can/pch_can.c
>

Given that the current PCH driver will lockup on my system I'm all for 
removing it.

Jacob
