Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0822F34A3
	for <lists+linux-can@lfdr.de>; Tue, 12 Jan 2021 16:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392009AbhALPuI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jan 2021 10:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392007AbhALPuI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jan 2021 10:50:08 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AE3C061575
        for <linux-can@vger.kernel.org>; Tue, 12 Jan 2021 07:49:27 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id u25so4082586lfc.2
        for <linux-can@vger.kernel.org>; Tue, 12 Jan 2021 07:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+2kWgHlRLEx/pMmaWMEqoM1HupiSZZNFBo7mTSMiyKA=;
        b=KSeXABICYsKOtGZnC678JnXLKPGetJ2s6VKg9/0qDSEvIsCJIXzc7YN7P78c+Wg7l2
         EMwdHYlCMFA7zGFyiUpyXcLslF8+N77vNb+kBcofltfEgNHeOb/GXkrweDvMKnVJVJUy
         8owmaleaEy9ZWTjpj5NFphTma73qEMIYESDnH7sGZ/4wIsucKOpFpwACA+ESHOiz1J+z
         TQLIT5NgF0inwHUdrpr840RGMi4G801xqAd0ft73pUkZ59HxdmwnxCI/fAuu16QgF2LG
         AsGmYAyia5Pq7b1z3vFz1xBV9Kej+/ftMQAG72H3RNDWnWGToz84Uj7xSb110+H4+JVr
         S/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+2kWgHlRLEx/pMmaWMEqoM1HupiSZZNFBo7mTSMiyKA=;
        b=kcER0zsbd/QWbRu2Z+N0XKyUReFoodfRZ44qH8BC1w6xVOUuIQI35pIyfyy9Tp/gO2
         3XhKOQSJSwMMEOVPFI/o1SVdL82yTZAbzb0vllKyuDspaY0Pbf2W4z+T+99RrABXfPYK
         i+R/Az1LPJF2WAUkfEIzLQ8Mp7W9zajS8OaPRJHsmuh6DUe+ZSlq/9+FqFvKN4oDwFf2
         pI443jwzTLEAqVn9Kt5AWOCr5clC+daihKPb18BWf3wtbNKuomgRPd8EawA6pNu6zliv
         2VHWIJd4VOXDFPeekK57APdb1diEWdG9EY8EJxejWC/k3rCK9wkYr8M8rhHCTmXlq60S
         ya0g==
X-Gm-Message-State: AOAM530glULvQ2v/fAV2lZMKfg9EvmXSo89W6cnFJuqeAlm4bWsCSOdw
        RljsMFoRI/CQY9EN5Sen8J5z4QqpvCrMt8Hz
X-Google-Smtp-Source: ABdhPJxphg/vZs1I2wEr7qLttnpbUIlpoYagwGUbgcu1tuMCKoyzY5EaokFJGuOHp5qcyF1RmNuXnw==
X-Received: by 2002:ac2:4e6d:: with SMTP id y13mr2319958lfs.648.1610466566369;
        Tue, 12 Jan 2021 07:49:26 -0800 (PST)
Received: from [192.168.16.30] (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id 126sm437200lfm.203.2021.01.12.07.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 07:49:25 -0800 (PST)
Subject: Re: [PATCH v10 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can <linux-can@vger.kernel.org>
References: <20210112130538.14912-1-mailhol.vincent@wanadoo.fr>
 <20210112130538.14912-2-mailhol.vincent@wanadoo.fr>
 <CAMZ6Rq+vwBtUZtHTDQw_1KGFx_VSoep7ZtD3bu6cx5y8VyQFgw@mail.gmail.com>
 <730bfea5-414a-da4b-8404-7dea8e5e9cd3@pengutronix.de>
From:   Jimmy Assarsson <extja@kvaser.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <6b010038-925b-9a52-e332-bcb08f9d9b77@kvaser.com>
Date:   Tue, 12 Jan 2021 16:49:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <730bfea5-414a-da4b-8404-7dea8e5e9cd3@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-01-12 16:22, Marc Kleine-Budde wrote:
> On 1/12/21 4:11 PM, Vincent MAILHOL wrote:
>> On Tue. 12 Jan 2021 at 22:05, Vincent Mailhol
>> <mailhol.vincent@wanadoo.fr> wrote:
>>>
>>> This driver supports the ES581.4, ES582.1 and ES584.1 interfaces from
>>> ETAS GmbH (https://www.etas.com/en/products/es58x.php).
>>>
>>> Co-developed-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
>>> Signed-off-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
>>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>> ---
>>>
>>
>> Something strange is going on with the mailing list.  I can not
>> see the second patch (1/1) in the *linux-can* mailing
>> archive (only the cover letter is present):
>> https://lore.kernel.org/linux-can/20210112130538.14912-1-mailhol.vincent@wanadoo.fr/T/#
>>
>> However, the full patch series is present on the *netdev* mailing
>> archives: https://lore.kernel.org/netdev/20210112130538.14912-2-mailhol.vincent@wanadoo.fr/
>>
>> Are there any restrictions in regard to the patch size on the
>> linux-can mailing list?
> 
> Not to my knowledge.

I remember having issues posting a large patch.

You probably hit this limit:
"Message size exceeding 100 000 characters causes blocking."
http://vger.kernel.org/majordomo-info.html

Regards,
jimmy
