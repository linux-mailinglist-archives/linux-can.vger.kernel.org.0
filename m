Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903C946D6F0
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 16:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhLHP2o (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 10:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhLHP2n (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 10:28:43 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783E0C061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 07:25:11 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id n12so6348803lfe.1
        for <linux-can@vger.kernel.org>; Wed, 08 Dec 2021 07:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8t960tQqkf4i8KT5jki6VuGscgtApeo1mPXKIB4s8jM=;
        b=VkYwDgzqLF3WlGMbuXRWrJLk908HlT7c8GQPbvK42yXBCGsPMlp7P13T9BmM6dq3Et
         K9Y9nh+qbospoBXG8Jd/d28uXLF7VQ+KTaJ5ZwnZEz4BXsBdLjfoRQWPJz0kVAnIp9Fo
         mJbPKg81Y65EuoUNf5N7Uz3/cj9eR7Nqw64H5thqo8hpO9zeCvWUdilh48+hljk3fDSt
         b+cH+dEGw/kRQ1Fv2jxPw7ecPdhe8RuJ2D712iz4kD4EgmNILTm1rUadLeQ3CjwOmkQo
         UUkbYRhe9W+q04KCAh8a+b/xyszR/toOfnd1A6GI7CGpJuvvZGoyZb/7nerydyiAZ/8A
         BrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8t960tQqkf4i8KT5jki6VuGscgtApeo1mPXKIB4s8jM=;
        b=lf8EaDQe15r4ktccV7sHduylJNdp7eV2m5fTiguIXl4aOSk9v6XLG0PPss6k8762gf
         2cKKs6e1kG/AUUsWMijqzKcPG/up7hvVWg1+y2klnWfOLAQX8lnpDp+x+VkMF8+8CT85
         m+mXWhmraiJABwZ8VNvxMrR+gysCDa0BDhcvC2JHkswR2nzzMDKTbX+Tw9iOkL8u6hSU
         cqdUOMMPvaiR9b0eAizop8rSireKHJadqMsH+uvN8bkmAQ8zRICHcVZSm1AUK4jNbu4i
         t2Fjz8ypKF4PnoYSvpjIO/6huOA1LPKRRZrkePlloKfaZ4rYKO5ledu2T9SwNOi4FUE7
         jd4A==
X-Gm-Message-State: AOAM5321co6fEReJvdT0rP6JZfxDikdzgtxtg5jylz1O8xSJJ6IR+O40
        FxJvH5v5uwA+lLkMvVF16pir4PGKMCm8+p64
X-Google-Smtp-Source: ABdhPJxMt76jhClTo18lW7ziAZeZFM2Q05tKZ1LY9bgZFnUzERd8MHyCXu4dqKW3nllTjrcD61wowg==
X-Received: by 2002:a05:6512:2314:: with SMTP id o20mr144989lfu.51.1638977109791;
        Wed, 08 Dec 2021 07:25:09 -0800 (PST)
Received: from [10.0.6.3] (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id x17sm310182ljp.95.2021.12.08.07.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 07:25:09 -0800 (PST)
Subject: Re: [PATCH v4 0/2] kvaser_{pciefd,usb} fixes
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20211208134910.263352-1-mkl@pengutronix.de>
From:   Jimmy Assarsson <extja@kvaser.com>
Message-ID: <cbd8600d-59b4-ae3d-ae65-f8ac48cd562e@kvaser.com>
Date:   Wed, 8 Dec 2021 16:25:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20211208134910.263352-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-12-08 14:49, Marc Kleine-Budde wrote:
> Hello,
> 
> picking up Jimmy's work.
> 
> Changes since v3:
> - dropped 2/4 "can: kvaser_usb: Use CAN_MHZ define in assignment of
>    frequency" for easier back porting
> - squashed 3/4 "kvaser_usb: Rearrange kvaser_usb_leaf_dev_cfg to avoid
>                  forward declaration"
>    and 4/4: "can: kvaser_usb: Get CAN clock frequency from device"
>    for easier back porting.
> 
> Jimmy, can you please rephrase the commit message of 2/2 so that it's
> clear why this change is done, so that it's clear, why it should be
> back ported to stable.

Sent v5, where I try to describe the problem and consequences.

Thanks!
jimmy

> 
> regards,
> Marc

