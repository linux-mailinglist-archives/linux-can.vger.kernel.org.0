Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4668A529CC0
	for <lists+linux-can@lfdr.de>; Tue, 17 May 2022 10:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbiEQIla (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 May 2022 04:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243687AbiEQIlL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 May 2022 04:41:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E9F3DDD7
        for <linux-can@vger.kernel.org>; Tue, 17 May 2022 01:41:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d15so30047727lfk.5
        for <linux-can@vger.kernel.org>; Tue, 17 May 2022 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=42ANMWW4EhugKVyQ1qgI/ie2RkgGRo8QrOhqXcnc/jg=;
        b=gDkwrQShT4WjlZAQ+1ixBY/pdwsApFRKl5iai6egn6aK4XJG8wIDQ/goYw3R/lwo4W
         63PLo7dm4lVQXfR5s3cj3BLuPD8kLPHuYHdZq80WKyaARJY38DQksEfKkyHhsXdXgRGa
         6Xf79w8SzjSHcZHoHOiiP0lwFPlcmg02tKtIhROHOEQ2WhRS7F4PKQmPVWfvqQpe1kTe
         SJ8taKcBMEddw2FcPx13e43cwN8Vvcgt8cxS/LcMS0fWsCQsc9aH0NZBmwCuhIqOaXBt
         GpYqJVlcuCx5iN0GOKD9pn08oCBgwmitfABQo6pMddDYqxfwgFpay83nKFTZEgzMyt0r
         1iAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=42ANMWW4EhugKVyQ1qgI/ie2RkgGRo8QrOhqXcnc/jg=;
        b=sw8hK6hmqWEzHMSkpeSJxvxHNkee+X/p7COprVhO+o8GG15BVFxaBHoEnAmPGcotq6
         ybJLGc1OvZw6dItIQhtTNqg4a4QWUzy/z9GEVe/uX3C2mBjMdLiRvMpay649BbF4MEqr
         BXIzZgqk+/jaLKz6fNKHJ0W0qsk6CSjmHwGSiUqo5g1N++E70FuWOzHdYb4JMuJFOM6l
         eq6W22JBlFYyexAgJM1rlb7hIA1jAmER3FFLYq2qu6ai4uTbuCe4N+qVYKuZQ8a3ObAb
         GH20oKUu3MW5RR2igCAtssoNl8jCUtM8NmJAT+jvnRLBYTKrK7CksDlI1trpA5BvZTV8
         ReSg==
X-Gm-Message-State: AOAM530vUgelEX5Qy1hCiy7JhNtJeJPJlteggKnSWeyfgyXsfXgYxIya
        JFUpDythEW+h495lZPov6DTbfA==
X-Google-Smtp-Source: ABdhPJz4pGyHUXIiqYB7Kea1MIt/ofWggg9PWXtQtgDg9G0K5LNExUwICzkePMPuBhOPwbmrnnfm5g==
X-Received: by 2002:a05:6512:3d26:b0:473:a5e5:1661 with SMTP id d38-20020a0565123d2600b00473a5e51661mr16765641lfv.239.1652776866385;
        Tue, 17 May 2022 01:41:06 -0700 (PDT)
Received: from [10.0.6.3] (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id t21-20020ac24c15000000b0047255d210e6sm1522174lfq.21.2022.05.17.01.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 01:41:05 -0700 (PDT)
Subject: Re: [PATCH 00/12] can: kvaser_usb: Various fixes
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
From:   Jimmy Assarsson <extja@kvaser.com>
Message-ID: <61060501-7edb-4277-acf6-117161e8593f@kvaser.com>
Date:   Tue, 17 May 2022 10:41:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2022-05-16 15:47, Anssi Hannula wrote:
> 
> Hi all,
> 
> Here's a set of fixes for issues I found while testing kvaser_usb as we
> are preparing to start using it in production (with 0bfd:0124).

Hi Anssi,

Thanks for the patches!
I will review and test your fixes before the weekend.

Best regards,
jimmy


> The biggest caveat is that I only have two devices to test with [1] and I
> don't have HW documentation, so there is a possibility that some of the
> fixes might not work properly on all HW variants.
> Hopefully Jimmy can confirm they look OK, or suggest alternatives.
> 
> [1] Tested devices:
> - 0bfd:0017 Kvaser Memorator Professional HS/HS FW 2.0.50
> - 0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778
