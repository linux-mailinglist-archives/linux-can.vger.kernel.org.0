Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A329A30D378
	for <lists+linux-can@lfdr.de>; Wed,  3 Feb 2021 07:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhBCGmv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Feb 2021 01:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhBCGmv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Feb 2021 01:42:51 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF05C06174A
        for <linux-can@vger.kernel.org>; Tue,  2 Feb 2021 22:42:10 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m22so31747839lfg.5
        for <linux-can@vger.kernel.org>; Tue, 02 Feb 2021 22:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZVObF6RQIKUV7edOIq2XzGpwGVjwfc3YddEZOCDfVmk=;
        b=sgGg9ehhbN8SKOxZJS97YGjVdAvAUAYyR4Jo5qFxmsUqu9uEZMe2+vh/DS/+c7j/FG
         m2u3fTHUZ38lVgF3jSqpIueN9DZh8Zenl+4VpMbyMS0Wumb0QgmmldL5iIVeoJq4RA2T
         ULH0y6EwN7reIw62Gacyu/iQ+WeeV5wOGDlrVE/M/2UeKKEJkUGmm45x8EzM+JNmxEFd
         ZlR98QVB8+LHCH+k0/KByMwMNkWL+ObX5fl20lPgkTOxDGOGjhOHU0RFvWAwrTpo53XG
         WHS8PQuucQ+CbgsOaSbpbUR+Mc3BXG8f5xaDQVRYNCPAba5Jznf9qobVvzG2bUNlbFAv
         w+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZVObF6RQIKUV7edOIq2XzGpwGVjwfc3YddEZOCDfVmk=;
        b=jD8tukAXuZSSK1I+Ngo0xGAcNr9BQRuqlc2I7C5vWcwGkkJCXdgFZuQCmhdtZDNFNv
         DZ8D1pcqRD039YSBWbn6+LnMb0iCTt3voKSqiHg/X+7VBKWSkVEMNt3amNJ6TCb6ANCl
         C1ESfKQ2GqBZNRjqrWgYSyEchTZn/nYI7ozH21kQsBU7mljWLigwZVuKnwO33qzI8N1P
         4jKqxcF+rBTFHUoZE9trc2Lz/UIKjXpCarxrraPTK9ZoPEF/APYIjDauMo79/rdt2/xg
         4A7pPPemmVG4eUxztx4Gv1vg2awpu/0F6ugioH79rAcwMF3PdZpV1jXVWiKfQ6zA5hxe
         RySA==
X-Gm-Message-State: AOAM530ORNgKtzUTFhJnu2IfIUGg1cjOudTGBNNoiOXGbGnkaHTFRA5T
        CzcyiauxSnqrGLx7izfWTVo=
X-Google-Smtp-Source: ABdhPJyVG30vseAD2FELKtbqZ20LHdacJHfvKOvXrHdngMIrAxQnU50qRH3BwQsF6298mGziGVh6lA==
X-Received: by 2002:a19:cd:: with SMTP id 196mr903480lfa.267.1612334528217;
        Tue, 02 Feb 2021 22:42:08 -0800 (PST)
Received: from [192.168.16.194] (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.googlemail.com with ESMTPSA id d18sm138830lfm.285.2021.02.02.22.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 22:42:07 -0800 (PST)
Subject: Re: [Question] Sending CAN error frames
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Jimmy Assarsson <extja@kvaser.com>,
        linux-can <linux-can@vger.kernel.org>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
References: <CAMZ6RqK0rTNg3u3mBpZOoY51jLZ-et-J01tY6-+mWsM4meVw-A@mail.gmail.com>
 <87e3dd54-50ab-1190-efdb-18ddb3b21a02@hartkopp.net>
 <42080d05-7ab3-99be-92e2-73ed262350ba@gmail.com>
 <CAMZ6RqJWrObGZRwyA1kD5cEZRUd_-4zt8rsMR+zZPLpxD6AWAQ@mail.gmail.com>
 <1debcaeb-71c7-6b78-88b3-7f121a33c1c1@kvaser.com>
 <CAMZ6Rq+ObkS2RDFbgbPP7HZH26WbN-eoLeQyiY6+CpDGYjE10w@mail.gmail.com>
 <17b14b11-87bf-9508-0da5-1031c5d5e132@pengutronix.de>
 <20210202082340.GA23043@x1.vandijck-laurijssen.be>
 <8050d433-591c-2d1f-f0c7-ffa92e33032d@pengutronix.de>
 <cac31b51-514d-462b-fe48-4c3bea8b28fd@hartkopp.net>
 <1b82f875-5884-3bf6-7891-2e4461d2a72a@pengutronix.de>
 <abc8923c-8cf6-c0d5-ec67-73afe183b9b3@hartkopp.net>
 <CAMZ6RqKx5NCFKiahb8AbUx=LC5xS6oYCdVZk8WGSAzZeAVs9Qg@mail.gmail.com>
 <ac8c4d3c-4261-8909-3481-abcd1d3bf43e@hartkopp.net>
 <CAMZ6RqKkeV6WRtfh65mDsYthuG1S+LD=kexAdcx=DeShf0T0YQ@mail.gmail.com>
 <d7584992-78a0-4be7-6b31-0bc1e4adfeca@hartkopp.net>
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
Message-ID: <707944b7-f202-edb1-cb67-beedaeedfda0@gmail.com>
Date:   Wed, 3 Feb 2021 07:42:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <d7584992-78a0-4be7-6b31-0bc1e4adfeca@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-02-02 20:19, Oliver Hartkopp wrote:
> On 02.02.21 12:12, Vincent MAILHOL wrote:
> 
>>> The CAN_ERR_FLAG has been renamed in the documentation to indicate
>>> "error messages" from the CAN controller, as an error frame is something
>>> completely different.
>>>
>>> Now as we are talking about having CAN_ERR_FLAG in the TX path besides
>>> the vcan testing stuff, we should think about an API for the really
>>> outgoing frames.
>>>
>>> We could not only think about "create an error frame right now" but also
>>> think about a more intelligent CAN node, which also offers to destroy
>>> one or more specific CAN ID(s) at a specific bit position after
>>> detecting that CAN ID.
>>
>> My original idea was to leave it unspecified until a device was
>> actually capable of doing such a thing. But I am not against
>> defining the API now :) We might just have to wait a long time
>> for someone to actually implement it.
>>
>>> We could use the CAN_RTR_FLAG and the data[] section of the outgoing
>>> error CAN frames for such an API.
>>
>> We are not limited to the CAN_RTR_FLAG and the data[]
>>
>> First, we have to list the use cases.
>>
>> As I wrote before, there are only two forms for the error flag:
>>    - The active error flag: 6 consecutive dominant bits
>>    - The passive error flag: 6 consecutive recessive bits
> 
> IMO this passive error flag stuff is pointless.
> The passive error does not have any effect on the bus. Nobody sees it. It's just a measure to continue counting error counters inside the CAN controller. IMO it's a read-only feature about the controller internal status.

I agree.

>> The device can either inject the flag either during:
>>    - bus idle
> 
> Is an error flag defined at bus idle?
> 
> Error flags are intended to destroy *other CAN controllers* transmissions when detecting protocol violations. There can not be a protocol violation at idle time, right?

This is what the Kvaser CAN controller does. It will wait for the bus to become idle, before an active error flag is transmitted.

>>    - while it is transmitting a frame
> 
> What's the use-case for destroying your own transmission?
> 
>>    - while it is receiving a frame
> 
> This makes sense, especially when you can destroy specific CAN ID frames at a specific bit position.
> Or for any CAN ID at a specific bit position.
> Or for any CAN ID at an undefined bit position.

I agree.

>> The error flag can occur at any time.
> 
> Sure? (see above)
> 
> Of course we might also provide some pump gun mode which just sends an error flag at some (any) time.

As above.

> But for what reason?

Testing purpose, e.g if you develop software where you want to keep track of bus errors, this makes it possible to test such software in a controlled way.
We also use this ourselves when testing the transitions ERROR_ACTIVE <-> ERROR_WARNING <-> ERROR_PASSIVE, for Rx.

Regards,
jimmy
