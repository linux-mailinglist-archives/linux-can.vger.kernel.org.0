Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DEB33219C
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 10:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhCIJKO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 04:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhCIJJo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 04:09:44 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA57C06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 01:09:44 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id q14so19696282ljp.4
        for <linux-can@vger.kernel.org>; Tue, 09 Mar 2021 01:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BcEG09nN5B++zykG2oLgy1Nttq2Au1ncOl4bOgfzC6s=;
        b=j2uQERksDpc433nFTJrA3NBf5CYZL2FoQUa02vyDMdxz2mPzGezk7wNFIVHseT8827
         dso2KWZG0R2Lyi0LaT/B2xPFVWfQByCUsSqvHJYEW3KxXFN9XJEvm7cQwATVp2HurZPX
         gS/Tfeu4LVqgAOI9ft6ST9/MbBb/WJhaLEyyWH7sF/AeosmVrfYrJ622K3sVEH4tACQb
         hDW2dt1/hVwZqyeMs5EjnJvZ15zrVm/YCkmuGnp/nMB8sKKqD1eSpN/ZJTXq8/NbSy5u
         uAHYgmSpqLNpr5z5Yq5kWggsq2Q1dM5haUy7P7CLzy4VbDZz5OjhPk8YI420QnzaiUgZ
         22Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BcEG09nN5B++zykG2oLgy1Nttq2Au1ncOl4bOgfzC6s=;
        b=JwcdsMTBilnd40mNno9LOOmIh5RvlbsqQkkLq6iSCTSWSTGlBC6u1Ip5PjeT0Yej7L
         yYkql3gobBB0+YFqi0Q1r7BWua2O47Yk6PT/Z21AweVOqn4QBHCmcpJ+sp7DUeccgb6T
         m4tAI0xAsf4uG0DVh9rQXx+1557162kUzkMYTTKtsHRJEpxR7B2aVoj+ssNWDsf18Edr
         n9wSCWyQiR8Ke2aiPn3GijXk3Zuhv9VNYd69cMzn+s2Hqh8+cw9zGbBLw2U/g4UIaNBm
         /PLF6ohZwiAAByV7++93BwV8Hl1vYNEBZCC0QCw/+5n5mpFyur2iJnkt9YSV1HUUIDfG
         EGFA==
X-Gm-Message-State: AOAM530uMGApw3rcfOSbrv6vJZZ48BZqrspnoB82FygizWINKGo6C1FP
        PL/8pKp8CrwDcC7cNgeXmj1MO40ZFWI=
X-Google-Smtp-Source: ABdhPJx88r+nKQUTr6M6YE9RBHCekHpc5Q3ZOhjcLb/CRUeqJ1ylhVsqxoDWrb0OCidodeww2GqVsA==
X-Received: by 2002:a2e:9791:: with SMTP id y17mr15616608lji.343.1615280982507;
        Tue, 09 Mar 2021 01:09:42 -0800 (PST)
Received: from [192.168.16.194] (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.googlemail.com with ESMTPSA id u14sm1733251lfl.40.2021.03.09.01.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 01:09:41 -0800 (PST)
Subject: Re: [PATCH v2 1/5] can: add new CAN FD bittiming parameters:
 Transmitter Delay Compensation (TDC)
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
References: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
 <20210224002008.4158-2-mailhol.vincent@wanadoo.fr>
 <20210224073140.vinoopn5zoxvyuq3@pengutronix.de>
 <d0761226-9509-18e1-b36b-ba6318eccb3f@gmail.com>
 <20210309083439.ltepbnol3jxp7mey@pengutronix.de>
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
Message-ID: <5b5bf498-dcf2-70e0-f4de-fd474db2d876@gmail.com>
Date:   Tue, 9 Mar 2021 10:09:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20210309083439.ltepbnol3jxp7mey@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-03-09 09:34, Marc Kleine-Budde wrote:
> On 09.03.2021 09:30:19, Jimmy Assarsson wrote:
>> Can't find this in linux-can-next/testing
>> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=testing
> 
> Try again.
> 
> Marc

Thanks!
