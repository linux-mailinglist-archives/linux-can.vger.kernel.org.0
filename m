Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DE646D1C3
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 12:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhLHLQo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 06:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbhLHLQo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 06:16:44 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576CEC061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 03:13:12 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id u22so3311001lju.7
        for <linux-can@vger.kernel.org>; Wed, 08 Dec 2021 03:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=so/5NSVDok6w6ZBvQPPoJ8TJliAFD8WOvi5O/3nJjzM=;
        b=QH6HgpBKpgvETjOhRKzvynM9nvSo4lABBR+uWwSaKd5I57myv3a3gJYmem8IkvQtN0
         pKWRycazxNf9kuKPyRW59Ix5yVJcNIoGAtITt+Eo0ogJHyuZpKRXTNAjnlIB9LID37Ny
         jvMLiX2WzVNVdzIwTK4Ck634FqKVZnykDqF4+YMQRg7a+6BK4+7lIipb0J5MOufXQiaA
         dhoe151nHPNXZYcT6/y88mzpAfD24+O1Q0V6pE4i6MTNsK0Oqx7rmX8/U4jrdPGqjElb
         rwxaHC6nXOSuD2CvlL99Xf8/DRRUp8yM3CJGJ92SUZq1wEfqtF78EgIMqSC5EblDE7Wh
         KV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=so/5NSVDok6w6ZBvQPPoJ8TJliAFD8WOvi5O/3nJjzM=;
        b=NiV3W4kXhFZp8s6pZmNF7Jn6rhfvT60rUuG5lU4CBqbl4g8MyKg/JiG//UJZFi4ykG
         rQKyKovOl3G79WqvBqFcc+Py/hvy9Ls92ODgG6z49plMCKxXwC5Irzh1lm2T85n6mNvc
         fGjMGKwJO79abmYwma2NbY6ztLhjk03MOQeSKIziFhpkUCWZ1R/bMOwXBO4s/imuMKr2
         EjUe+ybdvX1f27RBNH2xo5HADOJah5WyOjMExi6r0tScBnhKfkHQSMiW1z/bpJOTF3AJ
         6f8nZihY3MrVa7LXV8wuSrmeAGi8dY2Vdj+/rJHIc93+wZZ+20aB6EAHh8Va6sVhgPMm
         GA9g==
X-Gm-Message-State: AOAM5339u+GlhKuO7fsN6wxKMSA1LZayV4XocVKuOBH4Yc8WhkxDg4ie
        g6jHX+9XeHaZVfFG2Kb6dirB3w==
X-Google-Smtp-Source: ABdhPJzwdsn3YUPMN7IiXmqCf3nI+MRI7nKa1zp591Q2pFazQ4scQb5wHshHhkg362OGY2AVd8CzAw==
X-Received: by 2002:a2e:b058:: with SMTP id d24mr47980358ljl.237.1638961990627;
        Wed, 08 Dec 2021 03:13:10 -0800 (PST)
Received: from [10.0.6.3] (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id v10sm224158lfe.127.2021.12.08.03.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 03:13:10 -0800 (PST)
Subject: Re: [PATCH v1 0/5] kvaser_{pciefd,usb} fixes
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
References: <20211119131915.2033234-1-extja@kvaser.com>
 <20211208092750.mgeve7zlmpmivdnf@pengutronix.de>
From:   Jimmy Assarsson <extja@kvaser.com>
Message-ID: <cfb88b53-3a20-59ee-e00c-e2878f8fcff6@kvaser.com>
Date:   Wed, 8 Dec 2021 12:13:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20211208092750.mgeve7zlmpmivdnf@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-12-08 10:27, Marc Kleine-Budde wrote:
> On 19.11.2021 14:19:10, Jimmy Assarsson wrote:
>> The first patches fix net_device_stats when receiving error frames.
>> The last two patches fix the CAN clock frequency for Kvaser Leaf devices.
>>
>> Note that this series contains patches for both kvaser_usb and
>> kvaser_pciefd driver.
> 
> What's left of this series, after applying Vincent's stats cleanup [1]
> series?
> 
> [1]
> https://lore.kernel.org/all/20211207121531.42941-1-mailhol.vincent@wanadoo.fr/
> 
> Can you send a series only containing the remaining patches?

Fixed https://lore.kernel.org/all/20211208110940.185629-1-extja@kvaser.com

Best regards,
jimmy

> 
> regards,
> Marc

