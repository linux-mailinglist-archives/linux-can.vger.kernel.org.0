Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE8C2B3969
	for <lists+linux-can@lfdr.de>; Sun, 15 Nov 2020 22:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgKOVKb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 15 Nov 2020 16:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbgKOVKb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 15 Nov 2020 16:10:31 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C5DC0613CF
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 13:10:31 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id y17so15960322ejh.11
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 13:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=liQCBiz3clRBqvcrDaCtrkkRjc5coVvoFn92/B8GWBU=;
        b=WVUXRHsxepjIB02pYHa+doR3N6dT/IQgbu5NQZGsuE8HHKU97EjLl6P4vHcThSKyyW
         Wr4Z72L7COx7kgZwfPFjKwuJH6sPC6ivB51jLv8e5lrkX65XM1OWR+F2zJE0Yw4Yi2oS
         shfR0JbaMpveoTfCcBAw7iBuKr8wDZ6LyWuJS5zL3btcBZeJnr+Pc322gBv1BNm0wUTi
         Zjpg/NO0NwrILqPUNPtaOKgnkfPVWAUYVwR81oBVBQj+++NbuMfv8rK4GLVP4kqhIfHY
         DS8WYCGjIDGeCCEJRy9j1OQGnk7EHsz6wlQlreQyhO1HXgBjSiuRp7xg56AIQgCGCFsv
         ARAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=liQCBiz3clRBqvcrDaCtrkkRjc5coVvoFn92/B8GWBU=;
        b=JLZnzcDkAq6m0YSR0GCqJrXtiIv2g1+vYP1HKjwFLIz2GQf64GAERkmZ2lEqEYWFk5
         euFWNrJokYIDpbv/08HQE/2QCSnfl0vu9tz8eVh24nPmW9mRuFFP6BJciJvOI4zOngDN
         dZ7K6HlQsnjEaeLK1jq/LF4av9xPpREy2W1apbC17AqKT0sf/bIWur5dyUvo3MQbgJFi
         VHXoIHGXQi1pXkaeN3eTiFt5uTTa+VaewyuP+/bmVShlle/z0SdKKnkyi996zOh6+Cya
         0oMV4Jh5cMQUAfnjbfPKUGA9PlXB/c9XzhmchUGEInukch901R22pmshvujjP5Oy2Khy
         fasg==
X-Gm-Message-State: AOAM5316i/y33RrvXCIF5LcJN7E/sPaVAhwPV4wJhkUY2KOVwBklVIqa
        Z1ml3P2tU0GIsDCSDXNnkwuXs9+wtRU=
X-Google-Smtp-Source: ABdhPJyXtjbsAEs/LBkK5g/utH7LD9+POWa5xSXBisL9kpoYfk3ceZ7NdbTnsMlojyYTndT8x9w2Kw==
X-Received: by 2002:a17:906:6d13:: with SMTP id m19mr11943734ejr.345.1605474629760;
        Sun, 15 Nov 2020 13:10:29 -0800 (PST)
Received: from [192.168.16.195] (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.googlemail.com with ESMTPSA id a26sm9729940edt.74.2020.11.15.13.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 13:10:29 -0800 (PST)
Subject: Re: [PATCH 1/6] can: kvaser_pciefd: Fix KCAN bittiming limits
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Jimmy Assarsson <extja@kvaser.com>
References: <20201115163027.16851-1-jimmyassarsson@gmail.com>
 <20201115175556.f3kuyxwsy77hluvt@hardanger.blackshift.org>
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
Message-ID: <8464c383-38ba-3a82-da47-250f8f001dfc@gmail.com>
Date:   Sun, 15 Nov 2020 22:10:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201115175556.f3kuyxwsy77hluvt@hardanger.blackshift.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2020-11-15 18:55, Marc Kleine-Budde wrote:
> On Sun, Nov 15, 2020 at 05:30:22PM +0100, Jimmy Assarsson wrote:
>> From: Jimmy Assarsson <extja@kvaser.com>
>>
>> Use correct bittiming limits for the KCAN CAN controller.
>>
>> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> 
> Applied this and 2 to linux-can/testing. The rest to linux-can-next/testing.
> 
> regards,
> Marc

Thanks!

Regards,
jimmy
