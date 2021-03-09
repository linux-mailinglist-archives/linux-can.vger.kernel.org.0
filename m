Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661A733208E
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 09:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhCIIac (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 03:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhCIIaW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 03:30:22 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CC9C06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 00:30:22 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u4so25708152lfs.0
        for <linux-can@vger.kernel.org>; Tue, 09 Mar 2021 00:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gS2v3ey+iehTw2Gmnk97sY3suzJFGRCG4WPs3F/z990=;
        b=aOwk4bt8JEkEYBk/dYq+a+qT53BF8bYaOXrdN35zPxrbgo9Exf3Xd7IwD6YeQVHL4/
         tHartI3X5QY0nRUcsGkxIXKDA5A7VjHvgCVas8adADcv3WuA1y0KlbAVAwbbC174C9uE
         r7eJzlM5yEnXPCnKMR9K3JHWrzIjs3VoKTTdwRjzo+9pMbMU87UkRRE0HuSM773nRDdJ
         UDeS4xV1zYB3J/gYTw17jnDxKlNXbRsyZ0q68AkS+evVZHXf9c0t9++GmhFAOjaQuzLL
         pPje1oS2RwBGZD8Y7QEY7TmcikKMMhG27r7FciESxaIa23fZz92t5Xi4KjJs8vsGmz/a
         FF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gS2v3ey+iehTw2Gmnk97sY3suzJFGRCG4WPs3F/z990=;
        b=aCBWaBnP9WSlbJchxyN1IX2zktD8BJ7NvjQPjBIOls7tmKLwSAeRlPHtEhKgOT28JQ
         A4f5lD8i7uV9itQIN0D/oR7MPUm/7CVyqlTDu8ARwvA7Cp/4Fhi+Mr7V7fQFe5z9FBZC
         6XQPxdjvS8ekRNwD7idYUpj9FDUs7ZAGbo1yZXQxmXGRmBiaeh3x5/3FNKhk7mpO+O2N
         o2OL2YzpGaztSphlEaHa/0AlY324FiIIEEWYIFsIQ3295q0r+TK/vDuIQarfreuaAanA
         8LR1y/cydxNDU1v+HyJAiRTsqTvBAGKITuTiFzbgnq3sBxeKsZlPwhqrx9Vy3PK3Sy4B
         Zv2g==
X-Gm-Message-State: AOAM531EmY70KfBJosbdTCRFIbtAc/B1urkE0zkW+ZVJfZHD9MPMcI3x
        V7CK9Ovxz8WBeT/UuxpEzEc=
X-Google-Smtp-Source: ABdhPJzH5zg4iK7Uy6nsTKBzUt6gR9iaGHlYEIHnV+sVZew7mhqFA4aNRZC/gHK8EawRi4xQM4pbGA==
X-Received: by 2002:a19:3f93:: with SMTP id m141mr16805133lfa.423.1615278620764;
        Tue, 09 Mar 2021 00:30:20 -0800 (PST)
Received: from [192.168.16.194] (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.googlemail.com with ESMTPSA id i18sm1201653lfl.22.2021.03.09.00.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 00:30:20 -0800 (PST)
Subject: Re: [PATCH v2 1/5] can: add new CAN FD bittiming parameters:
 Transmitter Delay Compensation (TDC)
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
References: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
 <20210224002008.4158-2-mailhol.vincent@wanadoo.fr>
 <20210224073140.vinoopn5zoxvyuq3@pengutronix.de>
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
Message-ID: <d0761226-9509-18e1-b36b-ba6318eccb3f@gmail.com>
Date:   Tue, 9 Mar 2021 09:30:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20210224073140.vinoopn5zoxvyuq3@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-02-24 08:31, Marc Kleine-Budde wrote:
> On 24.02.2021 09:20:04, Vincent Mailhol wrote:
>> --- a/include/linux/can/bittiming.h
>> +++ b/include/linux/can/bittiming.h
>> @@ -1,5 +1,6 @@
>>   /* SPDX-License-Identifier: GPL-2.0-only */
>>   /* Copyright (c) 2020 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
>> + * Copyright (c) 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>    */
>>   
>>   #ifndef _CAN_BITTIMING_H
>> @@ -10,6 +11,70 @@
>>   
>>   #define CAN_SYNC_SEG 1
>>   
>> +/*
>> + * struct can_tdc - CAN FD Transmission Delay Compensation parameters
>> + *
>> + * At high bit rates, the propagation delay from the TX pin to the RX
>> + * pin of the transceiver causes measurement errors: the sample point
>> + * on the RX pin might occur on the previous bit.
>> + *
>> + * To solve this issue, ISO 11898-1 introduces in section 11.3.3
>> + * "Transmitter delay compensation" a SSP (Secondary Sample Point)
>> + * equal to the distance, in time quanta, from the start of the bit
>> + * time on the TX pin to the actual measurement on the RX pin.
>> + *
>> + * This structure contains the parameters to calculate that SSP.
>> + *
>> + * @tdcv: Transmitter Delay Compensation Value. Distance, in time
>> + *	quanta, from when the bit is sent on the TX pin to when it is
>> + *	received on the RX pin of the transmitter. Possible options:
>> + *
>> + *	  O: automatic mode. The controller dynamically measure @tdcv
>> + *	  for each transmited CAN FD frame.
>                           ^^^
> transmitted
> 
> Fixed while applying to linux-can-next/testing. As net-next ist still
> closed, there is still some time to the next pull request and I'll
> squash patches if needed.

Hi Marc,

Can't find this in linux-can-next/testing
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=testing

Regards,
jimmy
