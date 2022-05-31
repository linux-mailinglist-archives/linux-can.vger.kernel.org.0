Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DC7538C93
	for <lists+linux-can@lfdr.de>; Tue, 31 May 2022 10:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244750AbiEaIO0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 May 2022 04:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242430AbiEaIOZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 May 2022 04:14:25 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546CF8B0A4
        for <linux-can@vger.kernel.org>; Tue, 31 May 2022 01:14:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so1560126pjs.1
        for <linux-can@vger.kernel.org>; Tue, 31 May 2022 01:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cx6ZJevI88UT9ZYq3Kr2Cp7hPm+m5GoGiusr8BW9Ml4=;
        b=GTQgWE8+w2AwpOPZQcJ/++jNNRKkmZQlORpS20a0369JWVrAqGyBozhMCICwY2pc9J
         zSO/EPem0rE9hF0FU/JsbqJdw9CZqD+F3sJ7et0m8Fkkpz/GdEtt7A7C6+BUeBGsyUCE
         UolIPHkMBWFjPeVD0VCOBUi7nzzr98ulbvbhXnFTKz8/yOewlW8L0xmF+t8uPmb4MUab
         EYA70TgvgxzHkQSxRsQ8JW++a2IpBz9J9ZDvhXXv28Vgj2d0g1GS2zFSUMkzL3dFQ4wE
         35i0eha31IQnFK/F/yD7bxCyNny2yKucU85TAGMRBPdGa1Qy52y4GAuZYLcSreBbJSD6
         0IJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cx6ZJevI88UT9ZYq3Kr2Cp7hPm+m5GoGiusr8BW9Ml4=;
        b=7vN+3LpKadZsKt10NVxhH1WTrbouTFy204RnE7XcJkotkqKwxyjZO39K6PKRYRppdg
         6WZCEDd7hQSL4/YXxfa6IPiMWr/er0TewMgcBO//MNAexDEW3q3UeFZMWgd1ldaBHZGi
         49JhSpByPjokW7MiDNMkSb4zXngdkEv6lpTRIAVWzWlLjtRgLwYzEWXWEsji0VY0Ocp7
         UUwE2ozT6FSAgKugTwwjw5wV1g5ndUZvI5x3zQPu2u/m40HV6ZsOTFIlVF0ggL+gy2Br
         X+v3KW3H/viIVa1UolGF35Bwme/7dAM61M7JDScXaXxxFfbpFXIMmD1RsixOlN3MFJ9l
         Y7bw==
X-Gm-Message-State: AOAM532YwKlt1vGmFLMUxgK3rryy1PiZScxBm3G/OVopk7nMc9MZjB+H
        Mj4nPKXc+LBTSe+aldkKNiL5anAbp3I=
X-Google-Smtp-Source: ABdhPJx1TUfBF5IYXv21HMppZnA+mfaP1zqYW/Upe1570Ss0as7Lf8BjtaC4Z+YO4sRWho7m8lJ5zw==
X-Received: by 2002:a17:902:f605:b0:14d:9e11:c864 with SMTP id n5-20020a170902f60500b0014d9e11c864mr59957359plg.54.1653984863847;
        Tue, 31 May 2022 01:14:23 -0700 (PDT)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090282c900b0015e8d4eb269sm4355306plz.179.2022.05.31.01.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 01:14:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= 
        <philippe.mathieu.daude@gmail.com>
Message-ID: <36390846-ca71-54e7-e799-834e57e5ce89@amsat.org>
Date:   Tue, 31 May 2022 10:14:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: CTU CAN FD IP core SocketCAN driver - success with mainine Linux
 kernel and mainline QEMU builds
Content-Language: en-US
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org,
        qemu-devel@nongnu.org, Marin Jerabek <martin.jerabek01@gmail.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Jiri Novak <jnovak@fel.cvut.cz>,
        Jaroslav Beran <jara.beran@gmail.com>,
        Petr Porazil <porazil@pikron.com>, Pavel Machek <pavel@ucw.cz>,
        Drew Fustini <pdp7pdp7@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Carsten Emde <c.emde@osadl.org>,
        Matej Vasilevski <matej.vasilevski@gmail.com>,
        =?UTF-8?Q?Jan_Charv=c3=a1t?= <jancharvat.charvat@gmail.com>,
        Vikram Garhwal <fnu.vikram@xilinx.com>,
        Andrew Dennison <andrew.dennison@motec.com.au>,
        Reiner Zitzmann <zitzmann@can-cia.org>
References: <202205272119.46182.pisa@cmp.felk.cvut.cz>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
In-Reply-To: <202205272119.46182.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 27/5/22 21:19, Pavel Pisa wrote:
> Hello everybody,
> 
> I want to report successful build and test of the CTU CAN FD driver
> from actual Linux kernel mainline GIT on actual QEMU build from
> mainline git. Test on HW from net-next has been repeatedly
> run by Matej Vasilevski during his timestamping patches work.
> 
> Thanks to all who helped, namely Ondrej Ille for his investment
> in the project and rewrite of registers generator to provide
> headers files acceptable for mainline, Marc Kleine-Budde
> for review, integration and cleanup and together with
> Pavel Machek to provide valuable feeback what is not acceptable.

Nice team work, congratulation! :)

> I hope that we will be ready with with timestamping patches
> cleanup for 5.20 merge windows as well as with support
> for HDL sources parameterizable number of Tx buffres.
> 
> In the long term, I consider to use mechanism of software
> virtual FIFO to implement multiqueue Tx support which
> is in the fact needed in all serious CAN applications
> to prevent bus level priority inversion.
> 
> We plan to visit and present on the Embedded World
> in Nuremberg, so I would be happy to meet you there.
> I hope that Carsten Emde and OSADL will pass over
> information where we are available.
> 
> Program for Tuesday afternoon is given already
> Talk QtRvSim – RISC-V Simulator for Computer Architectures
> Classes, June 21, 2022 Session 10.3 – System-on-Chip (SoC)
> Design RISC-V Development (16:00 - 16:30) at Embedded World
> Conference. Our toy there https://github.com/cvut/qtrvsim
> 
> Best wishes,
> 
>                  Pavel Pisa
>      phone:      +420 603531357
>      e-mail:     pisa@cmp.felk.cvut.cz
>      Department of Control Engineering FEE CVUT
>      Karlovo namesti 13, 121 35, Prague 2
>      university: http://control.fel.cvut.cz/
>      personal:   http://cmp.felk.cvut.cz/~pisa
>      projects:   https://www.openhub.net/accounts/ppisa
>      CAN related:http://canbus.pages.fel.cvut.cz/
>      Open Technologies Research Education and Exchange Services
>      https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home
> 
> 

